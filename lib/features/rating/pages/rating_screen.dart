import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/widgets/primary_button.dart';
import 'package:movie_app/features/movie_flow/presentation/cubit/movie_flow_cubit.dart';
import 'package:movie_app/features/rating/cubit/rating_cubit.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: BlocProvider.of<MovieFlowCubit>(context).previousPage,
        ),
      ),
      body: Center(
        child: BlocBuilder<RatingCubit, int>(builder: (context, rating) {
          return Column(
            children: [
              Text(
                'Select a minimum rating ranging from 1-10',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${rating.ceil()}',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 62,
                  )
                ],
              ),
              const Spacer(),
              Slider(
                  value: rating.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 10,
                  label: '${rating.ceil()}',
                  onChanged: (value) {
                    BlocProvider.of<RatingCubit>(context)
                        .setRating(value.toInt());
                  }),
              const Spacer(),
              PrimaryButton(
                  text: 'Yes Please',
                  onPressed: BlocProvider.of<MovieFlowCubit>(context).nextPage),
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
