import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/components/mobile_navbar.dart';
import 'package:galaxy_web/components/navbar.dart';
import 'package:galaxy_web/components/product_details.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/responsive.dart';
import 'package:galaxy_web/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key, this.data}) : super(key: key);

  final data;
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    // items = duplicateItems;
    super.initState();
  }

  Future<bool> onBackPress() async {
    setState(() {
      if (kIsWeb) {
        Navigator.pop(context);
      } else {
        Provider.of<menuController>(context, listen: false)
            .navmenueSelect('Home');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => Bar(ind: 0),
          ),
          (route) => false, // Always return false to remove all routes
        );
      }
    });
    return Future.value(false);
  }

  var query = '';
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        key: scaffoldKey,
        body: ListView(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Colors.black),
                ),
                Responsive.isMobile(context)
                    ? MobileNavBar(scaffoldKey, context)
                    : const NavBar(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // cursorColor: const Color(0xffE5B920),
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                controller: editingController,
                decoration: const InputDecoration(
                    // iconColor: Color(0xffE5B920),
                    labelText: "Enter Keyword",
                    hintText: "Enter Keyword",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore
                  .instance //------for select the item in the firestore----
                  .collection('Properties List')
                  // .where('status', isEqualTo: 'Active')
                  .where('searchquery', arrayContains: query.toLowerCase())
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      child: const CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          color: Color(0xffE5B920)));
                } else if (snapshot.data!.docs.length == 0) {
                  return Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text('No Result Found'));
                } else {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: Responsive.isMobile(context) ? 20 : 40.0,
                        right: Responsive.isMobile(context) ? 20 : 40.0),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.isMobile(context)
                            ? 2
                            : 4, // Number of columns
                        mainAxisSpacing: 10.0, // Spacing between rows
                        crossAxisSpacing: 10.0, // Spacing between columns
                        childAspectRatio: Responsive.isMobile(context)
                            ? 0.8
                            : 1.0, // Width to height ratio of each grid item
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        // Build each grid item
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              getClick(data.id);
                              Provider.of<menuController>(context,
                                      listen: false)
                                  .navmenueSelect('Shop');
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ProductDetails(
                              //             data: data, id: data.id)));
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
                                    imageUrl: data.get('img')[
                                        0], // Replace with your image URL
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
                                            color: Color(0xffE5B920))),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      Responsive.isMobile(context) ? 200 : 310,
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
                                  width:
                                      Responsive.isMobile(context) ? 200 : 310,
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
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  getClick(var id) {
    FirebaseFirestore.instance.collection('Properties List').doc(id).set({
      'clicks': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }
}
