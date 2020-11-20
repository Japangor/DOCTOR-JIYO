import 'package:doctor/screens/addrecord.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../constants.dart';
import '../providers/fetch.dart';
import '../widgets/appointgrid.dart.dart';

class MyCoursesScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                PreferredSize(
                  preferredSize: Size.fromHeight(80),
                  child: Row(
                    children: <Widget>[
                      ButtonTheme(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRect(
                            child: Material(
                              color: Colors.yellow, // button color
                              child: InkWell(
                                splashColor: Colors.red, // inkwell color
                                child: SizedBox(
                                    width: 80,
                                    height: 60,
                                    child: Text('UPLOAD')),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => addrecord()),
                                  );
                                },
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future:
                Provider.of<fetchdata>(context, listen: false).fetchrecords(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (dataSnapshot.error != null) {
                  //error
                  return Center(
                    child: Text('Error Occured'),
                  );
                } else {
                  return Consumer<fetchdata>(
                    builder: (context, myCourseData, child) =>
                        StaggeredGridView.countBuilder(
                      padding: const EdgeInsets.all(10.0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 1,
                      itemCount: myCourseData.items.length,
                      itemBuilder: (ctx, index) {
                        return MyCoureGrid2(
                          myCourse: myCourseData.items[index],
                        );
                        // return Text(myCourseData.items[index].title);
                      },
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
