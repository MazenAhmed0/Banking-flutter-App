import 'package:banking/Pages/home.dart';
import 'package:banking/Pages/transfers.dart';
import 'package:banking/widgets/nav_bottom.dart';
import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  int _currentPage = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      bottomNavigationBar:  _navBottom(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            _moneySection(),
            const SizedBox(height: 30,),
            
          ],
        ),
      ),
        
    );
  }

  Row _moneySection() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 79,
                width: 156,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8E192),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 15.0,top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Money In',
                        style: TextStyle(
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            '+ \$3,456.98',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 5,),
                          Icon(
                            Icons.trending_up,
                            size: 15,
                            color: Colors.purple,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 79,
                width: 156,
                decoration: BoxDecoration(
                  color: const Color(0xFFB6E0F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                                  child: const Padding(
                  padding: EdgeInsets.only(left: 15.0,top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Money Out',
                        style: TextStyle(
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            '- \$567.25',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 5,),
                          Icon(
                            Icons.trending_up,
                            size: 15,
                            color: Colors.purple,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              
            ],
          );
  }

  NavBottom _navBottom(BuildContext context) {
    return NavBottom(
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
          // }else if (index == 1) {
          //   Navigator.pushReplacement(
          //     context,
          //     // MaterialPageRoute(builder: (context) => const MorePage()),
          //   );
          // }
        });
      },
    );
  }

    AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Reoprts',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          alignment: Alignment.center,
          child: Stack(
            children: [
            // Gradient border
            Container(
              padding: const EdgeInsets.all(2), // Space for the gradient border
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
            padding: const EdgeInsets.all(1), // Inner border thickness
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
              top: 10,
              right: 2,
              child: Container(
                width: 9,
                height: 9,
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
        ),
      ),
    );
    
  }
}
