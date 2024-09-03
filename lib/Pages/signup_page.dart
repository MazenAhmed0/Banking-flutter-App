import 'package:banking/Pages/home.dart';
import 'package:banking/Pages/login_page.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  bool _isPasswordVisible = false;

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
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value!;
                          },
                        ),
                        const SizedBox(height: 30,),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
                        ),
                        const SizedBox(height: 30,),
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
                        const SizedBox(height: 20),
                        _signupButton(context),
                        const SizedBox(height: 30),
                        const LineWithText(text: 'OR'),
                        const SizedBox(height: 30),
                        _loginLogos(),
                        const SizedBox(height: 30,),
                        _haveAccountSection()
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
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
                        },
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
