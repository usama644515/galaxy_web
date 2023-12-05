import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/components/search_screen.dart';
import 'package:galaxy_web/main/bottomBar.dart';

Widget MobileSearchBlock(context) {
  return Positioned(
    top: kIsWeb
        ? MediaQuery.of(context).size.height * 0.13
        : MediaQuery.of(context).size.height * 0.14,
    left: 0,
    right: 0,
    child: Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        children: [
          const Text(
            'Search Properties for Sale & Rent in Pakistan',
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          // const SizedBox(
          //   height: 7.0,
          // ),
          // const Text(
          //     'Buy/Rent Flats, Houses & Plots from the most reputable Real Estate Company in Multan',
          //     style: TextStyle(
          //         fontSize: 12.0,
          //         fontWeight: FontWeight.w400,
          //         color: Colors.white),textAlign: TextAlign.center,),
          const SizedBox(
            height: kIsWeb ? 15 : 30.0,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => kIsWeb ? SearchScreen() : Bar(ind: 2), ));
              context.go('/search');
            },
            child: Container(
              height: 49,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: const Color(0xffF9A51F)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Row(
                  children: [
                    Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fsearch.png?alt=media&token=c6c3edbc-ba62-42a0-9d6a-bd4e897a7573&_gl=1*4lwtm7*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzM5MTMuNjAuMC4w',
                      width: 20,
                    ),
                    const SizedBox(width: 9),
                    const Text('Search Properties...',
                        style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          kIsWeb ? SearchScreen() : Bar(ind: 2),
                    ));
              },
              child: Container(
                height: 49,
                width: MediaQuery.of(context).size.width * 0.3,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xffF9A51F),
                  // border: Border.all(color: const Color(0xffF9A51F)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                    child: Text('SEARCH',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white))),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
