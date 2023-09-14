import 'package:flutter/material.dart';

import '../controllers/crud_services.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({
    super.key,
    required this.docID,
    required this.name,
    required this.phone,
    required this.email,
  });
  final String docID, name, phone, email;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;
    _nameController.text = widget.name;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Contact"),
        backgroundColor: Color(0xFFBB86FC), // Set app bar background color
      ),
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
                      label: Text("Name"),
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
                      label: Text("Phone"),
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
                      label: Text("Email"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width * .9,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        CRUDService().updateContact(
                            _nameController.text,
                            _phoneController.text,
                            _emailController.text,
                            widget.docID);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Set the text color to white
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Color(0xFFBB86FC)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width * .9,
                  child: OutlinedButton(
                    onPressed: () {
                      CRUDService().deleteContact(widget.docID);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all(Color(0xFFBB86FC)),
                      side: MaterialStateProperty.all(
                        BorderSide(
                          color: Color(0xFFBB86FC),
                        ),
                      ),
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
