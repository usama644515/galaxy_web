import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:provider/provider.dart';

import '../main/shop.dart';

class CategoryMobile extends StatefulWidget {
  const CategoryMobile({super.key});

  @override
  State<CategoryMobile> createState() => _CategoryMobileState();
}

class _CategoryMobileState extends State<CategoryMobile> {
  var category = ['Residential', 'Commercial', 'Plots', 'Construction'];
  var iconcolor = [
    Color(0xffF5CD7A),
    Color(0xff8DCDF5),
    Color(0xff75C19A),
    Color(0xff6D7FBE)
  ];
  var backcolor = [
    Colors.yellow.shade50,
    Colors.blue.shade50,
    Colors.green.shade50,
    Colors.purple.shade50
  ];
  var itemhover = [false, false, false, false];
  var description = [
    'Home sweet home,\nresidential bliss.',
    'Business thrives,\nopportunities arise.',
    'Plots is Blank \ncanvas for dreams.',
    'Building our future,\none brick at a time'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 15, right: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) {
                  setState(() {
                    itemhover[0] = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    itemhover[0] = false;
                  });
                },
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Provider.of<menuController>(context, listen: false)
                            .navmenueSelect('Shop');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Shop(categ: 'Residential')));
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: backcolor[0],
                            border: Border.all(
                                color: itemhover[0]
                                    ? iconcolor[0]
                                    : Colors.transparent,
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fresidental.png?alt=media&token=1e871def-8d3d-418f-980f-b27fbf8bd5be&_gl=1*1ctcjxs*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzMxMjMuNjAuMC4w',
                        width: 30,
                      ),),
                      ),
                    ),
                    const SizedBox(
                      width: 13.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category[0],
                          style: TextStyle(
                              color: itemhover[0] ? iconcolor[0] : Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) {
                  setState(() {
                    itemhover[1] = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    itemhover[1] = false;
                  });
                },
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Provider.of<menuController>(context, listen: false)
                            .navmenueSelect('Shop');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Shop(categ: 'Commercial')));
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: backcolor[1],
                            border: Border.all(
                                color: itemhover[1]
                                    ? iconcolor[1]
                                    : Colors.transparent,
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fcommercial.png?alt=media&token=9f62f21a-0052-492a-b3ba-3ca5f1e0782d&_gl=1*rvrbwx*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzMxNDUuMzguMC4w',
                        width: 30,
                      ),),
                      ),
                    ),
                    const SizedBox(
                      width: 13.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category[1],
                          style: TextStyle(
                              color: itemhover[1] ? iconcolor[1] : Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) {
                  setState(() {
                    itemhover[2] = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    itemhover[2] = false;
                  });
                },
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Provider.of<menuController>(context, listen: false)
                            .navmenueSelect('Shop');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Shop(categ: 'Plots')));
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: backcolor[2],
                            border: Border.all(
                                color: itemhover[2]
                                    ? iconcolor[2]
                                    : Colors.transparent,
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fplots.png?alt=media&token=76f52bdd-9340-4ec3-8047-e7e9dd634bba&_gl=1*e34xtl*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzMxNjMuMjAuMC4w',
                        width: 30,
                      ),),
                      ),
                    ),
                    const SizedBox(
                      width: 13.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category[2],
                          style: TextStyle(
                              color: itemhover[2] ? iconcolor[2] : Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) {
                  setState(() {
                    itemhover[3] = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    itemhover[3] = false;
                  });
                },
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Provider.of<menuController>(context, listen: false)
                            .navmenueSelect('Shop');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Shop(categ: 'Construction')));
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: backcolor[3],
                            border: Border.all(
                                color: itemhover[3]
                                    ? iconcolor[3]
                                    : Colors.transparent,
                                width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fconstruction.png?alt=media&token=725d5135-4281-494d-b42c-5fe49f955e7b&_gl=1*1ag9h1j*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzMxODIuMS4wLjA.',
                        width: 30,
                      ),),
                      ),
                    ),
                    const SizedBox(
                      width: 13.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category[3],
                          style: TextStyle(
                              color: itemhover[3] ? iconcolor[3] : Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
