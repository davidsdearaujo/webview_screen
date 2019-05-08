library webview_screen;

import 'dart:async';

import 'webview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'webview_mixin.dart';

String _url = "";

class WebviewScreen extends StatefulWidget {
  Function(BuildContext) loadingBuilder;
  WebviewScreen(
    String url, {
    Key key,
    this.loadingBuilder,
  }) : super(key: key) {
    _url = url;
    loadingBuilder ??= (context) => Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        );
  }
  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> with WebviewMixin {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: bloc.loadingStream,
        builder: (context, snapshot) {
          bool isLoading = snapshot.data ?? true;

          return Stack(
            children: <Widget>[
              WebView(
                initialUrl: _url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (String url) {
                  bloc.loadingSink.add(false);
                  // print('Page finished loading: $url');
                },
              ),
              (isLoading)
                  ? widget.loadingBuilder(context)
                  : Container(),
            ],
          );
        });
  }
}
