import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phpc_v2/Views/BiblePageRP.dart';
import 'package:phpc_v2/Views/EventPage.dart';
import 'package:phpc_v2/Views/GivingPage.dart';
import 'package:phpc_v2/Views/Homepage.dart';
import 'package:phpc_v2/Views/SermonSeriesPage.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({Key? key}) : super(key: key);

  @override
  _PageNavigationState createState() => _PageNavigationState();
}

class _PageNavigationState extends State<PageNavigation> {
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fifthTabNavKey = GlobalKey<NavigatorState>();

  late int _pageIndex;
  late List<Widget> _pages;
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageIndex = 0;
    _pages = [
      CupertinoTabView(
        navigatorKey: firstTabNavKey,
        builder: (BuildContext context) => const FrontPage(),
      ),
      CupertinoTabView(
        navigatorKey: secondTabNavKey,
        builder: (BuildContext context) => const EventPage(),
      ),
      CupertinoTabView(
        navigatorKey: thirdTabNavKey,
        builder: (BuildContext context) => const SermonSeriesPage(),
      ),
      CupertinoTabView(
        navigatorKey: fourthTabNavKey,
        builder: (BuildContext context) => const GivePage(),
      ),
      CupertinoTabView(
        navigatorKey: fifthTabNavKey,
        builder: (BuildContext context) => const BiblePageRP(),
      ),
    ];
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.church),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidCalendar), label: 'Events'),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.tv,
              ),
              label: 'Sermons'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.handHoldingHeart), label: 'Give'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bible), label: 'Bible'),
        ],
        currentIndex: _pageIndex,
        onTap: (int index) {
          if (currentIndex == index) {
            switch (index) {
              case 0:
                firstTabNavKey.currentState?.popUntil((route) => route.isFirst);
                break;
              case 1:
                secondTabNavKey.currentState?.popUntil((r) => r.isFirst);
                break;
              case 2:
                thirdTabNavKey.currentState?.popUntil((r) => r.isFirst);
                break;
              case 3:
                fourthTabNavKey.currentState
                    ?.popUntil((route) => route.isFirst);
                break;
              case 4:
                fourthTabNavKey.currentState
                    ?.popUntil((route) => route.isFirst);
                break;
            }
          } else {
            setState(() {
              currentIndex = index;
              _pageIndex = index;
              _pageController.jumpToPage(index);
            });
          }
        },
      ),
    );
  }
}
