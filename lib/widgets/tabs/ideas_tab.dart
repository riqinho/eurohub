import 'package:eurohub/data/idea_repository.dart';
import 'package:eurohub/models/ideia.dart';
import 'package:eurohub/theme/app_colors.dart';
import 'package:eurohub/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // necessário para PointerDeviceKind
import 'package:eurohub/widgets/idea_card.dart';

class IdeasTab extends StatefulWidget {
  const IdeasTab({super.key});

  @override
  State<IdeasTab> createState() => _IdeasTabState();
}

class _IdeasTabState extends State<IdeasTab> {
  int selectedIndex = 0;

  static const chips = [
    'Tudo',
    'Em análise',
    'Melhoria Solicitada',
    'Recusada',
    'Aprovada',
  ];

  static const chipColors = [
    Color(0xFFEAF3FF), // Tudo
    Color(0xFFEFF8FF), // Em análise
    Color(0xFFFFF5E6), // Melhoria solicitada
    Color(0xFFFFEBEE), // Recusada
    Color(0xFFE8F5E9), // Aprovada
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kCard,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _Header()),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            // Chips pinados
            SliverPersistentHeader(
              pinned: true,
              delegate: _ChipsHeaderDelegate(
                minExtent: 56,
                maxExtent: 56,
                child: ChipsStatus(
                  chips: chips,
                  chipColors: chipColors,
                  selected: selectedIndex,
                  onChanged: (i) => setState(() => selectedIndex = i),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Lista de ideias (com filtro)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 24),
              sliver: FutureBuilder<List<Idea>>(
                future: IdeaRepository.loadFromAssets(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }
                  if (snap.hasError) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Text(
                          'Erro ao carregar: ${snap.error}',
                          style: AppTextStyles.body,
                        ),
                      ),
                    );
                  }

                  final all = snap.data ?? [];
                  final filtered =
                      selectedIndex == 0
                          ? all
                          : all
                              .where((e) => e.status == chips[selectedIndex])
                              .toList();

                  if (filtered.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Text(
                          'Nenhuma ideia neste filtro ainda.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  return SliverList.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final c = filtered[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: IdeaCard(
                          statusLabel: c.status,
                          title: c.title,
                          summary: c.summary,
                          votes: c.votes,
                          date: c.date,
                          statusColor: _mapStatusBg(c.status),
                          onTap: () {
                            // TODO: navegar para detalhe
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- HEADER ----------------
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Text(
        'Minhas Ideias',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }
}

// --------------- STATUS CHIPS ---------------
class ChipsStatus extends StatelessWidget {
  final List<String> chips;
  final List<Color> chipColors;
  final int selected;
  final ValueChanged<int> onChanged;

  const ChipsStatus({
    super.key,
    required this.chips,
    required this.chipColors,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kCard,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 40,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: chips.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final isSelected = i == selected;
              return FilterChip(
                showCheckmark: false,
                selected: isSelected,
                label: Text(chips[i]),
                onSelected: (_) => onChanged(i),
                selectedColor: chipColors[i].withOpacity(0.8),
                backgroundColor: chipColors[i],
                labelStyle: TextStyle(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                shape: StadiumBorder(
                  side: BorderSide(color: chipColors[i].withOpacity(0.8)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ---- SliverPersistentHeader delegate ----
class _ChipsHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;
  final Widget child;

  _ChipsHeaderDelegate({
    required this.minExtent,
    required this.maxExtent,
    required this.child,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _ChipsHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent;
  }
}

// ---------- util: mapeia cor do chip no card ----------
Color _mapStatusBg(String status) {
  switch (status) {
    case 'Em análise':
      return const Color(0xFFEFF8FF);
    case 'Aprovada':
      return const Color(0xFFE8F5E9);
    case 'Recusada':
      return const Color(0xFFFFEBEE);
    case 'Melhoria Solicitada':
      return const Color(0xFFFFF5E6);
    default:
      return const Color(0xFFEAF3FF);
  }
}
