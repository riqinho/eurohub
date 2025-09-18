import 'package:eurohub/routes.dart';
import 'package:eurohub/theme/app_colors.dart';
import 'package:eurohub/widgets/challenge_card.dart';
import 'package:flutter/material.dart';

// modelo + repositório
import 'package:eurohub/models/challenge.dart';
import 'package:eurohub/data/challenge_repository.dart';

// Tipos de texto locais (opcional: mover p/ theme depois)
TextStyle get titleLg =>
    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
TextStyle get titleMd =>
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
TextStyle get body => const TextStyle(fontSize: 14, color: AppColors.kMuted);

class ChallengesTab extends StatelessWidget {
  const ChallengesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kCard,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _Header()),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // const SliverToBoxAdapter(child: _SearchPill()),
            // const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 24),
              sliver: FutureBuilder<List<Challenge>>(
                future: ChallengeRepository.loadFromAssets(),
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
                        child: Text('Erro ao carregar desafios: ${snap.error}'),
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
                        child: Text('Nenhum desafio ativo no momento.'),
                      ),
                    );
                  }

                  // Lista vertical (estilo RecyclerView)
                  return SliverList.separated(
                    itemCount: itens.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final d = itens[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ChallengeCard(
                          badgeLabel: d.area,
                          title: d.title,
                          summary: d.summary,
                          badgeColor: _mapBadgeColor(d.area),
                          badgeTextColor: _mapBadgeTextColor(d.area),
                          onTap: () {
                            // TODO: navegar para detalhes do desafio
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

Color _mapBadgeColor(String area) {
  switch (area) {
    case 'Comercial':
      return const Color(0xFFFFE5E5);
    case 'Supply':
      return const Color(0xFFE8F5E9);
    case 'P&D':
      return const Color(0xFFFFF5E6);
    default:
      return const Color(0xFFEAF3FF);
  }
}

Color _mapBadgeTextColor(String area) {
  switch (area) {
    case 'Comercial':
      return AppColors.kDanger;
    case 'Supply':
      return const Color(0xFF1B5E20);
    case 'P&D':
      return const Color(0xFF9C6D00);
    default:
      return Colors.black87;
  }
}

// ---------- HEADER ----------
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Desafios',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),
          Text(
            'Participe dos desafios abertos e colabore com ideias que podem transformar a Eurofarma.',
          ),
        ],
      ),
    );
  }
}

// ---------- SEARCH PILL (opcional) ----------
class _SearchPill extends StatelessWidget {
  const _SearchPill();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.kPill,
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Row(
          children: [
            Icon(Icons.search_rounded, color: AppColors.kLabel),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Buscar por nome, categoria, área…',
                style: TextStyle(color: AppColors.kLabel, fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
