import 'package:eurohub/theme/app_colors.dart';
import 'package:eurohub/theme/app_text.dart';
import 'package:flutter/material.dart';

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
            SliverToBoxAdapter(child: _Header()),
            const SliverToBoxAdapter(child: SizedBox(height: 22)),
            // ---------- BLOCO 2: Minha Jornada ----------
            SliverToBoxAdapter(child: _SectionTitle(title: 'Minha Jornada')),
            SliverToBoxAdapter(
              child: LevelCard(level: 2, progress: 0.28, pointsToNext: 13),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 22)),
            // ---------- BLOCO 3: Conquistas ----------
            SliverToBoxAdapter(
              child: _SectionTitle(title: 'Conquitas Recentes'),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 22)),
            SliverToBoxAdapter(child: _ConquistasRow()),
            const SliverToBoxAdapter(child: SizedBox(height: 22)),
            // ---------- BLOCO 4: Minhas contribuições ----------
            SliverToBoxAdapter(
              child: _SectionTitle(
                title: 'Minhas contribuições',
                trailing: TextButton(
                  onPressed: () {
                    onNavigate(1);
                  },
                  child: const Text(
                    'Ver tudo',
                    style: TextStyle(color: AppColors.kMuted),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: _ContribCard()),
            const SliverToBoxAdapter(child: SizedBox(height: 22)),
            // ---------- BLOCO 7: Desenvolvimento & Cultura + chips ----------
            SliverToBoxAdapter(
              child: _SectionTitle(
                title: 'Desenvolvimento & Cultura Eurofarma',
              ),
            ),
            SliverToBoxAdapter(child: _ChipsArea()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            // ---------- BLOCO 8: Desafios Ativos ----------
            SliverToBoxAdapter(
              child: _SectionTitle(
                title: 'Desafios Ativos',
                trailing: TextButton(
                  onPressed: () {
                    onNavigate(2);
                  },
                  child: const Text(
                    'Ver tudo',
                    style: TextStyle(color: AppColors.kMuted),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: _DesafioCard()),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}

// BLOCO 1 — Header com avatar + saudação
class _Header extends StatelessWidget {
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
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 22),
                children: const [
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

// BLOCO 2 — Card “Minha Jornada”
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
                      valueColor: AlwaysStoppedAnimation(AppColors.kHeaderTop),
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

// BLOCO 3 — Conquistas (3 troféus)
class _ConquistasRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget pill(IconData icon) => Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(color: AppColors.kPill, shape: BoxShape.circle),
      child: Icon(icon, color: AppColors.kLabel),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              pill(Icons.emoji_events_outlined),
              const SizedBox(width: 12),
              pill(Icons.emoji_events_outlined),
              const SizedBox(width: 12),
              pill(Icons.emoji_events_outlined),
            ],
          ),
        ],
      ),
    );
  }
}

// BLOCO 6 — Card de contribuição
class _ContribCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kCard,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color(0x11000000),
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // status chip
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF8FF),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: const Color(0xFFD0E3FF)),
                  ),
                  child: const Text(
                    'Em análise',
                    style: TextStyle(fontSize: 12, color: AppColors.kPrimary),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Monitoramento Inteligente via IoT',
                style: AppTextStyles.titleMd,
              ),
              const SizedBox(height: 6),
              Text(
                'Utilizar sensores de IoT nas linhas de embalagem para monitorar em tempo real o desempenho...',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: AppColors.kLabel,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    '0 votos',
                    style: TextStyle(fontSize: 12, color: AppColors.kMuted),
                  ),
                  const Spacer(),
                  const Text(
                    '04 de Mai, 2025',
                    style: TextStyle(fontSize: 12, color: AppColors.kMuted),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// BLOCO 7 — Chips “Áreas de Inovação”
class _ChipsArea extends StatefulWidget {
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
  int selected = 0; // “Data” inicialmente

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
                showCheckmark: false, // ① sem check
                selected: isSelected,
                label: Text(chips[i]),
                onSelected: (_) => setState(() => selected = i),
                selectedColor: const Color(
                  0xFFD7E7FF,
                ), // ② cor + escura quando selecionado
                backgroundColor: const Color(0xFFEAF3FF),
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.kHeaderTop : Colors.black87,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
                shape: StadiumBorder(side: BorderSide(color: AppColors.kPill)),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// BLOCO 8 — Card de Desafio Ativo
class _DesafioCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kCard,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color(0x11000000),
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // “Comercial” etiqueta
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE5E5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Comercial',
                  style: TextStyle(fontSize: 12, color: AppColors.kDanger),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Transformação digital para farmácias independentes',
                style: AppTextStyles.titleMd,
              ),
              const SizedBox(height: 6),
              Text(
                'Como podemos apoiar farmácias independentes em seu processo de transformação digital?',
                style: AppTextStyles.body,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Título de seção reutilizável
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
