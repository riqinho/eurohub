import 'package:eurohub/data/challenge_repository.dart';
import 'package:eurohub/data/idea_repository.dart';
import 'package:eurohub/models/challenge.dart';
import 'package:eurohub/models/ideia.dart';
import 'package:eurohub/theme/app_colors.dart';
import 'package:eurohub/theme/app_text.dart';
import 'package:eurohub/widgets/challenge_card.dart';
import 'package:eurohub/widgets/idea_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ====== Home Tab =================================================
class HomeTab extends StatelessWidget {
  const HomeTab({super.key, required this.onNavigate});

  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ---------- BLOCO 1: Header ----------
            const SliverToBoxAdapter(child: _Header()),
            const SliverToBoxAdapter(child: SizedBox(height: 22)),

            // ---------- BLOCO 2: Minha Jornada ----------
            const SliverToBoxAdapter(
              child: _SectionTitle(title: 'Minha Jornada'),
            ),
            const SliverToBoxAdapter(
              child: LevelCard(level: 2, progress: 0.28, pointsToNext: 13),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 22)),

            // ---------- BLOCO 3: Conquistas (BADGES COLORIDOS) ----------
            const SliverToBoxAdapter(
              child: _SectionSubTitle(title: 'Conquistas Recentes'),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            const SliverToBoxAdapter(child: _ConquistasRow()), // <- atualizado
            const SliverToBoxAdapter(child: SizedBox(height: 22)),

            // ---------- BLOCO 4: Minhas contribuições (carrossel + JSON) ----------
            SliverToBoxAdapter(
              child: _SectionSubTitle(
                title: 'Minhas contribuições',
                trailing: TextButton(
                  onPressed: () => onNavigate(1), // vai para a guia IDEIAS
                  child: const Text(
                    'Ver tudo',
                    style: TextStyle(color: AppColors.kMuted),
                  ),
                ),
              ),
            ),
            const _MinhasIdeiasSliver(), // <<< carrossel horizontal
            const SliverToBoxAdapter(child: SizedBox(height: 22)),

            // ---------- BLOCO 7: Desenvolvimento & Cultura + chips ----------
            const SliverToBoxAdapter(
              child: _SectionTitle(
                title: 'Desenvolvimento & Cultura Eurofarma',
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
            const SliverToBoxAdapter(
              child: _SectionSubTitle(title: 'Áreas de Inovação'),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            const SliverToBoxAdapter(child: _ChipsArea()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // ---------- BLOCO 8: Desafios Ativos (carrossel com tamanho fixo) ----------
            SliverToBoxAdapter(
              child: _SectionSubTitle(
                title: 'Desafios Ativos',
                trailing: TextButton(
                  onPressed: () => onNavigate(2), // vai para a guia DESAFIOS
                  child: const Text(
                    'Ver tudo',
                    style: TextStyle(color: AppColors.kMuted),
                  ),
                ),
              ),
            ),
            const _DesafiosAtivosSliver(), // <<< agora com largura/altura fixas
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}

// ====================== BLOCO 1 — Header ========================
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: const AssetImage('assets/images/person.png'),
            backgroundColor: Colors.grey.shade300,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text.rich(
              TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 22),
                children: [
                  TextSpan(
                    text: 'Boa-tarde, ',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: 'Marina',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
    );
  }
}

// ================== BLOCO 2 — Card “Minha Jornada” ==============
class LevelCard extends StatelessWidget {
  const LevelCard({
    super.key,
    required this.level,
    required this.progress,
    required this.pointsToNext,
  });

  final int level;
  final double progress;
  final int pointsToNext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        color: AppColors.kPill,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nível $level',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  tween: Tween(begin: 0, end: progress.clamp(0, 1)),
                  builder: (context, value, _) {
                    return LinearProgressIndicator(
                      value: value,
                      minHeight: 10,
                      backgroundColor: theme.colorScheme.outlineVariant,
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.kHeaderTop,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '$pointsToNext pontos para nível ${level + 1}',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= BLOCO 3 — Conquistas (BADGES COLORIDOS) =============
class _ConquistasRow extends StatelessWidget {
  const _ConquistasRow();

  @override
  Widget build(BuildContext context) {
    const badges = [
      _BadgeData(Icons.star, 'Inovador', Colors.amber),
      _BadgeData(Icons.flash_on, 'Engajado', Colors.orange),
      _BadgeData(Icons.leaderboard, 'Top 10', Colors.blue),
      _BadgeData(Icons.handshake, 'Colaborador', Colors.green),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(badges.length, (i) {
              final b = badges[i];
              return Padding(
                padding: EdgeInsets.only(
                  right: i == badges.length - 1 ? 0 : 12,
                ),
                child: _Badge(icon: b.icon, label: b.label, color: b.color),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _BadgeData {
  final IconData icon;
  final String label;
  final Color color;
  const _BadgeData(this.icon, this.label, this.color);
}

class _Badge extends StatelessWidget {
  const _Badge({required this.icon, required this.label, required this.color});

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.18),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ======= BLOCO 4 — Minhas contribuições (carrossel + JSON) ======
class _MinhasIdeiasSliver extends StatelessWidget {
  const _MinhasIdeiasSliver();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FutureBuilder<List<Idea>>(
        future: IdeaRepository.loadFromAssets(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (snap.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text('Erro ao carregar: ${snap.error}'),
            );
          }
          final itens = snap.data ?? [];
          if (itens.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text('Você ainda não enviou contribuições.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(itens.length, (i) {
                    final c = itens[i];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: i == itens.length - 1 ? 0 : 12,
                      ),
                      child: IdeaCard(
                        statusLabel: c.status,
                        title: c.title,
                        summary: c.summary,
                        votes: c.votes,
                        date: c.date,
                        onTap: () {
                          // TODO: navegar para detalhe da contribuição
                        },
                        statusColor: _mapStatusBg(c.status),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // mapeamento simples de cor do chip por status
  static Color _mapStatusBg(String status) {
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
}

// ======= BLOCO 7 — Chips “Áreas de Inovação” (scroll) ===========
class _ChipsArea extends StatefulWidget {
  const _ChipsArea();

  @override
  State<_ChipsArea> createState() => _ChipsAreaState();
}

class _ChipsAreaState extends State<_ChipsArea> {
  final chips = const [
    'Data',
    'Six Sigma',
    'Ventures',
    'Open Innovation',
    'Design',
  ];
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
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
                  selectedColor: AppColors.kPill,
                  backgroundColor: AppColors.kPill,
                  labelStyle: TextStyle(
                    color: Colors.black87,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                  shape: const StadiumBorder(
                    side: BorderSide(color: AppColors.kPill),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ======= BLOCO 8 — Desafios Ativos (carrossel com tamanho fixo) ======
class _DesafiosAtivosSliver extends StatelessWidget {
  const _DesafiosAtivosSliver();

  static const double _cardWidth = 260; // largura fixa para todos
  static const double _cardHeight = 168; // altura fixa para todos

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FutureBuilder<List<Challenge>>(
        future: ChallengeRepository.loadFromAssets(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (snap.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text('Erro ao carregar desafios: ${snap.error}'),
            );
          }

          final desafios = snap.data ?? [];
          if (desafios.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text('Nenhum desafio ativo no momento.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(desafios.length, (i) {
                    final d = desafios[i];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: i == desafios.length - 1 ? 0 : 12,
                      ),
                      child: SizedBox(
                        // <- garante tamanho idêntico
                        width: _cardWidth,
                        height: _cardHeight,
                        child: ChallengeCard(
                          badgeLabel: d.area,
                          title: d.title,
                          summary: d.summary,
                          badgeColor: _mapBadgeColor(d.area),
                          badgeTextColor: _mapBadgeTextColor(d.area),
                          onTap: () {
                            // TODO: navegar para detalhes do desafio
                          },
                          oQueQueremosResolver: d.oQueQueremosResolver,
                          oQueBuscamos: d.oQueBuscamos,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
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
}

// =============== Títulos reutilizáveis ==========================
class _SectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const _SectionTitle({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.titleLg.copyWith(fontSize: 18),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _SectionSubTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const _SectionSubTitle({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.titleLg.copyWith(fontSize: 14),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
