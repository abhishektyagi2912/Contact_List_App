import 'package:flutter/material.dart';

import '../controllers/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/login.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                // column because i want text field jst up and down
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
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
                          'Sign In',
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
                            onPressed: () {
                              if (_emailController != null && _passwordController != null) {
                                setState(() {
                                  _isLoading = true;
                                });
                                AuthService()
                                    .loginWithEmail(_emailController.text, _passwordController.text)
                                    .then((value) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  // Handle the rest of the sign-in process as before
                                  if (value == "Login Successful") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Login Successful")));
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
                            icon: _isLoading
                                ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                                : const Icon(Icons.arrow_forward),
                          )

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
                            handleGoogleSignIn(context);
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

                        // const Padding(
                        //   padding: EdgeInsets.only(
                        //       left:
                        //       16.0), // Adjust the left value to control spacing
                        //   child: Image(
                        //     image: AssetImage('images/facebook.png'),
                        //     width: 30,
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('New User ?',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff4c505b))),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/signup");
                              // Navigator.pop(context);
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Color(0xff4c505b)),
                            ))
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
  Future<void> handleGoogleSignIn(BuildContext context) async {
    try {
      String? value = await AuthService().continueWithGoogle();

      if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'An error occurred during Google Sign-In.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xFFBB86FC),
          ),
        );
      } else if (value == "Google Login Successful") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Google Login Successful")),
        );
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              value,
              style: TextStyle(color: Colors.white),
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

