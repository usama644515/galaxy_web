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
    title: "Orders",
    svgSrc: "assets/svg/order icon.svg",
    bgcolor: Color(0xffFFD2D2),
    color: Color(0xffF46969),
    percentage: 35,
    collection: 'Order',
  ),
  CloudStorageInfo(
    title: "Users",
    svgSrc: "assets/svg/new signups.svg",
    bgcolor: Color(0xffFFF5D2),
    color: Color(0xffEAB91F),
    percentage: 35,
    collection: 'Users',
  ),
  CloudStorageInfo(
      title: "Stores",
      svgSrc: "assets/svg/rider.svg",
      bgcolor: Color(0xffE9EBFF),
      color: Color(0xff6B78F1),
      percentage: 35,
      collection: 'Store'),
  CloudStorageInfo(
    title: "Products",
    svgSrc: "assets/svg/product icon.svg",
    bgcolor: Color(0xffE3FFD9),
    color: Color(0xff4FCB21),
    percentage: 35,
    collection: 'Products',
  ),
];
