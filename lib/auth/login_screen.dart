import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_evntly/auth/home_screen.dart';
import 'package:todo_evntly/auth/regester_screen.dart';
import 'package:todo_evntly/core/firebase_functions.dart';

import '../provider/auth_provider.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var authprovider=Provider.of<AuthProvider>(context);


    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
              size: 25,
              color: Color(0xFF0E3A99)),
              onPressed: (){
               Navigator.of(context).pop();
              },

        ),
          centerTitle: true,
          title: Image.asset(
            "assets/images/logo.png",
            height: 32,
          ),
        ),

      body: Padding(

        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Login to your account",
                  style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                    fontWeight: FontWeight.bold,
                ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 24),
                // Email Field
                TextFormField(
                  controller: emailController,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFFB0B0B0),
                    ),
                    prefixIcon: Image.asset("assets/images/sms.png",
                    width: 24,
                    height: 24,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFFE0E0E0),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFFE0E0E0),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),


                TextFormField(
                  controller: passwordController,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  obscureText: _isPasswordObscured,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFFB0B0B0),
                    ),
                    prefixIcon: Image.asset("assets/images/lock.png",
                      width: 24,
                      height :24,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xFFB0B0B0),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFFE0E0E0),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFFE0E0E0),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ForgotPasswordScreen.routeName,
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                 ElevatedButton(
                  onPressed: () {
                    FireBaseFunctions.login(
                        emailController.text,
                        passwordController.text,

                        onSuccess: (){
                          authprovider.initUser();
                          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                        },
                        onError: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      message,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                  ),
                                  ),
                              ),
                          );
                        });

                  },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Color(0xFF0E3A99),
                     padding:  const EdgeInsets.symmetric(vertical: 16),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(16)
                     )
                   ),
                  child:  Text(
                      "Login",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500

                      )
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                        "Don't have an account?",
                        style: GoogleFonts.poppins(
                          color: Color(0xFF686868),
                          fontSize: 14,
                          fontWeight: FontWeight.w600

                        )
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegesterScreen.routeName);
                      },
                      child:  Text(
                          "SignUp",
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600

                          )
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(child: Divider(thickness: 3,
                      color: Color(0xFFF0F0F0),)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or ",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                     Expanded(child: Divider(thickness: 3,
                         color: Color(0xFFF0F0F0),
                     )
                     )
                  ],
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,


                  ),
                  onPressed: () {
                    // TODO: Implement Google Sign-In
                  },
                  icon: Image.asset("assets/images/google.png", height: 24), // TODO: Add google_logo.png to assets/images
                  label:  Text("Sign in with Google",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary

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
}
