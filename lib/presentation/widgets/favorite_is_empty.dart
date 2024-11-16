import 'package:flutter/material.dart';

class FavoriteIsEmpty extends StatelessWidget {
  const FavoriteIsEmpty({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
            size: 200,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}