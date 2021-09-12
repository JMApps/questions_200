import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:questions_200/arguments/chapter_arguments.dart';
import 'package:questions_200/data/database_query.dart';
import 'package:questions_200/model/question_item.dart';

class QuestionChapterAndroid extends StatefulWidget {
  const QuestionChapterAndroid({Key? key}) : super(key: key);

  @override
  _QuestionChapterAndroidState createState() => _QuestionChapterAndroidState();
}

class _QuestionChapterAndroidState extends State<QuestionChapterAndroid> {
  var _databaseQuery = DatabaseQuery();
  TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
        title: Text('200 вопросов'),
      ),
      body: Column(
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
        color: Colors.teal,
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
              setState(
                () {
                  item.favoriteState == 0
                      ? _databaseQuery.addRemoveFavorite(1, item.id!)
                      : _databaseQuery.addRemoveFavorite(0, item.id!);
                },
              );
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
                  data: item.questionContent,
                  style: {
                    '#': Style(
                        fontSize: FontSize(20),
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        fontFamily: 'Gilroy'),
                    'a': Style(
                      fontSize: FontSize(16),
                      color: Colors.blue,
                    )
                  },
                ),
              ],
            ),
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
