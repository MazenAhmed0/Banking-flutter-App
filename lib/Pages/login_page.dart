import 'package:banking/Pages/home.dart';
import 'package:banking/Pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.toString();
      final String password = _passwordController.text.toString();


        final response = await http.post(
        Uri.parse('https://ptechapp-5ab6d15ba23c.herokuapp.com/user/authenticate'), // Replace with your API endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': name, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        var successState = responseData['success'];
        if (successState == true) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
        print(responseData);
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usrname or password is wrong')),
          );
          print(responseData);
        }
      } else {
        // Handle failed login
        throw Exception('Failed to load data');
      }



    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 50),
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
                       const SizedBox(height: 30,),
                        TextFormField(
                           controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30,),
                        TextFormField(
                          controller: _passwordController,
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
                        ),
                        const SizedBox(height: 20),
                        _loginButton(context),
                        const SizedBox(height: 30),
                        const LineWithText(text: 'OR'),
                        const SizedBox(height: 30),
                        _loginLogos(),
                        const SizedBox(height: 30,),
                        _createAccountSection()
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

  Row _createAccountSection() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Create an account?',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupPage()));
              },
              child: const Text(
                'Sign Up',
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

  Container _loginButton(BuildContext context) {
    return Container(
          height: 75,
          margin: const EdgeInsets.only(left: 50.0, right: 50, top: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          width: double.infinity,
          child: TextButton(
          onPressed: () {
            _login();
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 94, 2, 155),
            padding: const EdgeInsets.all(16.0), 
          ),
          child: const Text(
            'Login',
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
            'Login',
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
