import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/features/movie_flow/movie_flow.dart';
import 'package:movie_app/theme/custom_theme.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

final dioProvider = Provider(
  (ref) => Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3'),
  ),
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Recommendation',
      theme: CustomTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: const MovieFlow(),
    );
  }
}
