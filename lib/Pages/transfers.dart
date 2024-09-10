import 'package:banking/Pages/payment_screen.dart';
import 'package:banking/models/apps.dart';
import 'package:banking/models/transfers_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TrasnfersPage extends StatefulWidget {
  const TrasnfersPage({super.key});

  @override
  State<TrasnfersPage> createState() => _TrasnfersPageState();
}

class _TrasnfersPageState extends State<TrasnfersPage> {

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
                    child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 141, 164, 248),
                            Color.fromARGB(75, 253, 114, 172),
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(40)),),
                      child:  const Center(
                        child: Text(
                          'ES',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
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
                    Padding(
                     padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.067),
                     child: const Text(
                      '\$30',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                                       ),
                   )
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
          onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  PaymentScreen()),
              );
          },
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

Future<Map<String, String?>> getUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('userID');
  String? username = prefs.getString('username');
  String? userBalance = prefs.getString('userBalance');
  String? userFirsName = prefs.getString('userFirstName');
  String? userLastName = prefs.getString('userLastName');
  return {
    'userId': userId,
    'username': username,
    'userBalance': userBalance,
    'userFirstName': userFirsName,
    'userLastName': userLastName,
  };
}


}



