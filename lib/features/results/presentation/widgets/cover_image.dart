import 'package:flutter/material.dart';
import 'package:movie_app/core/widgets/network_fading_image.dart';
import 'package:movie_app/features/results/domain/entities/movie_entity.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({super.key, required this.movie});

  final MovieEntity movie;
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
