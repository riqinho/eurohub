import 'package:eurohub/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kCard,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto e dados
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/person.png'),
            ),
            const SizedBox(height: 12),
            const Text(
              'Marina Silva',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.kPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'marina.silva@eurohub.com',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Conquistas (título e itens alinhados ao início)
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Conquistas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            const _AchievementsWrap(),
            const SizedBox(height: 50),

            // Configurações (com "Editar perfil")
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Configurações',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0, // <- sem sombra
              shadowColor: Colors.transparent, // <- sem sombra
              surfaceTintColor: Colors.transparent, // <- remove overlay do M3
              child: Column(
                children: [
                  _SettingsTile(
                    icon: Icons.edit,
                    label: 'Editar perfil',
                    onTap: () {
                      // TODO: navegar para tela de edição
                    },
                  ),
                  const Divider(height: 0),
                  _SettingsTile(
                    icon: Icons.lock,
                    label: 'Alterar senha',
                    onTap: () {},
                  ),
                  const Divider(height: 0),
                  _SettingsTile(
                    icon: Icons.language,
                    label: 'Idioma',
                    onTap: () {},
                  ),
                  const Divider(height: 0),
                  _SettingsTile(
                    icon: Icons.logout,
                    label: 'Sair',
                    onTap: () {
                      // TODO: logout
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Conquistas (formato anterior com Wrap) ----------
class _AchievementsWrap extends StatelessWidget {
  const _AchievementsWrap();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start, // alinhado à esquerda
      runAlignment: WrapAlignment.start,
      spacing: 12,
      children: const [
        _AchievementBadge(
          icon: Icons.star,
          label: 'Inovador',
          color: Colors.amber,
        ),
        _AchievementBadge(
          icon: Icons.flash_on,
          label: 'Engajado',
          color: Colors.orange,
        ),
        _AchievementBadge(
          icon: Icons.leaderboard,
          label: 'Top 10',
          color: Colors.blue,
        ),
        _AchievementBadge(
          icon: Icons.handshake,
          label: 'Colaborador',
          color: Colors.green,
        ),
      ],
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _AchievementBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96, // largura padrão do layout anterior
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.center, // rótulo alinhado ao centro
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.start, // texto começa no canto
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ---------- Item de Configurações ----------
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.kPill,
      leading: Icon(icon, color: AppColors.kLabel),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
