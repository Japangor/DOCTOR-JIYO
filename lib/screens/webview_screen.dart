import 'package:flutter/material.dart';
import 'dart:async';
import '../constants.dart';

class WebviewScreen extends StatelessWidget {
  static const routeName = '/webview';

  @override
  Widget build(BuildContext context) {
    final selectedUrl = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kSecondaryColor, //change your color here
          ),
          title: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
            height: 32,
          ),
          backgroundColor: kBackgroundColor,
          actions: <Widget>[
            // FutureBuilder<WebViewController>(
            //   future: _controller.future,
            //   builder: (ctx, AsyncSnapshot<WebViewController> controller) {
            //     if (controller.hasData) {
            //       // print('lalala');
            //       return IconButton(
            //         icon: Icon(Icons.refresh),
            //         onPressed: () async {
            //           controller.data.reload();
            //         },
            //       );
            //     } else {
            //       return Container();
            //     }
            //   },
            // ),
          ],
        ),
        body: Text(''));
  }
}

class NavigationControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {}
}
