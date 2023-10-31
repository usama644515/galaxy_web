import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore
              .instance //------for select the item in the firestore----
              .collection("Banners")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  height: Responsive.isMobile(context)? 140.0: 450,
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
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
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
                        height: Responsive.isMobile(context)? 140.0: 450,
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
                          color: Color(0xffF9A51F),
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
