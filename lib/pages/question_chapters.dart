import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:questions_200/arguments/chapter_arguments.dart';
import 'package:questions_200/data/database_query.dart';
import 'package:questions_200/model/question_item.dart';

class QuestionChapters extends StatefulWidget {
  const QuestionChapters({Key? key}) : super(key: key);

  @override
  _QuestionChaptersState createState() => _QuestionChaptersState();
}

class _QuestionChaptersState extends State<QuestionChapters> {
  var _databaseQuery = DatabaseQuery();
  TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        border: Border(
          bottom: BorderSide(color: Colors.transparent),
        ),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        middle: Text(
          '200 вопросов',
        ),
      ),
      child: Column(
        children: [
          _buildSearch(),
          Expanded(
            child: Scrollbar(
              child: _buildChapters(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGroupedBackground,
        border: Border(
          bottom: BorderSide(color: CupertinoColors.systemGrey4),
        ),
      ),
      child: CupertinoTextField(
        controller: _searchTextController,
        autocorrect: true,
        onChanged: (String text) {
          setState(() {});
        },
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        prefix: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            CupertinoIcons.search,
            color: Colors.teal,
          ),
        ),
        placeholder: 'Поиск по главам...',
        style:
            TextStyle(fontFamily: 'Gilroy', fontSize: 18, color: Colors.black),
        cursorColor: Colors.teal,
        clearButtonMode: OverlayVisibilityMode.editing,
      ),
    );
  }

  Widget _buildChapters() {
    return FutureBuilder<List>(
      future: _searchTextController.text.isEmpty
          ? _databaseQuery.getAllChapters()
          : _databaseQuery.getSearchResult(_searchTextController.text),
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
            child: CircularProgressIndicator(
              color: Colors.teal,
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
          caption: item.favoriteState == 0 ? 'В избранное' : 'Удалить',
          color: item.favoriteState == 0 ? Colors.teal : Colors.red,
          icon: item.favoriteState == 0
              ? CupertinoIcons.square_stack_3d_up_fill
              : CupertinoIcons.square_stack_3d_up,
          onTap: () {
            setState(
              () {
                item.favoriteState == 0
                    ? _databaseQuery.addRemoveFavorite(1, item.id!)
                    : _databaseQuery.addRemoveFavorite(0, item.id!);
              },
            );
          },
        ),
      ],
    );
  }
}
