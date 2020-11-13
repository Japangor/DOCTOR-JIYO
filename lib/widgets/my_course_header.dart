import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/custom_text.dart';
import '../screens/webview_screen.dart';
import '../screens/webview_screen_iframe.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import '../models/common_functions.dart';
import '../widgets/youtube_player_widget.dart';
import 'dart:io';

class MyCourseHeader extends StatelessWidget {
  Future<void> downloadFile(String downloadUrl, String filename) async {
    Dio dio = Dio();
    print(downloadUrl);

    try {
      var dir = await getApplicationDocumentsDirectory();
      print(dir.path);

      dio.download(downloadUrl, "${dir.path}/$filename",
          onReceiveProgress: (rec, total) {
        print(rec.toString());
      });
      CommonFunctions.showSuccessToast("Download completed");
    } catch (e) {
      print(e.getMessage());
      CommonFunctions.showSuccessToast("Download Error");
    }
    print("Download completed");
  }

  void _showYoutubeModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return YoutubePlayerWidget(
          newKey: UniqueKey(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: kDarkButtonBg,
        child: FractionallySizedBox(
          widthFactor: 0.5,
          heightFactor: 0.3,
          child: RaisedButton.icon(
            color: kBlueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
              // side: BorderSide(color: kBlueColor),
            ),
          ),
        ),
      ),
    );
  }
}
