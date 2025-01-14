import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skincare_app/utilities/color_constants.dart';

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

  String imageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy5zKoI_m0hy7V1711x_xYAGJesoMf7jwyhQ&s';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('Profile Details',
                          style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // CircleAvatar with Border Decoration
                    Center(
                      child: CircleAvatar(
                        radius: screenWidth * 0.20,
                        backgroundImage: NetworkImage(imageUrl),
                        child: imageUrl == null
                            ? Icon(Icons.person, size: screenWidth * 0.15)
                            : null,
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),

                    // Full Name TextField with Custom Decoration
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Full name',
                        labelStyle: TextStyle(fontSize: screenWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Mobile Number TextField with Custom Decoration
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Mobile number',
                        labelStyle: TextStyle(fontSize: screenWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 13),
                          child: Text(
                            '+91 ',
                            style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        suffixIcon: TextButton(
                          onPressed: () {
                            // Verify action
                          },
                          child: Text('Verify',
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Email TextField with Check Icon
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email address',
                        labelStyle: TextStyle(fontSize: screenWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        suffixIcon:
                            Icon(Icons.check_circle, color: Colors.green),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Date of Birth TextField with Calendar Icon
                    TextField(
                      controller: dobController,
                      decoration: InputDecoration(
                        labelText: 'Date of birth',
                        labelStyle: TextStyle(fontSize: screenWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: ColorConstants.buttonColor),
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
                    SizedBox(height: screenHeight * 0.02),

                    // Gender Dropdown Button
                    Text('GENDER',
                        style: TextStyle(fontSize: screenWidth * 0.04)),
                    SizedBox(height: screenHeight * 0.01),
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Gender',
                        labelStyle: TextStyle(fontSize: screenWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                      items: ['Male', 'Female', 'Undisclosed']
                          .map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Marital Status Dropdown Button
                    Text('MARITAL STATUS',
                        style: TextStyle(fontSize: screenWidth * 0.04)),
                    SizedBox(height: screenHeight * 0.01),
                    DropdownButtonFormField<String>(
                      value: selectedMaritalStatus,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMaritalStatus = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Marital Status',
                        labelStyle: TextStyle(fontSize: screenWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                      items: ['Married', 'Unmarried', 'Undisclosed']
                          .map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Save Button with Decoration
                    Center(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text('Save'),
                        style: OutlinedButton.styleFrom(
                          minimumSize:
                              Size(double.infinity, screenHeight * 0.065),
                          side: BorderSide(color: ColorConstants.buttonColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Logout Button with Decoration
                    Center(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text('Logout'),
                        style: OutlinedButton.styleFrom(
                          minimumSize:
                              Size(double.infinity, screenHeight * 0.065),
                          side: BorderSide(color: ColorConstants.buttonColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
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
