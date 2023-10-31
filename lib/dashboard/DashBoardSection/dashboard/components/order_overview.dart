
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:galaxy_web/responsive.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class OrderOverview extends StatelessWidget { OrderOverview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Overview',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap:(){
                
                  },
                  child: Text('View Details',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Color(0xff00ACFF),
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      )),
                ),
              )
            ],
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Responsive(
            mobile: OrderViewGridView(
              crossAxisCount: _size.width <= 438
                  ? 2
                  : _size.width <= 610
                      ? 3
                      : 4,
              childAspectRatio: _size.width <= 458 ? 1.7 : 1.8,
            ),
            tablet: OrderViewGridView(crossAxisCount: 2, childAspectRatio: 1.9),
            desktop: OrderViewGridView(
              crossAxisCount: 2,
              childAspectRatio: _size.width < 1400 ? 1.9 : 2,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderViewGridView extends StatefulWidget {
  OrderViewGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<OrderViewGridView> createState() => _OrderViewGridViewState();
}

class _OrderViewGridViewState extends State<OrderViewGridView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 7,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) => orderOverViewItem(
          orderviewData[index]['iconColor'],
          orderviewData[index]['title'],
          orderviewData[index]['bgcolor'],
          orderviewData[index]['svgpath'],
          orderviewData[index]['orderStatus'],
          ),
          
    );
  }

  Widget orderOverViewItem(var iconColor, var title, var bgColor, var svgpath,var status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(bgColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                SvgPicture.asset(svgpath, color: Color(iconColor), width: 15.0),
          ),
        ),
        SizedBox(width: 5.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('Order').where('status',isEqualTo: status).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return Text(
                      snapshot.data!.docs.length.toString(),
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    );
                  }
                }),
            SizedBox(
              height: 5.0,
            ),
            SizedBox(
              width: 60,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }

  var orderviewData = [
    {
      'title': 'Pending',
      'bgcolor': 0xffECECEC,
      'iconColor': 0xffA4A4A4,
      'svgpath': 'assets/svg/awaiting.svg',
      'orderStatus': 'Pending'
    },
    {
      'title': 'Accepted',
      'bgcolor': 0xffE3FFD9,
      'iconColor': 0xff4FCB21,
      'svgpath': 'assets/svg/accepeted.svg',
      'orderStatus': 'Accepted'
    },
    {
      'title': 'Ready to Ship',
      'bgcolor': 0xffE9EBFF,
      'iconColor': 0xff6B78F1,
      'svgpath': 'assets/svg/ready to ship.svg',
      'orderStatus': 'Ready to Ship'
    },
    {
      'title': 'Cancelled',
      'bgcolor': 0xffFFD2D2,
      'iconColor': 0xffF46969,
      'svgpath': 'assets/svg/cancel.svg',
      'orderStatus': 'Cancelled'
    },
    {
      'title': 'Failed',
      'bgcolor': 0xffD1F9FF,
      'iconColor': 0xff14C5DF,
      'svgpath': 'assets/svg/failed.svg',
      'orderStatus': 'Failed'
    },
    {
      'title': 'Returned',
      'bgcolor': 0xffF7E1FF,
      'iconColor': 0xffE85EE2,
      'svgpath': 'assets/svg/returned.svg',
      'orderStatus': 'Returned'
    },
    {
      'title': 'Shipped',
      'bgcolor': 0xffFFF5D2,
      'iconColor': 0xffEAB91F,
      'svgpath': 'assets/svg/shipped.svg',
      'orderStatus': 'Shipped'
    },
  ];
}
