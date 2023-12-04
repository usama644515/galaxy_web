import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:galaxy_web/components/add_product_store.dart';
import 'package:galaxy_web/components/contactUs.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/dashboard/DashBoardSection/main/main_screen.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/main/dashboard.dart';
import 'package:galaxy_web/router/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../main/about_us.dart';
import '../main/home.dart';
import '../main/shop.dart';
import '../welcome/signin.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff222222),
      child: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _auth.currentUser == null
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()));
                        },
                        child: Container(
                          width: 115,
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: const Center(
                            child: Text('LOGIN',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _logoutDialoge(context);
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${_auth.currentUser?.photoURL}'), // Replace with your image path
                                    fit: BoxFit
                                        .cover, // You can adjust the fit as needed
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                checkPhoneNumber();
                              },
                              child: Container(
                                  height: 35,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF9A51F),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                      child: Text(
                                    'Create Listing',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ))),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          _auth.currentUser == null
              ? const SizedBox()
              : ListTile(
                  title: Text(
                    'DashBoard',
                    style: TextStyle(
                        color:
                            Provider.of<menuController>(context, listen: false)
                                        .menue ==
                                    'dashboard'
                                ? Colors.white
                                : const Color(0xff8c8c8c),
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    setState(() {
                      Provider.of<menuController>(context, listen: false)
                          .navmenueSelect('dashboard');
                          RouteHandler.router
                                      .navigateTo(context, '/dashboard');
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => MainScreen()));
                    });
                  },
                ),
          _auth.currentUser == null
              ? const SizedBox()
              : const Divider(
                  color: Color(0xff8c8c8c),
                  thickness: 0.1,
                ),
          ListTile(
            title: Text(
              'HOME',
              style: TextStyle(
                  color: Provider.of<menuController>(context, listen: false)
                              .menue ==
                          'Home'
                      ? Colors.white
                      : const Color(0xff8c8c8c),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                Provider.of<menuController>(context, listen: false)
                    .navmenueSelect('Home');
                // Remove all routes and push a new route
                kIsWeb
                    ? RouteHandler.router.navigateTo(context, '/')
                    : Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => kIsWeb ? Home() : Bar(ind: 0),
                        ),
                        (route) =>
                            false, // Always return false to remove all routes
                      );
              });
            },
          ),
          const Divider(
            color: Color(0xff8c8c8c),
            thickness: 0.1,
          ),
          ListTile(
            title: Text(
              'SHOP',
              style: TextStyle(
                  color: Provider.of<menuController>(context, listen: false)
                              .menue ==
                          'Shop'
                      ? Colors.white
                      : const Color(0xff8c8c8c),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                Provider.of<menuController>(context, listen: false)
                    .navmenueSelect('Shop');
                kIsWeb
                    ? RouteHandler.router.navigateTo(context, '/shop')
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => kIsWeb ? Shop() : Bar(ind: 1),
                        ));
              });
            },
          ),
          const Divider(
            color: Color(0xff8c8c8c),
            thickness: 0.1,
          ),
          ListTile(
            title: Text(
              'AGENTS',
              style: TextStyle(
                  color: Provider.of<menuController>(context, listen: false)
                              .menue ==
                          'Agents'
                      ? Colors.white
                      : const Color(0xff8c8c8c),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                Provider.of<menuController>(context, listen: false)
                    .navmenueSelect('Agents');
                kIsWeb
                    ? RouteHandler.router.navigateTo(context, '/agents')
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => kIsWeb ? Shop() : Bar(ind: 1),
                        ));
              });
            },
          ),
          const Divider(
            color: Color(0xff8c8c8c),
            thickness: 0.1,
          ),
          ListTile(
            title: Text(
              'BLOG',
              style: TextStyle(
                  color: Provider.of<menuController>(context, listen: false)
                              .menue ==
                          'Blog'
                      ? Colors.white
                      : const Color(0xff8c8c8c),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                Provider.of<menuController>(context, listen: false)
                    .navmenueSelect('Blog');
                RouteHandler.router.navigateTo(context, '/blog');
              });
            },
          ),
          const Divider(
            color: Color(0xff8c8c8c),
            thickness: 0.1,
          ),
          ListTile(
            title: Text(
              'ABOUT',
              style: TextStyle(
                  color: Provider.of<menuController>(context, listen: false)
                              .menue ==
                          'About'
                      ? Colors.white
                      : const Color(0xff8c8c8c),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                Provider.of<menuController>(context, listen: false)
                    .navmenueSelect('About');
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(builder: (context) => const AboutUs()),
                //   (route) => false, // Always return false to remove all routes
                // );
                RouteHandler.router.navigateTo(context, '/about');
              });
            },
          ),
          const Divider(
            color: Color(0xff8c8c8c),
            thickness: 0.1,
          ),
          ListTile(
            title: Text(
              'CONTACT',
              style: TextStyle(
                  color: Provider.of<menuController>(context, listen: false)
                              .menue ==
                          'Contact'
                      ? Colors.white
                      : const Color(0xff8c8c8c),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                Provider.of<menuController>(context, listen: false)
                    .navmenueSelect('Contact');
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(builder: (context) => const ContactUs()),
                //   (route) => false, // Always return false to remove all routes
                // );
                RouteHandler.router.navigateTo(context, '/contactus');
              });
            },
          ),
        ],
      ),
    );
  }

  _logoutDialoge(context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Are you sure you want to Logout?'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Log Out'),
                onPressed: () async {
                  await GoogleSignIn().signOut();
                  await _auth.signOut().then((value) {
                    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('Home');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Home(),
                      ),
                      (route) => false,
                    );
                  });
                },
              ),
              CupertinoDialogAction(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  checkPhoneNumber() {
    FirebaseFirestore.instance
        .collection('AllUsers')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        if (value.get('phone') == '') {
          // print(value.get('phone'));
          _showPhoneNumberDialog(context);
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddProductStore()));
        }
      });
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
                saveUserData(_phoneNumberController.text);

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

  Future<void> saveUserData(phone) async {
    Map<String, dynamic> userdata = {
      // 'Name': name,
      // 'Email': email,
      // 'UID': uid,
      // 'img':
      //     'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1685014328~exp=1685014928~hmac=14d6f11cf538e43623c6eca39c016f64e2d2d871f324a80e169b6645b072fde6',
      'phone': phone
    };
    FirebaseFirestore.instance
        .collection('AllUsers')
        .doc(_auth.currentUser!.uid)
        .set(userdata,SetOptions(merge: true))
        .then((value) {
      setState(() {
        // loading = false;
      });
      Fluttertoast.showToast(
          msg: "Phone Number Saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(0xffFB7959),
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AddProductStore()));
    });
  }
}
