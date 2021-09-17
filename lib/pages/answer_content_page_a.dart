import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:questions_200/arguments/chapter_arguments.dart';
import 'package:questions_200/data/database_query.dart';
import 'package:questions_200/model/question_item.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnswerContentPageA extends StatefulWidget {
  const AnswerContentPageA({Key? key}) : super(key: key);

  @override
  _AnswerContentPageState createState() => _AnswerContentPageState();
}

class _AnswerContentPageState extends State<AnswerContentPageA> {
  var _databaseQuery = DatabaseQuery();
  late SharedPreferences _preferences;

  @override
  void initState() {
    initPreferences();
    super.initState();
  }

  initPreferences() async {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      setState(() {
        _preferences = sp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as ChapterArguments?;
    return FutureBuilder<List>(
      future: _databaseQuery.getChapterContent(arguments!.id!),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.teal,
            title: Text('Вопрос ${arguments.id}'),
            actions: [
              IconButton(
                onPressed: () {
                  var item = snapshot.data![0];
                  Share.share(
                    _parseHtmlString(
                      'Вопрос ${arguments.id}\n\n${item.questionContent}\n\nОтвет\n\n${item.answerContent}\n\n${item.footnoteForShare != null ? item.footnoteForShare : SizedBox()}',
                    ),
                    sharePositionOrigin: Rect.fromLTWH(0, 0, 10, 10 / 2),
                  );
                },
                icon: Icon(
                  Icons.share,
                ),
              ),
            ],
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              child: snapshot.hasData
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            _buildQuestionContent(snapshot.data![index]),
                            _buildAnswerContent(snapshot.data![index]),
                          ],
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuestionContent(QuestionItem item) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [
            Colors.grey[300]!,
            Colors.grey[100]!,
            Colors.grey[50]!,
          ],
        ),
      ),
      child: Html(
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
                  ),
                },
              ),
              cancelButton: CupertinoActionSheetAction(
                child: Text(
                  'Закрыть',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
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
        data: '${item.questionContent}',
        style: {
          '#': Style(
            color: Colors.teal,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
            fontSize: FontSize(20),
          ),
          'sup': Style(
            fontSize: FontSize(14),
            color: Colors.blue,
          ),
          'small': Style(
            fontSize: FontSize(16),
            color: Colors.grey[600],
          )
        },
      ),
    );
  }

  Widget _buildAnswerContent(QuestionItem item) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Html(
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
                  ),
                },
              ),
              cancelButton: CupertinoActionSheetAction(
                child: Text(
                  'Закрыть',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
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
        data: '${item.answerContent}',
        style: {
          '#': Style(
            textAlign: TextAlign.justify,
            fontSize: FontSize(20),
            fontFamily: 'Gilroy'
          ),
          'sup': Style(
            fontSize: FontSize(14),
            color: Colors.blue,
          ),
          'small': Style(
            fontSize: FontSize(14),
            color: Colors.grey[600],
          )
        },
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    final documentText = parse(htmlString);
    final String parsedString =
        parse(documentText.body!.text).documentElement!.text;
    return parsedString;
  }
}
