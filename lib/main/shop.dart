import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/footer.dart';
import '../components/footer_mobile.dart';
import '../components/mobile_navbar.dart';
import '../components/navbar.dart';
import '../components/side_drawer.dart';
import '../responsive.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  var filter = ['Buch Executive Villas', 'DHA Multan', 'Citi Housing'];
  var loader = true;
  List<Map<String, dynamic>> data = [];
  getData() {
    FirebaseFirestore.instance
        .collection('Properties List')
        .get()
        .then((value) {
      setState(() {
        data = value.docs.map((DocumentSnapshot doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
        loader = false;
      });
      // Provider.of<menuController>(context, listen: true).PropertiesList(data);
      // print(data);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      key: scaffoldKey,
      drawer: const SideDrawer(),
      body: ListView(children: [
        Stack(
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.black),
            ),
            Responsive.isMobile(context)
                ? MobileNavBar(scaffoldKey)
                : const NavBar(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 30,
              left: Responsive.isMobile(context) ? 20 : 50.0,
              right: Responsive.isMobile(context) ? 20 : 50.0),
          child: Text(
            "Shop",
            style: TextStyle(
                fontSize: Responsive.isMobile(context) ? 25.0 : 30.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20),
            child: ListView.builder(
              itemCount: filter.length,
              // snapshot.data!.docs.length > 10
              //     ? 10
              //     : snapshot.data!.docs.length,
              scrollDirection: Axis.horizontal,
              // controller: _scrollController, // Attach ScrollController
              itemBuilder: (
                context,
                index,
              ) {
                // DocumentSnapshot data =
                //     snapshot.data!.docs[index];
                return Filter(data: filter[index]);
              },
            ),
          ),
        ),
        loader
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xffF9A51F)))
            : Padding(
                padding: EdgeInsets.only(
                    left: Responsive.isMobile(context) ? 20 : 40.0,
                    right: Responsive.isMobile(context) ? 20 : 40.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isMobile(context)
                        ? 2
                        : 4, // Number of columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                    crossAxisSpacing: 10.0, // Spacing between columns
                    childAspectRatio: Responsive.isMobile(context)
                        ? 0.68
                        : 1.0, // Width to height ratio of each grid item
                  ),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Build each grid item
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 15.0, top: 20.0, bottom: 10),
                            child: CachedNetworkImage(
                              imageUrl: data[index]
                                  ['img'], // Replace with your image URL
                              imageBuilder: (context, imageProvider) =>
                                  ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set the radius here
                                child: Image(
                                  image: imageProvider,
                                  width: Responsive.isMobile(context)
                                      ? 200
                                      : 310, // Set the desired width
                                  height: Responsive.isMobile(context)
                                      ? 100
                                      : 170, // Set the desired height
                                  fit: BoxFit.cover,
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                      color: Color(0xffF9A51F))),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          SizedBox(
                            width: Responsive.isMobile(context) ? 200 : 310,
                            child: Text(
                              data[index]['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          SizedBox(
                            width: Responsive.isMobile(context) ? 200 : 310,
                            child: Text(
                              data[index]['location'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.home_work_outlined,
                                color: Colors.grey,
                                size: 15.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              const Text(
                                "House",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 25.0,
                              ),
                              const Icon(
                                Icons.height,
                                color: Colors.grey,
                                size: 15.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                data[index]['size'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
        const SizedBox(
          height: 25,
        ),
        Responsive.isMobile(context) ? const FooterMobile() : const Footer(),
      ]),
    );
  }
}

class Filter extends StatefulWidget {
  const Filter({super.key, this.data});
  final data;
  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var hover = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() {
            hover = true;
          });
        },
        onExit: (_) {
          setState(() {
            hover = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: hover ? const Color(0xffF9A51F) : Colors.grey),
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: Center(
              child: Text(widget.data,
                  style: TextStyle(
                    color: hover ? const Color(0xffF9A51F) : Colors.black,
                    fontSize: 17.0,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
