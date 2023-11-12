import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/components/footer.dart';
import 'package:galaxy_web/components/footer_mobile.dart';
import 'package:galaxy_web/components/mobile_navbar.dart';
import 'package:galaxy_web/components/product_details.dart';
import 'package:galaxy_web/components/side_drawer.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:galaxy_web/responsive.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/navbar.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key, this.categ});
  final categ;
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var filter = ['Residential', 'Commercial', 'Plots', 'Construction'];
  var loader = true;
  List<Map<String, dynamic>> data = [];
  getData() {
    if (widget.categ == null) {
      FirebaseFirestore.instance
          .collection('Properties List')
          .where('user', isEqualTo: _auth.currentUser?.uid)
          .get()
          .then((value) {
        setState(() {
          data = value.docs.map((DocumentSnapshot doc) {
            return doc.data() as Map<String, dynamic>;
          }).toList();
          loader = false;
        });
        // Provider.of<menuController>(context, listen: true).PropertiesList(data);
        // print(data);
      });
    } else {
      FirebaseFirestore.instance
          .collection('Properties List')
          .where('category', isEqualTo: widget.categ)
          .get()
          .then((value) {
        setState(() {
          data = value.docs.map((DocumentSnapshot doc) {
            return doc.data() as Map<String, dynamic>;
          }).toList();
          loader = false;
        });
        // Provider.of<menuController>(context, listen: true).PropertiesList(data);
        // print(data);
      });
    }
  }

  filtersearch(var val) {
    print(data);
    setState(() {
      loader = true;
    });
    FirebaseFirestore.instance
        .collection('Properties List')
        .where('category', isEqualTo: val)
        .get()
        .then((value) {
      setState(() {
        data = value.docs.map((DocumentSnapshot doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
        // print(data);
        loader = false;
      });
      // Provider.of<menuController>(context, listen: true).PropertiesList(data);
      // print(data);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<bool> onBackPress() async {
    setState(() {
      Provider.of<menuController>(context, listen: false)
          .navmenueSelect('Home');
    });
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => kIsWeb ? Home() : Bar(ind: 0),),
      (route) => false, // Always return false to remove all routes
    );
    return Future.value(false);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        key: scaffoldKey,
        drawer: const SideDrawer(),
        body: ListView(children: [
          Stack(
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.black),
              ),
              Responsive.isMobile(context)
                  ? MobileNavBar(scaffoldKey)
                  : const NavBar(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fbanner.jpg?alt=media&token=ef817b41-1399-4972-993d-63324cc646d0&_gl=1*1n1923a*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5Nzk1OTcxNS40Ni4xLjE2OTc5NjA5MTIuNTEuMC4w',
                  width: Responsive.isMobile(context)
                      ? MediaQuery.of(context).size.width * 0.9
                      : MediaQuery.of(context).size.width * 0.5),
            ],
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(
                top: 0,
                left: Responsive.isMobile(context) ? 20 : 50.0,
                right: Responsive.isMobile(context) ? 20 : 50.0),
            child: Text(
              "My DashBoard",
              style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 25.0 : 30.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: Responsive.isMobile(context) ? 15 : 25.0,
          ),
          SizedBox(
            height: 60,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20),
              child: ListView.builder(
                itemCount: filter.length,
                // snapshot.data!.docs.length > 10
                //     ? 10
                //     : snapshot.data!.docs.length,
                scrollDirection: Axis.horizontal,
                // controller: _scrollController, // Attach ScrollController
                itemBuilder: (
                  context,
                  index,
                ) {
                  // DocumentSnapshot data =
                  //     snapshot.data!.docs[index];
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (index == 0) {
                            filtersearch('Residential');
                          } else if (index == 1) {
                            filtersearch('Commercial');
                          } else if (index == 2) {
                            filtersearch('Plots');
                          } else if (index == 3) {
                            filtersearch('Construction');
                          }
                        });
                      },
                      child: Filter(data: filter[index]));
                },
              ),
            ),
          ),
          loader
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xffF9A51F)))
              : Padding(
                  padding: EdgeInsets.only(
                      left: Responsive.isMobile(context) ? 10 : 120.0,
                      right: Responsive.isMobile(context) ? 10 : 100.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: Responsive.isMobile(context) ? 0 : 400.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Responsive.isMobile(context)
                                  ? Colors.transparent
                                  : const Color(0xffF7F8FA),
                              border: Border.all(
                                  color: Responsive.isMobile(context)
                                      ? Colors.transparent
                                      : const Color(0xffEDEDED))),
                          child: Padding(
                            padding: EdgeInsets.all(
                                Responsive.isMobile(context) ? 0 : 30.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              // scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                // Build each grid item
                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<menuController>(context,
                                              listen: false)
                                          .navmenueSelect('Shop');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetails(
                                                      data: data[index])));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 13.0),
                                      child: Container(
                                        height: Responsive.isMobile(context)
                                            ? 170
                                            : 250,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.5), // Shadow color
                                              spreadRadius: 5, // Spread radius
                                              blurRadius: 7, // Blur radius
                                              offset:
                                                  const Offset(0, 3), // Offset
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: Responsive.isMobile(
                                                          context)
                                                      ? 5.0
                                                      : 15.0,
                                                  top: 0.0,
                                                  bottom: 0),
                                              child: CachedNetworkImage(
                                                imageUrl: data[index]['img'][
                                                    0], // Replace with your image URL
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        10.0), // Adjust the radius as needed
                                                    bottomLeft: Radius.circular(
                                                        10.0), // Adjust the radius as needed
                                                  ), // Set the radius here
                                                  child: Image(
                                                    image: imageProvider,
                                                    width: Responsive.isMobile(
                                                            context)
                                                        ? 140
                                                        : 300, // Set the desired width
                                                    height: Responsive.isMobile(
                                                            context)
                                                        ? 170
                                                        : 250, // Set the desired height
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: Color(
                                                                    0xffF9A51F))),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  Responsive.isMobile(context)
                                                      ? 5.0
                                                      : 15.0,
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'PKR ${data[index]['price']}',
                                                    // maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize:
                                                            Responsive.isMobile(
                                                                    context)
                                                                ? 17.0
                                                                : 20.0,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  const SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  SizedBox(
                                                    width: Responsive.isMobile(
                                                            context)
                                                        ? 200
                                                        : 310,
                                                    child: Text(
                                                      data[index]['title'],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: Responsive
                                                                  .isMobile(
                                                                      context)
                                                              ? 14.0
                                                              : 16.0,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Responsive.isMobile(
                                                            context)
                                                        ? 5.0
                                                        : 8.0,
                                                  ),
                                                  SizedBox(
                                                    width: Responsive.isMobile(
                                                            context)
                                                        ? 200
                                                        : 310,
                                                    child: Text(
                                                      data[index]['location'],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Responsive.isMobile(
                                                            context)
                                                        ? 5.0
                                                        : 8.0,
                                                  ),
                                                  Row(children: [
                                                    Image.network(
                                                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fbedroom.png?alt=media&token=8ecacc5e-26f1-4f6d-8be1-2a4c5dc37ac1&_gl=1*yjagxc*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5Nzg5MDgzMy40NC4xLjE2OTc4OTE2MzUuNjAuMC4w',
                                                        width: 18.0),
                                                    const SizedBox(width: 5.0),
                                                    Text(
                                                      data[index]['rooms'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(width: 18.0),
                                                    Image.network(
                                                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fbathroom.png?alt=media&token=50e413a2-c87a-4083-ba1a-6dd700bab39a&_gl=1*10fh5ol*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5Nzg5MDgzMy40NC4xLjE2OTc4OTIwNjIuNjAuMC4w',
                                                        width: 18.0),
                                                    const SizedBox(width: 5.0),
                                                    Text(
                                                      data[index]['bath'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(width: 18.0),
                                                    Image.network(
                                                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fsize.png?alt=media&token=d6f2499d-eecc-479f-9df6-5f5c31978de0&_gl=1*qw5rt*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5Nzg5MDgzMy40NC4xLjE2OTc4OTE5ODYuMTkuMC4w',
                                                        width: 18.0),
                                                    const SizedBox(width: 5.0),
                                                    Text(
                                                      data[index]['size'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ]),
                                                  SizedBox(
                                                      height:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 10
                                                              : 30.0),
                                                  Row(children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _openWhatsApp(
                                                          data[index]['title'],
                                                          data[index]['phone'],
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            border: Border.all(
                                                                width: 2.0,
                                                                color: const Color(
                                                                    0xffF9A51F))),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 7.0
                                                                  : 8.0,
                                                              right: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 7.0
                                                                  : 8.0,
                                                              top: 5.0,
                                                              bottom: 5.0),
                                                          child: Row(children: [
                                                            Image.network(
                                                                'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fwhatsapp.png?alt=media&token=89a781dc-cdc9-424c-96dc-d996eaabd8ae&_gl=1*tgw0tl*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzcwOTk0Ni40MC4xLjE2OTc3MDk5ODMuMjMuMC4w',
                                                                height: Responsive
                                                                        .isMobile(
                                                                            context)
                                                                    ? 14
                                                                    : 18,
                                                                width: Responsive
                                                                        .isMobile(
                                                                            context)
                                                                    ? 14
                                                                    : 18),
                                                            const SizedBox(
                                                                width: 6.0),
                                                            Text('WhatsApp',
                                                                style: TextStyle(
                                                                    color: const Color(
                                                                        0xffF9A51F),
                                                                    fontSize: Responsive.isMobile(
                                                                            context)
                                                                        ? 14
                                                                        : 16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))
                                                          ]),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            Responsive.isMobile(
                                                                    context)
                                                                ? 6.0
                                                                : 10.0),
                                                    GestureDetector(
                                                      onTap: () {
                                                        _launchPhone(data[index]
                                                            ['phone']);
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            color: const Color(
                                                                0xffF9A51F),
                                                            border: Border.all(
                                                                width: 2.0,
                                                                color: const Color(
                                                                    0xffF9A51F))),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 7.0
                                                                  : 8.0,
                                                              right: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 7.0
                                                                  : 8.0,
                                                              top: 5.0,
                                                              bottom: 5.0),
                                                          child: Row(children: [
                                                            Image.network(
                                                                'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fphone%20white.png?alt=media&token=4e3947e5-19f5-4d17-8d4d-379a63ac9910&_gl=1*tld1ry*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5Nzk1Njk3Mi40NS4xLjE2OTc5NTY5NzkuNTMuMC4w',
                                                                height: Responsive
                                                                        .isMobile(
                                                                            context)
                                                                    ? 14
                                                                    : 18,
                                                                width: Responsive
                                                                        .isMobile(
                                                                            context)
                                                                    ? 14
                                                                    : 18),
                                                            const SizedBox(
                                                                width: 6.0),
                                                            Text('CALL',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: Responsive.isMobile(
                                                                            context)
                                                                        ? 14
                                                                        : 16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))
                                                          ]),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Responsive.isMobile(context)
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Find out more about Projects',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 20),
                                  Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fbanner%2Fwide%20banner.jpg?alt=media&token=dfc6b1e2-f4c8-4ea9-8f6e-5ad02ea22885&_gl=1*r25b*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5Nzk2Mjg2Ny40Ny4xLjE2OTc5NjI4ODYuNDEuMC4w',
                                    width: 300,
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
          const SizedBox(
            height: 25,
          ),
          Responsive.isMobile(context) ? const FooterMobile() : const Footer(),
        ]),
      ),
    );
  }

  void _launchPhone(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to open WhatsApp
  _openWhatsApp(var msg, var phoneNumber) async {
    print(phoneNumber);
    // final phoneNumber =
    //     '923000335875'; // Replace with the recipient's phone number
    final message = msg; // Replace with your message
    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class Filter extends StatefulWidget {
  const Filter({super.key, this.data});
  final data;
  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var hover = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() {
            hover = true;
          });
        },
        onExit: (_) {
          setState(() {
            hover = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: hover ? const Color(0xffF9A51F) : Colors.grey),
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: Center(
              child: Text(widget.data,
                  style: TextStyle(
                    color: hover ? const Color(0xffF9A51F) : Colors.black,
                    fontSize: 17.0,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
