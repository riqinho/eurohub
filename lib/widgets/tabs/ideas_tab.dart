import 'package:eurohub/theme/app_colors.dart';
import 'package:eurohub/theme/app_text.dart';
import 'package:flutter/material.dart';

class IdeasTab extends StatelessWidget {
  const IdeasTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kCard,
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
            style: const TextStyle(color: Colors.black, fontSize: 22),
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
class ChipsStatus extends StatefulWidget {
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
