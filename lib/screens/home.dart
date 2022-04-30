import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/historymettingscreen.dart';
import 'package:zoom_clone/screens/meetingscreen.dart';
import 'package:zoom_clone/services/auth.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/customhomebutton.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static final String id = "/Home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  final List<Widget> _pages = [
    MeetingScreen(),
    const HistoryMettingScreen(),
    const Text('Contacts'),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        child: const Text('Logout'),
        style: ElevatedButton.styleFrom(
            primary: buttonColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: buttonColor),
            )),
        onPressed: () => AuthMethods().signOut(),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Zoom'),
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              AuthMethods().user.photoURL!,
            ),
          )
        ],
      ),
      body: _pages[_page],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: footerColor,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: onPageChanged,
          currentIndex: _page,
          unselectedFontSize: 14,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.comment_bank), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.lock_clock), label: 'Meetings'),

            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Contacts'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: 'Settings'),
            // BottomNavigationBarItem(icon: Icon(Icons.comment_bank), label: ''),
          ]),
    );
  }
}
