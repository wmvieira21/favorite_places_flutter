import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'package:favorite_places/models/place.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super([]);

  Future<void> loadPlaces() async {
    final Database db = await _getDatabaseOnDevice;
    final List<Map<String, Object?>> data = await db.query('USER_PLACES');

    List<Place> places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            tittle: row['tittle'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
                latitude: row['lat'] as double,
                longitude: row['lng'] as double,
                address: row['address'] as String,
                imageURL: row['location_image'] as String),
          ),
        )
        .toList();
    state = [...places];
  }

  void addFavoritePlace(Place place) async {
    final imageFromDevice = await _saveFileDevice(place.image);
    final newPlace = Place(
        tittle: place.tittle, image: imageFromDevice, location: place.location);
    _insertPlaceTable(newPlace);

    state = [...state, newPlace];
  }

  Future<File> _saveFileDevice(File file) async {
    final appDir = await pathProvider.getApplicationDocumentsDirectory();
    final fileName = path.basename(file.path);
    final copiedImageFile = await file.copy('${appDir.path}/$fileName');
    return copiedImageFile;
  }

  Future<Database> get _getDatabaseOnDevice async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE USER_PLACES (id TEXT PRIMARY KEY, tittle TEXT, image TEXT, lat REAL, lng REAL, address TEXT, location_image TEXT)');
    }, version: 1);
    return db;
  }

  Future<int> _insertPlaceTable(Place place) async {
    final Database db = await _getDatabaseOnDevice;
    final int lastIdInserted = await db.insert('USER_PLACES', {
      'id': place.id,
      'tittle': place.tittle,
      'image': place.image.path,
      'lat': place.location.latitude,
      'lng': place.location.longitude,
      'address': place.location.address,
      'location_image': place.location.imageURL
    });
    return lastIdInserted;
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>(
        (ref) => FavoritePlacesNotifier());
