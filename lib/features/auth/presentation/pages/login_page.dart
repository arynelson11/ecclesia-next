import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../home/presentation/pages/main_scaffold.dart';
import '../../../admin/presentation/pages/master_admin_page.dart';
import '../../data/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _churchCodeController = TextEditingController();



  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      // Supabase Login
      if (email.isNotEmpty && password.isNotEmpty) {
          // If not master admin simulation, try Supabase
         if (!email.contains('admin') && !email.contains('pastor') && !email.contains('lider') && !email.contains('membro')) {
            await AuthService().signIn(email, password);
         }
      }
      
      // Simulação de Roteamento Unificado (Mantendo a lógica de Roles para teste rápido)
      String role;
      if (email.contains('admin') || email.contains('pastor')) {
        role = 'pastor';
      } else if (email.contains('lider')) {
        role = 'leader';
      } else {
        role = 'member';
      }
  
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => MainScaffold(userRole: role)),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao entrar: $e'), backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bem-vindo de volta', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('Acesse o painel da sua igreja.', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 48),

            // Campos Bento UI Clean
            _buildInputLabel('Código da Igreja'),
            _buildInputField('Ex: IBR-2024', controller: _churchCodeController, icon: Icons.domain),
            const SizedBox(height: 24),
            
            _buildInputLabel('E-mail'),
            _buildInputField('seu@email.com', controller: _emailController, icon: Icons.email_outlined),
            const SizedBox(height: 24),
            
            _buildInputLabel('Senha'),
            _buildInputField('', controller: _passwordController, icon: Icons.lock_outline, isPassword: true),
            
            const SizedBox(height: 48),
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('ACESSAR PAINEL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
             const SizedBox(height: 24),
             Center(child: TextButton(onPressed: (){}, child: const Text('Esqueci minha senha', style: TextStyle(color: Colors.grey)))),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildInputField(String hint, {required TextEditingController controller, required IconData icon, bool isPassword = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.grey),
          hintText: hint,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}
