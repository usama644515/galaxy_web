import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/main/shop.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responsive.dart';

class WhyChooseSection extends StatefulWidget {
  const WhyChooseSection({super.key});

  @override
  State<WhyChooseSection> createState() => _WhyChooseSectionState();
}

class _WhyChooseSectionState extends State<WhyChooseSection> {
  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Container(
              height: 350.0,
              // width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xff1E1E1E),
                    const Color(0xff1E1E1E)
                  ], // Define your gradient colors
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Why Pretorian Realtors Builders?',
                        style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 26 : 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          'Welcome to Pretorian Realtor Builder – your gateway to a seamless real estate experience. Unlock the potential of our innovative portal, designed for real estate agencies and agents to effortlessly create accounts and listings. With user-friendly features, managing properties becomes a breeze, enhancing your online presence and connectivity with potential clients. Join us at Pretorian Realtor Builder and step into a future where efficiency and innovation redefine the real estate landscape.',
                          style: TextStyle(
                              fontSize:
                                  Responsive.isMobile(context) ? 12.0 : 15.0,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 139, 135, 135)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<menuController>(context,
                                      listen: false)
                                  .navmenueSelect('Shop');
                              // navigateToPage('/Shop');
                              kIsWeb
                                  ? context.go('/shop')
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              kIsWeb ? Shop() : Bar(ind: 1)));
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) {
                                setState(() {
                                  explorebtn = true;
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  explorebtn = false;
                                });
                              },
                              child: Container(
                                  height: 45,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: explorebtn
                                              ? Colors.white
                                              : Colors.transparent,
                                          width: 2.0),
                                      color: explorebtn
                                          ? const Color.fromARGB(
                                              255, 36, 34, 34)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    'Explore Now',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: explorebtn
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ))),
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) {
                              setState(() {
                                contactbtn = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                contactbtn = false;
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                _launchPhone('+923000335875');
                              },
                              child: Container(
                                  height: 45,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: contactbtn
                                              ? Colors.black
                                              : Colors.white,
                                          width: 2.0),
                                      color: contactbtn
                                          ? Colors.black
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    'Contact Now',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: contactbtn
                                            ? Colors.white
                                            : Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ))),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore
                    .instance //------for select the item in the firestore----
                    .collection("Banners")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.only(top: 20),
                        child: const CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          color: Color(0xffd2b48c),
                        ));
                  } else if (snapshot.data!.docs.length == 0) {
                    return Container(
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(''));
                  } else {
                    return CarouselSlider.builder(
                      options: CarouselOptions(
                        height: Responsive.isMobile(context) ? 140.0 : 450,
                        viewportFraction: 0.9,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        DocumentSnapshot data = snapshot.data!.docs[itemIndex];
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ImageViewer(
                            //               images: widget.data['img'],
                            //               controller: controller,
                            //             )));
                          },
                          child: CachedNetworkImage(
                            imageUrl: data['banner'],
                            imageBuilder: (context, imageProvider) => Container(
                              height:
                                  Responsive.isMobile(context) ? 140.0 : 450,
                              // width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                // shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              alignment: Alignment.topCenter,
                              margin: const EdgeInsets.only(top: 40.0),
                              child: const CircularProgressIndicator(
                                color: Color(0xffE8BB2A),
                                // color: AppColor.primary,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        );
                      },
                    );
                  }
                }),
          );
  }

  var explorebtn = false;
  var contactbtn = false;
  void _launchPhone(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
