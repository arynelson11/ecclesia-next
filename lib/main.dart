import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/di/injection_container.dart' as di;
import 'core/theme/theme_cubit.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/sign_up_page.dart';
import 'features/auth/presentation/pages/welcome_page.dart';
import 'features/admin/presentation/pages/master_admin_page.dart';
import 'features/admin/presentation/pages/leadership_requests_page.dart';
import 'features/home/presentation/pages/leader_home_page.dart';
import 'features/home/presentation/pages/cell_attendance_page.dart';
import 'features/home/presentation/pages/cell_report_page.dart';
import 'features/home/presentation/pages/my_disciples_page.dart';
import 'features/home/presentation/pages/cell_management_page.dart';
import 'features/sermons/presentation/pages/sermons_page.dart';
import 'features/bible/presentation/pages/bible_plans_page.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'features/home/presentation/cubit/content_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // URL Strategy (No more # in URL)
  setPathUrlStrategy();

  // Supabase Init
  await Supabase.initialize(
    url: 'https://orztgwkdimmzcsconowo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9yenRnd2tkaW1temNzY29ub3dvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYyOTYwMDcsImV4cCI6MjA4MTg3MjAwN30.3ELfbYD3jmE45ZIyLs6HY59x-XUYBB_K89IiVkaniSA',
  );
  
  await di.init();
  
  runApp(const EcclesiaApp());
}

class EcclesiaApp extends StatelessWidget {
  const EcclesiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<ContentCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            title: 'Ecclesia Next',
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: const WelcomePage(),
            routes: {
              '/login': (context) => const LoginPage(),
              '/signup': (context) => const SignUpPage(),
              '/master-admin': (context) => const MasterAdminPage(),
              '/leader-home': (context) => const LeaderHomePage(),
              '/leadership-requests': (context) => const LeadershipRequestsPage(),
              '/cell-attendance': (context) => const CellAttendancePage(),
              '/cell-report': (context) => const CellReportPage(),
              '/my-disciples': (context) => const MyDisciplesPage(),
              '/cell-management': (context) => const CellManagementPage(),
              '/sermons': (context) => const SermonsPage(),
              '/bible-plans': (context) => const BiblePlansPage(),
            },
          );
        },
      ),
    );
  }

}

