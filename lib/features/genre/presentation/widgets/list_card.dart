import 'package:flutter/material.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/features/genre/domain/entities/genre_entity.dart';

class ListCard extends StatelessWidget {
  const ListCard({super.key, required this.genre, required this.onTap});

  final GenreEntity genre;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Material(
        color: genre.isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            Constants.borderRadius,
          ),
          child: Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              genre.name,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
