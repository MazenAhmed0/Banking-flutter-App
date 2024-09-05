import 'dart:convert';  // For json decoding
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchJsonData(String username) async {
  String url = 'https://ptechapp-5ab6d15ba23c.herokuapp.com/users/';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);
    String userId = '';
    String balance = '';

    for (var user in responseData) {
      if (username == user['username']) {
        userId = user['userAccountID'].toString();
        balance = user['balance'].toString();
        break;
      }
    }

    return {'userID': userId, 'balance': balance, 'username': username.toUpperCase()};
  } else {
    throw Exception('Failed to load data');
  }
}
