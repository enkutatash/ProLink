import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skillswap/Front/homepage.dart';
import 'package:skillswap/Front/signup.dart';
import 'package:skillswap/firebase/firebase.dart';
import 'package:skillswap/homepage/homepage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  late final Firebase_Service _auth;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late Map<String, dynamic> userdata;
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _auth = Firebase_Service(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset('asset/animation.json'),
                ),
                const Text(
                  "SkillSwap",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Email",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.9,
                  height: height * 0.06,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white, // Set border color to red
                      width: 2.0, // Set border width to 2 pixels (optional)
                    ),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Password",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.9,
                  height: height * 0.06,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white, // Set border color to red
                      width: 2.0, // Set border width to 2 pixels (optional)
                    ),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          // toggle password visibility
                          setState(() {
                            _passwordController.text =
                                _passwordController.text.replaceAll('•', '');
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 8 || value.length > 16) {
                        return 'Password must be between 8 and 16 characters long';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: height * 0.03),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Forget your password?",
                        style: TextStyle(color: Colors.red),
                      )),
                ),
                SizedBox(height: height * 0.02),
                Button("Enter", Colors.white, Colors.red, () {
                  if (_formKey.currentState!.validate()) {
                    // form is valid, submit the form
                    String username = _emailController.text;
                    String password = _passwordController.text;
                    // TODO: implement form submission logic here
                    _signIn();
                  }
                }),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some action to take when the user presses the action button
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _fetchUserData(String userId) async {
    try {
      userdata = await _auth.userData(userId);
    } catch (e) {
      // Handle error
    }
  }

  void _signIn() async {
    String Email = _emailController.text;
    String Password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(Email, Password);

    if (user != null) {
      
      print(user.uid);
      await _fetchUserData(user.uid);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage(user.uid,userdata)));
      _showSnackBar("User is successfully Sign in");
    } else {
       _showSnackBar("Some error happend on create user");
    }
  }
}

Widget textfield(
  String hint,
  IconData icon,
  TextEditingController controller,
  TextInputType keyboardType, {
  IconData? suffixIcon,
  double? width,
  double? height,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontStyle: FontStyle.italic,
        color: Colors.white,
      ),
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
    ),
  );
}

class Button extends StatelessWidget {
  final String text;
  final Color btnclr;
  final Color textclr;
  final void Function() click;
  Button(this.text, this.textclr, this.btnclr, this.click, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: click,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Set border radius
          ),
        ),
        minimumSize: MaterialStateProperty.all(
            Size(width * 0.8, height * 0.07)), // Set width and height
        backgroundColor:
            MaterialStateProperty.all<Color>(btnclr), // Set color to red
      ),
      child: Text(
        text,
        style: TextStyle(color: textclr),
      ),
    );
  }
}
