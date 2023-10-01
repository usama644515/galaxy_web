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
    return Container(
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xffF9A51F),
            const Color(0xffF9A51F).withOpacity(0.9)
          ], // Define your gradient colors
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text(
            'Why Galaxy Realtors Builders?',
            style: TextStyle(
                fontSize: Responsive.isMobile(context)? 26 :30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
                textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15.0,
          ),
           Text(
            'Choose Galaxy Realtors Builders for their commitment to quality craftsmanship, innovative designs, and a proven track record of delivering exceptional homes.',
            style: TextStyle(
                fontSize: Responsive.isMobile(context)? 12.0: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) {
                  setState(() {
                    explorebtn = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    explorebtn = false;
                  });
                },
                child: Container(
                    height: 45,
                    width: 120,
                    decoration: BoxDecoration(
                        color: explorebtn
                            ?  const Color.fromARGB(255, 36, 34, 34)
                            : Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                        child: Text(
                      'Explore Now',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ))),
              ),
              const SizedBox(
            width: 15.0,
          ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) {
                  setState(() {
                    contactbtn = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    contactbtn = false;
                  });
                },
                child: GestureDetector(
                  onTap:(){
                    _launchPhone('+923000335875');
                  },
                  child: Container(
                      height: 45,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 2.0),
                          color: contactbtn
                              ? Colors.black: Colors.transparent,
                          borderRadius: BorderRadius.circular(5)),
                      child:  Center(
                          child: Text(
                        'Contact Now',
                        style: TextStyle(
                            fontSize: 16.0,
                            color:contactbtn? Colors.white :Colors.black,
                            fontWeight: FontWeight.w600),
                      ))),
                ),
              ),
            ],
          ),
        ]),
      ),
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
