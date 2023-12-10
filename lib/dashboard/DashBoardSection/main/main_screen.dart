import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:galaxy_web/components/add_product_store.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/dashboard/constants.dart';
import 'package:galaxy_web/dashboard/DashBoardSection/dashboard/dashboard_screen.dart';
import 'package:galaxy_web/dashboard/itemList.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:galaxy_web/main/profile.dart';
import 'package:galaxy_web/responsive.dart';
import 'package:galaxy_web/router/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> onBackPress() async {
    setState(() {
      Provider.of<menuController>(context, listen: false)
          .navmenueSelect('Home');
    });
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => kIsWeb ? Home() : Bar(ind: 0),
      ),
      (route) => false, // Always return false to remove all routes
    );
    return Future.value(false);
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        // key: context.read<MenuController>().scaffoldKey,

        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              // if (Responsive.isDesktop(context))
              //   Expanded(
              //     // default flex = 1
              //     // and it takes 1/6 part of the screen
              //     child: SideMenu(),
              //   ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: Container(
                  color: bgColor,
                  child: ListView(
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        Responsive.isMobile(context) ? 0 : 15.0,
                                    top: 0.0),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      RouteHandler.router
                                          .navigateTo(context, '/');
                                      Provider.of<menuController>(context,
                                              listen: false)
                                          .navmenueSelect('Home');
                                    },
                                    child: Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/logo%2Fgalaxy%20logo.png?alt=media&token=e3e98a29-aedf-4e0e-9a42-843f9ef885df',
                                      fit: BoxFit.cover,
                                      width: Responsive.isMobile(context)
                                          ? 170
                                          : 230,
                                    ),
                                  ),
                                ),
                              ),
                              Responsive.isDesktop(context)
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
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
                                                    color:
                                                        const Color(0xffF9A51F),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: const Center(
                                                    child: Text(
                                                  'Create Listing',
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))),
                                          ),
                                        ),
                                        const SizedBox(width: defaultPadding),
                                        Stack(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  '${_auth.currentUser?.photoURL}',
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  // borderRadius: BorderRadius.circular(50),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
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
                                                      const Text("Profile",
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
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProfileScreen()));
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
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
                                                        color: const Color(
                                                            0xffF9A51F),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: const Center(
                                                        child: Text(
                                                      'Create Listing',
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ))),
                                              ),
                                            ),
                                            const SizedBox(
                                                width: defaultPadding),
                                            Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl:
                                                      '${_auth.currentUser?.photoURL}',
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      // borderRadius: BorderRadius.circular(50),
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                                PopupMenuButton<int>(
                                                  icon: const Icon(
                                                      Icons.more_vert,
                                                      color:
                                                          Colors.transparent),
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
                                                          const Text('Profile',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
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
                                                                color: Colors
                                                                    .black,
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
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ProfileScreen()));
                                                    }
                                                  },
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Products(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut().then((value) {
                  // RouteHandler.router.navigateTo(context, '/');
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

Future<dynamic> supportDialog(
  BuildContext context,
) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // backgroundColor: Colors.transparent,
          backgroundColor: bgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.height * 0.3
                    : MediaQuery.of(context).size.height * 0.5,
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width * 0.3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 200,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: const Color(0xff00ACFF),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Seller Support',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                const SizedBox(width: 5.0),
                                StreamBuilder<QuerySnapshot>(
                                    stream: firestore
                                        .collection('ContactSupport')
                                        .where('status', isEqualTo: 'Open')
                                        .where('userType', isEqualTo: 'Seller')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else {
                                        // print(snapshot.data!.data());
                                        // Map<String, dynamic> data =
                                        // snapshot.data!.data() as Map<String, dynamic>;

                                        try {
                                          return snapshot.data!.docs.length > 0
                                              ? Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        snapshot.data!.docs
                                                                    .length ==
                                                                1
                                                            ? 7.0
                                                            : 5.0),
                                                    child: Text(
                                                      snapshot.data!.docs.length
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                        } catch (e) {
                                          return Container();
                                        }
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 200,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: const Color(0xff00ACFF),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'User Support',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                const SizedBox(width: 5.0),
                                StreamBuilder<QuerySnapshot>(
                                    stream: firestore
                                        .collection('ContactSupport')
                                        .where('status', isEqualTo: 'Open')
                                        .where('userType', isEqualTo: 'User')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else {
                                        // print(snapshot.data!.data());
                                        // Map<String, dynamic> data =
                                        // snapshot.data!.data() as Map<String, dynamic>;

                                        try {
                                          return snapshot.data!.docs.length > 0
                                              ? Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        snapshot.data!.docs
                                                                    .length ==
                                                                1
                                                            ? 7.0
                                                            : 5.0),
                                                    child: Text(
                                                      snapshot.data!.docs.length
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                        } catch (e) {
                                          return Container();
                                        }
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 10.0,
                top: 10.0,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20.0,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
