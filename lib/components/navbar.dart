import 'package:flutter/material.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

var homehover = false;
var shophover = false;
var bloghover = false;
var abouthover = false;
var contacthover = false;

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      // decoration: BoxDecoration(),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10.0),
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/galaxy%20logo%20w-011.png?alt=media&token=c99628aa-543a-4440-b4a9-209cdfece996',
              fit: BoxFit.cover,
              width: 170,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('Home');
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      setState(() {
                        homehover = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        homehover = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Provider.of<menuController>(context,
                                          listen: false)
                                      .menue ==
                                  'Home'
                              ? const Color(0xffF9A51F)
                              : Colors.transparent,
                          border: Border.all(
                            color: homehover
                                ? const Color(0xffF9A51F)
                                : Colors.transparent,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15, top: 5, bottom: 5.0),
                        child: Text('HOME',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('Shop');
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      setState(() {
                        shophover = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        shophover = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Provider.of<menuController>(context,
                                          listen: false)
                                      .menue ==
                                  'Shop'
                              ? const Color(0xffF9A51F)
                              : Colors.transparent,
                          border: Border.all(
                            color: shophover
                                ? const Color(0xffF9A51F)
                                : Colors.transparent,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15, top: 5, bottom: 5.0),
                        child: Text('SHOP',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('Blog');
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      setState(() {
                        bloghover = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        bloghover = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Provider.of<menuController>(context,
                                          listen: false)
                                      .menue ==
                                  'Blog'
                              ? const Color(0xffF9A51F)
                              : Colors.transparent,
                          border: Border.all(
                            color: bloghover
                                ? const Color(0xffF9A51F)
                                : Colors.transparent,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15, top: 5, bottom: 5.0),
                        child: Text('BLOG',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('About');
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      setState(() {
                        abouthover = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        abouthover = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Provider.of<menuController>(context,
                                          listen: false)
                                      .menue ==
                                  'About'
                              ? const Color(0xffF9A51F)
                              : Colors.transparent,
                          border: Border.all(
                            color: abouthover
                                ? const Color(0xffF9A51F)
                                : Colors.transparent,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15, top: 5, bottom: 5.0),
                        child: Text('ABOUT',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<menuController>(context, listen: false)
                        .navmenueSelect('Contact');
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) {
                      setState(() {
                        contacthover = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        contacthover = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Provider.of<menuController>(context,
                                          listen: false)
                                      .menue ==
                                  'Contact'
                              ? const Color(0xffF9A51F)
                              : Colors.transparent,
                          border: Border.all(
                            color: contacthover
                                ? const Color(0xffF9A51F)
                                : Colors.transparent,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15, top: 5, bottom: 5.0),
                        child: Text('CONTACT',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
              top: 10,
              right: 10.0,
              child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 35.0,
                  )))
        ],
      ),
    );
  }
}
