import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:questions_200/arguments/chapter_arguments.dart';
import 'package:questions_200/data/database_query.dart';
import 'package:questions_200/model/question_item.dart';
import 'package:html/parser.dart';
import 'package:share_plus/share_plus.dart';

class AnswerContentPage extends StatefulWidget {
  const AnswerContentPage({Key? key}) : super(key: key);

  @override
  _AnswerContentPageState createState() => _AnswerContentPageState();
}

class _AnswerContentPageState extends State<AnswerContentPage> {
  var _databaseQuery = DatabaseQuery();

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as ChapterArguments?;
    return FutureBuilder<List>(
      future: _databaseQuery.getChapterContent(arguments!.id!),
      builder: (context, snapshot) {
        return CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            middle: Text(
              'Вопрос ${arguments.id}',
            ),
            // leading: CupertinoButton(
            //     onPressed: () {
            //       Navigator.of(context, rootNavigator: true)
            //         .pushNamed('/settings');
            //     },
            //     padding: EdgeInsets.zero,
            //     child: Icon(
            //       CupertinoIcons.settings,
            //       color: Colors.teal,
            //     )),
            trailing: CupertinoButton(
              onPressed: () {
                var item = snapshot.data![0];
                Share.share(
                  _parseHtmlString(
                    'Вопрос ${arguments.id}\n\n${item.questionContent}\n\nОтвет\n\n${item.answerContent}',
                  ),
                  sharePositionOrigin: Rect.fromLTWH(0, 0, 10, 10 / 2),
                );
              },
              padding: EdgeInsets.zero,
              child: Icon(
                CupertinoIcons.share,
                color: Colors.teal,
              ),
            ),
          ),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: snapshot.hasData
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildQuestionContent(snapshot.data![index]),
                            _buildAnswerContent(snapshot.data![index]),
                          ],
                        );
                      },
                    )
                  : Center(
                      child: CupertinoActivityIndicator(),
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
      margin: EdgeInsets.only(left: 8, top: 32, right: 8, bottom: 8),
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
      child: Center(
        child: SelectableHtml(
          data: '${item.questionContent}',
          style: {
            '#': Style(
                fontSize: FontSize(20),
                color: Colors.teal,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
                fontFamily: 'Gilroy'),
            'a': Style(
              fontSize: FontSize(18),
              color: Colors.blue,
            ),
          },
        ),
      ),
    );
  }

  Widget _buildAnswerContent(QuestionItem item) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SelectableHtml(
        onLinkTap: (String? url, RenderContext rendContext,
            Map<String, String> attributes, element) {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
              message: Html(
                data: url,
                style: {
                  '#': Style(
                      fontSize: FontSize(18),
                      color: Colors.grey[800],
                      fontFamily: 'Gilroy')
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
        data: '${item.answerContent}',
        style: {
          '#': Style(
              fontSize: FontSize(20),
              color: Colors.grey[800],
              fontFamily: 'Gilroy'),
          'a': Style(
            fontSize: FontSize(18),
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

  String _parseHtmlString(String htmlString) {
    final documentText = parse(htmlString);
    final String parsedString =
        parse(documentText.body!.text).documentElement!.text;
    return parsedString;
  }
}
