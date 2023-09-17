import 'package:flutter/material.dart';
import 'package:galaxy_web/components/category.dart';
import 'package:galaxy_web/components/categorymobile.dart';
import 'package:galaxy_web/components/mobile_navbar.dart';
import 'package:galaxy_web/components/mobile_searchblock.dart';
import 'package:galaxy_web/components/navbar.dart';
import 'package:galaxy_web/components/search_block.dart';
import 'package:galaxy_web/components/side_drawer.dart';
import 'package:galaxy_web/responsive.dart';

import '../components/blogitem.dart';
import '../components/footer.dart';
import '../components/logosection.dart';
import '../components/productlist.dart';
import '../components/whychoose.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      key: scaffoldKey,
      drawer: const SideDrawer(),
      body: ListView(
        children: [
          Stack(
            children: [
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/multan%20cover.png?alt=media&token=26ea21c1-c846-4ac5-9289-ede20b574778',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.height * 0.45
                    : MediaQuery.of(context).size.height * 0.9,
              ),
              Responsive.isMobile(context)
                  ? MobileNavBar(scaffoldKey)
                  : const NavBar(),
              Responsive.isMobile(context)
                  ? MobileSearchBlock(context)
                  : SearchBlock(context),
            ],
          ),
          Padding(
            padding:  EdgeInsets.only(left: Responsive.isMobile(context)? 20: 50.0, top: 40.0),
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
            padding:  EdgeInsets.only(left: Responsive.isMobile(context)? 20:50.0, top: 40.0,right: Responsive.isMobile(context)? 20:50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Galaxy Projects",
                  style: TextStyle(
                      fontSize: Responsive.isMobile(context) ? 20.0 : 25.0,
                      fontWeight: FontWeight.bold),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    "View All",
                    style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 15.0 : 15.0,
                        decoration: TextDecoration.underline,
                        color: const Color(0xff4DB9F4),
                        fontWeight: FontWeight.w600,),
                  ),
                ),
              ],
            ),
          ),
          const ProductList(),
          const WhyChooseSection(),
          Padding(
            padding:  EdgeInsets.only(left: Responsive.isMobile(context)? 20:50.0, top: 40.0,right: Responsive.isMobile(context)? 20:50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Blogs",
                  style: TextStyle(
                      fontSize: Responsive.isMobile(context) ? 20.0 : 25.0,
                      fontWeight: FontWeight.bold),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    "View All",
                    style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 15.0 : 15.0,
                        decoration: TextDecoration.underline,
                        color: const Color(0xff4DB9F4),
                        fontWeight: FontWeight.w600,),
                  ),
                ),
              ],
            ),
          ),
          const BlogItems(),
          const LogoSection(),
          const Footer(),
        ],
      ),
    );
  }
}
