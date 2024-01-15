import 'package:flutter/foundation.dart';
import 'package:movie_app/features/movie_flow/genre/genre_entity.dart';

@immutable
class Genre {
  const Genre({required this.name, this.isSelected = false, this.id = 0});

  final String name;
  final bool isSelected;
  final int id;

  factory Genre.fromEntity(GenreEntity entity) {
    return Genre(name: entity.name, id: entity.id, isSelected: false);
  }

  Genre toggleSelected() {
    print('Genre(name: $name, isSelected: ${!isSelected}, id: $id)');
    return Genre(name: name, isSelected: !isSelected, id: id);
  }

  @override
  String toString() {
    return 'Genre{name: $name, isSelected: $isSelected, id: $id}';
  }

  @override
  bool operator ==(covariant Genre other) =>
      name == other.name && isSelected == other.isSelected && id == other.id;

  @override
  int get hashCode => name.hashCode ^ isSelected.hashCode ^ id.hashCode;
}
