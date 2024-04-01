import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/components/footer.dart';
import 'package:galaxy_web/components/footer_mobile.dart';
import 'package:galaxy_web/components/mobile_navbar.dart';
import 'package:galaxy_web/components/navbar.dart';
import 'package:galaxy_web/components/side_drawer.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:galaxy_web/responsive.dart';
import 'package:provider/provider.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key, this.data});
  final data;
  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
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

  @override
  void initState() {
    getData();
    Provider.of<menuController>(context, listen: false).navmenueSelect('Blog');
    super.initState();
  }

  var data;
  getData() {
    FirebaseFirestore.instance
        .collection('Blog')
        .doc(widget.data)
        .get()
        .then((value) {
      setState(() {
        data = value;
      });
    });
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
        body: data == null
            ? Center(
                child: CircularProgressIndicator(
                color: Color(0xffE5B920),
              ))
            : ListView(children: [
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
                SizedBox(
                  height: Responsive.isMobile(context) ? 15 : 25.0,
                ),
                Padding(
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
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 0,
                                          left: Responsive.isMobile(context)
                                              ? 20
                                              : 20.0,
                                          right: Responsive.isMobile(context)
                                              ? 20
                                              : 20.0),
                                      child: Text(
                                        data.get('title'),
                                        style: TextStyle(
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 20.0
                                                    : 25.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 15.0),
                                    CachedNetworkImage(
                                      imageUrl: data.get('img'),
                                      // Replace with your image URL
                                      imageBuilder: (context, imageProvider) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Image(
                                          image: imageProvider,
                                          width: Responsive.isMobile(context)
                                              ? MediaQuery.of(context)
                                                  .size
                                                  .width
                                              : 900, // Set the desired width
                                          height: Responsive.isMobile(context)
                                              ? 200
                                              : 450, // Set the desired height
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const Center(
                                              child: CircularProgressIndicator(
                                                  color: Color(0xffE5B920))),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    const SizedBox(height: 20.0),
                                    ListView.builder(
                                      itemCount: data.get('content').length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      // snapshot.data!.docs.length > 10
                                      //     ? 10
                                      //     : snapshot.data!.docs.length,
                                      // scrollDirection: Axis.horizontal,
                                      // controller: _scrollController, // Attach ScrollController
                                      itemBuilder: (
                                        context,
                                        index,
                                      ) {
                                        // DocumentSnapshot data =
                                        //     snapshot.data!.docs[index];
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 30.0),
                                          child: Column(
                                            children: [
                                              MouseRegion(
                                                cursor: SystemMouseCursors.text,
                                                child: Text(
                                                  data.get('content')[index],
                                                  style: const TextStyle(
                                                    fontSize: 17.0,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                              index == 1
                                                  ? const SizedBox(height: 15.0)
                                                  : const SizedBox(),
                                              index == 1
                                                  ? Image.network(
                                                      'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fbanner.jpg?alt=media&token=ef817b41-1399-4972-993d-63324cc646d0&_gl=1*1n1923a*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5Nzk1OTcxNS40Ni4xLjE2OTc5NjA5MTIuNTEuMC4w',
                                                      width: Responsive
                                                              .isMobile(context)
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.9
                                                          : MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5)
                                                  : const SizedBox(),
                                              index == 4
                                                  ? const SizedBox(height: 15.0)
                                                  : const SizedBox(),
                                              index == 4
                                                  ? Image.network(
                                                      'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fbanner.jpg?alt=media&token=ef817b41-1399-4972-993d-63324cc646d0&_gl=1*1n1923a*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5Nzk1OTcxNS40Ni4xLjE2OTc5NjA5MTIuNTEuMC4w',
                                                      width: Responsive
                                                              .isMobile(context)
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.9
                                                          : MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5)
                                                  : const SizedBox(),
                                              index == 7
                                                  ? const SizedBox(height: 15.0)
                                                  : const SizedBox(),
                                              index == 7
                                                  ? Image.network(
                                                      'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fbanner.jpg?alt=media&token=ef817b41-1399-4972-993d-63324cc646d0&_gl=1*1n1923a*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5Nzk1OTcxNS40Ni4xLjE2OTc5NjA5MTIuNTEuMC4w',
                                                      width: Responsive
                                                              .isMobile(context)
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.9
                                                          : MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5)
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ])),
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
                Responsive.isMobile(context)
                    ? const FooterMobile()
                    : const Footer(),
              ]),
      ),
    );
  }
}
