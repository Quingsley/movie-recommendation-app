import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/features/genre/domain/entities/genre_entity.dart';

part 'genre_model.g.dart';

@JsonSerializable()
class GenresResponse {
  final List<GenreModel> genres;

  GenresResponse({required this.genres});

  factory GenresResponse.fromJson(Map<String, dynamic> json) {
    return _$GenresResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GenresResponseToJson(this);
}

@JsonSerializable()
class GenreModel extends GenreEntity with EquatableMixin {
  GenreModel({required int id, required String name})
      : super(id: id, name: name);

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return _$GenreModelFromJson(json);
  }
}
