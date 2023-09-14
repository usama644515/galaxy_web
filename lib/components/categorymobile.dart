import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                    Container(
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
                          child: SvgPicture.asset(
                              'assets/images/residential.svg',
                              width: 30.0,
                              color: iconcolor[0])),
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
                    Container(
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
                          child: SvgPicture.asset(
                              'assets/images/commercial.svg',
                              width: 30.0,
                              color: iconcolor[1])),
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
                    Container(
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
                          child: SvgPicture.asset('assets/images/plots.svg',
                              width: 30.0, color: iconcolor[2])),
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
                    Container(
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
                          child: SvgPicture.asset(
                              'assets/images/construction.svg',
                              width: 30.0,
                              color: iconcolor[3])),
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
