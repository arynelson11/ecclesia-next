import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DevotionalDetailPage extends StatelessWidget {
  final Map<String, dynamic> devotionalData;

  const DevotionalDetailPage({super.key, required this.devotionalData});

  @override
  Widget build(BuildContext context) {
    final String title = devotionalData['title'] ?? 'Devocional';
    final String? imageUrl = devotionalData['imageUrl'];
    final String category = devotionalData['category'] ?? 'Geral';

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // 1. Capa Imersiva (SliverAppBar)
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black), // Botão voltar
            flexibleSpace: FlexibleSpaceBar(
              background: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
            ),
          ),

          // 2. Conteúdo do Texto
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categoria
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Título
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Divider
                  Divider(color: Colors.grey[200], thickness: 1),
                  const SizedBox(height: 24),

                  // Texto do Devocional (Gerado Automaticamente para UX)
                  Text(
                    _generateDevotionalText(),
                    style: GoogleFonts.merriweather( // Fonte Serifada para leitura
                      fontSize: 18,
                      color: const Color(0xFF333333), // Cinza Escuro
                      height: 1.8, // Espaçamento de linha confortável
                    ),
                  ),
                  
                  const SizedBox(height: 48), // Espaço final
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _generateDevotionalText() {
    return """
Em tempos de incerteza e velocidade, muitas vezes nos encontramos perdidos em meio ao ruído do dia a dia. A busca pela paz interior não é uma jornada para longe de nós mesmos, mas um reencontro com o que há de mais sagrado em nosso interior.

A verdadeira serenidade não significa a ausência de tempestades, mas a certeza de que temos um refúgio seguro, uma âncora firme que nos sustenta quando as ondas sobem. Quando olhamos para as escrituras, vemos que o convite é sempre para "aquietar-se".

"Aquietai-vos e sabei que eu sou Deus."

Este convite não é apenas um pedido de silêncio externo, mas de uma postura interna de confiança. É soltar o controle, respirar fundo e lembrar que não estamos sozinhos nesta caminhada.

A gratidão é a chave que abre a porta para essa paz. Quando começamos a agradecer, nossos olhos se desviam do que falta e se voltam para o que já temos. O simples ato de respirar, o sol que nasce, o alimento na mesa, os amigos que caminham conosco. Tudo é graça.

Que hoje você possa encontrar um momento para parar. Desligue as notificações, olhe para o céu, faça uma oração sincera. Não precisa de palavras bonitas, apenas de um coração aberto.

Permita-se ser cuidado. Permita-se descansar. A jornada é longa, mas a companhia é eterna. E a paz que excede todo o entendimento guardará o seu coração e a sua mente.
    """;
  }
}
