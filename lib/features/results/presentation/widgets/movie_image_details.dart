import 'package:flutter/material.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/widgets/network_fading_image.dart';
import 'package:movie_app/features/results/domain/entities/movie_entity.dart';

class MovieImageDetails extends StatelessWidget {
  const MovieImageDetails(
      {super.key,
      required this.movieHeight,
      required this.movie,
      required this.titleOpacity,
      required this.genreOpacity,
      required this.ratingOpacity});

  final double movieHeight;
  final MovieEntity movie;
  final Animation<double> titleOpacity;
  final Animation<double> genreOpacity;
  final Animation<double> ratingOpacity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: movieHeight,
            child: NetworkFadingImage(path: movie.posterPath ?? ''),
          ),
          const SizedBox(
            width: Constants.mediumSpacing,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: titleOpacity,
                  child: Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                FadeTransition(
                  opacity: genreOpacity,
                  child: Text(
                    movie.getGenresCommaSeparated(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                FadeTransition(
                  opacity: ratingOpacity,
                  child: Row(
                    children: [
                      Text(
                        movie.voteAverage.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(.62),
                            ),
                      ),
                      const Icon(
                        Icons.star_rounded,
                        size: 20,
                        color: Colors.amber,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
