import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/widgets/primary_button.dart';
import 'package:movie_app/features/movie_flow/movie_flow_controller.dart';
import 'package:movie_app/features/movie_flow/results/movie.dart';

class ResultsScreen extends ConsumerWidget {
  static route({bool fullScreenDialog = true}) =>
      MaterialPageRoute(builder: (context) => const ResultsScreen());

  const ResultsScreen({super.key});

  final double movieHeight = 150;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(movieFlowControlProvider).movie.when(
          data: (movie) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CoverImage(
                            movie: movie,
                          ),
                          Positioned(
                            width: MediaQuery.sizeOf(context).width,
                            bottom: -(movieHeight / 2),
                            child: MovieImageDetails(
                              movie: movie,
                              movieHeight: movieHeight,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: movieHeight / 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          movie.overView,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                    text: 'Find another movie',
                    onPressed: () => Navigator.of(context).pop()),
                const SizedBox(
                  height: Constants.mediumSpacing,
                ),
              ],
            );
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary),
              ))),
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({super.key, required this.movie});

  final Movie movie;
  @override
  Widget build(BuildContext context) {
    print(movie.backdropPath);
    return Container(
      constraints: const BoxConstraints(minHeight: 298),
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Colors.transparent,
            ],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Image.network(
          movie.backdropPath ?? '',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const SizedBox(),
        ),
      ),
    );
  }
}

class MovieImageDetails extends StatelessWidget {
  const MovieImageDetails(
      {super.key, required this.movieHeight, required this.movie});

  final double movieHeight;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: movieHeight,
            child: Image.network(
              movie.posterPath ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          ),
          const SizedBox(
            width: Constants.mediumSpacing,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  movie.getGenresCommaSeparated(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
