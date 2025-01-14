import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedGender = 'Undisclosed';
  String selectedMaritalStatus = 'Undisclosed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text('Profile'),
      //  actions: [
      //    TextButton(
      //      onPressed: () {
      //        // Save action
      //      },
      //      child: Text(
      //        'Save',
      //        style: TextStyle(color: Colors.blue),
      //      ),
      //    ),
      //  ],
      //),
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
                      decoration: InputDecoration(
                        labelText: 'Date of birth',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('GENDER', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChoiceChip(
                          label: Text('Male'),
                          selected: selectedGender == 'Male',
                          onSelected: (bool selected) {
                            setState(() {
                              selectedGender = 'Male';
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text('Female'),
                          selected: selectedGender == 'Female',
                          onSelected: (bool selected) {
                            setState(() {
                              selectedGender = 'Female';
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text('Undisclosed'),
                          selected: selectedGender == 'Undisclosed',
                          onSelected: (bool selected) {
                            setState(() {
                              selectedGender = 'Undisclosed';
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text('MARITAL STATUS', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChoiceChip(
                          label: Text('Married'),
                          selected: selectedMaritalStatus == 'Married',
                          onSelected: (bool selected) {
                            setState(() {
                              selectedMaritalStatus = 'Married';
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text('Unmarried'),
                          selected: selectedMaritalStatus == 'Unmarried',
                          onSelected: (bool selected) {
                            setState(() {
                              selectedMaritalStatus = 'Unmarried';
                            });
                          },
                        ),
                        ChoiceChip(
                          label: Text('Undisclosed'),
                          selected: selectedMaritalStatus == 'Undisclosed',
                          onSelected: (bool selected) {
                            setState(() {
                              selectedMaritalStatus = 'Undisclosed';
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    //ElevatedButton(
                    //  onPressed: () {
                    //    // Add GSTIN details action
                    //  },
                    //  child: Text('Add GSTIN details'),
                    //  style: ElevatedButton.styleFrom(
                    //    minimumSize: Size(double.infinity, 50),
                    //  ),
                    //),
                    SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        // Logout action
                      },
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
