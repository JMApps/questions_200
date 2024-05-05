import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/state/main_app_state.dart';
import '../../application/styles/app_styles.dart';
import '../../data/model/footnote_model.dart';
import 'footnote_container.dart';

class FootnoteData extends StatelessWidget {
  const FootnoteData({super.key, required this.footnoteId});

  final int footnoteId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FootnoteModel>(
      future: context.read<MainAppState>().getDatabaseQuery.getFootnote(footnoteId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FootnoteContainer(content: snapshot.data!.footnoteContent);
        } else if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: AppStyles.mainPadding,
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
