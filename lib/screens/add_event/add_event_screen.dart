import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_evntly/core/firebase_functions.dart';

import '../../models/task_model.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName="AddEventScreen";
   AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  var selectedDate = DateTime.now();
  List<String> Categories = [

    "sport",
    "book_club",
    "meeting",
    "exhibition",
    "birthday",
  ];
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();


  int selectedCategoriesIndex = 0;


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
        title: Text("Add Event", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Theme
              .of(context)
              .colorScheme
              .onError,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/${Categories[selectedCategoriesIndex]}.png",
                  height: 193, width: double.infinity, fit: BoxFit.cover,)
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                height: 50,
                child:
                ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 12),
                  itemCount: Categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedCategoriesIndex = index;
                        setState(() {

                        });
                      },
                      child: Chip(label: Text(
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                          color: index != selectedCategoriesIndex
                              ? Theme
                              .of(context)
                              .colorScheme
                              .primary
                              : Colors.white,
                        ),
                        Categories[index].replaceAll("_", ' ').toUpperCase(),
                      ),
                        backgroundColor: index == selectedCategoriesIndex ?
                        Theme
                            .of(context)
                            .colorScheme
                            .primary
                            : Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),

                      ),
                    );
                  },
                )
            ),
            SizedBox(
              height: 15,
            ),
            Text("Title",

                style: TextStyle(color: Color(0xFF1C1C1C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

                )),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "Please enter your name";
                }
                return null;
              },
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Event Title",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFFB0B0B0),
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
            SizedBox(
              height: 12,
            ),
            Text("Description",

                style: TextStyle(color: Color(0xFF1C1C1C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

                )),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              maxLines: 7,
              controller: descriptionController,
              validator: (value){
                if(value!.isEmpty){
                  return "Please enter your name";

                }
                return null;
              },
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),

              decoration: InputDecoration(

                hintText: "Event Description",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFFB0B0B0),
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
            SizedBox(height: 12),
            Row(
              children: [
                Image.asset(
                  "assets/images/calendar.png", width: 24, height: 24,),
                SizedBox(
                  width: 8,
                ),
                Text("Event Date", style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1C1C),
                ),),
                Spacer(),

                GestureDetector(
                  onTap: () {
                    selectDateTime();
                  },
                  child: Text(selectedDate.toString().substring(0, 10),
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0XFF0E3A99),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary)),
                )

              ],
            ),
            SizedBox(height: 30),
            Container(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {
                  TaskModel task = TaskModel(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    title: titleController.text,
                    description: descriptionController.text,
                    date: selectedDate.microsecondsSinceEpoch,
                    category: Categories[selectedCategoriesIndex],
                  );
                  FireBaseFunctions.createTask(task);
                  Navigator.of(context).pop();
                },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                        ),
                      ),
                      backgroundColor: Theme
                          .of(context)
                          .colorScheme
                          .primary
                  ),
                  child: Text("Add Event", style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,)),
                )
            ),
          ],
        ),
      ),
    );
  }

  selectDateTime() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: selectedDate,
        builder: (context, child) => Theme(data: ThemeData(), child: child!),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
        if (chosenDate != null) {
          selectedDate=chosenDate;
    }
          setState(() {}
          );
        }
  }





