// import 'dart:collection';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Providers/login_provider.dart';
import 'package:ecommerce_app/forget_password_screens/password_recovery.dart';
import 'package:ecommerce_app/home_screens/home.dart';
import 'package:ecommerce_app/start_screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart'
    show GoogleSignIn, GoogleSignInAccount, GoogleSignInAuthentication;

class Login extends StatefulWidget {
  final VoidCallback replacetheme;
  Login({super.key, required this.replacetheme});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emaileditingcont = TextEditingController();
  final TextEditingController passwordeditingcont = TextEditingController();
  final GlobalKey<FormState> globleformkey = GlobalKey();
  bool isloaded = false;
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    } else {
      setState(() {
        isloaded = true;
      });
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        isloaded = false;
      });
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => HomeScreen(
            emailkey: googleUser.email,
            replacetheme: widget.replacetheme,
          ),
        ),
        (route) => false,
      );
      // CustomSnakebar(cont: context, text: 'Login Successfully');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login Successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isdark = Theme.of(context).brightness == Brightness.dark;
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: isloaded
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Container(
                    color: const Color.fromARGB(172, 255, 145, 182),
                    height: 300,
                    padding: EdgeInsets.only(right: 90),
                    child: Image.asset(
                      'assets/images/login_dark.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Welcome back!',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Log in with the data you entered during your registration',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Form(
                  key: globleformkey,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                            color: isdark ? Colors.black : Colors.black,
                          ),
                          controller: emaileditingcont,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Requird';
                            } else if (!value.contains('@')) {
                              return 'Email Must have @';
                            } else {
                              return null;
                            }
                          },
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.lightBlueAccent,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: Colors.grey.shade200,
                            prefixIcon: Icon(Icons.email_outlined),
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            prefixIconColor: Colors.grey.shade600,
                            hintText: 'Email address',
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(
                            color: isdark ? Colors.black : Colors.black,
                          ),
                          controller: passwordeditingcont,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Requird';
                            } else if (value.length < 6) {
                              return 'Password must more than 6 characters';
                            } else {
                              return null;
                            }
                          },
                          obscureText: loginProvider.passwordVisible,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                loginProvider.togglePasswordVisibility();
                              },
                              icon: loginProvider.passwordVisible
                                  ? Icon(Icons.visibility_off_outlined)
                                  : Icon(Icons.remove_red_eye_outlined),
                            ),
                            suffixIconColor: Colors.grey[600],
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.lightBlueAccent,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: Colors.grey.shade200,
                            prefixIcon: Icon(Icons.lock_outline),
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            prefixIconColor: Colors.grey.shade600,
                            hintText: 'Password',
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => PasswordRecovery()),
                      );
                    },
                    textColor: Colors.deepPurpleAccent,
                    child: Text(
                      'Forgot password',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    onPressed: !loginProvider.isLoading
                        ? () async {
                            if (globleformkey.currentState!.validate()) {
                              try {
                                final result = await loginProvider.login(
                                  emaileditingcont.text.trim(),
                                  passwordeditingcont.text.trim(),
                                );
                                if (result != null &&
                                    FirebaseAuth
                                        .instance
                                        .currentUser!
                                        .emailVerified) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomeScreen(
                                        replacetheme: widget.replacetheme,
                                        emailkey: emaileditingcont.text.trim(),
                                      ),
                                    ),
                                    (route) => false,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Login Successfully'),
                                    ),
                                  );
                                } else if (FirebaseAuth
                                        .instance
                                        .currentUser!
                                        .emailVerified ==
                                    false) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'You Must Verified your account',
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Wrong email or password'),
                                    ),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Login Failed: ${e.toString()}',
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    textColor: Colors.white,
                    color: Colors.deepPurpleAccent,
                    child: loginProvider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            'Log In',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Text(
                      "Or Login with",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: !isloaded
                        ? () async {
                            await signInWithGoogle();
                          }
                        : null,
                    child: !isloaded
                        ? Row(
                            children: [
                              Image.asset(
                                'assets/logo/logo_16509564.png',
                                width: MediaQuery.sizeOf(context).width * .15,
                              ),
                              Container(
                                color: Colors.grey,
                                width: 1,
                                height: 62,
                                margin: EdgeInsets.only(right: 20),
                              ),
                              Text(
                                'Login With Google',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        : CircularProgressIndicator(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                SignUp(replacetheme: widget.replacetheme),
                          ),
                          (route) => false,
                        );
                      },
                      textColor: Colors.deepPurpleAccent,

                      child: Text(
                        'Sign up',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
