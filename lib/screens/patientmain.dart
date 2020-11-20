import 'package:doctor/screens/appointscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './home_screen.dart';
import './login_screen.dart';
import '../constants.dart';
import '../screens/courses_screen.dart';
import '../screens/my_courses_screen.dart';
import '../screens/my_wishlist_screen.dart';
import '../screens/account_screen.dart';
import '../screens/my_wishlist_screen.dart';

import '../widgets/filter_widget.dart';
import '../providers/auth.dart';

class patient extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<patient> {
  List<Widget> _pages = [
    LoginScreen(),
    LoginScreen(),
    LoginScreen(),
    LoginScreen(),
  ];
  var _isInit = true;
  var _isLoading = false;

  int _selectedPageIndex = 0;
  bool _isSearching = false;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Provider.of<Auth>(context).tryAutoLogin().then((_) {});
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      final _isAuth = Provider.of<Auth>(context, listen: false).isAuth;

      if (_isAuth) {
        _pages = [
          MyCoursesScreen(),
          MyCoursesScreen2(),
          MyWishlistScreen(),
          AccountScreen(),
        ];
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _handleSubmitted(String value) {
    final searchText = searchController.text;
    if (searchText.isEmpty) {
      return;
    }

    searchController.clear();
    Navigator.of(context).pushNamed(
      CoursesScreen.routeName,
      arguments: {
        'category_id': null,
        'seacrh_query': searchText,
        'type': CoursesPageData.Search,
      },
    );
    // print(searchText);
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showFilterModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return FilterWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !_isSearching
            ? Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                height: 32,
              )
            : TextFormField(
                controller: searchController,
                onFieldSubmitted: _handleSubmitted,
              ),
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: kSecondaryColor,
              ),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                });
              }),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future:
                  Provider.of<Auth>(context, listen: false).getpatientinfo(),
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
                    return Consumer<Auth>(builder: (context, authData, child) {
                      final user = authData.user;
                      return SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          child: UserAccountsDrawerHeader(
                            accountName: Text(user.firstName),
                            accountEmail: Text(""),
                            currentAccountPicture: CircleAvatar(
                              backgroundColor: Theme.of(context).platform ==
                                      TargetPlatform.iOS
                                  ? Colors.blue
                                  : Colors.white,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(user.image),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                  }
                }
              },
            ),
            ListTile(
                title: Text("Appointments"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  AccountScreen();
                }),
            ListTile(
              title: Text("Records"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text("Presciptions"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text("Health Articles"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text("Conversations"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text("Accounts"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterModal(context),
        child: Icon(Icons.filter_list),
        backgroundColor: kDarkButtonBg,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            backgroundColor: kBackgroundColor,
            icon: Icon(Icons.school),
            title: Text('Appointments'),
          ),
          BottomNavigationBarItem(
            backgroundColor: kBackgroundColor,
            icon: Icon(Icons.shopping_basket),
            title: Text('Record'),
          ),
          BottomNavigationBarItem(
            backgroundColor: kBackgroundColor,
            icon: Icon(Icons.favorite_border),
            title: Text('Prescription'),
          ),
          BottomNavigationBarItem(
            backgroundColor: kBackgroundColor,
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          ),
        ],
        backgroundColor: kBackgroundColor,
        unselectedItemColor: kSecondaryColor,
        selectedItemColor: kSelectItemColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
