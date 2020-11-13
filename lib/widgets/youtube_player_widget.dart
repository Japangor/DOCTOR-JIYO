import 'package:flutter/material.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final String videoUrl;
  final UniqueKey newKey;
  YoutubePlayerWidget({@required this.videoUrl, this.newKey});
  @override
  _YoutubePlayerWidgetState createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  // String videoURL = "https://www.youtube.com/watch?v=n8X9_MgEdCg";

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: Align(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
