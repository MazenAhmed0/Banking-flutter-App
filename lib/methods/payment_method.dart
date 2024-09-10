// import 'dart:convert';  // For json decoding
// import 'package:banking/methods/getUserData.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;



// Future<String> sendMoney(String userName, recId, date, amount) async {
//   String url = 'https://ptechapp-5ab6d15ba23c.herokuapp.com/payments/transfer';


//         final paymentData = {
//           'receiverAccountNumber': recId,
//           'senderAccountNumber': userID,
//           'paymentDate': date,
//           'paymentAmount': amount,
//           'paymentType': 'test',
//       };


//   final response = await http.post(
//     Uri.parse(url),
//     body: paymentData,
//   );

//    String message = '';

//   if (response.statusCode == 200) {
//     var responseData = json.decode(response.body);
//     var successState = responseData['success'];
//     if (successState == false) {
//       message = responseData['message'];
//     } else{

//       message = 'Successful transaction';
//      }

//     return message;
//   } else {
//     throw Exception('Failed to load data');
//   }
// }
