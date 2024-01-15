import 'package:flutter/material.dart';
import 'package:movie_app/core/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      this.width = double.infinity,
      this.isLoading = false,
      required this.text,
      required this.onPressed})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final double width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: TextButton(
          onPressed: !isLoading ? onPressed : null,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadius / 2),
            ),
            fixedSize: Size(width, 48),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              if (isLoading)
                const SizedBox(
                  width: Constants.mediumSpacing,
                ),
              Text(
                text,
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          )),
    );
  }
}
