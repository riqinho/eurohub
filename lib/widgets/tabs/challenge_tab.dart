import 'package:eurohub/routes.dart';
import 'package:eurohub/theme/app_colors.dart';
import 'package:flutter/material.dart';

// Tipos de texto locais (opcional: pode mover p/ um theme depois)
TextStyle get titleLg =>
    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
TextStyle get titleMd =>
    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
TextStyle get body => const TextStyle(fontSize: 14, color: AppColors.kMuted);

class ChallengesTab extends StatelessWidget {
  const ChallengesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: Header()),
            SliverToBoxAdapter(child: _SearchPill()),
            SliverToBoxAdapter(
              child: _DesafioCard(
                id: 'c1',
                tag: 'Comercial',
                title: 'Transformação digital para farmácias independentes',
                description:
                    'Como podemos apoiar farmácias independentes em seu processo de transformação digital?',
              ),
            ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 18),
              children: const [
                TextSpan(
                  text: 'Desafios',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Text(
            'Participe dos desafios abertos e colabore com ideias que podem transformar a Eurofarma.',
          ),
        ],
      ),
    );
  }
}

class _SearchPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.kPill,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: const [
            Icon(Icons.search_rounded, color: AppColors.kLabel),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Buscar por nome, categoria, área…',
                style: TextStyle(color: AppColors.kLabel, fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// BLOCO 8 — Card de Desafio Ativo

class _DesafioCard extends StatelessWidget {
  final String id;
  final String tag;
  final String title;
  final String description;

  const _DesafioCard({
    super.key,
    required this.id,
    required this.tag,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Material(
        // material p/ efeito de ripple
        color: AppColors.kCard,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: const Color(0x11000000),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.challengeDetail,
              arguments: {
                'id': id,
                'tag': tag,
                'title': title,
                'description': description,
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // etiqueta
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE5E5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.kDanger,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(title, style: titleMd),
                const SizedBox(height: 6),
                Text(description, style: body),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
