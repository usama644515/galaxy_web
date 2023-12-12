import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:galaxy_web/controllers/image_viewer.dart';

class AgencyScreenMobile extends StatefulWidget {
  const AgencyScreenMobile({super.key, this.data});
  final data;
  @override
  State<AgencyScreenMobile> createState() => _AgencyScreenMobileState();
}

class _AgencyScreenMobileState extends State<AgencyScreenMobile> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _message = '';
  bool _isHovered = false;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            // shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.data['img']),
                            ),
                          ),
                        ),
                        const SizedBox(
                              height: 12.0,
                            ),
                        Text(
                              widget.data['Name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 23.0, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Flocation%20icon.png?alt=media&token=0a3ac270-0c1a-4cd9-aee8-8acab0afb3cb',
                                    width: 20.0),
                                const SizedBox(width: 5.0),
                                Text(
                                  '${widget.data['city']}, Pakistan',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            StreamBuilder<QuerySnapshot>(
                                // widget.info.collection.toString()
                                stream: FirebaseFirestore.instance
                                    .collection('Properties List')
                                    .where('user',
                                        isEqualTo: widget.data['UID'])
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  } else {
                                    return Text(
                                      'Properties: ${snapshot.data!.docs.length.toString()}',
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    );
                                  }
                                }),
                                const SizedBox(
                              height: 20.0,
                            ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 10.0),
                          child: Text(
                            'About ${widget.data['Name']}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.text,
                            child: ExpandableText(
                              widget.data['description'],
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.justify,
                              expandText: 'Show More',
                              collapseText: 'Show Less',
                              linkColor: const Color(0xffF9A51F),
                              maxLines:
                                  5, // Adjust the maximum number of lines to show initially
                              expanded: _isExpanded,
                              onExpandedChanged: (isExpanded) {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _isExpanded = false;
}
