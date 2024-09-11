import 'package:banking/Pages/payment_screen.dart';
import 'package:banking/models/apps.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransfersPage extends StatefulWidget {
  const TransfersPage({super.key});

  @override
  State<TransfersPage> createState() => _TransfersPageState();
}

class _TransfersPageState extends State<TransfersPage> {
  List<dynamic>? payments;
  late int paymentsLength;
  late Map<String, String?> userData;
  List<AppsModel> apps = [];

  // Fetch payments data from the server and process it
  Future<Map<String, dynamic>> getPayments(String userId) async {
    String url = 'https://ptechapp-5ab6d15ba23c.herokuapp.com/payments/$userId';

    // Fetch payment and user data
    final paymentResponse = await http.get(Uri.parse(url));
    final usersResponse = await http.get(Uri.parse('https://ptechapp-5ab6d15ba23c.herokuapp.com/users/'));

    // Check if payment response is successful
    if (paymentResponse.statusCode == 200 && usersResponse.statusCode == 200) {
      // Decode JSON response
      List<dynamic> paymentData = json.decode(paymentResponse.body);
      List<dynamic> usersData = json.decode(usersResponse.body);

      // Match payment receiverAccountNumber with usersData and add receiverName, fullName, shortName 
      for (int i = 0; i < paymentData.length; i++) {
        for (var user in usersData) {
          if (paymentData[i]['receiverAccountNumber'] == user['userAccountID']) {
            paymentData[i]['receiverName'] = user['username'];
            paymentData[i]['receiverFullName'] = 
                      '${user['firstName'][0].toUpperCase()}${user['firstName'].substring(1).toLowerCase()} '
                      '${user['lastName'][0].toUpperCase()}${user['lastName'].substring(1).toLowerCase()}';
            paymentData[i]['shortName'] = (user['firstName'][0].toUpperCase() + user['lastName'][0].toUpperCase());
            break;
          }
        }
      }

      // Return the processed payment data
      return {
        'payments': paymentData,
        'length': paymentData.length,
      };
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load payment data. Status: ${paymentResponse.statusCode}');
    }
  }

  // Initialize some initial data
  void _getInitialInfo() {
    apps = AppsModel.getApps();
  }

  @override
  void initState() {
    super.initState();
    _getInitialInfo();
    _loadUserData();
  }

  // Load user data from SharedPreferences and then fetch payments
  Future<void> _loadUserData() async {
    userData = await getUserData();
    await fetchPayments();  // Fetch payments after loading user data
  }

  // Fetch payments and update the state
  Future<void> fetchPayments() async {
    final data = await getPayments(userData['userId']!);
    setState(() {
      payments = data['payments'];
      paymentsLength = data['length'];
    });
  }

  // Pull-to-refresh method
  Future<void> _refreshData() async {
    await fetchPayments();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: RefreshIndicator(
        onRefresh: _refreshData, // The method to call when the user pulls down to refresh
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              _appsSection(),
              const SizedBox(height: 20,),
              IconButton(
                  icon: const Icon(Icons.refresh),
                  color: Colors.purple,
                  tooltip: 'Refresh',
                  onPressed: _refreshData,
              ),
              const SizedBox(height: 5,),
              _transfersSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Display the apps section
  Row _appsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(apps.length, (index) {
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
                spreadRadius: 0,
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
      }),
    );
  }

  // Display the transfers section
  Column _transfersSection() {
    return Column(
      children: payments != null 
        ? List.generate(paymentsLength, (index) {
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
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Center(
                          child: Text(
                            payments?[index]['shortName'] ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          payments?[index]['receiverFullName'] ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        const Text(
                          'AW BANK UNI 234-46589-000',
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 15,
                            color: Color(0xff858585),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.067),
                      child: Text(
                        payments?[index]['amount'] ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        : [const CircularProgressIndicator()], // Show a loading indicator while payments are being loaded
    );
  }

  // Build the app bar
  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Transfer',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
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
              MaterialPageRoute(builder: (context) => PaymentScreen()),
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

  // Load user data from SharedPreferences
  Future<Map<String, String?>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userID');
    String? username = prefs.getString('username');
    String? userBalance = prefs.getString('userBalance');
    String? userFirstName = prefs.getString('userFirstName');
    String? userLastName = prefs.getString('userLastName');
    return {
      'userId': userId,
      'username': username,
      'userBalance': userBalance,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
    };
  }
}
