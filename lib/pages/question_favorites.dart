import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:questions_200/arguments/chapter_arguments.dart';
import 'package:questions_200/data/database_query.dart';
import 'package:questions_200/model/question_item.dart';

class QuestionFavorites extends StatefulWidget {
  const QuestionFavorites({Key? key}) : super(key: key);

  @override
  _QuestionFavoritesState createState() => _QuestionFavoritesState();
}

class _QuestionFavoritesState extends State<QuestionFavorites> {
  var _databaseQuery = DatabaseQuery();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        middle: Text(
          'Избранное',
        ),
      ),
      child: _buildFavoriteChapters(),
    );
  }

  Widget _buildFavoriteChapters() {
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
            child: Text(
              'Избранных глав нет',
              style: TextStyle(
                fontSize: 20,
                color: CupertinoColors.secondaryLabel,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildChapterItem(QuestionItem item) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Row(
        children: [
          GestureDetector(
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
                        padding: EdgeInsets.symmetric(horizontal: 4),
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
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed(
                '/answer_content',
                arguments: ChapterArguments(item.id),
              );
            },
          ),
        ],
      ),
      secondaryActions: [
        IconSlideAction(
          caption: 'Удалить',
          color: Colors.red,
          icon: CupertinoIcons.square_stack_3d_up,
          onTap: () {
            setState(
              () {
                item.favoriteState == 1
                    ? _databaseQuery.addRemoveFavorite(0, item.id!)
                    : _databaseQuery.addRemoveFavorite(1, item.id!);
              },
            );
          },
        ),
      ],
    );
  }
}
