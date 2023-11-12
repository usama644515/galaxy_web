import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import '../responsive.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  bool _isObscure = true;
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    print(_auth.currentUser?.email);
    // getphonenumber();
    super.initState();
  }

  var phone;
  getphonenumber() {
    FirebaseFirestore.instance
        .collection('AllUsers')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((value) {
      phone = value.get('phone');
      // employeeList = employeeList + ['usama'];
      // print('----------------${employeeList}---------------');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  //     ? MediaQuery.of(context).size.height * 0.6
                  //     : MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:  EdgeInsets.only(top:Responsive.isMobile(context)? MediaQuery.of(context).size.height*0.07: 0.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30.0,
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
                          height: 15.0,
                        ),
                        const Text(
                          "Sign Up Form",
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
                              'Name',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
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
                                    return "Enter Name";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  // email = value; //get the value entered by user.
                                },
                                controller: name,
                                autofocus: false,
                                style: const TextStyle(
                                    fontSize: 15.0, color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'Enter Name',
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
                              'Email',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
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
                                  filled: true,
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
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
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
                                    return "Enter Phone Number";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  // email = value; //get the value entered by user.
                                },
                                // obscureText: _isObscure,
                                controller: phonenumber,
                                autofocus: false,
                                style: const TextStyle(
                                    fontSize: 15.0, color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: '923.......',
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
                            const SizedBox(height: 10.0),
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
                                  register();
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
                                        'Sign Up',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
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
            ],
          ),
        ],
      ),
    );
  }

  Future register() async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    try {
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      await FirebaseFirestore.instance
          .collection("AllUsers")
          .doc(userCredential.user!.uid)
          .set({
        'Name': name.text,
        'Email': email.text,
        'UID': userCredential.user!.uid,
        'phone': phonenumber.text,
        'password': password.text,
        'img':
            'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1685014328~exp=1685014928~hmac=14d6f11cf538e43623c6eca39c016f64e2d2d871f324a80e169b6645b072fde6'
      }, SetOptions(merge: true));

      FirebaseAuth.instanceFor(app: app).currentUser!.updatePhotoURL(
          'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1685014328~exp=1685014928~hmac=14d6f11cf538e43623c6eca39c016f64e2d2d871f324a80e169b6645b072fde6');
      FirebaseAuth.instanceFor(app: app)
          .currentUser!
          .updateDisplayName(name.text)
          .then((value) => setState(() {
                loading = false;
                name.clear();
                email.clear();
                password.clear();
              }));
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
    }

    await app.delete().then((value) {
      Navigator.pop(context);
    });
  }
}
