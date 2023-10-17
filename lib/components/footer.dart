import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350.0,
      decoration: const BoxDecoration(color: Color(0xff1F1F1F)),
      child: Padding(
        padding: const EdgeInsets.only(left: 60.0, right: 100.0, top: 40.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.27,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/galaxy%20logo%20w-011.png?alt=media&token=c99628aa-543a-4440-b4a9-209cdfece996',
                        fit: BoxFit.cover,
                        width: 200,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'Galaxy Realtors and Builders is a reputable real estate company recognized for its excellence in residential and commercial property development. Renowned for their commitment to quality and customer satisfaction, they have consistently delivered exceptional projects in their region, establishing themselves as a trusted name in the real estate industry.',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xffBDBDBD),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Links',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xffBDBDBD),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        'Home',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xffBDBDBD),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        'Shop',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xffBDBDBD),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        'Blog',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xffBDBDBD),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xffBDBDBD),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        'About Us',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xffBDBDBD),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Head Office',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xffBDBDBD),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Flocation.png?alt=media&token=a24c6ae4-7899-4431-aa88-79dc0b4980d3&_gl=1*1qgyu3l*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzQ2MDEuMS4wLjA.',
                            width: 20,
                          ),
                          const SizedBox(width: 10.0),
                          const Text(
                            'Buch Executive Villas, Multan, Pakistan',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xffBDBDBD),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fphone.png?alt=media&token=327a739a-ae0f-4980-8506-298582ffaf8d&_gl=1*l2ey4*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzQ3MTkuOS4wLjA.',
                            width: 20,
                          ),
                          const SizedBox(width: 10.0),
                          const Text(
                            '0300-0335875 \n0301-1285988',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xffBDBDBD),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Femail%20icon.png?alt=media&token=240c5b3c-7b95-4937-adb7-5cd10e496a4d&_gl=1*13gnddf*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzQ2NjUuMi4wLjA.',
                            width: 20,
                          ),
                          const SizedBox(width: 10.0),
                          const Text(
                            'galaxyrealtorsbuilders.com',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xffBDBDBD),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Get Connected',
                      style: TextStyle(
                          fontSize: 18.0,
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
                                  'https://www.facebook.com/galaxyrealtorsandbuilders');
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
                                  'https://www.instagram.com/galaxyrealtorbuilders/');
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
                                  'https://youtube.com/@galaxyrealtorsbuilders3129?si=YTrm5RzKtMvvtU7f');
                            },
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/social%20media%20logo%2Fyoutube.png?alt=media&token=d6efd871-aa3e-4c96-8f6b-3c6229da8be6',
                              width: 33.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              _openUrlInNewTab(
                                  'https://www.tiktok.com/@galaxyrealtorsbuilders75?is_from_webapp=1&sender_device=pc');
                            },
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/social%20media%20logo%2Ftwitter.png?alt=media&token=c94b8483-a090-40e4-a862-8497c9e1b905',
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
                        const SizedBox(
                          width: 11.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 25.0,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '© Copyright 2023 Galaxy Realtors Builders. All Rights Reserved',
                    style: TextStyle(fontSize: 15.0, color: Color(0xff707070)))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openUrlInNewTab(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
