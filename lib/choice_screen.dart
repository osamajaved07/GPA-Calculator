// ignore_for_file: avoid_function_literals_in_foreach_calls, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field

import 'package:flutter/material.dart';

import 'package:gpa_calculator/gpa_show_screen.dart';

import 'package:multi_dropdown/multiselect_dropdown.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  int? selectedOption;

  List<TextEditingController> controllers = [];

  
  int? numFieldsToFill;

  Color _inputTextColor = Colors.white;

  @override

  void initState() {

    super.initState();

    controllers = List.generate(6, (index) => TextEditingController());

  }

  @override

  void dispose() {

    controllers.forEach((controller) => controller.dispose());

    super.dispose();
  }



  double gpaCalc() {

    double totalGrade = 0.0;

    int totalCredits = 0;

    bool allFieldsFilled = true;


    if (numFieldsToFill != null) {

      for (int i = 0; i < numFieldsToFill!; i++) {

        String textGrade = controllers[i].text.trim();

        if (textGrade.isEmpty) {

          allFieldsFilled = false;

          break;

        }

        double grade = double.parse(textGrade);

        totalCredits++;



        if (grade >= 90) {

          totalGrade += 4.0;

        } else if (grade >= 85 && grade <= 89) {

          totalGrade += 4.0;

        } else if (grade >= 80 && grade <= 84) {

          totalGrade += 3.8;

        } else if (grade >= 75 && grade <= 79) {

          totalGrade += 3.4;

        } else if (grade >= 71 && grade <= 74) {
          totalGrade += 3.0;

        } else if (grade >= 68 && grade <= 70) {

          totalGrade += 2.8;

        } else if (grade >= 64 && grade <= 67) {

          totalGrade += 2.4;

        } else if (grade >= 61 && grade <= 63) {

          totalGrade += 2.0;

        } else if (grade >= 57 && grade <= 60) {

          totalGrade += 1.8;

        } else if (grade >= 53 && grade <= 56) {

          totalGrade += 1.4;

        } else if (grade >= 50 && grade <= 52) {

          totalGrade += 1.0;

        } else if (grade < 50) {

          totalGrade += 0.0;

        }
      }


      if (allFieldsFilled) {
        // Calculate the average GPA

        double averageGPA = totalGrade / totalCredits;

        return averageGPA;

      } else {

        return 1000.0; // Indicate an error

      }

    }

    return 0.0; // Default value

  }


  void _showDialog() {

    showDialog(

      context: context,

      builder: (BuildContext context) {

        return AlertDialog(

          backgroundColor: Color.fromARGB(255, 182, 245, 245),

          title: Text("Alert"),

          content: Text('Please fill all fields', style: TextStyle(

            color: Color.fromARGB (255, 54, 69, 79)

          ),),

          actions: [
            TextButton(

              onPressed: () {

                Navigator.of(context).pop();

              },

              child: Text("OK"),

            ),

          ],

        );

      },
    );

  }



  void _refreshTextFields() {

    for (final controller in controllers) {

      controller.clear();

    }

  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Color.fromARGB(255, 0, 128, 128),

      appBar: AppBar(

        backgroundColor: Color.fromARGB(255, 0, 128, 128),
        title: Text(

          "GPA Calculator",

          style: TextStyle(

            fontWeight: FontWeight.bold,

            color: Color.fromARGB(255, 254, 255, 255),

          ),

        ),

        actions: [

          IconButton(

            onPressed: _refreshTextFields,

            icon: Icon(Icons.refresh,color: Colors.white,),

          ),

        ],

        centerTitle: true,

      ),

      body: Padding(

        padding: EdgeInsets.all(16),

        child: SingleChildScrollView(

          child: Column(

            children: [

              MultiSelectDropDown(

                onOptionSelected: (List<ValueItem> selectedOptions) {

                  setState(() {

                    selectedOption = selectedOptions.isNotEmpty

                        ? selectedOptions.first.value as int

                        : null;

                    numFieldsToFill = selectedOption;

                  });

                },

                options: [

                  ValueItem(label: '4', value: 4),

                  ValueItem(label: '5', value: 5),

                  ValueItem(label: '6', value: 6),

                ],

                selectionType: SelectionType.single,

                chipConfig: const ChipConfig(wrapType: WrapType.wrap),

                dropdownHeight: 150,

                optionTextStyle: const TextStyle(fontSize: 16),

                selectedOptionIcon: const Icon(Icons.check_circle),

                hint: "Choose number of courses",

              ),

              if (selectedOption != null)

                ...List.generate(

                  selectedOption!,

                  (index) => Padding(

                    padding: const EdgeInsets.only(top: 28.0),







                    child: TextField(
                      

                     onChanged: (value) {

                // Example: Change text color based on input length

                setState(() {

                  if (value.length > 2) {

                    _inputTextColor = Colors.red; 

                  } else {

                    _inputTextColor = Colors.white;

                  }

                });

              },



              style: TextStyle(color: _inputTextColor),



                      controller: controllers[index],

                      keyboardType: TextInputType.number,

                      cursorColor: Colors.white,

                      decoration: InputDecoration(



                        labelStyle: TextStyle(color: Colors.white),

                        labelText: 'Course ${index + 1}',

                        border: OutlineInputBorder(

                            borderSide: BorderSide(color: Colors.white)),

                        focusedBorder: OutlineInputBorder(

                          borderSide: BorderSide(color: Color.fromARGB(255, 227, 227, 227), width: 4),

                        ),

                        enabledBorder: OutlineInputBorder(

                            borderSide: BorderSide(color: Colors.white)),

                      ),

                    ),

                  ),

                ),

              SizedBox(height: 22),

              ElevatedButton(

                style: ButtonStyle(

                  backgroundColor: MaterialStateProperty.all(

                      Color.fromARGB(255, 54, 69, 79)),

                ),

                onPressed: () {

                  double calculatedGPA = gpaCalc();

                  if (calculatedGPA != 1000.0) {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                          builder: (context) => GPA_Show_Screen(gpa: calculatedGPA)),

                    );

                  } else {

                    _showDialog();

                  }

                },

                child: Text(

                  "Calculate",

                  style: TextStyle(color: Colors.white,

                  fontSize: 16),



                ),

              ),

            ],

          ),

        ),

      ),

    );
  }
}






























































