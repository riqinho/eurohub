import 'package:eurohub/widgets/challenge_tab.dart';
import 'package:eurohub/widgets/home_tab.dart';
import 'package:eurohub/widgets/ideas_tab.dart';
import 'package:eurohub/widgets/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:eurohub/widgets/nav_bottom.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  // PageStorageKey ajuda a manter posição de scroll ao trocar de aba
  final List<Widget> _pages = const [
    HomeTab(key: PageStorageKey('home')),
    IdeasTab(key: PageStorageKey('ideas')),
    ChallengesTab(key: PageStorageKey('challenges')),
    ProfileTab(key: PageStorageKey('profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      bottomNavigationBar: BottomNav(
        index: _tab,
        onChanged: (i) => setState(() => _tab = i),
      ),
      body: IndexedStack(index: _tab, children: _pages),
    );
  }
}
