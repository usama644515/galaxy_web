import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/welcome/signup.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../main/home.dart';
import '../responsive.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

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

  Future<bool> onBackPress() async {
    setState(() {
      if (kIsWeb) {
        Navigator.pop(context);
      } else {
        Provider.of<menuController>(context, listen: false)
            .navmenueSelect('Home');
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(
        //     builder: (context) => Bar(ind: 0),
        //   ),
        //   (route) => false, // Always return false to remove all routes
        // );
        context.go('/');
      }
    });
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: formGlobalKey,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // height: Responsive.isMobile(context)
                    //     ? MediaQuery.of(context).size.height * 0.7
                    //     : MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Galaxy Realtors & Builders",
                            style: TextStyle(
                                color: const Color(0xffF9A51F),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    Responsive.isMobile(context) ? 29 : 40.0),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          const Text(
                            "Login Form",
                            style: TextStyle(
                                color: Colors.black,
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
                              Container(
                                width: Responsive.isMobile(context)
                                    ? MediaQuery.of(context).size.width * 0.9
                                    : MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color(0xffF9A51F), // Border color
                                    width: 2.0, // Border width
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0), // Border radius
                                  ),
                                ),
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
                                      fontSize: 15.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    // fillColor: Colors.grey,
                                    hintText: 'Enter Email',
                                    hintStyle: const TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 15.0, top: 15.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffF7F8FA)),
                                      borderRadius: BorderRadius.circular(10.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffF7F8FA)),
                                      borderRadius: BorderRadius.circular(10.7),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
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
                              Container(
                                width: Responsive.isMobile(context)
                                    ? MediaQuery.of(context).size.width * 0.9
                                    : MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color(0xffF9A51F), // Border color
                                    width: 2.0, // Border width
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0), // Border radius
                                  ),
                                ),
                                child: TextFormField(
                                  onFieldSubmitted: (value) {
                                    if (formGlobalKey.currentState!
                                        .validate()) {
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
                                      fontSize: 15.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
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
                                    hintText: 'Enter Pssword',
                                    hintStyle: const TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 15.0, top: 15.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffF7F8FA)),
                                      borderRadius: BorderRadius.circular(10.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffF7F8FA)),
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
                const SizedBox(height: 40.0),
                const Text(
                  'Login With',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      print('click................');
                      await googlewebsignin();
                    } catch (e) {
                      if (e is FirebaseAuthException) {
                        showMessage(e.message!);
                      }
                    }
                    setState(() {
                      loading = false;
                    });

                    // signinWithGoogle();
                    // Fluttertoast.showToast(
                    //     msg: 'Coming Soon',
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.BOTTOM,
                    //     timeInSecForIosWeb: 1,
                    //     backgroundColor: Colors.blue,
                    //     textColor: Colors.white,
                    //     fontSize: 16.0);
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fgoogle%20icon.png?alt=media&token=553e04c1-3503-433a-925c-33c39177dd73&_gl=1*g7j1nb*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODMxNjY5My42MS4xLjE2OTgzMTY3MzkuMTQuMC4w',
                      width: 35,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SignUp()));
                    context.go('/singup');
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
          ],
        ),
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
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => kIsWeb ? Home() : Bar(ind: 0),
        //     ));
        context.go('/');
      } else {
        await GoogleSignIn().signOut();
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
                            GoogleSignIn().signOut();
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

  final GoogleSignIn googleSignIn = GoogleSignIn();

  // String? name;
  // String? imageUrl;
  // Future<User?> signInWithGoogle() async {
  //   // Initialize Firebase
  //   await Firebase.initializeApp();

  //   User? user;

  //   // The `GoogleAuthProvider` can only be used while running on the web
  //   GoogleAuthProvider authProvider = GoogleAuthProvider();

  //   try {
  //     final UserCredential userCredential =
  //         await _auth.signInWithPopup(authProvider);

  //     user = userCredential.user;
  //   } catch (e) {
  //     print('-----------------error');
  //     print(e);
  //   }

  //   if (user != null) {
  //     // uid = user.uid;
  //     name = user.displayName;
  //     // userEmail = user.email;
  //     imageUrl = user.photoURL;

  //     // SharedPreferences prefs = await SharedPreferences.getInstance();
  //     // prefs.setBool('auth', true);
  //   }

  //   return user;
  // }

  // google login

  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final userRef = FirebaseFirestore.instance.collection('AllUsers');

  // Future<String?> signInwithGoogle() async {
  //   try {
  //     print('enter...........');
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     await _auth.signInWithCredential(credential);
  //     checkUserData(_auth.currentUser!.uid);
  //   } on FirebaseAuthException catch (e) {
  //     if (kDebugMode) {
  //       print(e.message);
  //     }
  //     rethrow;
  //   }
  //   return null;
  // }

  Future<void> saveUserData(name, email, uid, photoUrl, phone) async {
    Map<String, dynamic> userdata = {
      'Name': name,
      'Email': email,
      'UID': uid,
      'role': 'user',
      'img':
          'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1685014328~exp=1685014928~hmac=14d6f11cf538e43623c6eca39c016f64e2d2d871f324a80e169b6645b072fde6',
      'phone': phone
    };
    firestore
        .collection('AllUsers')
        .doc(_auth.currentUser!.uid)
        .set(userdata)
        .then((value) {
      setState(() {
        loading = false;
      });
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => const Home(),
      //   ),
      //   (route) => false,
      // );
      context.go('/');
    });
  }

  Future<void> checkUserData(id) async {
    DocumentSnapshot userRecord = await userRef.doc(id).get();
    if (!userRecord.exists) {
      _showPhoneNumberDialog(context);
    } else {
      Fluttertoast.showToast(
          msg: "Welcome Back ${_auth.currentUser?.displayName}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(0xffFB7959),
          textColor: Colors.white,
          fontSize: 16.0);
      // ignore: use_build_context_synchronously
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => const Home(),
      //   ),
      //   (route) => false,
      // );
      context.go('/');
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => const AccessLocaion()));
    }
    return;
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<UserCredential> signinWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  googlewebsignin() {
    signinWithGoogle().then((value) {
      checkUserData(_auth.currentUser!.uid);
    });
  }

  TextEditingController _phoneNumberController = TextEditingController();
  void _showPhoneNumberDialog(BuildContext context) async {
    String phoneNumber = await showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: Text("Enter Your Phone Number"),
        content: TextField(
          controller: _phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(labelText: "Phone Number"),
        ),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("Later"),
            onPressed: () {
              saveUserData(
                  _auth.currentUser!.displayName,
                  _auth.currentUser!.email,
                  _auth.currentUser!.uid,
                  _auth.currentUser!.photoURL,
                  _phoneNumberController.text);
              Navigator.pop(context);
            },
          ),
          BasicDialogAction(
            title: Text("Submit"),
            onPressed: () {
              if (_phoneNumberController.text == '') {
                Fluttertoast.showToast(
                    msg: "Please Enter Your Phone Number",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: const Color(0xffFB7959),
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                saveUserData(
                    _auth.currentUser!.displayName,
                    _auth.currentUser!.email,
                    _auth.currentUser!.uid,
                    _auth.currentUser!.photoURL,
                    _phoneNumberController.text);

                String enteredPhoneNumber = _phoneNumberController.text;

                // Do something with the phone number (validate, store, etc.)
                // print("Entered Phone Number: $enteredPhoneNumber");

                // Close the dialog
                Navigator.pop(context, enteredPhoneNumber);
              }
            },
          ),
        ],
      ),
    );

    // Handle the phone number obtained from the dialog
    if (phoneNumber != null) {
      // Do something with the phone number
      print("Phone Number obtained: $phoneNumber");
    }
  }
}
