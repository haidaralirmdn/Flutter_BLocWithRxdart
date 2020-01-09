import 'package:bloc_hero/ui/addheropage.dart';
import 'package:bloc_hero/ui/listheropage.dart';
import 'package:bloc_hero/ui/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final int _pageCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blueAccent,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.pinkAccent,
        height: 50,
        index: _currentIndex,
        items: <Widget>[
          Icon(Icons.list, size: 25, color: Colors.white),
          Icon(Icons.add, size: 25, color: Colors.white),
          Icon(Icons.person, size: 25, color: Colors.white),
        ],
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        onTap: onTappedNav,
      ),
    );
  }

  void onTappedNav(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _body() {
    return Stack(
      children: List<Widget>.generate(_pageCount, (int index) {
        return IgnorePointer(
          ignoring: index != _currentIndex,
          child: Opacity(
            opacity: _currentIndex == index ? 1.0 : 0.0,
            child: Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return new MaterialPageRoute(
                  builder: (_) => _page(index),
                  settings: settings,
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _page(int index) {
    switch (index) {
      case 0:
        return ListHeroPage();
      case 1:
        return AddHeroPage();
      case 2:
        return ProfilePage();
    }
    throw "Invalid index $index";
  }
}
