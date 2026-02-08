import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_evntly/auth/onbording_screen_one.dart';

import '../provider/theme_provider.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = "IntroScreen";

  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  bool isEnglishSelected = true;
  bool isLightSelected = true;
  bool _isInitialized=false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      isEnglishSelected = context.locale.languageCode == 'en';
      _isInitialized = true;
    }
  }
  @override


  Widget build(BuildContext context) {
    var provider=Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/images/logo.png",
          height: 32,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
            Theme.of(context).brightness ==Brightness.light?  "assets/images/being_intro.png":
            "assets/images/dark_being.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 16),

            Text(
              "title".tr(),
              style: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.onError,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              "subtitle".tr(),
              style: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 40),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _titleText("language".tr()),
                Row(
                  children: [
                    _selectItem(
                      image: "assets/images/Eng.png",
                        isSelected: isEnglishSelected,
                        onTap: ()async {
                        await context.setLocale(const Locale('en'));
                        setState(() {
                        isEnglishSelected = true;
                        });

                        },
                        ),
                        const SizedBox(width: 16),
                        _selectItem(
                        image: "assets/images/Arabic.png",

                        isSelected: !isEnglishSelected,
                        onTap: ()async {
                        await context.setLocale(const Locale('ar'));
                        setState(() {
                        isEnglishSelected = false;
                        });

                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                _titleText("theme".tr()),

                Row(
                  children: [
                    _selectItem(
                      image: "assets/images/Light.png",
                      isSelected: isLightSelected,
                      onTap: () {
                        provider.changeTheme(ThemeMode.dark);
                        setState(() {
                          isLightSelected = true;
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    _selectItem(
                      image: "assets/images/Dark.png",
                      isSelected: !isLightSelected,
                      onTap: () {
                        provider.changeTheme(ThemeMode.light);

                        setState(() {
                          isLightSelected = false;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                 Navigator.pushNamed(context, OnboardingScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0E3A99),

                padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "start".tr(),
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }


  Widget _titleText(String text,) {
    return Text(
      text,
      style:  TextStyle(
        fontSize: 25,
        color: Theme.of(context).colorScheme.primary,

        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _selectItem({
    required String image,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 75,
        height: 40,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
            width: 3,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),

          child: Image.asset(
            image,
            fit: BoxFit.cover,


          ),
        ),
      ),
    );
  }
}