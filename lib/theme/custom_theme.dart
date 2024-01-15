import 'package:flutter/material.dart';
import 'package:movie_app/theme/pallete.dart';

class CustomTheme {
  static ThemeData darkTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: MaterialColor(Pallette.red500.value, const {
          100: Pallette.red100,
          200: Pallette.red200,
          300: Pallette.red300,
          400: Pallette.red400,
          500: Pallette.red500,
          600: Pallette.red600,
          700: Pallette.red700,
          800: Pallette.red800,
          900: Pallette.red900
        }),
        accentColor: Pallette.red500,
      ),
      scaffoldBackgroundColor: Pallette.almostBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: Pallette.almostBlack,
        elevation: 0,
      ),
      sliderTheme: SliderThemeData(
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
        thumbColor: Colors.white,
        inactiveTrackColor: Colors.grey.shade800,
        valueIndicatorColor: Pallette.red500,
        activeTrackColor: Colors.white,
      ),
      textTheme: theme.primaryTextTheme
          .copyWith(
              labelLarge: theme.primaryTextTheme.labelLarge?.copyWith(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ))
          .apply(
            displayColor: Colors.white,
          ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Pallette.red500,
        ),
      ),
    );
  }
}
