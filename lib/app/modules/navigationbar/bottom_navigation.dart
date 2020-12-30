import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:thor_flutter/app/modules/main/main_page.dart';

class BottomNavigationBarPage extends StatefulWidget {
  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TabController _tabController;
  AnimationController _animationController;
  DateTime currentBackPressTime;
  int _currentTab = 0;

  var currentTab = [
    MainPage(),
    MainPage(),
    MainPage(),
    MainPage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: currentTab.length);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(context),
      child: Scaffold(
        key: _scaffoldkey,
        drawerEdgeDragWidth: 0,
        body: Stack(
          children: <Widget>[
            NotificationListener<UserScrollNotification>(
              child: TabBarView(
                  children: currentTab,
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics()),
              onNotification: (UserScrollNotification notification) {
                if (true) {
                  if (notification.direction == ScrollDirection.reverse &&
                      notification.metrics.extentAfter > kToolbarHeight &&
                      notification.metrics.axis == Axis.vertical) {
                    _animationController.forward();
                  } else if (notification.direction ==
                      ScrollDirection.forward) {
                    _animationController.reverse();
                  }
                }
                return true;
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTab,
          onTap: (index) {
            setState(() {
              _currentTab = index;
              _tabController.animateTo(_currentTab);
              _animationController.reverse();
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).accentColor,
          selectedLabelStyle: TextStyle(
              // fontSize: 15.0,
              ),
          items: [
            BottomNavigationBarItem(
                icon: Icon(FlutterIcons.home_ant), label: 'Tienda'),
            BottomNavigationBarItem(
                icon: Icon(FlutterIcons.shopping_cart_fea), label: 'Carrito'),
            BottomNavigationBarItem(
                icon: Icon(FlutterIcons.favorite_border_mdi),
                label: 'Favoritos'),
            BottomNavigationBarItem(
                icon: Icon(FlutterIcons.account_outline_mco), label: 'Cliente'),
          ],
        ),
      ),
    );
  }

  Future<bool> _willPopCallback(BuildContext context) async {
    DateTime now = DateTime.now();
    if (_currentTab != 1) {
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > Duration(seconds: 4)) {
        currentBackPressTime = now;
        _scaffoldkey.currentState
            .showSnackBar(SnackBar(content: Text('Press again to exit')));
        return Future.value(false);
      }
    }
    return Future.value(true);
  }
}