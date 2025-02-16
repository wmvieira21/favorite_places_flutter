import 'package:favorite_places/favorite_places.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  surface: const Color.fromARGB(255, 56, 49, 255),
);

final customizedTheme = ThemeData().copyWith(
  textTheme: GoogleFonts.unboundedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
  ),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      theme: customizedTheme,
      themeMode: ThemeMode.light,
      home: FavoritePlaces(),
    ),
  );
}
