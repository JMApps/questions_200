import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SupportProjectPage extends StatelessWidget {
  SupportProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.money_dollar_circle,
        color: Colors.white,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Поддержать проект!',
              style: TextStyle(color: Colors.teal),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    CupertinoIcons.bitcoin_circle,
                    color: Colors.teal,
                  ),
                  title: Text(
                    'Bitcoin',
                    style: _itemTitleTextStyle,
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.all(8),
                    child: SelectableText(
                      '13B9fMAxXFCSkLnkHFNrA2D2xAZtyMaWxy',
                      style: _itemSubtitleTextStyle,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      CupertinoIcons.doc_on_doc,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      FlutterClipboard.copy(
                          '13B9fMAxXFCSkLnkHFNrA2D2xAZtyMaWxy');
                      _snackMessage(context, 'Bitcoin адрес скопирован');
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    CupertinoIcons.money_dollar_circle,
                    color: Colors.teal,
                  ),
                  title: Text(
                    'Monero',
                    style: _itemTitleTextStyle,
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.all(8),
                    child: SelectableText(
                      '87zyaJCihgg2r8mSbXKE1uj4iqPp8hqQkWMdr2SbBVmGchjVNACEDDtEV1tB79cK1q2bC8h8Sy3BMVQLfWCSfyBjLjqkJB7',
                      style: _itemSubtitleTextStyle,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      CupertinoIcons.doc_on_doc,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      FlutterClipboard.copy(
                          '87zyaJCihgg2r8mSbXKE1uj4iqPp8hqQkWMdr2SbBVmGchjVNACEDDtEV1tB79cK1q2bC8h8Sy3BMVQLfWCSfyBjLjqkJB7');
                      _snackMessage(context, 'Monero адрес скопирован');
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final _itemTitleTextStyle = TextStyle(fontSize: 20, fontFamily: 'Gilroy');
  final _itemSubtitleTextStyle =
      TextStyle(fontSize: 18, fontFamily: 'Gilroy', color: Colors.grey[600]);

  _snackMessage(BuildContext context, String clipMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          clipMessage,
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
