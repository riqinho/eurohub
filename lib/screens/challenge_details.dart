import 'package:eurohub/routes.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ChallengeDetailsScreen extends StatelessWidget {
  const ChallengeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String title = (args?['title'] as String?) ?? 'Título do desafio';
    final String tag = (args?['tag'] as String?) ?? 'Comercial';
    final String desc =
        (args?['description'] as String?) ?? 'Descrição breve do desafio…';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.kCard,
        body: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                // HEADER com imagem + overlay + título
                SliverAppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  pinned: true,
                  expandedHeight: 220,
                  backgroundColor: AppColors.kPrimary,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        // sua imagem de fundo
                        Image.asset(
                          'assets/images/bg-challenge.png', // troque pelo seu asset
                          fit: BoxFit.cover,
                        ),
                        // overlay para ler o texto
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black54],
                            ),
                          ),
                        ),
                        // título sobre a imagem
                        Positioned(
                          left: 16,
                          right: 16,
                          bottom: 16,
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // TAB BAR presa no topo
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabBarDelegate(
                    TabBar(
                      labelColor: AppColors.kPrimary,
                      unselectedLabelColor: AppColors.kMuted,
                      indicatorColor: AppColors.kPrimary,
                      tabs: const [
                        Tab(text: 'Sobre o Desafio'),
                        Tab(text: 'Ideias Enviadas'),
                      ],
                    ),
                  ),
                ),
              ],
          // CONTEÚDO das abas
          body: TabBarView(
            children: [
              // ----- ABA 1: Sobre o Desafio -----
              ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  _Tag(
                    text: tag,
                    bg: const Color(0xFFFFE5E5),
                    fg: AppColors.kDanger,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(desc, style: const TextStyle(color: AppColors.kMuted)),
                  const SizedBox(height: 20),

                  // Seções de exemplo (troque pelo seu conteúdo real)
                  const _SectionTitle('O que queremos resolver?'),
                  const SizedBox(height: 6),
                  const Text(
                    'Coloque aqui o texto explicando o problema que o desafio quer resolver.',
                    style: TextStyle(color: AppColors.kMuted),
                  ),
                  const SizedBox(height: 16),
                  const _SectionTitle('O que buscamos?'),
                  const SizedBox(height: 6),
                  const Text(
                    'Coloque aqui os objetivos/expectativas das ideias.',
                    style: TextStyle(color: AppColors.kMuted),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  const _SectionTitle('Enviar Ideia'),
                  const SizedBox(height: 6),
                  const Text(
                    'Tem alguma ideia de como podemos resolver esse desafio? Envie pra gente!',
                    style: TextStyle(color: AppColors.kMuted),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.chat);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kPrimary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Enviar Ideia'),
                    ),
                  ),
                ],
              ),

              // ----- ABA 2: Ideias Enviadas -----
              ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  // Troque pelo seu SliverList/ListView.builder com ideias reais
                  Center(child: Text('Nenhuma ideia enviada ainda.')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// SliverPersistentHeaderDelegate para fixar o TabBar
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _TabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.kCard, // fundo branco sob as abas
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) => false;
}

/// Chip simples para a etiqueta (ex.: "Comercial")
class _Tag extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;
  const _Tag({required this.text, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(text, style: TextStyle(fontSize: 12, color: fg)),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );
  }
}
