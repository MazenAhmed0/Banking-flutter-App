import 'package:banking/Pages/home.dart';
import 'package:banking/Pages/transfers.dart';
import 'package:banking/models/trans.dart';
import 'package:banking/widgets/nav_bottom.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  List<TransModel> trans = [];

  int _currentPage = 0;

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
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
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
            } else if (index == 3) {
              _showAlertDialog(context);
            }
            // Additional pages can be added here with further else-if conditions
          });
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              _transactionsLabel(),
              const SizedBox(height: 25,),
              _transactionsCards(),
            ],
          ),
        ),
      ),
    );
  }

  Column _transactionsCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(trans.length, (index) {
        return Container(
          height: 88,
          margin: const EdgeInsets.symmetric(vertical: 6,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        fontWeight: FontWeight.w400,
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

  Column _transactionsLabel() {
    return const Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Transactions',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 5,),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                '2021',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.only(left: 7.0),
          child: Row(
            children: [
              Text(
                'JAN',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                'FEB',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                'MAR',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                'APR',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                'JAN',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
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
                MaterialPageRoute(builder: (context) => const TransactionsPage()),
              );
              },
            ),
          ],
        );
      },
    );
  }


}