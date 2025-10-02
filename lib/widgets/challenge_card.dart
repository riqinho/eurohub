// ======= Card de Desafio (parametrizável) =======================
import 'package:eurohub/routes.dart';
import 'package:eurohub/theme/app_colors.dart';
import 'package:eurohub/theme/app_text.dart';
import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({
    super.key,
    required this.badgeLabel,
    required this.title,
    required this.summary,
    this.badgeColor = const Color(0xFFFFE5E5),
    this.badgeTextColor = AppColors.kDanger,
    this.onTap,
    this.width = 300,
  });

  final String badgeLabel;
  final String title;
  final String summary;
  final Color badgeColor;
  final Color badgeTextColor;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Material(
        color: AppColors.kCard,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.challengeDetail,
              arguments: {'title': title},
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // etiqueta/área
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      badgeLabel,
                      style: TextStyle(fontSize: 12, color: badgeTextColor),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: AppTextStyles.titleMd,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    summary,
                    style: AppTextStyles.body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
