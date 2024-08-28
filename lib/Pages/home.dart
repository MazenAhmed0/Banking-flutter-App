import 'package:banking/Pages/reports.dart';
import 'package:banking/Pages/transactions.dart';
import 'package:banking/Pages/transfers.dart';
import 'package:banking/models/trans.dart';
import 'package:banking/widgets/nav_bottom.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  List<TransModel> trans = [];

  @override
  void initState() {
    super.initState();
    _getInitialInfo();
  }

  void _getInitialInfo() {
    trans = TransModel.getTrans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: NavBottom(
        currentPage: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
            // Navigate to the corresponding page
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TrasnfersPage()),
              );
            }else if (index == 2) {
              Navigator.pushReplacement(
                context,
               MaterialPageRoute(builder: (context) => const ReportsPage()),
              );
             // Additional pages can be added here with further else-if conditions
          }
          }
          );
        },
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [ 
            Positioned(
              top: -70,
              right: -110, 
                child: Container(
                  width: 230,
                  height: 230,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8E192),
                    shape: BoxShape.circle,
                  ),
            )
          ),
            Positioned(
              top: 296,
              left: -92, 
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Color(0x4D2FCBFC),
                    shape: BoxShape.circle,
                  ),
            )
          ),
            Column(
            children: [
              _profileAndName(),
              const SizedBox(height: 40,),
              _cardSection(),
              const SizedBox(height: 40,),
              _transactionsLabel(context),
              const SizedBox(height: 20,),
              _transSection(),
            ],
          ),
          ]
        ),
      ),
    );
  }

  SafeArea _profileAndName() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 30),
        child: Column(
          children: [
            Row(
              children: [
          Stack(
            children: [
            // Gradient border
            Container(
              padding: const EdgeInsets.all(4), // Space for the gradient border
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF133FD8),
                    Color(0x4CB7004D),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
          child: Container(
            padding: const EdgeInsets.all(4), // Inner border thickness
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // Inner border color
            ),
            child: const CircleAvatar(
              radius: 40, // Adjust the size of the avatar
              backgroundImage: AssetImage('assets/images/profile.jpeg'), // Replace with your image path
            ),
          ),
            ),
            // Notification dot
            Positioned(
              top: 7,
              right: 7,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: const Color(0xFFDB1337),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white, // Add white border to separate from the avatar
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
                const SizedBox(width: 30,),
                const Column(
                  children: [
                    Text(
                      'Good morning',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'ANDREA',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 33,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 Padding _cardSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.center,
            end: Alignment.centerRight,
            colors: [
              Colors.white,
              Color.fromARGB(255, 253, 238, 243), // Darker shadow
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 1),
              blurRadius: 8.0,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  children: [
                    Text(
                      'Current Balance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '\$12567.89',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0,),
                child: Container(
                  width: 333,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF133FD8),
                        Color(0x4CB7004D),
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '3452 1235 7894 1678',
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '05/2025',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _transactionsLabel(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'LAST TRANSACTIONS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff858585),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TransactionsPage()),
                    );
                  },
                  child: const Text(
                    'View',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF133FDB),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Column _transSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(5, (index) {
        return Container(
          height: 88,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      trans[index].name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      trans[index].date,
                      style: const TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 15,
                        color: Color(0xff858585),
                      ),
                    ),
                  ],
                ),
                Text(
                  '\$${trans[index].money}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

 

}
