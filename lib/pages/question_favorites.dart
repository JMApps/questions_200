import 'package:flutter/cupertino.dart';

class QuestionFavorites extends StatelessWidget {
  const QuestionFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Избранное',
        ),
      ),
      child: SafeArea(
        child: _buildFavorites(),
      ),
    );
  }

  Widget _buildFavorites() {
    return SizedBox();
  }
}
