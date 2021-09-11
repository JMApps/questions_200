import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questions_200/arguments/chapter_arguments.dart';
import 'package:questions_200/data/database_query.dart';

class AnswerContentPage extends StatefulWidget {
  const AnswerContentPage({Key? key}) : super(key: key);

  @override
  _AnswerContentPageState createState() => _AnswerContentPageState();
}

class _AnswerContentPageState extends State<AnswerContentPage> {
  var _databaseQuery = DatabaseQuery();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as ChapterArguments?;
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        middle: Text(
          'Вопрос ${arguments!.id}',
        ),
      ),
      child: SizedBox(),
    );
  }
}
