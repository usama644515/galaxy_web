import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/responsive.dart';
import 'package:galaxy_web/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../controllers/MenuController.dart';
import 'product_details.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: Responsive.isMobile(context) ? 20 : 50.0,
              right: Responsive.isMobile(context) ? 20 : 50.0,
              top: 5.0),
          child: SizedBox(
            height: Responsive.isMobile(context) ? 240 : 350,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore
                  .instance //------for select the item in the firestore----
                  .collection('Properties List')
                  // .where('status', isEqualTo: 'Live')
                  // .where('status', isEqualTo: 'Active')
                  .orderBy('datetime', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      child: const CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          color: Color(0xffF9A51F)));
                } else if (snapshot.data!.docs.length == 0) {
                  return Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text('No Data Foulnd'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length > 10
                        ? 10
                        : snapshot.data!.docs.length,
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController, // Attach ScrollController
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      DocumentSnapshot data = snapshot.data!.docs[index];
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            getClick(data.id);
                            Provider.of<menuController>(context, listen: false)
                                .navmenueSelect('Shop');
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             ProductDetails(data: data,id: data.id)));
                            var id = data.id;
                            // Replace with the actual value
                            // RouteHandler.router
                            //     .navigateTo(context, '/shop/$id');
                            context.go(
                                        Uri(
                                          path: '/shop/$id',
                                          queryParameters: {'id': id},
                                        ).toString(),
                                      );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, top: 20.0, bottom: 10),
                                child: CachedNetworkImage(
                                  imageUrl: data.get(
                                      'img')[0], // Replace with your image URL
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
                                  data.get('title'),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              SizedBox(
                                width: Responsive.isMobile(context) ? 200 : 310,
                                child: Text(
                                  data.get('location'),
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
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
        Responsive.isMobile(context)
            ? const SizedBox()
            : Positioned(
                top: 110,
                right: 30.0,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      scrollToPosition();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffF9A51F)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Farrow%20right.png?alt=media&token=872830ea-971e-41c7-bb4d-a6cb6241a691&_gl=1*1yv5bxu*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzM3NzkuMjguMC4w',
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        Responsive.isMobile(context)
            ? const SizedBox()
            : Positioned(
                top: 110,
                left: 30.0,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      scrollreverse();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffF9A51F)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Farrow%20left.png?alt=media&token=4f23b9ce-7c61-4223-940c-ea3f5bd14c24&_gl=1*1k048es*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzUzMjQ1NC4zMy4xLjE2OTc1MzM3NDcuNjAuMC4w',
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  getClick(var id) {
    FirebaseFirestore.instance.collection('Properties List').doc(id).set({
      'clicks': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  var toIndex = 1;
  var toIndexreverse = 1;
  // Method to scroll to the next item in the ListView
  void scrollToPosition() {
    toIndex++;
    _scrollController.animateTo(
      toIndex * 100.0, // Replace 50.0 with the height of your list items
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void scrollreverse() {
    toIndex++;
    _scrollController.animateTo(
      toIndexreverse *
          -100.0, // Replace 50.0 with the height of your list items
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
