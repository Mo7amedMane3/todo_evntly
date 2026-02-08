import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_evntly/auth/forgot_password_screen.dart';
import 'package:todo_evntly/core/my_theme.dart';
import 'package:todo_evntly/firebase_options.dart';
import 'package:todo_evntly/provider/auth_provider.dart';
import 'package:todo_evntly/provider/theme_provider.dart';
import 'package:todo_evntly/screens/add_event/add_event_screen.dart';
import 'package:todo_evntly/screens/intro_screen.dart';
import 'package:todo_evntly/auth/login_screen.dart';
import 'package:todo_evntly/screens/tabs/home2_tabs.dart';
import 'screens/tabs/favourite_tabs.dart';
import 'auth/home_screen.dart';
import 'auth/onbording_screen_one.dart';
import 'screens/tabs/profile_tabs.dart';
import 'auth/regester_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await FirebaseFirestore.instance.disableNetwork();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp( EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('ar'),
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context)=>ThemeProvider()),
            ChangeNotifierProvider(create: (context)=>AuthProvider()),

          ],
          child: MyApp()),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ThemeProvider>(context);
    var authprovider=Provider.of<AuthProvider>(context);

    return MaterialApp(
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      initialRoute: authprovider.fireBaseUser!=null
          ? HomeScreen.routeName
          :LoginScreen.routeName,
        routes: {
        IntroScreen.routeName:(context)=> const IntroScreen(),
          OnboardingScreen.routeName:(context)=> const OnboardingScreen(),
          LoginScreen.routeName:(context)=> const LoginScreen(),
          RegesterScreen.routeName:(context)=> const RegesterScreen(),
          ForgotPasswordScreen.routeName:(context)=>  ForgotPasswordScreen(),
          HomeScreen.routeName:(context)=>  HomeScreen(),
          FavouriteTabs.routeName:(context)=> const FavouriteTabs(),
          ProfileTabs.routeName:(context)=> const ProfileTabs(),
          HomeTabs2.routeName:(context)=>  HomeTabs2(),
          AddEventScreen.routeName:(context)=>  AddEventScreen(),






        },
    );
  }
}
