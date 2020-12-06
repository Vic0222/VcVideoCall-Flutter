import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    Key key,
    @required this.message,
    @required this.textStyle,
  }) : super(key: key);

  final String message;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 34,
      ),
      padding: EdgeInsets.all(8),
      child: ParsedText(
        text: message,
        style: textStyle,
        parse: [
          MatchText(
              type: ParsedType.EMAIL,
              style: textStyle.copyWith(
                decoration: TextDecoration.underline,
              ),
              onTap: (url) {}),
          MatchText(
            type: ParsedType.URL,
            style: textStyle.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
          MatchText(
              type: ParsedType.PHONE,
              style: textStyle.copyWith(
                decoration: TextDecoration.underline,
              ),
              onTap: (url) {
                print(url);
              }),
        ],
      ),
    );
  }
}
