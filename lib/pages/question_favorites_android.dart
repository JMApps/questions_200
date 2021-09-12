import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:questions_200/arguments/chapter_arguments.dart';
import 'package:questions_200/data/database_query.dart';
import 'package:questions_200/model/question_item.dart';

class QuestionFavoritesAndroid extends StatefulWidget {
  const QuestionFavoritesAndroid({Key? key}) : super(key: key);

  @override
  _QuestionFavoritesAndroidState createState() =>
      _QuestionFavoritesAndroidState();
}

class _QuestionFavoritesAndroidState extends State<QuestionFavoritesAndroid> {
  var _databaseQuery = DatabaseQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text('Избранное'),
      ),
      body: Column(
        children: [
          _buildFavorites(),
        ],
      ),
    );
  }

  Widget _buildFavorites() {
    return FutureBuilder<List>(
      future: _databaseQuery.getFavoriteChapters(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) =>
                Divider(indent: 16, endIndent: 16),
            itemBuilder: (context, index) {
              return _buildChapterItem(snapshot.data![index]);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildChapterItem(QuestionItem item) {
    return InkWell(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              item.favoriteState == 0
                  ? _databaseQuery.addRemoveFavorite(1, item.id!)
                  : _databaseQuery.addRemoveFavorite(0, item.id!);
            },
            icon: Icon(item.favoriteState == 0
                ? Icons.bookmark_border
                : Icons.bookmark),
          ),
          Column(
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
                      fontFamily: 'Gilroy'),
                  'a': Style(
                    fontSize: FontSize(16),
                    color: Colors.blue,
                  )
                },
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          '/answer_content_android',
          arguments: ChapterArguments(item.id),
        );
      },
    );
  }
}
