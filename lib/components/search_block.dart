import 'package:flutter/material.dart';

Widget SearchBlock(context) {
  return Positioned(
    top: MediaQuery.of(context).size.height * 0.35,
    left: 0,
    right: 0,
    child: Column(
      children: [
        const Text('Search Dream Properties for Sale in Multan',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(
          height: 12.0,
        ),
        const Text(
            'Buy/Rent Flats, Houses & Plots from the most reputable Real Estate Company in Multan',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: Colors.white)),
        const SizedBox(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: const Color(0xffF9A51F)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const TextField(
                cursorColor: Color(0xffF9A51F),
                decoration: InputDecoration(
                  hintText: 'Search Here',
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 5.0),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                height: 49,
                width: MediaQuery.of(context).size.width * 0.07,
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
            )
          ],
        ),
      ],
    ),
  );
}
