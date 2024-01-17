import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/widgets/primary_button.dart';
import 'package:movie_app/features/movie_flow/presentation/cubit/movie_flow_cubit.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Let\'s find a movie',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Image.asset('assets/images/undraw_horror_movie.png'),
            const Spacer(),
            PrimaryButton(
                text: 'Get Started',
                onPressed: () =>
                    BlocProvider.of<MovieFlowCubit>(context).nextPage()),
            const SizedBox(
              height: Constants.mediumSpacing,
            ),
          ],
        ),
      ),
    );
  }
}
