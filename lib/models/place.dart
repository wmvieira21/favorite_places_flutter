import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  Place(this.tittle) : id = uuid.v4();

  final String id;
  final String tittle;
}
