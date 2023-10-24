import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/components/add_product_store.dart';
import 'package:galaxy_web/components/contactUs.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:provider/provider.dart';

import '../main/about_us.dart';
import '../main/home.dart';
import '../main/shop.dart';
import '../welcome/signin.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
                child: _auth.currentUser == null
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()));
                        },
                        child: Container(
                          width: 115,
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: const Center(
                            child: Text('LOGIN',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap:(){
                               signOutWithConfirmation(context);
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${_auth.currentUser?.photoURL}'), // Replace with your image path
                                    fit: BoxFit
                                        .cover, // You can adjust the fit as needed
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddProductStore()));
                              },
                              child: Container(
                                  height: 35,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF9A51F),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                      child: Text(
                                    'Create Listing',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ))),
                            ),
                          ),
                        ],
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
                  (route) => false, // Always return false to remove all routes
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
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const AboutUs()),
                  (route) => false, // Always return false to remove all routes
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
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const ContactUs()),
                  (route) => false, // Always return false to remove all routes
                );
              });
            },
          ),
        ],
      ),
    );
  }

  void signOutWithConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Sign Out"),
          content: Text("Are you sure you want to sign out?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Sign Out"),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(dialogContext).pop(); // Close the dialog
                  // You can navigate to the login screen or another screen here.
                } catch (e) {
                  print("Error signing out: $e");
                  // Handle sign-out error, e.g., show a snackbar
                }
              },
            ),
          ],
        );
      },
    );
  }
}
