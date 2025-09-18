import 'package:eurohub/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IdeaDetailsScreen extends StatelessWidget {
  const IdeaDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kCard,
      appBar: AppBar(
        backgroundColor: AppColors.kCard,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.construction,
              size: 60,
              color: Color.fromARGB(110, 158, 158, 158),
            ),
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
      ),
    );
  }
}
