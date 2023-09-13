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
            child: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 25.0,
            )),
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
