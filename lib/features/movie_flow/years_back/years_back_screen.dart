import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/widgets/primary_button.dart';
import 'package:movie_app/features/movie_flow/movie_flow_controller.dart';
import 'package:movie_app/features/movie_flow/results/results_screen.dart';

class YearsBackScreen extends ConsumerWidget {
  const YearsBackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double yearsBack = ref.watch(movieFlowControlProvider).yearsBack.toDouble();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed:
                ref.read(movieFlowControlProvider.notifier).previousPage),
      ),
      body: Center(
        child: Column(
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
                value: yearsBack,
                min: 0,
                max: 70,
                divisions: 70,
                label: '${yearsBack.ceil()}',
                onChanged: (value) {
                  ref
                      .read(movieFlowControlProvider.notifier)
                      .updatedYearsBack(value.toInt());
                }),
            const Spacer(),
            PrimaryButton(
              text: 'Amazing',
              isLoading:
                  ref.watch(movieFlowControlProvider).movie is AsyncLoading,
              onPressed: () async {
                ref
                    .watch(movieFlowControlProvider.notifier)
                    .getRecommendedMovie();
                Navigator.of(context).push(ResultsScreen.route());
              },
            ),
            const SizedBox(
              height: Constants.mediumSpacing,
            )
          ],
        ),
      ),
    );
  }
}
