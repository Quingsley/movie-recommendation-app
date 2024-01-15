import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/widgets/primary_button.dart';
import 'package:movie_app/features/movie_flow/movie_flow_controller.dart';

class RatingScreen extends ConsumerWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double rating = ref.watch(movieFlowControlProvider).rating.toDouble();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: ref.read(movieFlowControlProvider.notifier).previousPage,
        ),
      ),
      body: Center(
        child: Column(
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
                value: rating,
                min: 1,
                max: 10,
                divisions: 10,
                label: '${rating.ceil()}',
                onChanged: (value) {
                  ref
                      .read(movieFlowControlProvider.notifier)
                      .updatedRating(value.toInt());
                }),
            const Spacer(),
            PrimaryButton(
                text: 'Yes Please',
                onPressed:
                    ref.read(movieFlowControlProvider.notifier).nextPage),
            const SizedBox(
              height: Constants.mediumSpacing,
            )
          ],
        ),
      ),
    );
  }
}
