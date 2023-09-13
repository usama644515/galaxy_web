import 'package:flutter/material.dart';

Widget MobileSearchBlock(context) {
  return Positioned(
    top: MediaQuery.of(context).size.height * 0.13,
    left: 0,
    right: 0,
    child: Padding(
      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
      child: Column(
        children: [
          const Text('Search Properties for Sale in Multan',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),textAlign: TextAlign.center,),
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
            height: 15.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 5),
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
          const SizedBox(
            height: 10.0,
          ),
          MouseRegion(
                cursor: SystemMouseCursors.click,
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
              )
        ],
      ),
    ),
  );
}