import 'package:banking/Pages/home.dart';
import 'package:banking/Pages/reports.dart';
import 'package:banking/Pages/start_page.dart';
import 'package:banking/Pages/transfers.dart';
import 'package:banking/widgets/nav_bottom.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const StartPage(),
      },
    );
  }
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  String username;
  MyApp({super.key, required this.username});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   int _selectedIndex = 0;
   late dynamic userName;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    userName = widget.username;
    _pages = [
    HomePage(name: userName,),
    const TrasnfersPage(),
    const ReportsPage(),
  ];
  }
  

  void _onItemTapped(int index) {
    setState(() {
     if (index != 3) {
       _selectedIndex = index;
     } else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('It\' not avilable yet.'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.black,
              ),
          );
     }
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavBottom(
        currentPage: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}