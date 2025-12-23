import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'contribution_history_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Mock State
  String _userName = 'Mateus Silva';
  String _userEmail = 'mateus@email.com';
  String _userAvatarUrl = 'https://i.pravatar.cc/300';
  bool _areNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackground, // #F2F4F7
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // 1. Centered Header (Clean, No Card)
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4), // Thick White Border
                      boxShadow: const [AppTheme.kSoftShadow],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(_userAvatarUrl),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _userName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          // Open Edit Modal with BottomSheet
                          _showEditProfileModal(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
                          child: const Icon(Icons.edit_rounded, size: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _userEmail,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),

            // 2. Stats Bento Grid (2 Cards)
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.menu_book_rounded,
                    color: Colors.blue,
                    value: '12',
                    label: 'Devocionais',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.local_fire_department_rounded,
                    color: Colors.orange,
                    value: '5',
                    label: 'Dias Seguidos',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 3. Unified Menu Container (One Big White Card)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.kRadius),
                boxShadow: const [AppTheme.kSoftShadow],
              ),
              child: Column(
                children: [
                   _buildMenuItem(
                     icon: Icons.receipt_long_rounded,
                     title: 'Minhas Contribuições',
                     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ContributionHistoryPage())),
                   ),
                   _buildDivider(),
                   _buildMenuItem(
                     icon: Icons.dark_mode_rounded,
                     title: 'Modo Escuro (Indisponível)',
                     trailing: const Icon(Icons.lock_outline, size: 16, color: Colors.grey),
                   ),
                   _buildDivider(),
                   _buildMenuItem(
                     icon: Icons.notifications_rounded,
                     title: 'Notificações',
                     trailing: Switch(
                       value: _areNotificationsEnabled,
                       activeColor: Colors.black,
                       onChanged: (val) => setState(() => _areNotificationsEnabled = val),
                     ),
                   ),
                   _buildDivider(),
                   _buildMenuItem(
                     icon: Icons.logout_rounded,
                     title: 'Sair',
                     iconColor: Colors.red,
                     titleColor: Colors.red,
                     onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                   ),
                ],
              ),
            ),
            
            const SizedBox(height: 100), // Bottom Dock Spacing
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({required IconData icon, required Color color, required String value, required String label}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.kRadius),
        boxShadow: const [AppTheme.kSoftShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon, 
    required String title, 
    Color? iconColor, 
    Color? titleColor, 
    Widget? trailing, 
    VoidCallback? onTap
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFF2F4F7),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor ?? Colors.black, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: titleColor ?? Colors.black,
          fontSize: 15,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.black12),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: Colors.grey[100], indent: 24, endIndent: 24);
  }

  void _showEditProfileModal(BuildContext context) {
     final nameController = TextEditingController(text: _userName);
     final phoneController = TextEditingController(text: '(11) 98765-4321');
     final dobController = TextEditingController(text: '12/05/1990');

     showModalBottomSheet(
       context: context,
       isScrollControlled: true,
       backgroundColor: Colors.transparent,
       builder: (context) => Container(
         height: MediaQuery.of(context).size.height * 0.7,
         decoration: const BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
         ),
         padding: const EdgeInsets.all(24),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
             const SizedBox(height: 24),
             const Text('Editar Perfil', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
             const SizedBox(height: 32),
             
             _buildInput('Nome Completo', nameController, Icons.person_outline),
             const SizedBox(height: 16),
             _buildInput('Telefone', phoneController, Icons.phone_outlined),
             const SizedBox(height: 16),
             _buildInput('Data de Nascimento', dobController, Icons.calendar_today_outlined),
             
             const Spacer(),
             
             SizedBox(
               width: double.infinity,
               height: 56,
               child: ElevatedButton(
                 onPressed: () {
                    // Update Logic
                    setState(() {
                      _userName = nameController.text;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Perfil atualizado com sucesso!')));
                 },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.black,
                   foregroundColor: Colors.white,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                   elevation: 0,
                 ),
                 child: const Text('SALVAR ALTERAÇÕES', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
               ),
             ),
             const SizedBox(height: 24),
           ],
         ),
       ),
     );
  }

  Widget _buildInput(String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: const Color(0xFFF2F4F7), borderRadius: BorderRadius.circular(16)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              icon: Icon(icon, color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
