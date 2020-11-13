import 'package:flutter/cupertino.dart';

class Section {
  int id;
  int numberOfCompletedLessons;
  String title;
  String prestit;
  String diag;
  int lessonCounterEnds;

  Section({
    @required this.id,
    @required this.numberOfCompletedLessons,
    @required this.title,
    @required this.prestit,
    @required this.lessonCounterEnds,
    @required this.diag,
  });
}
