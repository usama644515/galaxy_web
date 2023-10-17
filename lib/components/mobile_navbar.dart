import 'package:flutter/material.dart';

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
      )
    ],
  );
}
