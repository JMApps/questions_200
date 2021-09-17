import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:questions_200/arguments/chapter_arguments.dart';
import 'package:questions_200/data/database_query.dart';
import 'package:questions_200/model/question_item.dart';
import 'package:questions_200/pages/support_project_page.dart';

class QuestionChaptersA extends StatefulWidget {
  const QuestionChaptersA({Key? key}) : super(key: key);

  @override
  _QuestionChaptersAState createState() => _QuestionChaptersAState();
}

class _QuestionChaptersAState extends State<QuestionChaptersA> {
  var _databaseQuery = DatabaseQuery();
  TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('200 вопросов'),
        backgroundColor: Colors.teal,
        actions: [
          SupportProjectPage(),
          IconButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed('/settings_a');
            },
            icon: Icon(Icons.settings),
          ),
        ],
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
      color: Colors.teal,
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
              _snackMessage(item);
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

  _snackMessage(QuestionItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.teal,
        content: Text(
          item.favoriteState == 0
              ? 'Добавлено в избранное'
              : 'Удалено из избранного',
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
