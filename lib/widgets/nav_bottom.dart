// BLOCO 1 — Bottom Navigation custom com cantos arredondados
import 'package:eurohub/theme/app_colors.dart';
import 'package:eurohub/widgets/nav_item.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const BottomNav({super.key, required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.kBg, // fundo branco do nav
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Color(0x1A000000),
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 6),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavItem(
              icon: Icons.home_rounded,
              label: 'Início',
              active: index == 0,
              onTap: () => onChanged(0),
            ),
            NavItem(
              icon: Icons.lightbulb,
              label: 'Ideias',
              active: index == 1,
              onTap: () => onChanged(1),
            ),
            NavItem(
              icon: Icons.track_changes_rounded,
              label: 'Desafios',
              active: index == 2,
              onTap: () => onChanged(2),
            ),
            NavItem(
              icon: Icons.person_2_outlined,
              label: 'Perfil',
              active: index == 3,
              onTap: () => onChanged(3),
            ),
          ],
        ),
      ),
    );
  }
}
