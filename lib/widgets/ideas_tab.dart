import 'package:eurohub/theme/app_colors.dart';
import 'package:flutter/material.dart';

// Tipos de texto locais (opcional: pode mover p/ um theme depois)
TextStyle get titleLg =>
    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
TextStyle get titleMd =>
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
TextStyle get body => const TextStyle(fontSize: 14, color: AppColors.kMuted);

class IdeasTab extends StatelessWidget {
  const IdeasTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: Header()),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverToBoxAdapter(child: ChipsStatus()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: ContribCard()),
          ],
        ),
      ),
    );
  }
}

// BLOCO 1 - HEADER
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Expanded(
        child: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 18),
            children: const [
              TextSpan(
                text: 'Minhas Ideias',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// BLOCO 2 - STATUS
class ChipsStatus extends StatelessWidget {
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

//  BLOCO 3 - IDEIAS
class ContribCard extends StatelessWidget {
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
