import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../home/presentation/cubit/content_cubit.dart';

class CreateDevotionalPage extends StatefulWidget {
  const CreateDevotionalPage({super.key});

  @override
  State<CreateDevotionalPage> createState() => _CreateDevotionalPageState();
}

class _CreateDevotionalPageState extends State<CreateDevotionalPage> {
  String _selectedCategory = 'Fé';
  final List<String> _categories = ['Fé', 'Jovens', 'Família', 'Vida Cristã', 'Liderança'];

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, size: 24, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('NOVO DEVOCIONAL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.kRadius),
                boxShadow: const [AppTheme.kSoftShadow],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('Título da Mensagem'),
                  _buildFilledInput(controller: _titleController, hint: 'Ex: O Poder da Oração'),
                  const SizedBox(height: 24),
                  _buildSectionLabel('Categoria'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _categories.map((category) {
                       final isSelected = _selectedCategory == category;
                       return ChoiceChip(
                         label: Text(category),
                         selected: isSelected,
                         selectedColor: Colors.black,
                         backgroundColor: Colors.grey[100],
                         labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.w700),
                         onSelected: (val) => setState(() => _selectedCategory = category),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                         showCheckmark: false,
                         side: BorderSide.none,
                       );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionLabel('Imagem de Capa (URL)'),
                  _buildFilledInput(controller: _imageController, hint: 'https://...', icon: Icons.link_rounded),
                  const SizedBox(height: 24),
                  _buildSectionLabel('Conteúdo'),
                  _buildFilledInput(controller: _contentController, hint: 'Escreva a mensagem aqui...', maxLines: 10),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              // Add to Cubit
              final newDevotional = {
                'title': _titleController.text.isNotEmpty ? _titleController.text : 'Sem Título',
                'category': _selectedCategory.toUpperCase(),
                'summary': _contentController.text.isNotEmpty ? _contentController.text : 'Sem conteúdo...',
                'imageUrl': _imageController.text.isNotEmpty ? _imageController.text : 'https://images.unsplash.com/photo-1507692049790-de58293a4697',
              };

              context.read<ContentCubit>().addDevotional(newDevotional);

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Devocional publicado com sucesso!')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text('PUBLICAR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black87)));

  Widget _buildFilledInput({required TextEditingController controller, required String hint, IconData? icon, int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF2F4F7), borderRadius: BorderRadius.circular(16)),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.normal),
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
