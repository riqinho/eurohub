import 'package:eurohub/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.construction, size: 60, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'Em construção',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: AppColors.kPrimary,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Estamos preparando algo legal aqui!',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
