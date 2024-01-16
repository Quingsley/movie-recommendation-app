import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/failure.dart';
import 'package:movie_app/core/widgets/network_fading_image.dart';
import 'package:movie_app/core/widgets/primary_button.dart';
import 'package:movie_app/features/movie_flow/movie_flow_controller.dart';
import 'package:movie_app/features/movie_flow/results/movie.dart';

class ResultScreenAnimator extends StatefulWidget {
  const ResultScreenAnimator({super.key});

  @override
  State<ResultScreenAnimator> createState() => _ResultScreenAnimatorState();
}

class _ResultScreenAnimatorState extends State<ResultScreenAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResultsScreen(animationController: controller);
  }
}

class ResultsScreen extends ConsumerWidget {
  static route({bool fullScreenDialog = true}) =>
      MaterialPageRoute(builder: (context) => const ResultScreenAnimator());

  ResultsScreen({super.key, required this.animationController})
      : titleOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: animationController, curve: const Interval(0, .3))),
        genreOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: animationController, curve: const Interval(.3, .4))),
        ratingOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: animationController, curve: const Interval(.4, .6))),
        descriptionOpacity = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
                parent: animationController, curve: const Interval(.6, .8))),
        buttonOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: animationController, curve: const Interval(.8, 1)));

  final double movieHeight = 150;
  final AnimationController animationController;
  final Animation<double> titleOpacity;
  final Animation<double> genreOpacity;
  final Animation<double> ratingOpacity;
  final Animation<double> descriptionOpacity;
  final Animation<double> buttonOpacity;

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
                              genreOpacity: genreOpacity,
                              titleOpacity: titleOpacity,
                              ratingOpacity: ratingOpacity,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: movieHeight / 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: FadeTransition(
                          opacity: descriptionOpacity,
                          child: Text(
                            movie.overView,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FadeTransition(
                  opacity: buttonOpacity,
                  child: PrimaryButton(
                      text: 'Find another movie',
                      onPressed: () => Navigator.of(context).pop()),
                ),
                const SizedBox(
                  height: Constants.mediumSpacing,
                ),
              ],
            );
          },
          error: (error, stackTrace) => Center(
              child: Text(error is Failure
                  ? error.message
                  : 'Something went wrong, please try again')),
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
        child: NetworkFadingImage(path: movie.backdropPath ?? ''),
      ),
    );
  }
}

class MovieImageDetails extends StatelessWidget {
  const MovieImageDetails(
      {super.key,
      required this.movieHeight,
      required this.movie,
      required this.titleOpacity,
      required this.genreOpacity,
      required this.ratingOpacity});

  final double movieHeight;
  final Movie movie;
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
