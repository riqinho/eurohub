import 'package:eurohub/data/idea_repository.dart';
import 'package:eurohub/models/ideia.dart';
import 'package:eurohub/theme/app_colors.dart';
import 'package:eurohub/theme/app_text.dart';
import 'package:flutter/material.dart';

// seu card renomeado para `Idea`:
import 'package:eurohub/widgets/idea_card.dart';

class IdeasTab extends StatelessWidget {
  const IdeasTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kCard,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _Header()),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            const SliverToBoxAdapter(child: ChipsStatus()),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Lista vertical vindo do JSON (assets/mock/...)
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

                  final itens = snap.data ?? [];
                  if (itens.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Text('Você ainda não enviou ideias.'),
                      ),
                    );
                  }

                  // SliverList => lista vertical, estilo RecyclerView
                  return SliverList.separated(
                    itemCount: itens.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final c = itens[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: IdeaCard(
                          // <- se seu widget se chamar IdeaCard, troque para IdeaCard
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
class ChipsStatus extends StatefulWidget {
  const ChipsStatus({super.key});
  @override
  State<ChipsStatus> createState() => ChipsStatusState();
}

class ChipsStatusState extends State<ChipsStatus> {
  final chips = const [
    'Tudo',
    'Em análise',
    'Melhoria Solicitada',
    'Recusada',
    'Aprovada',
  ];

  final chipColors = const [
    Color(0xFFEAF3FF), // Tudo
    Color(0xFFEFF8FF), // Em análise
    Color(0xFFFFF5E6), // Melhoria solicitada
    Color(0xFFFFEBEE), // Recusada
    Color(0xFFE8F5E9), // Aprovada
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(chips.length, (i) {
            final isSelected = i == selected;
            return Padding(
              padding: EdgeInsets.only(right: i == chips.length - 1 ? 0 : 8),
              child: FilterChip(
                showCheckmark: false,
                selected: isSelected,
                label: Text(chips[i]),
                onSelected: (_) => setState(() => selected = i),
                selectedColor: chipColors[i].withOpacity(0.8),
                backgroundColor: chipColors[i],
                labelStyle: TextStyle(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                shape: StadiumBorder(
                  side: BorderSide(color: chipColors[i].withOpacity(0.8)),
                ),
              ),
            );
          }),
        ),
      ),
    );
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
