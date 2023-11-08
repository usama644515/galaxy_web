// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:galaxy_web/main/profile_edit.dart';
import 'package:galaxy_web/responsive.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, this.uid, this.fromprofile});
  final uid;
  final fromprofile;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  PageController controller = PageController();

  var username = "username";
  var bio = "bio";
  var country = "country";
  var city = "city";
  var type;
  var phone = "phone number";
  var address = "address";
  var email = "email";
  var userpic =
      "https://www.kindpng.com/picc/m/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png";

  getuserData() {
    FirebaseFirestore.instance
        .collection('AllUsers')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        userpic = value.get("img");
        username = value.get('Name');
        // country = value.get('country');
        // city = value.get('city');
        // address = value.get('address');
        phone = value.get('phone');
        email = value.get("Email");
      });
    });
  }

  _onpop() {
    // if (widget.fromprofile == true) {
    //   Navigator.pop(context);
    // } else {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: ((context) => home())));
    // }
  }

  @override
  void initState() {
    super.initState();
    getuserData();
    // _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: const Color(0xffF9A51F),
          decoration: const BoxDecoration(
            gradient: SweepGradient(
              colors: [
                Colors.black,
                Color(0xffF9A51F),
              ],
              center: Alignment.center,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Color(0xffFAFAFA),
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: Responsive.isMobile(context)
                                ? 20.0
                                : MediaQuery.of(context).size.width * 0.3,
                            right: Responsive.isMobile(context)
                                ? 20.0
                                : MediaQuery.of(context).size.width * 0.3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 70.0,
                            ),
                            Text(username,
                                style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                            // const SizedBox(
                            //   height: 5.0,
                            // ),
                            // Text(bio,
                            //     textAlign: TextAlign.center,
                            //     style: const TextStyle(
                            //         fontSize: 15.0,
                            //         fontWeight: FontWeight.w500,
                            //         color: Colors.black54)),
                            const SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () async {
                                final Uri params = Uri(
                                  scheme: 'mailto',
                                  path: email,
                                );
                                String url = params.toString();
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  print('Could not launch $url');
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 15.0,
                                      bottom: 15.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Femail%20black.png?alt=media&token=3ca11570-cf81-4dbc-a088-f333acac9633&_gl=1*3d1cy0*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODkwNjA5My43Ny4xLjE2OTg5MDczNDAuNjAuMC4w',
                                              width: 30,
                                            ),
                                            SizedBox(
                                                width:
                                                    Responsive.isMobile(context)
                                                        ? 15.0
                                                        : 40),
                                            SizedBox(
                                              // width: MediaQuery.of(context)
                                              //         .size
                                              //         .width *
                                              //     0.65,
                                              child: Text(email,
                                                  style: const TextStyle(
                                                      fontSize: 17.0,
                                                      color: Color(0xff494949),
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            GestureDetector(
                              onTap: () async {
                                // final Uri _phoneUri =
                                //     Uri(scheme: "tel", path: phone);
                                // try {
                                //   if (await canLaunch(_phoneUri.toString()))
                                //     await launch(_phoneUri.toString());
                                // } catch (error) {
                                //   throw ("Cannot dial");
                                // }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 15.0,
                                      bottom: 15.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fphone%20black.png?alt=media&token=bd12f419-474d-474b-95b7-7dd18d483cb6&_gl=1*1wremju*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODkwNjA5My43Ny4xLjE2OTg5MDcyOTAuNi4wLjA.',
                                              width: 30,
                                            ),
                                            SizedBox(
                                                width:
                                                    Responsive.isMobile(context)
                                                        ? 15.0
                                                        : 40),
                                            Text(phone,
                                                style: const TextStyle(
                                                    fontSize: 17.0,
                                                    color: Color(0xff494949),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile(
                                              email: email,
                                              username: username,
                                              pic: userpic,
                                              phonenumber: phone,
                                            )));
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        top: 15.0,
                                        bottom: 15.0),
                                    child: Row(children: [
                                      Image.network(
                                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fedit.png?alt=media&token=c3126938-6ca0-4ce1-85f6-cfc5ad264015&_gl=1*onc3x3*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODkwNjA5My43Ny4xLjE2OTg5MDcyNTIuNDQuMC4w',
                                        width: 30,
                                      ),
                                      SizedBox(
                                          width: Responsive.isMobile(context)
                                              ? 15.0
                                              : 40),
                                      const SizedBox(
                                        // width: MediaQuery.of(context).size.width *
                                        //     0.65,
                                        child: Text("Edit Profile",
                                            style: TextStyle(
                                                fontSize: 17.0,
                                                color: Color(0xff494949),
                                                fontWeight: FontWeight.w500)),
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 10.0),
                                GestureDetector(
                                  onTap: () {
                                    _logoutDialoge(context);
                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0,
                                            right: 15.0,
                                            top: 15.0,
                                            bottom: 15.0),
                                        child: Row(children: [
                                          Image.network(
                                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Flogout%20icon.png?alt=media&token=9705628c-695d-445a-a715-086ca56bf567&_gl=1*1s5s5tk*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODkwNjA5My43Ny4xLjE2OTg5MDYyNzMuNjAuMC4w',
                                            width: 30,
                                          ),
                                          SizedBox(
                                              width:
                                                  Responsive.isMobile(context)
                                                      ? 15.0
                                                      : 40),
                                          const Text('Logout',
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Color(0xff494949),
                                                  fontWeight: FontWeight.w500))
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(vertical: 15),
                      //   width: MediaQuery.of(context).size.width,
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(15.0)),
                      //   child: Column(
                      //     children: [
                      //       Padding(
                      //         padding: EdgeInsets.only(
                      //             left: MediaQuery.of(context).size.width * 0.1,
                      //             right: 15.0,
                      //             bottom: 4.0),
                      //         child: const Row(children: [
                      //           Icon(Icons.hdr_auto_rounded,
                      //               color: Color(0xff494949), size: 30.0),
                      //           SizedBox(width: 15.0),
                      //           Text("Log Out",
                      //               style: TextStyle(
                      //                   fontSize: 17.0,
                      //                   color: Color(0xff494949),
                      //                   fontWeight: FontWeight.w500))
                      //         ]),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.74,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ImageViewer(
                    //               images: userpic,
                    //               controller: controller,
                    //             )));
                  },
                  child: CachedNetworkImage(
                    imageUrl: '${_auth.currentUser?.photoURL}',
                    imageBuilder: (context, imageProvider) => Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.white),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.03,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Farrow%20left.png?alt=media&token=4f23b9ce-7c61-4223-940c-ea3f5bd14c24&_gl=1*blgm6y*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODkwNjA5My43Ny4xLjE2OTg5MDY2MTAuNjAuMC4w',
                      width: 25,
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   top: MediaQuery.of(context).size.height * 0.075,
              //   right: MediaQuery.of(context).size.width * 0.05,
              //   child: GestureDetector(
              //     onTap: () {
              //       shareProfileLink();
              //     },
              //     child: Container(
              //       padding: EdgeInsets.all(4),
              //       decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: Colors.white,
              //           border: Border.all(
              //             color: Colors.white,
              //           )),
              //       child: const Icon(
              //         Icons.share,
              //         size: 25.0,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ),
              // ),
              _auth.currentUser != null
                  ? Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.74,
                      right: MediaQuery.of(context).size.width * 0.05,
                      child: Visibility(
                        visible: widget.uid == _auth.currentUser!.uid,
                        child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => username_edit(
                              //       edit: true,
                              //       bio: bio,
                              //       username: username,
                              //       phone: phone,
                              //       city: city,
                              //       country: country,
                              //       address: address,
                              //       photo: userpic,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xFF12122A),
                                  )),
                              child: const Icon(
                                Icons.edit,
                                size: 25.0,
                                color: Color(0xFF12122A),
                              ),
                            )),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  // final String baseUrl = 'https://www.artshub.com/profile/';
  // final String userId = '123';
  // String profileUrl = '$baseUrl${widget.uid}';
  // final String shareMessage = 'Check out my profile: $profileUrl';

  void shareProfileLink() async {
    // var profileurl = 'https://the-arts-hub.web.app/profile/${widget.uid}';
    // // await launch(profileUrl);
    // await Share.share(
    //     "Install Arts Hub App to see $username's Portfolio: $profileurl");
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
                  // await GoogleSignIn().signOut();
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
}
