import 'package:flutter/foundation.dart';

@immutable
class GenreEntity {
  const GenreEntity({required this.id, required this.name});
  final int id;
  final String name;

  factory GenreEntity.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'id': int id,
          'name': String name,
        }) {
      return GenreEntity(id: id, name: name);
    } else {
      throw const FormatException('Invalid JSON');
    }
  }

  @override
  String toString() {
    return 'GenreEntity(id: $id, name: $name)';
  }

  @override
  bool operator ==(covariant GenreEntity other) {
    return identical(this, other) || (id == other.id && name == other.name);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
