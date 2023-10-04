import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/auth/widgets/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool _passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    }
    return false;
  }

  Future _signUp() async {
    if (_passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      await _addUserDetails(
        _emailController.text.trim(),
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        int.parse(_ageController.text.trim()),
      );
      _navigatePop();
    }
  }

  Future _addUserDetails(
      String email, String firstName, String lastName, int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "age": age,
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _ageController.dispose();

    super.dispose();
  }

  void _navigatePop() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/firebase_logo.png",
                        width: 80,
                        height: 80,
                      ),
                      const Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Image.asset(
                        "assets/flutter_logo.png",
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "SIGN UP NOW!",
                    style: GoogleFonts.bebasNeue(
                      color: Colors.black54,
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "fill in details!",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  TextfieldWidget(
                    controller: _emailController,
                    hintText: "email",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextfieldWidget(
                    controller: _passwordController,
                    hintText: "password",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextfieldWidget(
                    controller: _confirmPasswordController,
                    hintText: "confirm password",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextfieldWidget(
                    controller: _firstNameController,
                    hintText: "first name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextfieldWidget(
                    controller: _lastNameController,
                    hintText: "last name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextfieldWidget(
                    controller: _ageController,
                    hintText: "age",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: GestureDetector(
                      onTap: _signUp,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff0F5E9F),
                              Color(0xff59C7F8),
                              Color(0xffFFCE35),
                              Color(0xffFFAB1C),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I am a memeber! ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Login Now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
