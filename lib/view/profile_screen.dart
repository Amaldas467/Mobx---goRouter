import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedGender = 'Undisclosed';
  String selectedMaritalStatus = 'Undisclosed';
  TextEditingController dobController = TextEditingController();
  String? ageError;
  final FocusNode dobFocusNode = FocusNode();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      int age = calculateAge(selectedDate);

      if (age < 18) {
        setState(() {
          ageError = 'You must be at least 18 years old.';
        });
      } else {
        setState(() {
          ageError = null;
          dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
        });
      }
    }
  }

  int calculateAge(DateTime dob) {
    final today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Profile Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Full name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Mobile number',
                        border: OutlineInputBorder(),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 13),
                          child: Text(
                            '+91 ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        suffixIcon: TextButton(
                          onPressed: () {
                            // Verify action
                          },
                          child: Text('Verify'),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        border: OutlineInputBorder(),
                        suffixIcon:
                            Icon(Icons.check_circle, color: Colors.green),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: dobController,
                      decoration: InputDecoration(
                        labelText: 'Date of birth',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              //color: dobFocusNode.hasFocus
                              //    ? Colors.green
                              //    : Colors.grey, // Green border when focused
                              ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                        errorText: ageError,
                      ),
                      readOnly: true,
                    ),
                    SizedBox(height: 20),
                    Text('GENDER', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    // Dropdown for Gender
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Gender',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Male', 'Female', 'Undisclosed']
                          .map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text('MARITAL STATUS', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    // Dropdown for Marital Status
                    DropdownButtonFormField<String>(
                      value: selectedMaritalStatus,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMaritalStatus = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Marital Status',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Married', 'Unmarried', 'Undisclosed']
                          .map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 5),
                    Center(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text('Save'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text('Logout'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
