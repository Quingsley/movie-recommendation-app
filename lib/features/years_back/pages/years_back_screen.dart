import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/widgets/primary_button.dart';
import 'package:movie_app/features/genre/presentation/cubit/genre_cubit.dart';
import 'package:movie_app/features/movie_flow/presentation/cubit/movie_flow_cubit.dart';
import 'package:movie_app/features/rating/cubit/rating_cubit.dart';
import 'package:movie_app/features/results/presentation/cubit/results_cubit.dart';
import 'package:movie_app/features/years_back/cubit/years_back_cubit.dart';

class YearsBackScreen extends StatelessWidget {
  const YearsBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: BlocProvider.of<MovieFlowCubit>(context).previousPage,
        ),
      ),
      body: Center(
        child: BlocBuilder<YearsBackCubit, int>(builder: (context, yearsBack) {
          return Column(
            children: [
              Text(
                'How many years back should we check for',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${yearsBack.ceil()}',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    'Years back',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.color
                            ?.withOpacity(.62)),
                  )
                ],
              ),
              const Spacer(),
              Slider(
                  value: yearsBack.toDouble(),
                  min: 0,
                  max: 70,
                  divisions: 70,
                  label: '${yearsBack.ceil()}',
                  onChanged: (value) {
                    BlocProvider.of<YearsBackCubit>(context)
                        .setYearsBack(value.toInt());
                  }),
              const Spacer(),
              BlocBuilder<ResultsCubit, ResultsState>(
                builder: (context, state) {
                  final isLoading = state is ResultsLoadingState;
                  return PrimaryButton(
                    text: 'Amazing',
                    isLoading: isLoading,
                    onPressed: () async {
                      if (!isLoading) {
                        final genres = context.read<GenreCubit>().state.genres;
                        final yearsBack = context.read<YearsBackCubit>().state;
                        final rating = context.read<RatingCubit>().state;
                        await context
                            .read<ResultsCubit>()
                            .getRecommendedMovie(genres, rating, yearsBack);
                        if (context.mounted) {
                          Navigator.of(context).pushNamed('/results');
                        }
                      }
                    },
                  );
                },
              ),
              const SizedBox(
                height: Constants.mediumSpacing,
              )
            ],
          );
        }),
      ),
    );
  }
}
