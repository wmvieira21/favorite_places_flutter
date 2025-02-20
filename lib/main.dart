import 'package:favorite_places/favorite_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  surface: const Color.fromARGB(244, 30, 29, 34),
);

final customizedTheme = ThemeData.dark().copyWith(
  colorScheme: colorScheme,
  scaffoldBackgroundColor: colorScheme.surface,
  textTheme: GoogleFonts.unboundedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold, color: colorScheme.onSurface),
    titleMedium: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold, color: colorScheme.onSurface),
    titleLarge: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold, color: colorScheme.onSurface),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary, iconSize: 22),
  ),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: customizedTheme,
        themeMode: ThemeMode.light,
        home: FavoritePlaces(),
      ),
    ),
  );
}
