import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_web/components/add_product_store.dart';
import 'package:galaxy_web/dashboard/constants.dart';
import 'package:galaxy_web/dashboard/DashBoardSection/dashboard/dashboard_screen.dart';
import 'package:galaxy_web/responsive.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            top: 15, bottom: 15.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 0.0),
                              child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/galaxy%20logo%20w-011.png?alt=media&token=c99628aa-543a-4440-b4a9-209cdfece996',
                                fit: BoxFit.cover,
                                width: 170,
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
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AddProductStore()));
                                          },
                                          child: Container(
                                              height: 35,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffF9A51F),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
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
                                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png",
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
                                              const PopupMenuItem(
                                                value: 1,
                                                // row with 2 children
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.account_circle,
                                                        color: Colors.red),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Create Account",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              const PopupMenuItem(
                                                value: 2,
                                                // row with 2 children
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.logout,
                                                        color: Colors.red),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Log Out",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                            offset: Offset(0, 100),
                                            color: Colors.white,
                                            elevation: 2,
                                            // on selected we show the dialog box
                                            onSelected: (value) {
                                              // if value 1 show dialog
                                              // if (value == 2) {
                                              //   _logoutDialoge(context);
                                              //   // if value 2 show dialog
                                              // }else if (value == 1) {
                                              //       Navigator.push(
                                              //           context,
                                              //           MaterialPageRoute(
                                              //               builder: (context) =>
                                              //                   SignUp()));
                                              //     }
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
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const AddProductStore()));
                                              },
                                              child: Container(
                                                  height: 35,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffF9A51F),
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
                                                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png",
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
                                                icon: Icon(Icons.more_vert,
                                                    color: Colors.transparent),
                                                itemBuilder: (context) => [
                                                  // PopupMenuItem 1
                                                  PopupMenuItem(
                                                    value: 1,
                                                    // row with 2 children
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .account_circle,
                                                            color: Colors.red),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("Create Account",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 2,
                                                    // row with 2 children
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.logout,
                                                            color: Colors.red),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("Log Out",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                                offset: Offset(0, 100),
                                                color: Colors.white,
                                                elevation: 2,
                                                // on selected we show the dialog box
                                                onSelected: (value) {
                                                  // if value 1 show dialog
                                                  if (value == 2) {
                                                    _logoutDialoge(context);
                                                    // if value 2 show dialog
                                                  } else if (value == 1) {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             SignUp()));
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
                    DashboardScreen(),
                  ],
                ),
              ),
            ),
          ],
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
                await FirebaseAuth.instance.signOut().then((value) {});
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
                              color: Color(0xff00ACFF),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Seller Support',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 5.0),
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
                      SizedBox(height: 20.0),
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
                              color: Color(0xff00ACFF),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'User Support',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 5.0),
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
