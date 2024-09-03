import 'package:banking/Pages/home.dart';
import 'package:banking/Pages/reports.dart';
import 'package:banking/models/apps.dart';
import 'package:banking/models/transfers_model.dart';
import 'package:banking/widgets/nav_bottom.dart';
import 'package:flutter/material.dart';

class TrasnfersPage extends StatefulWidget {
  const TrasnfersPage({super.key});

  @override
  State<TrasnfersPage> createState() => _TrasnfersPageState();
}

class _TrasnfersPageState extends State<TrasnfersPage> {
  int _currentPage = 1;
  List<AppsModel> apps = [];
  List<TransfModel> transfers = [];

  void _getInitialInfo() {
    apps = AppsModel.getApps();
    transfers = TransfModel.getTransfers();
  }

  @override
  void initState() {
    super.initState();
    _getInitialInfo();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SingleChildScrollView(
        
        child: Column(
          children: [
            const SizedBox(height: 20,),
            _appsSection(),
            const SizedBox(height: 20,),
            _transfersSection(),
          ],
        ),
      ),
      bottomNavigationBar:  NavBottom(
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
          }else if (index == 3) {
              _showAlertDialog(context);
            }
          });
        },
      ),
    
    );
  }

  Row _appsSection() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(apps.length, (index){
                return Container(
                  height: 90,
                  decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 0.1),
                      blurRadius: 5.0,
                      spreadRadius: 0
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  child: Image.asset(
                    apps[index].iconPath,
                    width: 60,
                  ),
                ),
                );
              })
          );
  }

  Column _transfersSection() {
    return Column(
      children: List.generate(transfers.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: SizedBox(
            height: 105,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(transfers[index].imagePath),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        transfers[index].name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        transfers[index].bank,
                        style: const TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                          color: Color(0xff858585),
                        ),
                      )
                    ],
                  ),
                ],
            ),
          ),
        );
      }),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Transfer',
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
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: Image.asset(
              'assets/icons/plus.png',
              height: 25,
              width: 25,
              color: const Color(0xFF7B1FA2),
            ),
          ),
        ),
      ],
    );
  }

void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sorry!"),
          content: const Text("It's not avilable yet."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                 Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TrasnfersPage()),
              );
              },
            ),
          ],
        );
      },
    );
  }


}

