import 'package:flutter/material.dart';
import '../controllers/crud_services.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Define the custom color scheme
  final Color primaryColor = Color(0xFFBB86FC); // #FFBB86FC
  final Color backgroundColor = Colors.white;
  final Color textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
        backgroundColor: primaryColor, // Set app bar background color
      ),
      backgroundColor: backgroundColor, // Set background color
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    validator: (value) =>
                    value!.isEmpty ? "Enter any name" : null,
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(
                        "Name",
                        style: TextStyle(color: textColor), // Set text color
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(
                        "Phone",
                        style: TextStyle(color: textColor), // Set text color
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(
                        "Email",
                        style: TextStyle(color: textColor), // Set text color
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width * .9,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        CRUDService().addNewContacts(
                          _nameController.text,
                          _phoneController.text,
                          _emailController.text,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "Create",
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor, // Set button color
                      onPrimary: Colors.white, // Set text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
