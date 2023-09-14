import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/register.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            // here single child scroll view make box of email pass up and down according to the keyboard
            SingleChildScrollView(
              child: Container(
                // column because i want text field jst up and down
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    // want gap
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff4c505b)),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xff4c505b),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: (){
                              if (_emailController != null && _passwordController != null) {
                                AuthService()
                                    .createAccountWithEmail(
                                    _emailController.text, _passwordController.text)
                                    .then((value) {
                                  if (value == "Account Created") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Account Created")));
                                    Navigator.pushReplacementNamed(context, "/home");
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                        value,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Color(0xFFBB86FC),
                                    ));
                                  }
                                });
                              }
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "or with",
                          style:
                          TextStyle(fontSize: 18, color: Color(0xff4c505b)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            handleSignIn(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                              right: 16.0,
                            ),
                            child: Image(
                              image: AssetImage('images/google.png'),
                              width: 30,
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already Have account ?',
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff4c505b))),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Color(0xff4c505b)),
                            )
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> handleSignIn(BuildContext context) async {
    try {
      String value = await AuthService().continueWithGoogle();

      if (value == "Google Login Successful") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Google Login Successful")),
        );
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xFFBB86FC),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An unexpected error occurred.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFFBB86FC),
        ),
      );
    }
  }

}
