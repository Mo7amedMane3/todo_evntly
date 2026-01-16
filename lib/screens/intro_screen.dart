import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatelessWidget {
  static const String routeName="IntroScreen";

  const IntroScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         centerTitle: true,
        title: Image.asset("assets/images/logo.png"),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/being_intro.png",
              width: double.infinity,),
            Text("Personalize Your Experience",

              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,

              ),

            ),
            SizedBox(height: 15),
            Text("Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",

              style: GoogleFonts.inter(
                color: Color(0xFF686868),
                fontSize: 18,
                fontWeight: FontWeight.w500,

              ),

            ),
            SizedBox(height: 40),
            Column(

              spacing: 5,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Language",style: TextStyle(
                      fontSize: 22,
                        color: Color(0xFF0E3A99),

                    ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Image.asset("assets/images/Eng.png"),
                           Image.asset("assets/images/Arabic.png"),
                        ],
                      )
                      ,
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Theme",style: TextStyle(
                      fontSize: 22,
                    color: Color(0xFF0E3A99)),
                      ),
                    Container(
                      child: Row(
                        children: [
                          Image.asset("assets/images/Dark.png"),

                          Image.asset("assets/images/Light.png"),
                        ],
                      )
                      ,
                    ),
                  ],
                ),
                
              ],
            ),
            SizedBox(height: 100,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){

              }, child: Text("Let's Start",style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,

              ),),
                style:ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  backgroundColor: Color(0xFF0E3A99),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
