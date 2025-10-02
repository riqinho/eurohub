import 'package:eurohub/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatIdeiaScreen extends StatefulWidget {
  const ChatIdeiaScreen({super.key});

  @override
  State<ChatIdeiaScreen> createState() => _ChatIdeiaScreenState();
}

class _ChatIdeiaScreenState extends State<ChatIdeiaScreen> {
  bool _showTyping = true; // Euri está "digitando"
  bool _showMessage = false; // Quando a mensagem aparece

  @override
  void initState() {
    super.initState();

    // Simula o tempo de "pensando..."
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showTyping = false;
        _showMessage = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kCard,
      appBar: AppBar(
        backgroundColor: AppColors.kCard,
        elevation: 0,
        title: const Text(
          "Enviar Ideia",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Bolha do Euri
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(backgroundColor: AppColors.kPrimary),
                    const SizedBox(width: 8),

                    // Mostra os 3 pontinhos ou a mensagem final
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:
                            _showTyping
                                ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    _Dot(),
                                    SizedBox(width: 4),
                                    _Dot(),
                                    SizedBox(width: 4),
                                    _Dot(),
                                  ],
                                )
                                : _showMessage
                                ? const Text(
                                  "Olá, eu sou o Euri e vou te ajudar a desenvolver sua ideia!\n\n"
                                  "Se quiser me mandar o que tem até agora, posso te ajudar a melhorar, "
                                  "estruturar e configurar todo o resto.\n"
                                  "Se já tiver tudo pronto, é só me informar o título e a ideia completa. "
                                  "Vamos nessa?",
                                  style: TextStyle(fontSize: 15),
                                )
                                : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Campo de digitação
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Digite aqui sua mensagem",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.kPrimary),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget simples para criar animação de "digitando..."
class _Dot extends StatefulWidget {
  const _Dot();

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: const CircleAvatar(radius: 4, backgroundColor: Colors.grey),
    );
  }
}
