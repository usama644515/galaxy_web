import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget MobileNavBar(var drawerstate) {
  return Stack(
    children: [
      Positioned(
        left: 15.0,
        top: 15.0,
        child: GestureDetector(
          onTap: () {
            drawerstate.currentState?.openDrawer();
          },
          child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fmenu.png?alt=media&token=cbd3cf6f-cc56-4049-a039-c2ee02a4d6e8&_gl=1*q9vn4g*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzQxNDAuNDYuMC4w',
            width: 25,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/galaxy%20logo%20w-011.png?alt=media&token=c99628aa-543a-4440-b4a9-209cdfece996',
              fit: BoxFit.cover,
              width: 150,
            ),
          ],
        ),
      ),
      Positioned(
        right: 10.0,
        top: 15.0,
        child: GestureDetector(
          onTap: () {
            _launchPhone('923000335875');
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
                height: 30,
                width: 115,
                decoration: BoxDecoration(
                    color: const Color(0xffF9A51F),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fphone%20icon%20white.png?alt=media&token=a7859ee1-775e-4184-bee3-784022426a16&_gl=1*xlwa8r*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODMwMTE3Ni41OS4xLjE2OTgzMDExOTQuNDIuMC4w',
                      width: 14,
                    ),
                    const SizedBox(width: 4.0),
                    const Text(
                      '0300-0335875',
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ))),
          ),
        ),
      )
    ],
  );
}

void _launchPhone(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
