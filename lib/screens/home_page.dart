import 'package:uashopi_mobile/screens/home.dart';
import 'package:uashopi_mobile/screens/ruangan/ruangan_screen.dart';
import 'package:uashopi_mobile/screens/booking/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  String token = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  _loadToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var data = localStorage.getString('accessToken');

    if (data != null) {
      setState(() {
        token = data;
      });
    }
    // Optionally, provide a default value if the token is null
    // else {
    //   setState(() {
    //     token = 'defaultAccessToken';
    //   });
    // }
  }

  void navigateToBookingScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BookingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;

            // Navigasi ke halaman BookingScreen saat item Booking dipilih
            if (index == 2) {
              navigateToBookingScreen();
            }
          });
        },
        // indicatorColor: Colors.amber[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'Master Ruangan',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'Booking',
          ),
        ],
      ),
      body: <Widget>[
        const HomeScreen(),
        RuanganScreen(),
        BookingScreen(),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Booking Ruangan'),
        ),
      ][currentPageIndex],
    );
  }
}
