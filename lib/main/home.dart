import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/components/category.dart';
import 'package:galaxy_web/components/categorymobile.dart';
import 'package:galaxy_web/components/mobile_navbar.dart';
import 'package:galaxy_web/components/mobile_searchblock.dart';
import 'package:galaxy_web/components/navbar.dart';
import 'package:galaxy_web/components/search_block.dart';
import 'package:galaxy_web/components/side_drawer.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/responsive.dart';
import 'package:galaxy_web/router/routes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/blogitem.dart';
import '../components/footer.dart';
import '../components/footer_mobile.dart';
import '../components/logosection.dart';
import '../components/productlist.dart';
import '../components/whychoose.dart';
import '../controllers/MenuController.dart';
import 'shop.dart';
import 'package:seo_renderer/seo_renderer.dart';
// import 'dart:html' as html;

class Home extends StatefulWidget {
  const Home({
    super.key,
  });
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  

  void initState() {
    // updatedata();
    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('Home');
    super.initState();
  }

  // void _onScreenDisplay() {
  //   // Add your logic for actions to be performed when the screen is displayed
  //   print('Displayed Second Screen');
  //   Provider.of<menuController>(context, listen: false).navmenueSelect('Home');
  // }
  // var search =
  //     'Buch Villas Multan';
  // var arr = [];
  // stringslicing() {

  //   for (var i = 0; i < search.length; i++) {
  //     arr.add(search.substring(0, i + 1).toLowerCase());
  //     if (i + 1 == search.length) {
  //       updatedata();
  //     }
  //   }
  // }

  // updatedata() {
  //   FirebaseFirestore.instance
  //       .collection('Properties List')
  //       .doc('1e7Ho8dO8S18OybCM361')
  //       .set({'searchquery': arr}, SetOptions(merge: true));
  // }
  // void updatedata() async {
  //   CollectionReference collectionRef =
  //       FirebaseFirestore.instance.collection('Properties List');

  //   QuerySnapshot querySnapshot = await collectionRef.get();

  //   querySnapshot.docs.forEach((document) async {
  //     // Update the data in each document
  //     await collectionRef.doc(document.id).set({
  //       'status': 'Active',
  //     }, SetOptions(merge: true));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      key: scaffoldKey,
      drawer: const SideDrawer(),
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  kIsWeb
                      ? Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/web%20background.png?alt=media&token=91e7e798-ae2e-4f48-8152-916da53e1357',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: Responsive.isMobile(context)
                              ? MediaQuery.of(context).size.height * 0.45
                              : MediaQuery.of(context).size.height * 0.9,
                        )
                      : Image.asset(
                          'assets/images/main cover.png',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: Responsive.isMobile(context)
                              ? MediaQuery.of(context).size.height * 0.45
                              : MediaQuery.of(context).size.height * 0.9,
                        ),
                  Responsive.isMobile(context)
                      ? MobileNavBar(scaffoldKey, context)
                      : const NavBar(),
                  Responsive.isMobile(context)
                      ? MobileSearchBlock(context)
                      : SearchBlock(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: Responsive.isMobile(context) ? 20 : 50.0, top: 40.0),
                child: Text(
                  "Explore more on Galaxy",
                  style: TextStyle(
                      fontSize: Responsive.isMobile(context) ? 20.0 : 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Responsive.isMobile(context)
                  ? const CategoryMobile()
                  : const category(),
              Padding(
                padding: EdgeInsets.only(
                    left: Responsive.isMobile(context) ? 20 : 50.0,
                    top: 40.0,
                    right: Responsive.isMobile(context) ? 20 : 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Galaxy Projects",
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 20.0 : 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<menuController>(context, listen: false)
                            .navmenueSelect('Shop');
                        // navigateToPage('/Shop');
                        kIsWeb
                            ? RouteHandler.router.navigateTo(context, '/shop')
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        kIsWeb ? Shop() : Bar(ind: 1)));
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize:
                                Responsive.isMobile(context) ? 15.0 : 15.0,
                            decoration: TextDecoration.underline,
                            color: const Color(0xff4DB9F4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const ProductList(),
              const WhyChooseSection(),
              Padding(
                padding: EdgeInsets.only(
                    left: Responsive.isMobile(context) ? 20 : 50.0,
                    top: 40.0,
                    right: Responsive.isMobile(context) ? 20 : 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Blogs",
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 20.0 : 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap:(){
                        Provider.of<menuController>(context, listen: false)
                    .navmenueSelect('Blog');
                RouteHandler.router.navigateTo(context, '/blog');
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 15.0 : 15.0,
                            decoration: TextDecoration.underline,
                            color: const Color(0xff4DB9F4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const BlogItems(),
              const LogoSection(),
              Responsive.isMobile(context)
                  ? const FooterMobile()
                  : const Footer(),
            ],
          ),
          Positioned(
            bottom: Responsive.isMobile(context) ? 20.0 : 15,
            left: Responsive.isMobile(context) ? 10.0 : 15,
            child: GestureDetector(
              onTap: () {
                _openWhatsApp(923000335875, '');
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) {},
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: ,
                    //     blurRadius: 4,
                    //     offset: const Offset(0, 3),
                    //   ),
                    // ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fwhatsapp%20icon.png?alt=media&token=0c59daba-322a-4cb3-b9ed-2f65dede9ea2&_gl=1*1tpr174*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODMyMDU2NC42Mi4xLjE2OTgzMjA3MjYuMzIuMC4w',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // void navigateToPage(String pagePath) {
  //   // Change the URL without reloading the page (client-side routing)
  //   html.window.history.pushState(null, '', pagePath);

  //   // Perform any additional navigation logic if needed
  //   // For example, you can use the Navigator class to push routes.
  // }

  _openWhatsApp(var phoneNumber, var title) async {
    // final phoneNumber =
    //     '923000335875'; // Replace with the recipient's phone number
    // Replace with your message
    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(title)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
