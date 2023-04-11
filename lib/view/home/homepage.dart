import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:coding_test/repository/home/notifier/homepage.notifier.dart';
import 'package:coding_test/view/home/homeScreen/homeScreen.dart';
import 'package:coding_test/view/home/profileScreen/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List screens = [
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    final homeData = Provider.of<HomePageNotifier>(context, listen: false);

    return WillPopScope(
      onWillPop: () {
        showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text('Exit'),
                content: const Text('Do you want to exit from this app?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      'No',
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          color: Colors.pink.shade900,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                    child: Text(
                      'Yes',
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          color: Colors.pink.shade900,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              );
            }));
        return Future.value(false);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: homeData.selectedIndex,
          itemCornerRadius: 25,
          curve: Curves.easeIn,
          showElevation: false,
          onItemSelected: (index) => setState(() {
            homeData.selectedIndex = index;
            // _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: Colors.pink.shade900,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              activeColor: Colors.pink.shade900,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        body: screens[homeData.selectedIndex],
      ),
    );
  }
}
