import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:galaxy_web/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/footer.dart';
import '../components/footer_mobile.dart';
import '../components/mobile_navbar.dart';
import '../components/navbar.dart';
import '../components/product_details.dart';
import '../components/side_drawer.dart';
import '../controllers/MenuController.dart';
import '../responsive.dart';

class Blog extends StatefulWidget {
  const Blog({
    super.key,
  });

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  var loader = true;
  List<Map<String, dynamic>> data = [];
  var dataId = [];
  getData() {
    FirebaseFirestore.instance
        .collection('Blog')
        // .where('category', isEqualTo: widget.categ)
        .orderBy('datetime', descending: true)
        .get()
        .then((value) {
      setState(() {
        for (var i = 0; i < value.docs.length; i++) {
          dataId.add(value.docs[i].id);
        }
        data = value.docs.map((DocumentSnapshot doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
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
    Provider.of<menuController>(context, listen: false).navmenueSelect('Blog');
  }

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
                  ? MobileNavBar(scaffoldKey, context)
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
              "Blog",
              style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 25.0 : 30.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: Responsive.isMobile(context) ? 15 : 25.0,
          ),
          loader
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xffE5B920)))
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
                                // getimpresssion(dataId[index]);
                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<menuController>(context,
                                              listen: false)
                                          .navmenueSelect('Blog');
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             ProductDetails(
                                      //                 id: dataId[index],
                                      //                 data: data[index],
                                      //                 shop: 'true')));

                                      var id = dataId[index];
                                      // Replace with the actual value
                                      // RouteHandler.router
                                      //     .navigateTo(context, '/blog/$id');
                                      context.go(
                                        Uri(
                                          path: '/blog/$id',
                                          queryParameters: {'id': id},
                                        ).toString(),
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 13.0),
                                      child: Container(
                                        height: Responsive.isMobile(context)
                                            ? 470
                                            : 700,
                                        // width:
                                        //     MediaQuery.of(context).size.width *
                                        //         0.3,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.5), // Shadow color
                                              spreadRadius: 3, // Spread radius
                                              blurRadius: 3, // Blur radius
                                              offset:
                                                  const Offset(0, 3), // Offset
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: data[index][
                                                  'img'], // Replace with your image URL
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      ClipRRect(
                                                borderRadius: const BorderRadius
                                                    .only(
                                                    topLeft: Radius.circular(
                                                        10.0), // Adjust the radius as needed

                                                    topRight: Radius.circular(
                                                        10.0) // Adjust the radius as needed
                                                    ), // Set the radius here
                                                child: Image(
                                                  image: imageProvider,
                                                  width: Responsive.isMobile(
                                                          context)
                                                      ? MediaQuery.of(context)
                                                          .size
                                                          .width
                                                      : MediaQuery.of(context)
                                                          .size
                                                          .width, // Set the desired width
                                                  height: Responsive.isMobile(
                                                          context)
                                                      ? 250
                                                      : 450, // Set the desired height
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                              color: Color(
                                                                  0xffE5B920))),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20.0,
                                                        right: 20,
                                                        top:
                                                            Responsive.isMobile(
                                                                    context)
                                                                ? 10
                                                                : 30),
                                                    child: Text(
                                                      data[index]['title'],
                                                      maxLines:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 2
                                                              : 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: Responsive
                                                                  .isMobile(
                                                                      context)
                                                              ? 18.0
                                                              : 25.0,
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0,
                                                            right: 20,
                                                            top: 10),
                                                    child: Text(
                                                      data[index]['content'][0],
                                                      maxLines: 4,
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
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20),
                                                          child: Text(
                                                              "Posted: ${_date(data[index]['datetime'].toDate().toString())}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10.0,
                                                                    right: 20),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  color: const Color(
                                                                      0xffE5B920),
                                                                  border: Border.all(
                                                                      width:
                                                                          2.0,
                                                                      color: const Color(
                                                                          0xffE5B920))),
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: Responsive.isMobile(
                                                                            context)
                                                                        ? 7.0
                                                                        : 8.0,
                                                                    right: Responsive.isMobile(
                                                                            context)
                                                                        ? 7.0
                                                                        : 8.0,
                                                                    top: 5.0,
                                                                    bottom:
                                                                        5.0),
                                                                child: Text(
                                                                    'Read More',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: Responsive.isMobile(context)
                                                                            ? 14
                                                                            : 16.0,
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                              ),
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

  getimpresssion(var id) {
    FirebaseFirestore.instance.collection('Properties List').doc(id).set({
      'impression': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  getClick(var id) {
    FirebaseFirestore.instance.collection('Properties List').doc(id).set({
      'clicks': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  getCallClick(var id) {
    FirebaseFirestore.instance.collection('Properties List').doc(id).set({
      'call': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  getWhatsappClick(var id) {
    FirebaseFirestore.instance.collection('Properties List').doc(id).set({
      'whatsapp': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  String _date(String _timestamp) {
    String formattedDate =
        DateFormat('dd MMM, yyyy').format(DateTime.parse(_timestamp));
    return formattedDate;
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
                  color: hover ? const Color(0xffE5B920) : Colors.grey),
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
                    color: hover ? const Color(0xffE5B920) : Colors.black,
                    fontSize: 17.0,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
