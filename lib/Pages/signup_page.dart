import 'package:banking/Pages/login_page.dart';
import 'package:banking/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  String? _firstname;
  String? _lastname;
  String? _email;
  String? _selectedLang; // Corrected variable name
  bool _isPasswordVisible = false;

    final List<String> _langs = ['en', 'ar', 'es'];



Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final data = {
        'username': _username,
        'password': _password,
        'firstname': _firstname,
        'lastname': _lastname,
        'email': _email,
        'language': _selectedLang,
      };

      final url = Uri.parse('https://ptechapp-5ab6d15ba23c.herokuapp.com/user/register'); // Replace with your API endpoint

      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          // Handle successful sign-up
          final responseData = jsonDecode(response.body);
          var successState = responseData['success'];
          String? userName;
          (successState == true)?(userName = responseData['data']['username'].toString()):(userName = null);
          print('Sign-up successful: $responseData');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp(username: userName.toString(),)), // Replace with your next screen
          );
        } else {
          // Handle errors from the API
          print('Sign-up failed: ${response.body}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(

            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _logoAndName(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Username'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _username = value!;
                            },
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty || !value.contains('@')) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value!;
                            },
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !_isPasswordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Firstname'),
                            validator: (value) {
                              if (value == null || value.isEmpty ) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _firstname = value!;
                            },
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Lastname'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _lastname = value!;
                            },
                          ),
                          const SizedBox(height: 15,),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(labelText: 'Language'),
                            value: _selectedLang,
                            items: _langs.map((String lang) {
                              return DropdownMenuItem<String>(
                                value: lang,
                                child: Text(lang),
                              );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedLang = newValue;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a language';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _selectedLang = value;
                              },
                           ),
                          const SizedBox(height: 20),
                          _signupButton(context),
                          const SizedBox(height: 30),
                          const LineWithText(text: 'OR'),
                          const SizedBox(height: 30),
                          _loginLogos(),
                          const SizedBox(height: 30,),
                          _haveAccountSection(),
                          const SizedBox(height: 30,),
                        ],
                      ),
                    ),
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }

  Row _haveAccountSection() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Already have an account?',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.purple
                ),
                ))
          ],
        );
  }

  Row _loginLogos() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {

              },
            child: Image.asset(
              'assets/icons/google.png',
              height: 50,
            )
            ),
            const SizedBox(width: 30,),
            GestureDetector(
              onTap: () {

              },
            child: Image.asset(
              'assets/icons/facebook.png',
              height: 40,
              )
            ),
          ],
        );
  }

  Container _signupButton(BuildContext context) {
    return Container(
            height: 75,
            margin: const EdgeInsets.only(left: 50.0, right: 50, top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            width: double.infinity,
            child: TextButton(
            onPressed: _signUp,
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 94, 2, 155),
              padding: const EdgeInsets.all(16.0), 
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white, 
                fontSize: 23.0, 
              ),
            ),
          ),
          );
  }

  Column _logoAndName() {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logo.jpg', height: 70,),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          );
  }
}

class LineWithText extends StatelessWidget {
  final String text;

  const LineWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const Divider(
          thickness: 1,
          color: Colors.grey,
          indent: 40.0,
          endIndent: 40.0,
        ),
        Container(
          color: Colors.white, 
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
