import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/provider/favorite_places_provider.dart';
import 'package:favorite_places/dialogs/alert_dialog.dart';
import 'package:favorite_places/models/place.dart';

class AddNewPlaceScreen extends ConsumerStatefulWidget {
  const AddNewPlaceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends ConsumerState<AddNewPlaceScreen> {
  final TextEditingController tittleController = TextEditingController();

  _showAlertError() {
    return showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) =>
            AlertDialogCustomized(errorMessage: 'Tittle must be valid.'));
  }

  _saveFavoritePlace() {
    if (tittleController.text.isEmpty) {
      return _showAlertError();
    }
    ref
        .read(favoritePlacesProvider.notifier)
        .addFavoritePlace(Place(tittleController.text));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    tittleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: tittleController,
              maxLength: 30,
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                label: Text('Title'),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _saveFavoritePlace(),
              label: const Text('Add'),
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
