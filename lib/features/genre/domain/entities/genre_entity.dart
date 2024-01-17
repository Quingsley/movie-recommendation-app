import 'package:equatable/equatable.dart';

class GenreEntity extends Equatable {
  const GenreEntity(
      {required this.name, required this.id, this.isSelected = false});
  final String name;
  final int id;
  final bool isSelected;

  GenreEntity toggleSelected() {
    return GenreEntity(name: name, id: id, isSelected: !isSelected);
  }

  @override
  List<Object?> get props => [name, id, isSelected];
  @override
  bool? get stringify => true;
}
