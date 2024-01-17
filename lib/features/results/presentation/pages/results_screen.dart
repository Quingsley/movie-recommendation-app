import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/widgets/primary_button.dart';
import 'package:movie_app/features/results/presentation/cubit/results_cubit.dart';
import 'package:movie_app/features/results/presentation/widgets/cover_image.dart';
import 'package:movie_app/features/results/presentation/widgets/movie_image_details.dart';
import 'package:movie_app/injection.dart';

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
    return BlocProvider(
      create: (_) => serviceLocator<ResultsCubit>(),
      child: ResultsScreen(animationController: controller),
    );
  }
}

class ResultsScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ResultsCubit, ResultsState>(
        builder: (context, state) {
          if (state is ResultsLoadingState) {
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary),
            ));
          } else if (state is ResultsLoadedState) {
            final movie = state.movieEntity;
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
          } else if (state is ResultsErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
