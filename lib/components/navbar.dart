import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:galaxy_web/components/contactUs.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/dashboard/DashBoardSection/main/main_screen.dart';
import 'package:galaxy_web/main/dashboard.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:galaxy_web/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main/about_us.dart';
import '../main/shop.dart';
import '../welcome/signin.dart';
import '../welcome/signup.dart';
import 'add_product_store.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var homehover = false;
  var shophover = false;
  var bloghover = false;
  var abouthover = false;
  var contacthover = false;
  var agenthover = false;

  final router = FluroRouter();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void _launchPhone(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  var agent = false;

  getuserdata() {
    FirebaseFirestore.instance
        .collection('AllUsers')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        agent = value.get('agent');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70.0,
      // decoration: BoxDecoration(),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 6.0),
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/splash%20icon.png?alt=media&token=f1349db9-4cc0-4902-bb4b-636ab022e07d',
              fit: BoxFit.cover,
              width: 110,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('Home');
                    // Remove all routes and push a new route
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(builder: (context) => const Home()),
                    //   (route) =>
                    //       false, // Always return false to remove all routes
                    // );

                    // Replace with the actual value
                    // RouteHandler.router.navigateTo(context, '/');
                    context.go('/');
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      setState(() {
                        homehover = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        homehover = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Provider.of<menuController>(context,
                                          listen: false)
                                      .menue ==
                                  'Home'
                              ? const Color(0xffE8BB2A)
                              : Colors.transparent,
                          border: Border.all(
                            color: homehover
                                ? const Color(0xffE8BB2A)
                                : Colors.transparent,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15, top: 5, bottom: 5.0),
                        child: Text('HOME',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('Shop');
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => const Shop()));
                    // RouteHandler.router.navigateTo(context, '/shop');
                    // router.navigateTo(context, '/shop');
                    context.go('/shop');
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      setState(() {
                        shophover = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        shophover = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Provider.of<menuController>(context,
                                          listen: false)
                                      .menue ==
                                  'Shop'
                              ? const Color(0xffE8BB2A)
                              : Colors.transparent,
                          border: Border.all(
                            color: shophover
                                ? const Color(0xffE8BB2A)
                                : Colors.transparent,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15, top: 5, bottom: 5.0),
                        child: Text('SHOP',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('Agents');
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => const Shop()));
                    // RouteHandler.router.navigateTo(context, '/agents');
                    // router.navigateTo(context, '/shop');
                    context.go('/agents');
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      setState(() {
                        agenthover = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        agenthover = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Provider.of<menuController>(context,
                                          listen: false)
                                      .menue ==
                                  'Agents'
                              ? const Color(0xffE8BB2A)
                              : Colors.transparent,
                          border: Border.all(
                            color: agenthover
                                ? const Color(0xffE8BB2A)
                                : Colors.transparent,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15, top: 5, bottom: 5.0),
                        child: Text('AGENTS',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('Blog');
                    // RouteHandler.router.navigateTo(context, '/blog');
                    context.go('/blog');
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      setState(() {
                        bloghover = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        bloghover = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Provider.of<menuController>(context,
                                          listen: false)
                                      .menue ==
                                  'Blog'
                              ? const Color(0xffE8BB2A)
                              : Colors.transparent,
                          border: Border.all(
                            color: bloghover
                                ? const Color(0xffE8BB2A)
                                : Colors.transparent,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15, top: 5, bottom: 5.0),
                        child: Text('BLOG',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('About');
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(builder: (context) => const AboutUs()),
                    //   (route) =>
                    //       false, // Always return false to remove all routes
                    // );
                    // RouteHandler.router.navigateTo(context, '/about');
                    context.go('/about');
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      setState(() {
                        abouthover = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        abouthover = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Provider.of<menuController>(context,
                                          listen: false)
                                      .menue ==
                                  'About'
                              ? const Color(0xffE8BB2A)
                              : Colors.transparent,
                          border: Border.all(
                            color: abouthover
                                ? const Color(0xffE8BB2A)
                                : Colors.transparent,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15, top: 5, bottom: 5.0),
                        child: Text('ABOUT',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('Contact');
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(
                    //       builder: (context) => const ContactUs()),
                    //   (route) =>
                    //       false, // Always return false to remove all routes
                    // );
                    // RouteHandler.router.navigateTo(context, '/contactus');
                    context.go('/contactus');
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      setState(() {
                        contacthover = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        contacthover = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Provider.of<menuController>(context,
                                          listen: false)
                                      .menue ==
                                  'Contact'
                              ? const Color(0xffE8BB2A)
                              : Colors.transparent,
                          border: Border.all(
                            color: contacthover
                                ? const Color(0xffE8BB2A)
                                : Colors.transparent,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15, top: 5, bottom: 5.0),
                        child: Text('CONTACT',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10.0,
            child:
                // MouseRegion(
                //   cursor: SystemMouseCursors.click,
                //   child: Icon(
                //     Icons.account_circle,
                //     color: Colors.white,
                //     size: 35.0,
                //   ),
                // ),
                _auth.currentUser == null
                    ? Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _launchPhone('923000172599');
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                  height: 35,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffE8BB2A),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fphone%20icon%20white.png?alt=media&token=a7859ee1-775e-4184-bee3-784022426a16&_gl=1*xlwa8r*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODMwMTE3Ni41OS4xLjE2OTgzMDExOTQuNDIuMC4w',
                                        width: 17,
                                      ),
                                      const SizedBox(width: 6.0),
                                      const Text(
                                        '0300-0172599',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ))),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) {
                              setState(() {
                                loginbtn = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                loginbtn = false;
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const SignIn()));
                                context.go('/login');
                              },
                              child: Container(
                                  height: 35,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      // color: signupbtn
                                      //     ? const Color.fromARGB(255, 199, 24, 24)
                                      //     : const Color(0xffFD1A1A),
                                      border: Border.all(
                                          color: loginbtn
                                              ? const Color(0xffE8BB2A)
                                              : Colors.transparent),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    'Login',
                                    style: TextStyle(
                                        decoration: loginbtn
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ))),
                            ),
                          ),
                          const SizedBox(width: 6.0),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) {
                              setState(() {
                                signupbtn = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                signupbtn = false;
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const SignUp()));
                                context.go('/singup');
                              },
                              child: Container(
                                  height: 35,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: signupbtn
                                          ? const Color.fromARGB(
                                              255, 206, 139, 30)
                                          : const Color(0xffE8BB2A),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                      child: Text(
                                    'Signup',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ))),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _launchPhone('923000335875');
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                  height: 35,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffE8BB2A),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fphone%20icon%20white.png?alt=media&token=a7859ee1-775e-4184-bee3-784022426a16&_gl=1*xlwa8r*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODMwMTE3Ni41OS4xLjE2OTgzMDExOTQuNDIuMC4w',
                                        width: 17,
                                      ),
                                      const SizedBox(width: 6.0),
                                      const Text(
                                        '0300-0335875',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ))),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) {
                              setState(() {
                                signupbtn = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                signupbtn = false;
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                checkPhoneNumber();
                              },
                              child: Container(
                                  height: 35,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: signupbtn
                                          ? const Color.fromARGB(
                                              255, 206, 139, 30)
                                          : const Color(0xffE8BB2A),
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
                          const SizedBox(width: 10.0),
                          Stack(children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                height: 40,
                                width: 40,
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
                            PopupMenuButton<int>(
                              icon: const Icon(Icons.more_vert,
                                  color: Colors.transparent),
                              itemBuilder: (context) => [
                                // PopupMenuItem 1
                                PopupMenuItem(
                                  value: 1,
                                  // row with 2 children
                                  child: Row(
                                    children: [
                                      Image.network(
                                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fprofile%20icon.png?alt=media&token=e45345ca-dbde-4f0c-b58a-326f8f5a5365&_gl=1*j3egs6*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODkwNjA5My43Ny4xLjE2OTg5MDYzNDMuNjAuMC4w',
                                        width: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("DashBoard",
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),

                                if (agent == false)
                                  PopupMenuItem(
                                    value: 3,
                                    // row with 2 children
                                    child: Row(
                                      children: [
                                        Image.network(
                                          'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fagent%20icon.png?alt=media&token=63d01d55-0b6f-4ea9-8175-9e0c0b65cd27',
                                          width: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text("Become a Agent",
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                  ),
                                PopupMenuItem(
                                  value: 2,
                                  // row with 2 children
                                  child: Row(
                                    children: [
                                      Image.network(
                                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Flogout%20icon.png?alt=media&token=9705628c-695d-445a-a715-086ca56bf567&_gl=1*1s5s5tk*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODkwNjA5My43Ny4xLjE2OTg5MDYyNzMuNjAuMC4w',
                                        width: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("Log Out",
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                              offset: const Offset(0, 100),
                              color: Colors.white,
                              elevation: 2,
                              // on selected we show the dialog box
                              onSelected: (value) {
                                // if value 1 show dialog
                                if (value == 2) {
                                  _logoutDialoge(context);
                                  // if value 2 show dialog
                                } else if (value == 1) {
                                  Provider.of<menuController>(context,
                                          listen: false)
                                      .navmenueSelect('dashboard');
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => MainScreen()));
                                  // RouteHandler.router
                                  //     .navigateTo(context, '/dashboard');
                                  context.go('/dashboard');
                                } else if (value == 3) {
                                  context.go('/create-agent');
                                }
                              },
                            )
                          ]),
                        ],
                      ),
          ),
        ],
      ),
    );
  }

  var signupbtn = false;
  var loginbtn = false;
  _logoutDialoge(context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Are you sure you want to Logout?'),
            // content: const Text('Are you sure to Delete Message?'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Log Out'),
                onPressed: () async {
                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                  // prefs.setBool('isLoggedIn', false);
                  await GoogleSignIn().signOut();
                  await FirebaseAuth.instance.signOut().then((value) {
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(builder: (context) => const Home()),
                    //   (route) =>
                    //       false, // Always return false to remove all routes
                    // );
                    Navigator.pop(context);
                    context.go('/');
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

  // var userphone = '';
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
        .set(userdata, SetOptions(merge: true))
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
