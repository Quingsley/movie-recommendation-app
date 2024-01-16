import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/failure.dart';
import 'package:movie_app/core/widgets/primary_button.dart';
import 'package:movie_app/features/movie_flow/genre/list_card.dart';
import 'package:movie_app/features/movie_flow/movie_flow_controller.dart';

class GenreScreen extends ConsumerWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              'Let\'s start with a genre',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: ref.watch(movieFlowControlProvider).genres.when(
                      data: (genres) {
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              vertical: Constants.listItemSpacing),
                          itemBuilder: (context, index) => ListCard(
                            genre: genres[index],
                            onTap: () {
                              var selectedGenre = genres[index];
                              ref
                                  .read(movieFlowControlProvider.notifier)
                                  .toggleSelected(selectedGenre);
                            },
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: Constants.listItemSpacing,
                          ),
                          itemCount: genres.length,
                        );
                      },
                      error: (error, stackTrace) => Center(
                          child: Text(error is Failure
                              ? error.message
                              : 'Something went wrong')),
                      loading: () => Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.primary),
                      )),
                    )),
            PrimaryButton(
              text: 'Continue',
              onPressed: ref.read(movieFlowControlProvider.notifier).nextPage,
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
