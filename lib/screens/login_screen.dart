import 'package:eurohub/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;

  // Decoração reutilizável para os campos tipo “pílula”
  InputDecoration _pillDecoration({
    required String hint,
    required IconData prefix,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.kLabel, fontSize: 16),
      prefixIcon: Icon(prefix, color: AppColors.kLabel),
      suffixIcon: suffix,
      filled: true,
      fillColor: AppColors.kFieldFill,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: AppColors.kPrimary, width: 1.2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.kCard,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---------- HEADER ----------
              SizedBox(
                height: 350,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Gradiente
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.kHeaderTop,
                            AppColors.kHeaderBottom,
                          ],
                        ),
                      ),
                    ),
                    // Logo central
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/euro-logo.svg',
                        height: 64,
                      ),
                    ),
                    // Wave que “encaixa” no branco
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -30,
                      child: SvgPicture.asset(
                        'assets/images/wave.svg',
                        width: w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),

              // ---------- CONTEÚDO ----------
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Título
                    const Text(
                      'Bem-vindo de Volta!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AppColors.kPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Subtítulo
                    const Text(
                      'Seu espaço de inovação e crescimento na Eurofarma.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: AppColors.kMuted),
                    ),

                    const SizedBox(height: 40),

                    // Campo Email (pílula + ícone à esquerda)
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: _pillDecoration(
                        hint: 'Email',
                        prefix: Icons.email_outlined,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Campo Senha (pílula + cadeado + olho mostrar/ocultar)
                    TextField(
                      obscureText: _obscure,
                      textInputAction: TextInputAction.done,
                      decoration: _pillDecoration(
                        hint: 'Senha',
                        prefix: Icons.lock_outline,
                        suffix: IconButton(
                          onPressed: () => setState(() => _obscure = !_obscure),
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.kMuted,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Esqueci minha senha
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: AppColors.kPrimary,
                        ),
                        onPressed: () {
                          // TODO: navegue para sua tela de recuperação
                          // Navigator.pushNamed(context, '/forgot');
                        },
                        child: const Text('Esqueci minha senha'),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Botão Entrar (pílula azul)
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kPrimary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Divisor "ou entre com"
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'ou entre com',
                            style: TextStyle(color: AppColors.kMuted),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Botões sociais circulares (branco + leve sombra)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialCircle(
                          child: Image.asset(
                            'assets/images/google.png',
                            height: 24,
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                        _SocialCircle(
                          child: Image.asset(
                            'assets/images/facebook.png',
                            height: 24,
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                        _SocialCircle(
                          child: Image.asset(
                            'assets/images/apple.png',
                            height: 24,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 35),

                    // Rodapé
                    Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text('Não tem uma conta? '),
                          GestureDetector(
                            onTap: () {
                              // TODO: navegue para cadastro
                              // Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              'Registre-se agora',
                              style: TextStyle(
                                color: AppColors.kPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Botão social circular com sombra suave
class _SocialCircle extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const _SocialCircle({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      elevation: 1.5,
      color: Colors.white,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(14), child: child),
      ),
    );
  }
}
