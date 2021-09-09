import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:questions_200/data/database_query.dart';
import 'package:questions_200/model/question_item.dart';

class QuestionChapters extends StatelessWidget {
  const QuestionChapters({Key? key, required this.databaseQuery})
      : super(key: key);

  final DatabaseQuery databaseQuery;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          '200 вопросов',
        ),
      ),
      child: FutureBuilder<List>(
        future: databaseQuery.getAllChapters(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return SafeArea(
              child: Scrollbar(
                child: _buildChapters(snapshot),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildChapters(AsyncSnapshot snapshot) {
    return ListView.separated(
      itemCount: snapshot.data!.length,
      separatorBuilder: (context, index) => Divider(indent: 16, endIndent: 16),
      itemBuilder: (context, index) {
        return _buildChapterItem(snapshot.data![index]);
      },
    );
  }

  Widget _buildChapterItem(QuestionItem item) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Text(
              'Вопрос ${item.id}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.teal,
              ),
            ),
          ),
          Html(
            data: item.questionContent,
            style: {
              '#': Style(
                fontSize: FontSize(20),
                padding: EdgeInsets.symmetric(horizontal: 4),
              ),
              'a': Style(
                fontSize: FontSize(16),
                color: Colors.blue,
              )
            },
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
