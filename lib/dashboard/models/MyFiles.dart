import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage, collection;
  final int? numOfFiles, percentage;
  final Color? color;
  final Color? bgcolor;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
    this.bgcolor,
    this.collection,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: 'Listing',
    svgSrc: 'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fresidental.png?alt=media&token=1e871def-8d3d-418f-980f-b27fbf8bd5be&_gl=1*bcpi6p*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzI0OTYuMTguMC4w',
    bgcolor: Color(0xffFFFDE7),
    color: Color(0xffFFFDE7),
    percentage: 35,
    collection: 'main',
  ),
  CloudStorageInfo(
    title: "Residential",
    svgSrc: 'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fcommercial.png?alt=media&token=9f62f21a-0052-492a-b3ba-3ca5f1e0782d&_gl=1*xjlhsn*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzI5MDguNjAuMC4w',
    bgcolor: Color(0xffE3F2FD),
    color: Color(0xffFFF5D2),
    percentage: 35,
    collection: 'Residential',
  ),
  CloudStorageInfo(
      title: "Commercial",
      svgSrc: 'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fplots.png?alt=media&token=76f52bdd-9340-4ec3-8047-e7e9dd634bba&_gl=1*j4am2k*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzI5NTAuMTguMC4w',
      bgcolor: Color(0xffE8F5E9),
      color: Color(0xff6B78F1),
      percentage: 35,
      collection: 'Commercial'),
  CloudStorageInfo(
    title: "Plots",
    svgSrc: 'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fconstruction.png?alt=media&token=725d5135-4281-494d-b42c-5fe49f955e7b&_gl=1*fozzc6*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzI5ODguNjAuMC4w',
    bgcolor: Color(0xffF3E5F5),
    color: Color(0xff4FCB21),
    percentage: 35,
    collection: 'Plots',
  ),
];
