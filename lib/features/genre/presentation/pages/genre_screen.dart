import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants.dart';
import 'package:movie_app/core/widgets/primary_button.dart';
import 'package:movie_app/features/genre/presentation/cubit/genre_cubit.dart';
import 'package:movie_app/features/genre/presentation/widgets/list_card.dart';
import 'package:movie_app/features/movie_flow/presentation/cubit/movie_flow_cubit.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await BlocProvider.of<GenreCubit>(context).getGenres();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: BlocProvider.of<MovieFlowCubit>(context).previousPage,
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
            Expanded(child: BlocBuilder<GenreCubit, GenreState>(
              builder: (context, state) {
                if (state is GenreLoadingState) {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary),
                  ));
                } else if (state is GenreErrorState) {
                  return Center(child: Text(state.message));
                } else if (state is GenreLoadedState) {
                  final genres = state.genres;
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        vertical: Constants.listItemSpacing),
                    itemBuilder: (context, index) => ListCard(
                      genre: genres[index],
                      onTap: () {
                        var selectedGenre = genres[index];
                        BlocProvider.of<GenreCubit>(context)
                            .toggleSelected(selectedGenre);
                      },
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: Constants.listItemSpacing,
                    ),
                    itemCount: genres.length,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            )),
            PrimaryButton(
              text: 'Continue',
              onPressed: () => BlocProvider.of<MovieFlowCubit>(context)
                  .nextPage(context: context),
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
