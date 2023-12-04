import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_web/dashboard/models/MyFiles.dart';

import '../../../constants.dart';

class FileInfoCard extends StatefulWidget {
  const FileInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final CloudStorageInfo info;

  @override
  State<FileInfoCard> createState() => _FileInfoCardState();
}

class _FileInfoCardState extends State<FileInfoCard> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int click = 0;
  var call = 0;
  var whatsapp = 0;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                color: widget.info.bgcolor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.network(
                  widget.info.svgSrc!,
                  width: 40,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<QuerySnapshot>(
                    // widget.info.collection.toString()
                    stream: widget.info.collection.toString() == 'Users'? firestore
                                .collection('AllUsers')
                                .snapshots():  widget.info.collection.toString() == 'main'
                        ? _auth.currentUser?.email == 'hanifusama688@gmail.com'
                            ? firestore.collection('Properties List').snapshots()
                            : firestore
                                .collection('Properties List')
                                .where('user', isEqualTo: _auth.currentUser?.uid)
                                .snapshots()
                        : _auth.currentUser?.email == 'hanifusama688@gmail.com'
                            ? firestore
                                .collection('Properties List')
                                .where('category',
                                    isEqualTo: widget.info.collection.toString())
                                .snapshots()
                            : firestore
                                .collection('Properties List')
                                .where('user', isEqualTo: _auth.currentUser?.uid)
                                .where('category',
                                    isEqualTo: widget.info.collection.toString())
                                .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return Text(
                          snapshot.data!.docs.length.toString(),
                          style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        );
                      }
                    }),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  widget.info.title!,
                  style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
