import 'package:eurohub/routes.dart';
import 'package:eurohub/theme/app_colors.dart';
import 'package:eurohub/theme/app_text.dart';
import 'package:flutter/material.dart';

class IdeaCard extends StatelessWidget {
  const IdeaCard({
    super.key,
    required this.statusLabel,
    required this.title,
    required this.summary,
    required this.votes,
    required this.date, // DateTime do backend
    this.statusColor, // opcional: cor do chip
    this.onTap,
    this.width = 300, // largura fixa p/ carrossel
  });

  final String statusLabel;
  final String title;
  final String summary;
  final int votes;
  final DateTime date;
  final Color? statusColor;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Material(
        color: AppColors.kCard,
        borderRadius: BorderRadius.circular(12),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, Routes.ideaDetail);
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  // status chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor ?? const Color(0xFFEFF8FF),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.kLabel),
                    ),
                    child: Text(
                      statusLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.kPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    title,
                    style: AppTextStyles.titleMd,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    summary,
                    style: AppTextStyles.body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: AppColors.kLabel,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$votes votos',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.kMuted,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(date),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.kMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime d) {
    const meses = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez',
    ];
    final dia = d.day.toString().padLeft(2, '0');
    final mes = meses[d.month - 1];
    return '$dia de $mes, ${d.year}';
  }
}
