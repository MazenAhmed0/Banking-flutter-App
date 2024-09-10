import 'package:flutter/material.dart';
import 'package:banking/Pages/transactions.dart';
import 'package:banking/models/trans.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String name;

  const HomePage({super.key, required this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> _userDataFuture;
  List<TransModel> trans = [];

  @override
  void initState() {
    super.initState();
    _userDataFuture = fetchJsonData(widget.name); // Fetch data when widget loads
    _getInitialInfo(); // Initialize transaction data
  }

  void _getInitialInfo() {
    trans = TransModel.getTrans(); // Initialize transaction data
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
              future: _userDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Scaffold(
                        backgroundColor: Colors.white,
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
                                _profileAndName(data),
                                const SizedBox(height: 40,),
                                _cardSection(data),
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
                } else {
                      return const Center(child: Text('No data found'));
                }
                },
                );
          
  }

  SafeArea _profileAndName(Map<String, dynamic> data) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 30),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
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
                Column(
                  children: [
                    const Text(
                      'Good morning',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      data['username'],
                      style: const TextStyle(
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

  Padding _cardSection(Map<String, dynamic> data) {
    var balance = double.parse(data['balance']);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.27,
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
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  children: [
                    const Text(
                      'Current Balance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      '\$$balance',
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.037,),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
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

Future<Map<String, dynamic>> fetchJsonData(String username) async {
  String url = 'https://ptechapp-5ab6d15ba23c.herokuapp.com/users/';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);
    String userId = '';
    String balance = '';
    String userFirstName = '';
    String userLastName = '';
    String password = '';

    for (var user in responseData) {
      if (username == user['username']) {
        userId = user['userAccountID'].toString();
        balance = user['balance'].toString();
        userFirstName = user['firstName'].toString();
        userLastName = user['lastName'].toString();
        password = user['password'].toString();
        break;
      }
    }

    await saveUserData(userId, username, balance, userFirstName, userLastName, password);

    return {'userID': userId, 'balance': balance, 'username': username.toUpperCase()};
  } else {
    throw Exception('Failed to load data');
  }
}

Future<void> saveUserData(String userId, username, userBalance, userFirstName, userLastName, password) async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userID', userId);
  await prefs.setString('username', username);
  await prefs.setString('userBalance', userBalance);
  await prefs.setString('userFirstName', userFirstName);
  await prefs.setString('userLastName', userLastName);
  await prefs.setString('password', password);
}

Future<Map<String, String?>> getUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('userID');
  String? username = prefs.getString('username');
  String? userBalance = prefs.getString('userBalance');
  String? userFirsName = prefs.getString('userFirstName');
  String? userLastName = prefs.getString('userLastName');
    String? password = prefs.getString('password');

  return {
    'userId': userId,
    'username': username,
    'userBalance': userBalance,
    'userFirstName': userFirsName,
    'userLastName': userLastName,
    'password': password,
  };
}

}
