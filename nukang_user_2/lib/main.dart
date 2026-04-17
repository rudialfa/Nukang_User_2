import 'package:flutter/material.dart';
import 'package:nukang_user_2/presentation/pages/auth/login_pages.dart';
import 'package:nukang_user_2/presentation/pages/auth/register_pages.dart';
import 'package:nukang_user_2/presentation/pages/home_paages.dart';
import 'package:nukang_user_2/presentation/pages/kategori_pages.dart';
import 'package:nukang_user_2/presentation/pages/kategori_worker_pages.dart';
import 'package:nukang_user_2/presentation/pages/splash_pages.dart';
import 'package:nukang_user_2/presentation/pages/kategori_pages.dart';  // ⭐ TAMBAHAN
import 'package:nukang_user_2/presentation/pages/kategori_worker_pages.dart';  // ⭐ TAMBAHAN

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nukang - Tukang Profesional',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        fontFamily: 'Roboto',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2),
          brightness: Brightness.light,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/categories': (context) => const CategoriesPage(),  // ⭐ ROUTE BARU
        '/category-workers': (context) => const CategoryWorkersPage(  // ⭐ ROUTE BARU (placeholder)
          categoryId: 1,
          categoryName: 'Listrik',
        ),
      },
    );
  }
}