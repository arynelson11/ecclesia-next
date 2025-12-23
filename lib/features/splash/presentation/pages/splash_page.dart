import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../auth/presentation/pages/login_page.dart';

class SplashPage extends StatefulWidget {

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _loadConfigAndNavigate();
  }

  Future<void> _loadConfigAndNavigate() async {
    // 1. Simula delay de network/processamento
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    try {
      // 2. Lê arquivo de configuração local (simulando API)
      final String configString = await DefaultAssetBundle.of(context)
          .loadString('assets/config/tenants.json');
      
      final Map<String, dynamic> jsonMap = json.decode(configString);

      // 3. Escolhe um tenant para simular (HARDCODED PARA TESTE -> church_grace)
      // Numa app real, isso viria de um subdomínio ou login anterior
      final String currentTenantId = 'church_grace'; 
      final Map<String, dynamic> tenantConfig = jsonMap[currentTenantId] ?? jsonMap['default'];

      // 4. Atualiza o Tema Global via Cubit
      context.read<ThemeCubit>().updateTheme(tenantConfig);

      // 5. Navega para Login Page (Auth Flow)
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    } catch (e) {
      print("Erro ao carregar config: $e");
      if (mounted) {
         Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );       
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo placeholder
            Icon(Icons.church_rounded, size: 80, color: Colors.grey),
            SizedBox(height: 24),
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "Ecclesia Next",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
