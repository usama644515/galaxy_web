import 'package:flutter/material.dart';

class FooterMobile extends StatefulWidget {
  const FooterMobile({super.key});

  @override
  State<FooterMobile> createState() => _FooterMobileState();
}

class _FooterMobileState extends State<FooterMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      decoration: const BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
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
                const SizedBox(
                  width: 11.0,
                ),
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
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: const Text(
                  '© Copyright 2023 Galaxy Realtors Builders. All Rights Reserved',
                  style: TextStyle(fontSize: 15.0, color: Color(0xff707070))),
            )
          ],
        ),
      ),
    );
  }
}
