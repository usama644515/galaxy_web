import 'package:flutter/material.dart';

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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Head Office',
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
                      child: Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Color(0xffBDBDBD), size: 20.0),
                          SizedBox(width: 10.0),
                          Text(
                            'Buch Executive Villas, Multan, Pakistan',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xffBDBDBD),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          Icon(Icons.phone,
                              color: Color(0xffBDBDBD), size: 20.0),
                          SizedBox(width: 10.0),
                          Text(
                            '0300-0335875 \n0301-1285988',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xffBDBDBD),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          Icon(Icons.email,
                              color: Color(0xffBDBDBD), size: 20.0),
                          SizedBox(width: 10.0),
                          Text(
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
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/social%20media%20logo%2Fpngwing.com%20(1).png?alt=media&token=c3a47eda-c909-4424-9150-400cdf2b7db0',
                            width: 33.0,
                          ),
                        ),
                        const SizedBox(
                          width: 11.0,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/social%20media%20logo%2Finstagram.png?alt=media&token=0108cb55-c1fc-44a4-b306-3bb7503d06ac',
                            width: 33.0,
                          ),
                        ),
                        const SizedBox(
                          width: 11.0,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/social%20media%20logo%2Fyoutube.png?alt=media&token=d6efd871-aa3e-4c96-8f6b-3c6229da8be6',
                            width: 33.0,
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
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/social%20media%20logo%2Ftwitter.png?alt=media&token=c94b8483-a090-40e4-a862-8497c9e1b905',
                            width: 33.0,
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
}
