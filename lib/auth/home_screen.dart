import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_evntly/screens/tabs/favourite_tabs.dart';
import 'package:todo_evntly/screens/tabs/home2_tabs.dart';
import 'package:todo_evntly/screens/tabs/profile_tabs.dart';

import '../provider/auth_provider.dart';
import '../provider/home_provider.dart';
import '../screens/add_event/add_event_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName= "HomeScreen";
   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authprovider=Provider.of<AuthProvider>(context);
    return ChangeNotifierProvider(

      create: (context)=>HomeProvider(),
      builder: (context,child){
        var provider=Provider.of<HomeProvider>(context);
      return  Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios,
                size: 25,
                color:Color (0xFF0E3A99)),
            onPressed: (){
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
          ),


          actions: [
            ImageIcon(AssetImage("assets/images/sun.png"),
              color: Colors.blue,
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text("En",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            SizedBox(width: 8),
          ],
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text("Welcome Back ✨",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF686868),
              ),),
            subtitle: Text(
              authprovider.userModel!.name,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1C1C1C),
              ),

            ),
          ),

        ),

        bottomNavigationBar: BottomNavigationBar(
            currentIndex: provider.selectedIndex,
            onTap: (value){
              provider.changeIndex(value);
            },
            items:
            [BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/Vector.png")),
                label: "Home"),
              BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/heart.png")),
                  label: "Favorite"),
              BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/user.png")),
                  label: "Profile"),
            ]
        ),
       body: tabs[provider.selectedIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, AddEventScreen.routeName);
          },
          child: Icon(Icons.add,color: Colors.white,size: 35,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),


      );
      }

    );
    
  }
  List<Widget> tabs=[HomeTabs2(),FavouriteTabs(),ProfileTabs()];
}
