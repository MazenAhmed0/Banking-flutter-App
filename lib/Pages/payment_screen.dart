import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Map<String, String?> userData;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _receiverController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? receiverName;
  String? amount;

  @override
  void initState() {
    super.initState();
    _loadUserData();  // Call the async function
  }

String formattedDate() {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(now);
}


  Future<void> _loadUserData() async {
    userData = await getUserData();
    setState(() {
      // Any state updates after loading the data should be done here
    });
  }

  Future<void> _transfer(String recId, date, String amount) async {
    if (_formKey.currentState!.validate()) {
      String url = 'https://ptechapp-5ab6d15ba23c.herokuapp.com/payments/transfer';

      final paymentData = {
        'receiverAccountNumber': recId,
        'senderAccountNumber': userData['userId'],
        'paymentDate': date,
        'paymentAmount': amount,
        'paymentType': 'test',
      };

      final response = await http.post(
        Uri.parse(url),
        body: paymentData,
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        var successState = responseData['success'];
        if (successState == false) {
          String errorMessage = 'Transaction failed. Make sure you have enough balance and entered a valid name';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Transfer Successful!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors in red before submitting.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<String> getReceiverID(String receiverName) async {
    String url = 'https://ptechapp-5ab6d15ba23c.herokuapp.com/users/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      String receiverId = '';

      for (var user in responseData) {
        if (receiverName == user['username']) {
          receiverId = user['userAccountID'].toString();
          break;
        }
      }
      return receiverId;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void dispose() {
    _receiverController.dispose();
    _amountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Money'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _receiverController,
                decoration: const InputDecoration(labelText: 'Receiver Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the receiver\'s name';
                  }
                  return null;
                },
                onSaved: (value) {
                  receiverName = value!;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
                onSaved: (value) {
                  amount = value!;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value != userData['password']) {
                    return 'Password is wrong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    String receiverId = await getReceiverID(receiverName!);
                    _transfer(receiverId, formattedDate().toString(), amount!);
                  }
                },
                child: const Text('Transfer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, String?>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userID');
    String? username = prefs.getString('username');
    String? userBalance = prefs.getString('userBalance');
    String? userFirstName = prefs.getString('userFirstName');
    String? userLastName = prefs.getString('userLastName');
    String? password = prefs.getString('password');

    return {
      'userId': userId,
      'username': username,
      'userBalance': userBalance,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'password': password,
    };
  }
}
