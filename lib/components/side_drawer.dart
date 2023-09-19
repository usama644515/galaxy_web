import 'package:flutter/material.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:provider/provider.dart';

import '../main/home.dart';
import '../main/shop.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff222222),
      child: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 115,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: const Center(
                    child: Text('LOGIN',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          ListTile(
            title: Text(
              'HOME',
              style: TextStyle(
                  color: Provider.of<menuController>(context, listen: false)
                              .menue ==
                          'Home'
                      ? Colors.white
                      : const Color(0xff8c8c8c),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                Provider.of<menuController>(context, listen: false)
                  .navmenueSelect('Home');
                  // Remove all routes and push a new route
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Home()),
                      (route) =>
                          false, // Always return false to remove all routes
                    );
              });
            },
          ),
          const Divider(
            color: Color(0xff8c8c8c),
            thickness: 0.1,
          ),
          ListTile(
            title: Text(
              'SHOP',
              style: TextStyle(
                  color: Provider.of<menuController>(context, listen: false)
                              .menue ==
                          'Shop'
                      ? Colors.white
                      : const Color(0xff8c8c8c),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                Provider.of<menuController>(context, listen: false)
                    .navmenueSelect('Shop');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Shop()));
              });
            },
          ),
          const Divider(
            color: Color(0xff8c8c8c),
            thickness: 0.1,
          ),
          ListTile(
            title: Text(
              'BLOG',
              style: TextStyle(
                  color: Provider.of<menuController>(context, listen: false)
                              .menue ==
                          'Blog'
                      ? Colors.white
                      : const Color(0xff8c8c8c),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                Provider.of<menuController>(context, listen: false)
                    .navmenueSelect('Blog');
              });
            },
          ),
          const Divider(
            color: Color(0xff8c8c8c),
            thickness: 0.1,
          ),
          ListTile(
            title: Text(
              'ABOUT',
              style: TextStyle(
                  color: Provider.of<menuController>(context, listen: false)
                              .menue ==
                          'About'
                      ? Colors.white
                      : const Color(0xff8c8c8c),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                Provider.of<menuController>(context, listen: false)
                    .navmenueSelect('About');
              });
            },
          ),
          const Divider(
            color: Color(0xff8c8c8c),
            thickness: 0.1,
          ),
          ListTile(
            title: Text(
              'CONTACT',
              style: TextStyle(
                  color: Provider.of<menuController>(context, listen: false)
                              .menue ==
                          'Contact'
                      ? Colors.white
                      : const Color(0xff8c8c8c),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                Provider.of<menuController>(context, listen: false)
                    .navmenueSelect('Contact');
              });
            },
          ),
        ],
      ),
    );
  }
}
