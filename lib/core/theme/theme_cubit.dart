import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

// Events are not strictly necessary for simple Cubit, but good for expansion.
// We will just use functions in Cubit for now.

class ThemeCubit extends Cubit<ThemeData> {
  // Inicializa com um tema padrão safe
  ThemeCubit() : super(AppTheme.fromConfig({}));

  void updateTheme(Map<String, dynamic> config) {
    if (config.isEmpty) return;
    
    // Pequeno print para debug
    print("🎨 Updating theme with config: $config");
    
    final newTheme = AppTheme.fromConfig(config);
    emit(newTheme);
  }
}
