import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:galaxy_web/components/search_screen.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:galaxy_web/main/profile.dart';
import 'package:galaxy_web/main/shop.dart';
import 'package:galaxy_web/welcome/signin.dart';

class Bar extends StatefulWidget {
  final int ind;
  // ignore: use_key_in_widget_constructors
  const Bar({required this.ind});

  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  int ind = 0;
  final List<bool> chk = [false, false, false, false];
  @override
  void initState() {
    super.initState();
    ind = widget.ind;
    chk[ind] = true;
  }

  final List<Widget> screens = [
    Home(),
    Shop(),
    SearchScreen(),
    FirebaseAuth.instance.currentUser == null ? SignIn() : ProfileScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Colors.white,
            ),
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
            height: MediaQuery.of(context).size.height * 0.08,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ind = 0;
                        chk[0] = true;
                        // chk[5] = false;
                        // chk[4] = false;
                        chk[1] = false;
                        chk[2] = false;
                        chk[3] = false;
                      });
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/images/home.svg',
                            height: chk[0]
                                ? MediaQuery.of(context).size.height * 0.035
                                : MediaQuery.of(context).size.height * 0.03,
                            color: chk[0] ? Color(0xffE5B920) : Colors.grey),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "Home",
                          style: chk[0]
                              ? TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  fontSize: 14,
                                  color:
                                      chk[0] ? Color(0xffE5B920) : Colors.grey)
                              : TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 1,
                                  color:
                                      chk[0] ? Color(0xffE5B920) : Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ind = 1;
                        chk[1] = true;
                        // chk[5] = false;
                        // chk[4] = false;
                        chk[0] = false;
                        chk[2] = false;
                        chk[3] = false;
                      });
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/images/shop.svg',
                            height: chk[1]
                                ? MediaQuery.of(context).size.height * 0.035
                                : MediaQuery.of(context).size.height * 0.03,
                            color: chk[1] ? Color(0xffE5B920) : Colors.grey),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "Shop",
                          style: chk[1]
                              ? TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  fontSize: 14,
                                  color:
                                      chk[1] ? Color(0xffE5B920) : Colors.grey)
                              : TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 1,
                                  color:
                                      chk[1] ? Color(0xffE5B920) : Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ind = 2;
                        chk[2] = true;
                        // chk[5] = false;
                        // chk[4] = false;
                        chk[1] = false;
                        chk[0] = false;
                        chk[3] = false;
                      });
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/images/search.svg',
                            height: chk[2]
                                ? MediaQuery.of(context).size.height * 0.035
                                : MediaQuery.of(context).size.height * 0.03,
                            color: chk[2] ? Color(0xffE5B920) : Colors.grey),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "Search",
                          style: chk[2]
                              ? TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  fontSize: 14,
                                  color:
                                      chk[2] ? Color(0xffE5B920) : Colors.grey)
                              : TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 1,
                                  color:
                                      chk[2] ? Color(0xffE5B920) : Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        ind = 3;
                        chk[3] = true;
                        // chk[5] = false;
                        // chk[4] = false;
                        chk[1] = false;
                        chk[2] = false;
                        chk[0] = false;
                      });
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/images/profile.svg',
                            height: chk[3]
                                ? MediaQuery.of(context).size.height * 0.035
                                : MediaQuery.of(context).size.height * 0.03,
                            color: chk[3] ? Color(0xffE5B920) : Colors.grey),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          "Profile",
                          style: chk[3]
                              ? TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  fontSize: 14,
                                  color:
                                      chk[3] ? Color(0xffE5B920) : Colors.grey)
                              : TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 1,
                                  color:
                                      chk[3] ? Color(0xffE5B920) : Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       ind = 4;
                  //       chk[4] = true;
                  //       chk[5] = false;
                  //       chk[3] = false;
                  //       chk[1] = false;
                  //       chk[2] = false;
                  //       chk[0] = false;
                  //     });
                  //   },
                  //   child: Column(
                  //     children: [
                  //       Image.asset(
                  //         "assets/images/Walk.png",
                  //         height: chk[4]
                  //             ? MediaQuery.of(context).size.height * 0.04
                  //             : MediaQuery.of(context).size.height * 0.035,
                  //       ),
                  //       AutoSizeText(
                  //         "Steps",
                  //         style: chk[4]
                  //             ? const TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 14,
                  //                 letterSpacing: 1,
                  //               )
                  //             : const TextStyle(
                  //                 fontSize: 14,
                  //                 letterSpacing: 1,
                  //               ),
                  //         minFontSize: 12,
                  //         maxLines: 2,
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       ind = 5;
                  //       chk[5] = true;
                  //       chk[4] = false;
                  //       chk[3] = false;
                  //       chk[1] = false;
                  //       chk[2] = false;
                  //       chk[0] = false;
                  //     });
                  //   },
                  //   child: Column(
                  //     children: [
                  //       Image.asset(
                  //         "assets/images/Quran.png",
                  //         height: chk[5]
                  //             ? MediaQuery.of(context).size.height * 0.04
                  //             : MediaQuery.of(context).size.height * 0.035,
                  //       ),
                  //       AutoSizeText(
                  //         "Quran",
                  //         style: chk[5]
                  //             ? const TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 14,
                  //                 letterSpacing: 1,
                  //               )
                  //             : const TextStyle(
                  //                 fontSize: 14,
                  //                 letterSpacing: 1,
                  //               ),
                  //         minFontSize: 12,
                  //         maxLines: 2,
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        body: PageStorage(
          child: screens[ind],
          bucket: bucket,
        ),
      ),
    );
  }
}
