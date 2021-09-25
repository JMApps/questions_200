import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:questions_200/arguments/chapter_arguments.dart';
import 'package:questions_200/data/database_query.dart';
import 'package:questions_200/model/question_item.dart';
import 'package:questions_200/pages/support_project_page.dart';

class QuestionFavoritesA extends StatefulWidget {
  const QuestionFavoritesA({Key? key}) : super(key: key);

  @override
  _QuestionFavoritesAState createState() => _QuestionFavoritesAState();
}

class _QuestionFavoritesAState extends State<QuestionFavoritesA> {
  var _databaseQuery = DatabaseQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Избранное'),
        backgroundColor: Colors.teal,
        actions: [
          //SupportProjectPage(),
          IconButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed('/settings_a');
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: _buildFavorites(),
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
              return _buildFavoriteItem(snapshot.data![index]);
            },
          );
        } else {
          return Center(
            child: Text(
              'Избранных глав нет',
              style: TextStyle(fontSize: 18),
            ),
          );
        }
      },
    );
  }

  Widget _buildFavoriteItem(QuestionItem item) {
    return InkWell(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              _snackMessage();
              setState(() {
                item.favoriteState == 0
                    ? _databaseQuery.addRemoveFavorite(1, item.id!)
                    : _databaseQuery.addRemoveFavorite(0, item.id!);
              });
            },
            icon: Icon(
              item.favoriteState == 0 ? Icons.bookmark_border : Icons.bookmark,
              color: Colors.teal,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8, top: 16, right: 16),
                  child: Text(
                    'Вопрос ${item.id}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                ),
                Html(
                  onLinkTap: (String? url, RenderContext rendContext,
                      Map<String, String> attributes, element) {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        message: SelectableHtml(
                          data: url,
                          style: {
                            '#': Style(
                                fontSize: FontSize(18),
                                color: Colors.grey[800],
                                fontFamily: 'Gilroy'),
                            'small': Style(
                                fontSize: FontSize(14),
                                color: Colors.grey[800],
                                fontFamily: 'Gilroy'),
                          },
                        ),
                        cancelButton: CupertinoActionSheetAction(
                          child: Text(
                            'Закрыть',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context, 'Закрыть');
                          },
                        ),
                      ),
                    );
                  },
                  data: item.questionContent,
                  style: {
                    '#': Style(
                        fontSize: FontSize(20),
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        fontFamily: 'Gilroy'),
                    'sup': Style(
                      fontSize: FontSize(14),
                      color: Colors.blue,
                      fontFamily: 'Gilroy',
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          '/answer_content_a',
          arguments: ChapterArguments(item.id),
        );
      },
    );
  }

  _snackMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.teal,
        content: Text(
          'Удалено из избранного',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
