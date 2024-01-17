import 'package:equatable/equatable.dart';
import 'package:movie_app/features/genre/domain/entities/genre_entity.dart';

class GenreModel extends GenreEntity with EquatableMixin {
  GenreModel({required int id, required String name})
      : super(id: id, name: name);

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'id': int id,
          'name': String name,
        }) {
      return GenreModel(id: id, name: name);
    } else {
      throw const FormatException('Invalid JSON');
    }
  }
}
