import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:questions_200/arguments/chapter_arguments.dart';
import 'package:questions_200/data/database_query.dart';
import 'package:questions_200/model/question_item.dart';

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
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        middle: Text(
          'Вопрос ${arguments!.id}',
        ),
      ),
      child: Scrollbar(
        child: SingleChildScrollView(
          child: FutureBuilder<List>(
              future: _databaseQuery.getChapterContent(arguments.id!),
              builder: (context, snapshot) {
                return snapshot.hasData
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
                        child: CircularProgressIndicator(
                          color: Colors.teal,
                        ),
                      );
              }),
        ),
      ),
    );
  }

  Widget _buildQuestionContent(QuestionItem item) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 8),
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
}
