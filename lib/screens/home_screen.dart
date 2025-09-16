import 'package:eurohub/widgets/tabs/challenge_tab.dart';
import 'package:eurohub/widgets/tabs/home_tab.dart';
import 'package:eurohub/widgets/tabs/ideas_tab.dart';
import 'package:eurohub/widgets/tabs/profile_tab.dart';
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

  void _onNavChange(int index) => setState(() => _tab = index);

  // PageStorageKey ajuda a manter posição de scroll ao trocar de aba
  late final List<Widget> _pages = [
    HomeTab(key: PageStorageKey('home'), onNavigate: _onNavChange),
    IdeasTab(key: PageStorageKey('ideas')),
    ChallengesTab(key: PageStorageKey('challenges')),
    ProfileTab(key: PageStorageKey('profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      bottomNavigationBar: BottomNav(index: _tab, onChanged: _onNavChange),
      body: IndexedStack(index: _tab, children: _pages),
    );
  }
}
