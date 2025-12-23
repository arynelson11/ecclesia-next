import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_cubit.dart';

class MasterAdminPage extends StatelessWidget {
  const MasterAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7), // Sóbrio
      appBar: AppBar(
        title: const Text(
          'MASTER ADMIN',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5, fontSize: 14, color: Colors.black54),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.red),
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configurações da Igreja',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            const Text('Gerencie a identidade e pagamentos da sua instância.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),

            // Card Identidade Visual
            _buildSectionCard(
              title: 'Identidade Visual',
              icon: Icons.palette_outlined,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 50, width: 50,
                      decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                      child: const Icon(Icons.upload, color: Colors.white),
                    ),
                    title: const Text('Logo da Igreja'),
                    subtitle: const Text('Toque para alterar'),
                    trailing: const Icon(Icons.edit, size: 16),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 40, width: 40,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                    ),
                    title: const Text('Cor Primária'),
                    subtitle: const Text('Toque para personalizar'),
                    trailing: const Icon(Icons.colorize, size: 20),
                    onTap: () {
                       showDialog(
                         context: context,
                         builder: (context) => SimpleDialog(
                           title: const Text('Escolha a Cor do App'),
                           children: [
                             _buildColorOption(context, 'Azul (Padrão)', '#2196F3', Colors.blue),
                             _buildColorOption(context, 'Roxo Moderno', '#9C27B0', Colors.purple),
                             _buildColorOption(context, 'Verde Esperança', '#4CAF50', Colors.green),
                             _buildColorOption(context, 'Laranja Vibrante', '#FF9800', Colors.orange),
                             _buildColorOption(context, 'Vermelho Paixão', '#F44336', Colors.red),
                             _buildColorOption(context, 'Preto Premium', '#000000', Colors.black),
                           ],
                         ),
                       );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Card Pagamentos
            _buildSectionCard(
              title: 'Pagamentos e Gateway',
              icon: Icons.payments_outlined,
              child: Column(
                children: [
                  _buildStatusRow('Stripe Connect', true),
                  const SizedBox(height: 12),
                  _buildStatusRow('Chave Pix Admin', true),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('GERENCIAR PLANO SAAS'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Card Auditoria
            _buildSectionCard(
              title: 'Auditoria de Acesso',
              icon: Icons.security,
              child: Column(
                children: [
                  _buildAuditItem('Pr. Ricardo', 'Login Web', 'Agora'),
                  _buildAuditItem('Sec. Ana', 'Edição Membro', '10 min atrás'),
                  _buildAuditItem('Líder Carlos', 'Chamada Célula', '1h atrás'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required IconData icon, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [AppTheme.kSoftShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black87),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, bool active) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: active ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(active ? Icons.check_circle : Icons.error, size: 14, color: active ? Colors.green : Colors.red),
              const SizedBox(width: 4),
              Text(active ? 'Conectado' : 'Desconectado', style: TextStyle(color: active ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuditItem(String user, String action, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(radius: 12, backgroundColor: Colors.grey[200], child: Text(user[0], style: const TextStyle(fontSize: 10, color: Colors.black))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(action, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildColorOption(BuildContext context, String name, String hex, Color color) {
    return SimpleDialogOption(
      onPressed: () {
        context.read<ThemeCubit>().updateTheme({'primaryColor': hex});
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Tema atualizado para $name!'),
          backgroundColor: color,
        ));
      },
      child: Row(
        children: [
          Container(width: 24, height: 24, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Text(name),
        ],
      ),
    );
  }
}
