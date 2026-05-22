import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../core/firebase_functions.dart';
import '../models/task_model.dart';

class EditEventScreen extends StatefulWidget {
  static const String routeName = "EditEventScreen";
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  DateTime selectedDate = DateTime.now();
  List<String> categories = [
    "sport",
    "book_club",
    "meeting",
    "exhibition",
    "birthday",
  ];
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  int selectedCategoriesIndex = 0;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      var args = ModalRoute.of(context)?.settings.arguments;
      if (args is TaskModel) {
        titleController.text = args.title;
        descriptionController.text = args.description;
        selectedDate = DateTime.fromMicrosecondsSinceEpoch(args.date);
        selectedCategoriesIndex = categories.indexOf(args.category);
        if (selectedCategoriesIndex == -1) selectedCategoriesIndex = 0;
      }
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context)!.settings.arguments as TaskModel;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0E3A99)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Edit Event",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/${categories[selectedCategoriesIndex]}.png",
                  height: 193,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 50,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoriesIndex = index;
                        });
                      },
                      child: Chip(
                        label: Text(
                          categories[index].replaceAll("_", ' ').toUpperCase(),
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: index != selectedCategoriesIndex
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.white,
                              ),
                        ),
                        backgroundColor: index == selectedCategoriesIndex
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text("Title", style: TextStyle(fontSize: 20,
                  color: Color(0xFF1C1C1C),
                  fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              TextFormField(
                controller: titleController,
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
              const SizedBox(height: 16),
              const Text("Description", style: TextStyle(fontSize: 20,
                  color: Color(0xFF1C1C1C),
                  fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 4,
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
              const SizedBox(height: 20),
              Row(
                children: [
                   Icon(Icons.calendar_month, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  const Text("Event Date", style: TextStyle(fontSize: 18,
                      color: Color(0xFF1C1C1C),fontWeight: FontWeight.w500)),
                  const Spacer(),
                  TextButton(
                    onPressed: selectDateTime,
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(selectedDate),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  task.title = titleController.text;
                  task.description = descriptionController.text;
                  task.date = selectedDate.microsecondsSinceEpoch;
                  task.category = categories[selectedCategoriesIndex];

                  await FireBaseFunctions.updateTask(task);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Event Edit Successfully"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pop(); // العودة لشاشة التفاصيل
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text("Update Event", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectDateTime() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      builder: (context, child) => Theme(data: ThemeData(), child: child!),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }
}
