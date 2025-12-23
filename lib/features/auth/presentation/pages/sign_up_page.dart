import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLeader = false;
  String _selectedRole = 'Líder de Célula';
  final List<String> _roles = ['Líder de Célula', 'Líder de Ministério', 'Pastor'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground,
      appBar: AppBar(
        title: const Text('CRIAR CONTA', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.5, color: Colors.black54)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person_add, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 32),
            _buildInputField('Nome Completo', Icons.person),
            const SizedBox(height: 16),
            _buildInputField('E-mail', Icons.email),
            const SizedBox(height: 16),
            _buildInputField('Senha', Icons.lock, isPassword: true),
            const SizedBox(height: 16),
            _buildInputField('Confirmar Senha', Icons.lock, isPassword: true),
            
            const SizedBox(height: 32),

            // Role Request Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _isLeader ? Colors.blue : Colors.transparent, width: 2),
                boxShadow: const [AppTheme.kSoftShadow],
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: const Text('Sou um Líder ou Pastor', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Solicite acesso às ferramentas de gestão.'),
                    value: _isLeader,
                    activeColor: Colors.blue,
                    onChanged: (val) => setState(() => _isLeader = val!),
                  ),
                  if (_isLeader) ...[
                    const Divider(),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedRole,
                          isExpanded: true,
                          items: _roles.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                          onChanged: (val) => setState(() => _selectedRole = val!),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),

            const SizedBox(height: 48),
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                   // Mock Registration
                   Navigator.pop(context);
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text(_isLeader 
                       ? 'Conta criada! Solicitação de $_selectedRole enviada para aprovação.' 
                       : 'Conta criada com sucesso! Bem-vindo.'))
                   );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('CRIAR CONTA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, IconData icon, {bool isPassword = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
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
