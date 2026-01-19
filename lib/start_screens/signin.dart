import 'package:ecommerce_app/Providers/signup_provider.dart';
// import 'package:ecommerce_app/home_screens/home.dart';
import 'package:ecommerce_app/start_screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key, required this.replacetheme});
  final VoidCallback replacetheme;
  final TextEditingController emaileditingcont = TextEditingController();
  final TextEditingController passwordeditingcont = TextEditingController();
  final TextEditingController nameeditingcont = TextEditingController();
  final GlobalKey<FormState> globleformkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    bool isdark = Theme.of(context).brightness == Brightness.dark;
    final signupprovider = Provider.of<SignupProvider>(context);
    return Scaffold(
      body: ListView(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Container(
              // color: const Color.fromARGB(172, 255, 145, 182),
              color: const Color.fromARGB(179, 132, 216, 255),
              height: 300,
              padding: EdgeInsets.only(right: 90),
              child: Image.asset(
                'assets/images/signUp_dark.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'Let\'s get started!',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Please enter your valid data in order to create an account.',
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
                    controller: nameeditingcont,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      } else if (value.length < 4) {
                        return 'Name must be 4 character or more';
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
                      prefixIcon: Icon(Icons.person_outlined),
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIconColor: Colors.grey.shade600,
                      hintText: 'Name',
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
                    controller: emaileditingcont,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
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
                        return 'Required';
                      } else if (value.length < 6) {
                        return 'Password must more than 6 characters';
                      } else {
                        return null;
                      }
                    },
                    obscureText: signupprovider.passwordVisible,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          signupprovider.togglePasswordVisibility();
                        },
                        icon: signupprovider.passwordVisible
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
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    activeColor: Colors.deepPurpleAccent,
                    value: signupprovider.privacy,
                    onChanged: (value) {
                      signupprovider.togglePrivacy();
                    },
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'I agree with the Terms of service & privacy policy.',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              child: MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 140, vertical: 20),
                onPressed: (signupprovider.privacy && !signupprovider.isLoading)
                    ? () async {
                        if (globleformkey.currentState!.validate()) {
                          try {
                            final result = await signupprovider.signUp(
                              emaileditingcont.text.trim(),
                              passwordeditingcont.text.trim(),
                              nameeditingcont.text.trim(),
                            );
                            if (result != null) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Login(
                                    replacetheme: replacetheme,
                                    // emailkey: emaileditingcont.text.trim(),
                                  ),
                                ),
                                (route) => false,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Sign Up Successfully, You must verify your account via the link sent in the spam messages.',
                                  ),
                                ),
                              );
                              FirebaseAuth.instance.currentUser
                                  ?.sendEmailVerification();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "This account is already registered",
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Sign Up Failed: ${e.toString()}',
                                ),
                              ),
                            );
                          }
                        }
                      }
                    : null,
                disabledColor: const Color.fromARGB(96, 124, 77, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textColor: Colors.white,
                color: Colors.deepPurpleAccent,
                child: signupprovider.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Continue',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Do you have an account?',
                style: TextStyle(color: Colors.grey),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Login(replacetheme: replacetheme),
                    ),
                    (route) => false,
                  );
                },
                textColor: Colors.deepPurpleAccent,

                child: Text(
                  'Log in',
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
