import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage, collection;
  final int? numOfFiles, percentage;
  final Color? color;
  final Color? bgcolor;
  final check;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
    this.bgcolor,
    this.collection,
    this.check,
  });
}

final FirebaseAuth _auth = FirebaseAuth.instance;
List demoMyFiles = [
  CloudStorageInfo(
    title: 'Listing',
    svgSrc:
        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fresidental.png?alt=media&token=1e871def-8d3d-418f-980f-b27fbf8bd5be&_gl=1*bcpi6p*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzI0OTYuMTguMC4w',
    bgcolor: const Color(0xffFFFDE7),
    color: const Color(0xffFFFDE7),
    percentage: 35,
    collection: 'main',
    check: false,
  ),
  CloudStorageInfo(
    title: "Residential",
    svgSrc:
        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fcommercial.png?alt=media&token=9f62f21a-0052-492a-b3ba-3ca5f1e0782d&_gl=1*xjlhsn*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzI5MDguNjAuMC4w',
    bgcolor: const Color(0xffE3F2FD),
    color: const Color(0xffFFF5D2),
    percentage: 35,
    collection: 'Residential',
    check: false,
  ),
  CloudStorageInfo(
    title: "Commercial",
    svgSrc:
        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fplots.png?alt=media&token=76f52bdd-9340-4ec3-8047-e7e9dd634bba&_gl=1*j4am2k*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzI5NTAuMTguMC4w',
    bgcolor: const Color(0xffE8F5E9),
    color: const Color(0xff6B78F1),
    percentage: 35,
    collection: 'Commercial',
    check: false,
  ),
  CloudStorageInfo(
    title: "Plots",
    svgSrc:
        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fconstruction.png?alt=media&token=725d5135-4281-494d-b42c-5fe49f955e7b&_gl=1*fozzc6*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzI5ODguNjAuMC4w',
    bgcolor: const Color(0xffF3E5F5),
    color: const Color(0xff4FCB21),
    percentage: 35,
    collection: 'Plots',
    check: false,
  ),
  CloudStorageInfo(
    title: "Flats",
    svgSrc:
        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fflat.png?alt=media&token=b4b18e02-1bb4-40be-8955-ac091923d91c&_gl=1*1jn184*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5OTQyNTM3Ni44Ni4xLjE2OTk0MjU0MDYuMzAuMC4w',
    bgcolor: Colors.red.withOpacity(0.2),
    color: const Color(0xff4FCB21),
    percentage: 35,
    collection: 'Flats',
    check: false,
  ),
  if (_auth.currentUser?.email == 'hanifusama688@gmail.com')
    CloudStorageInfo(
      title: "Users",
      svgSrc:
          'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fusers.png?alt=media&token=f894e66a-22b5-460a-802c-64285ae3498f',
      bgcolor: const Color.fromARGB(255, 243, 58, 33).withOpacity(0.2),
      color: const Color(0xff4FCB21),
      percentage: 35,
      collection: 'Users',
      check: false,
    ),
  // CloudStorageInfo(
  //   title: "Impressions",
  //   svgSrc:
  //       'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fimpression.png?alt=media&token=0fdaffce-aaf9-45b4-9006-6ca11c706ee7&_gl=1*1i564sl*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5OTUxNzY2MS45Mi4xLjE2OTk1MTc3NTIuMzAuMC4w',
  //   bgcolor: Colors.blue.withOpacity(0.2),
  //   color: const Color(0xff4FCB21),
  //   percentage: 35,
  //   collection: 'Flats',
  //   check: false,
  // ),
  CloudStorageInfo(
    title: "Clicks",
    svgSrc:
        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fclick.png?alt=media&token=dbd5943f-5292-4dc9-9d47-aa54c9820d45&_gl=1*tb6j5b*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5OTUxNzY2MS45Mi4xLjE2OTk1MTc3MjAuMS4wLjA.',
    bgcolor: Colors.yellow.withOpacity(0.2),
    color: const Color(0xff4FCB21),
    percentage: 35,
    collection: 'Flats',
    check: true,
  ),
  CloudStorageInfo(
    title: "Call",
    svgSrc:
        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fcall%20color.png?alt=media&token=02b1e950-e2a2-4981-8ab7-d3bf1428f077&_gl=1*163vs6n*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5OTUxNzY2MS45Mi4xLjE2OTk1MTc2ODMuMzguMC4w',
    bgcolor: Colors.orange.withOpacity(0.2),
    color: const Color(0xff4FCB21),
    percentage: 35,
    collection: 'Flats',
    check: true,
  ),
  CloudStorageInfo(
    title: "Whatsapp",
    svgSrc:
        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fwhatsapp%20icon.png?alt=media&token=0c59daba-322a-4cb3-b9ed-2f65dede9ea2&_gl=1*1tpr174*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODMyMDU2NC42Mi4xLjE2OTgzMjA3MjYuMzIuMC4w',
    bgcolor: Colors.green.withOpacity(0.2),
    color: const Color(0xff4FCB21),
    percentage: 35,
    collection: 'Flats',
    check: true,
  ),
];
