import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

class FooterMobile extends StatefulWidget {
  const FooterMobile({super.key});

  @override
  State<FooterMobile> createState() => _FooterMobileState();
}

class _FooterMobileState extends State<FooterMobile> {
  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            decoration: const BoxDecoration(color: Colors.black),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Get Connected',
                    style: TextStyle(
                        fontSize: 21.0,
                        color: Color(0xffBDBDBD),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            _openUrlInNewTab(
                                'https://www.facebook.com/pretorianrealtorsbuilder?mibextid=ZbWKwL');
                          },
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/social%20media%20logo%2Fpngwing.com%20(1).png?alt=media&token=c3a47eda-c909-4424-9150-400cdf2b7db0',
                            width: 33.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 11.0,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            _openUrlInNewTab(
                                'https://www.instagram.com/pretorianrealtorsbuilder/');
                          },
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/social%20media%20logo%2Finstagram.png?alt=media&token=0108cb55-c1fc-44a4-b306-3bb7503d06ac',
                            width: 33.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 11.0,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            _openUrlInNewTab(
                                'https://www.youtube.com/@Pretorianrealtorsbuilder');
                          },
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/social%20media%20logo%2Fyoutube.png?alt=media&token=d6efd871-aa3e-4c96-8f6b-3c6229da8be6',
                            width: 33.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 11.0,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            _openUrlInNewTab(
                                'https://www.tiktok.com/@pretorianrealtorsbuilder');
                          },
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Ftik-tok.png?alt=media&token=a79765b5-c0b4-416d-9a9d-4930fdd74caf&_gl=1*1cg7ddv*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODQ5MDM0OC42Ni4xLjE2OTg0OTE5MTAuMTIuMC4w',
                            width: 33.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 11.0,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/social%20media%20logo%2Flinkedin.png?alt=media&token=a63b4de0-2167-470c-8c78-72a8633f23d5',
                          width: 33.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: const Text(
                        '© Copyright 2023 Pretorian Realtors Builders. All Rights Reserved',
                        style: TextStyle(
                            fontSize: 15.0, color: Color(0xff707070))),
                  )
                ],
              ),
            ),
          )
        : SizedBox();
  }

  void _openUrlInNewTab(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
