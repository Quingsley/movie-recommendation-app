// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/widgets/primary_button.dart';
import 'package:movie_app/features/movie_flow/movie_flow_controller.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  ref.read(movieFlowControlProvider.notifier).nextPage(),
            ),
            const SizedBox(
              height: Constants.mediumSpacing,
            ),
          ],
        ),
      ),
    );
  }
}
