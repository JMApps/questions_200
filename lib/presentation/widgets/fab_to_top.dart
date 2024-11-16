import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/strings/app_strings.dart';
import '../state/scroll_page_state.dart';

class FabToTop extends StatelessWidget {
  const FabToTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollPageState>(
      builder: (context, scrollPageState, _) {
        return ValueListenableBuilder<double>(
          valueListenable: scrollPageState.getButtonOpacity,
          builder: (context, buttonOpacity, child) {
            return AnimatedOpacity(
              opacity: buttonOpacity,
              duration: const Duration(milliseconds: 150),
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () {
                  scrollPageState.getToTop;
                },
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                tooltip: AppStrings.toStart,
                child: Icon(
                  Icons.arrow_upward_rounded,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
