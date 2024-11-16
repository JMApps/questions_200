import 'package:flutter/material.dart';

import '../../core/styles/app_styles.dart';

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
            style: AppStyles.mainTextStyle17,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}