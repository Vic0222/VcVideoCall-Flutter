import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:url_launcher/url_launcher.dart';

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
              onTap: (url) {
                _launchEmail(url, context);
              }),
          MatchText(
              type: ParsedType.URL,
              style: textStyle.copyWith(
                decoration: TextDecoration.underline,
              ),
              onTap: (String url) {
                _launchUrl(url, context);
              }),
          MatchText(
              type: ParsedType.PHONE,
              style: textStyle.copyWith(
                decoration: TextDecoration.underline,
              ),
              onTap: (url) {
                _launchTelephone(url, context);
              }),
        ],
      ),
    );
  }

  void _launchEmail(url, BuildContext context) {
    Uri uri = Uri.parse(url);
    if (!uri.hasScheme) {
      uri = uri.replace(scheme: "mailto");
    }

    url = uri.toString();
    _launch(url, context);
  }

  void _launchTelephone(url, BuildContext context) {
    Uri uri = Uri.parse(url);
    if (!uri.hasScheme) {
      uri = uri.replace(scheme: "tel");
    }

    url = uri.toString();
    _launch(url, context);
  }

  void _launchUrl(String url, BuildContext context) {
    Uri uri = Uri.parse(url);
    if (!uri.hasScheme) {
      uri = uri.replace(scheme: "https");
    }

    url = uri.toString();
    _launch(url, context);
  }

  Future<void> _launch(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Can't launch url")));
    }
  }
}
