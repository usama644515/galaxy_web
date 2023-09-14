import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/responsive.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:  EdgeInsets.only(left:Responsive.isMobile(context)? 20: 50.0, right:Responsive.isMobile(context)? 20: 50.0, top: 5.0),
          child: SizedBox(
            height: 350,
            child:
                //  StreamBuilder<QuerySnapshot>(
                //   stream:
                //       firestore //------for select the item in the firestore----
                //           .collection('Products')
                //           .where('status', isEqualTo: 'Live')
                //           .orderBy('rating', descending: true)
                //           .snapshots(),
                //   builder: (BuildContext context,
                //       AsyncSnapshot<QuerySnapshot> snapshot) {
                //     if (!snapshot.hasData) {
                //       return Container(
                //           alignment: Alignment.topCenter,
                //           margin: const EdgeInsets.only(top: 20),
                //           child: const CircularProgressIndicator(
                //             backgroundColor: Colors.grey,
                //             color: Color(0xffd2b48c),
                //           ));
                //     } else if (snapshot.data!.docs.length == 0) {
                //       return Container(
                //           alignment: Alignment.topCenter,
                //           margin: const EdgeInsets.only(top: 20),
                //           child: Text(translate(Keys.no_store_found)));
                //     } else {
                //       return
                //     }
                //   },
                // ),
                ListView.builder(
              itemCount: 10,
              // snapshot.data!.docs.length > 10
              //     ? 10
              //     : snapshot.data!.docs.length,
              scrollDirection: Axis.horizontal,
              controller: _scrollController, // Attach ScrollController
              itemBuilder: (
                context,
                index,
              ) {
                // DocumentSnapshot data =
                //     snapshot.data!.docs[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 15.0, top: 20.0, bottom: 10),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://pretorianrealtorbuilder.pk/wp-content/uploads/2023/08/WhatsApp-Image-2023-08-26-at-12.29.13-PM-1170x785.jpeg', // Replace with your image URL
                        imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set the radius here
                          child: Image(
                            image: imageProvider,
                            width: Responsive.isMobile(context)? 200: 310, // Set the desired width
                            height: Responsive.isMobile(context)? 100: 170, // Set the desired height
                            fit: BoxFit.cover,
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                     SizedBox(
                      width:Responsive.isMobile(context)? 200: 310,
                      child: const Text(
                        "Exquisite 1 Kanal Corner House For Sale In DHA Multan – A Blend Of Elegance And Location",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                     SizedBox(
                      width: Responsive.isMobile(context)? 200:310,
                      child: const Text(
                        "Buch Executive Villas Multan",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.home_work_outlined,
                          color: Colors.grey,
                          size: 15.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "House",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 25.0,
                        ),
                        Icon(
                          Icons.height,
                          color: Colors.grey,
                          size: 15.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "5 Marla",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
       Responsive.isMobile(context)? const SizedBox() :Positioned(
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    weight: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Responsive.isMobile(context)? const SizedBox() :Positioned(
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    weight: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
      toIndexreverse * -100.0, // Replace 50.0 with the height of your list items
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
