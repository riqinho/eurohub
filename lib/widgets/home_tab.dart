import 'package:eurohub/theme/app_colors.dart';
import 'package:flutter/material.dart';

// Tipos de texto locais (opcional: pode mover p/ um theme depois)
TextStyle get titleLg =>
    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
TextStyle get titleMd =>
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
TextStyle get body => const TextStyle(fontSize: 14, color: AppColors.kMuted);

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ---------- BLOCO 2: Header ----------
            SliverToBoxAdapter(child: _Header()),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            // ---------- BLOCO 4: Minha Jornada ----------
            SliverToBoxAdapter(child: _MinhaJornadaCard()),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            // ---------- BLOCO 5: Conquistas ----------
            SliverToBoxAdapter(child: _ConquistasRow()),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            // ---------- BLOCO 6: Minhas contribuições ----------
            SliverToBoxAdapter(
              child: _SectionTitle(
                title: 'Minhas contribuições',
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('Ver tudo'),
                ),
              ),
            ),
            SliverToBoxAdapter(child: _ContribCard()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
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
                  onPressed: () {},
                  child: const Text('Ver tudo'),
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

// BLOCO 2 — Header com avatar + saudação
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            // backgroundImage: const AssetImage(
            //   'assets/images/avatar.png',
            // ), // troque pelo seu
            backgroundColor: Colors.grey.shade300,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 18),
                children: const [
                  TextSpan(
                    text: 'Boa-tarde, ',
                    style: TextStyle(fontWeight: FontWeight.w400),
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

// BLOCO 3 — Barra de busca “pílula”
class _SearchPill extends StatelessWidget {
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
        child: Row(
          children: const [
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

// BLOCO 4 — Card “Minha Jornada”
class _MinhaJornadaCard extends StatelessWidget {
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
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Minha Jornada',
                      style: TextStyle(fontSize: 14, color: AppColors.kMuted),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Nível 2',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE5E7EB),
                              ),
                            ),
                            child: const Text(
                              '13 pontos para 3',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.kMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: AppColors.kLabel),
            ],
          ),
        ),
      ),
    );
  }
}

// BLOCO 5 — Conquistas (3 troféus)
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
          const Text(
            'Conquistas recentes',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
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
              Text('Monitoramento Inteligente via IoT', style: titleMd),
              const SizedBox(height: 6),
              Text(
                'Utilizar sensores de IoT nas linhas de embalagem para monitorar em tempo real o desempenho...',
                style: body,
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
class _ChipsArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chips = [
      'Data',
      'Six Sigma',
      'Ventures',
      'Open Innovation',
      'Design',
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            chips
                .map(
                  (c) => FilterChip(
                    selected: c == 'Data',
                    label: Text(c),
                    onSelected: (_) {},
                    selectedColor: const Color(0xFFEAF3FF),
                    labelStyle: TextStyle(
                      color: c == 'Data' ? AppColors.kPrimary : Colors.black87,
                    ),
                    shape: StadiumBorder(
                      side: BorderSide(color: const Color(0xFFE5E7EB)),
                    ),
                    backgroundColor: Colors.white,
                  ),
                )
                .toList(),
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
                style: titleMd,
              ),
              const SizedBox(height: 6),
              Text(
                'Como podemos apoiar farmácias independentes em seu processo de transformação digital?',
                style: body,
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
          Expanded(child: Text(title, style: titleLg.copyWith(fontSize: 18))),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
