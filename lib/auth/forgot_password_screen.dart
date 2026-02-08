import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/firebase_functions.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "ForgotPasswordScreen";
   ForgotPasswordScreen({super.key});
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
            size: 25,
            color: Color(0xFF0E3A99),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Forgot Password",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1C1C1C)
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(

              "assets/images/resetpass.png",
              width: double.infinity,
              fit: BoxFit.cover,// You can change this to your actual image

            ),
            SizedBox(height: 50),
            TextFormField(
              controller: emailController,
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: "Enter your email",
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
            SizedBox(height: 20),

            // Note: A text field to enter the email is usually needed here.
            ElevatedButton(
              onPressed: () {
                FireBaseFunctions.resetPassword(emailController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 127),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child:  Text("Reset password",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,

                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
