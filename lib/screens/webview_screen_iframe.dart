import 'package:flutter/material.dart';
import 'dart:async';
import '../constants.dart';

class WebviewScreenIframe extends StatelessWidget {
  static const routeName = '/webview-iframe';

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
        ),
        body: Text(''));
  }
}
