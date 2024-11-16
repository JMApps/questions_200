import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../../domain/entities/footnote_entity.dart';
import '../state/questions_state.dart';
import 'main_error_text_data.dart';
import 'main_html_data.dart';

class MainFootnoteData extends StatelessWidget {
  const MainFootnoteData({
    super.key,
    required this.footnoteId,
  });

  final int footnoteId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FootnoteEntity>(
      future: Provider.of<QuestionsState>(context, listen: false).getFootnoteById(footnoteId: footnoteId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            padding: AppStyles.paddingWithoutTop,
            child: MainHtmlData(
              htmlData: '<b>[${snapshot.data!.id}]</b> – ${snapshot.data!.footnoteContent}',
              font: AppStrings.fontRaleway,
              fontSize: 18.0,
              textAlign: TextAlign.center,
              fontColor: Theme.of(context).colorScheme.onSurface,
            ),
          );
        }
        if (snapshot.hasError) {
          return MainErrorTextData(errorText: snapshot.error.toString());
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
