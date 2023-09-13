import 'package:flutter/material.dart';
import 'package:galaxy_web/components/category.dart';
import 'package:galaxy_web/components/categorymobile.dart';
import 'package:galaxy_web/components/mobile_navbar.dart';
import 'package:galaxy_web/components/mobile_searchblock.dart';
import 'package:galaxy_web/components/navbar.dart';
import 'package:galaxy_web/components/search_block.dart';
import 'package:galaxy_web/components/side_drawer.dart';
import 'package:galaxy_web/responsive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
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
                  ? MobileNavBar(_scaffoldKey)
                  : const NavBar(),
              Responsive.isMobile(context)
                  ? MobileSearchBlock(context)
                  : SearchBlock(context),
            ],
          ),
           Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 40.0),
            child: Text(
              "Explore more on Galaxy",
              style: TextStyle(fontSize:Responsive.isMobile(context)? 20.0: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
         Responsive.isMobile(context)? CategoryMobile() : category(),
        ],
      ),
    );
  }
}
