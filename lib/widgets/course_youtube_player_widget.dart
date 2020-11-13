import 'package:flutter/material.dart';

class CourseYoutubePlayerWidget extends StatefulWidget {
  final String videoUrl;
  final UniqueKey newKey;
  CourseYoutubePlayerWidget({@required this.videoUrl, this.newKey})
      : super(key: newKey);
  @override
  _CourseYoutubePlayerWidgetState createState() =>
      _CourseYoutubePlayerWidgetState();
}

class _CourseYoutubePlayerWidgetState extends State<CourseYoutubePlayerWidget> {
  // String videoURL = "https://www.youtube.com/watch?v=n8X9_MgEdCg";


  void initState() {


    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  // @override
  // void deactivate() {
  //   // Pauses video while navigating to next page.
  //   _controller.pause();
  //   super.deactivate();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AspectRatio(
        aspectRatio: 16 / 9,

      ),
    );
  }
}
