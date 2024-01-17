import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movie_flow/presentation/cubit/movie_flow_cubit.dart';
import 'package:movie_app/features/movie_flow/presentation/pages/movie_flow_page.dart';
import 'package:movie_app/injection.dart';
import 'package:movie_app/theme/custom_theme.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Recommendation',
      theme: CustomTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: BlocProvider(
        create: (context) {
          return serviceLocator<MovieFlowCubit>();
        },
        child: const MovieFlow(),
      ),
    );
  }
}
