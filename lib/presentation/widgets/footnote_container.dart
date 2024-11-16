import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class FootnoteContainer extends StatelessWidget {
  const FootnoteContainer({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SelectableRegion(
        focusNode: FocusNode(),
        selectionControls: Platform.isAndroid ? MaterialTextSelectionControls() : CupertinoTextSelectionControls(),
        child: Html(
          data: content,
          style: {
            '#': Style(
              padding: HtmlPaddings.zero,
              margin: Margins.zero,
              fontSize: FontSize(18),
              textAlign: TextAlign.center,
            ),
          },
        ),
      ),
    );
  }
}
