import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:galaxy_web/welcome/signup.dart';
import '../main/home.dart';
import '../responsive.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _isObscure = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: formGlobalKey,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.height * 0.7
                  : MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Galaxy Realtors & Builders",
                      style: TextStyle(
                          color: const Color(0xffF9A51F),
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.isMobile(context) ? 29 : 40.0),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      "Login Form",
                      style: TextStyle(
                          color: Color(0xffF9A51F),
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                    const SizedBox(height: 25.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        SizedBox(
                          width: Responsive.isMobile(context)
                              ? MediaQuery.of(context).size.width * 0.9
                              : MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            validator: (value) {
                              if (value == "") {
                                return "Enter Email";
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              // email = value; //get the value entered by user.
                            },
                            controller: email,
                            autofocus: false,
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey,
                              hintText: 'Enter Email',
                              hintStyle: const TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 15.0, top: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffF7F8FA)),
                                borderRadius: BorderRadius.circular(10.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffF7F8FA)),
                                borderRadius: BorderRadius.circular(10.7),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        SizedBox(
                          width: Responsive.isMobile(context)
                              ? MediaQuery.of(context).size.width * 0.9
                              : MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            onFieldSubmitted: (value) {
                              if (formGlobalKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                  login();
                                  // sending = true;
                                  // saveFaq();
                                });
                              }
                            },
                            validator: (value) {
                              if (value == "") {
                                return "Enter Password";
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              // email = value; //get the value entered by user.
                            },
                            obscureText: _isObscure,
                            controller: password,
                            autofocus: false,
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  color: Colors.grey[400],
                                  icon: Icon(_isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                              filled: true,
                              fillColor: Colors.grey,
                              hintText: 'Enter Pssword',
                              hintStyle: const TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 15.0, top: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffF7F8FA)),
                                borderRadius: BorderRadius.circular(10.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffF7F8FA)),
                                borderRadius: BorderRadius.circular(10.7),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: InkWell(
                        onTap: () {
                          if (formGlobalKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                              login();
                              // sending = true;
                              // saveFaq();
                            });
                          }
                        },
                        child: Container(
                          height: 50.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            color: const Color(0xffF9A51F),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Create Account: ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    )),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text('Sign Up: ',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xffF9A51F),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // bool? result1;
  // String? type;
  // Future<bool?> checkUser() async {
  //   await FirebaseFirestore.instance
  //       .collection("AllUsers")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((value) {
  //     if (value.get('role') == 'Admin' || value.get('role') == 'Sale') {
  //       setState(() {
  //         Provider.of<menuController>(context, listen: false)
  //             .Role(value.get('role'));
  //         result1 = true;
  //       });
  //       if (value.get('role') == 'Sale') {
  //         Provider.of<menuController>(context, listen: false)
  //             .SelectedMenue('Leads');
  //       }
  //     } else {
  //       setState(() {
  //         type = value.get("role");
  //         result1 = false;
  //       });
  //     }
  //   });
  //   return result1;
  // }

  bool loading = false;
  void login() async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
              email: email.text, password: password.text))
          .user;
      // checkUser().then((value) async {
      if (user != null) {
        email.clear();
        password.clear();

        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setBool('isLoggedIn', true);
        //---show message----
        Fluttertoast.showToast(
            msg: 'Successfully Login',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);

        setState(() {
          loading = false;
        });
        //-----go to next screen-----
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        FirebaseAuth.instance.signOut().then((value) {
          setState(() {
            loading = false;
          });
          dialogeBox(context);
        });
      }
      // });
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
        // Navigator.pop(context);
      });
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No User Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        print(e.code);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Wrong Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        print('Wrong password provided for that user.');
      } else {
        Fluttertoast.showToast(
            msg: "Error occurred while logging in",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  Future<dynamic> dialogeBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: SizedBox(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text("This Account is already registered on $type App"),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SizedBox(
                        width: 320.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF56B7E6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            FirebaseAuth.instance.signOut();
                          },
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
