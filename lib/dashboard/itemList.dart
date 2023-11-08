import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:galaxy_web/components/product_details.dart';
import 'package:galaxy_web/dashboard/DashBoardSection/dashboard/components/header.dart';
import 'package:galaxy_web/dashboard/DashBoardSection/dashboard/components/my_fields.dart';
import 'package:galaxy_web/dashboard/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controllers/MenuController.dart';
import '../main.dart';
import '../responsive.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  String? dropdownvalue;
  var status = 'All';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // List of items in our dropdown menu
  var items = [
    'Today Followups',
    'Residental',
    'Commerical',
    'Appartment',
    '4 Marla',
    '5 Marla',
    '7.5 Marla',
    '10 Marla',
    '12 Marla',
    '1 Kanal',
    'DHA',
    'City Housing',
    'Buch Executive Villas',
    'All',
  ];
  var categ = ['Electronics'];
  // Future<bool> onBackPress() async {
  //   // setState(() {
  //   //   Provider.of<menuController>(context, listen: false)
  //   //       .SelectedMenue('Dashboard');
  //   //   Provider.of<menuController>(context, listen: false).SellerId(null);
  //   //   Provider.of<menuController>(context, listen: false).OrderId(null);
  //   //   Provider.of<menuController>(context, listen: false).ProductId(null);
  //   //   Provider.of<menuController>(context, listen: false).StoreId(null);
  //   // });
  //   // return Future.value(false);
  // }

  var employeeList;
  getEmployeelist() {
    FirebaseFirestore.instance
        .collection('Sales Employee')
        .doc('sales_employee')
        .get()
        .then((value) {
      employeeList = value.get('list');
    });
  }

  var visitDate;
  var todaydate = new DateTime.now();
  @override
  void initState() {
    todaydate = new DateTime(todaydate.year, todaydate.month, todaydate.day);
    getEmployeelist();
    super.initState();
  }

  TextEditingController _searchController = TextEditingController();
//TODO Make sure to provide your own Collection instead of 'all_Notes'

// List<DocumentSnapshot> documents = [];

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(color: secondaryColor),
            borderRadius:
                const BorderRadius.only(topLeft: Radius.circular(30))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(
                  Responsive.isMobile(context) ? 0.0 : defaultPadding),
              child: Column(
                children: [
                  const SizedBox(height: defaultPadding),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Responsive.isMobile(context) ? 11 : 0,
                    ),
                    child: const Header(),
                  ),
                  const SizedBox(height: defaultPadding),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Responsive.isMobile(context) ? 11 : 150.0,
                        right: Responsive.isMobile(context) ? 11 : 150),
                    child: const MyFiles(),
                  ),
                  const SizedBox(height: defaultPadding),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Responsive.isMobile(context)
                            ? 11.0
                            : defaultPadding,
                        right: Responsive.isMobile(context)
                            ? 11.0
                            : defaultPadding),
                    child: Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(Responsive.isMobile(context)
                            ? 8.0
                            : defaultPadding),
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "My Listing",
                                  style: TextStyle(
                                      color: Color(0xffF9A51F),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21.0),
                                ),
                                const Spacer(),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02),
                              ],
                            ),
                            // Responsive.isMobile(context)
                            //     ? Container(
                            //         margin: const EdgeInsets.only(
                            //             left: 10, right: 20),
                            //         height: 37.0,
                            //         width: 300,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(15),
                            //           border: Border.all(color: Colors.black),
                            //         ),
                            //         child: PopupMenuButton(
                            //           color: Theme.of(context)
                            //               .scaffoldBackgroundColor,
                            //           // initialValue: 2,
                            //           onSelected: (int index) {
                            //             // Provider.of<menuController>(context,
                            //             //         listen: false)
                            //             //     .changePCategory(
                            //             //         Provider.of<menuController>(
                            //             //                 context,
                            //             //                 listen: false)
                            //             //             .categories[index]);
                            //             // setState(() {});
                            //           },
                            //           child: Container(
                            //             width: 200,
                            //             padding: const EdgeInsets.symmetric(
                            //                 horizontal: 4),
                            //             child: Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceAround,
                            //               children: [
                            //                 Expanded(
                            //                   child: Text(
                            //                     '123',
                            //                     style: TextStyle(
                            //                         color: Colors.black),
                            //                   ),
                            //                 ),
                            //                 const Icon(
                            //                   Icons.filter_list,
                            //                   size: 17,
                            //                   color: Colors.black,
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //           itemBuilder: (context) {
                            //             return List.generate(
                            //                 Provider.of<menuController>(
                            //                         context,
                            //                         listen: false)
                            //                     .categories
                            //                     .length, (index) {
                            //               return PopupMenuItem(
                            //                 value: index,
                            //                 child: Text(
                            //                   "  ${Provider.of<menuController>(context, listen: false).categories[index]}",
                            //                   style: TextStyle(
                            //                       color: Colors.black),
                            //                 ),
                            //               );
                            //             });
                            //           },
                            //         ),
                            //   )
                            // : SizedBox(),
                            const Divider(color: Color(0xffE5EBF1)),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffF9A51F),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Responsive.isMobile(context)
                                        ? Container()
                                        : const Expanded(
                                            flex: 1,
                                            child: Text(
                                              "ID",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                    Responsive.isMobile(context)
                                        ? Container()
                                        : const SizedBox(width: 10),
                                    Expanded(
                                      flex:
                                          Responsive.isMobile(context) ? 3 : 6,
                                      child: const Text(
                                        "Name",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex:
                                          Responsive.isMobile(context) ? 2 : 2,
                                      child: const Text(
                                        'Price',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Responsive.isMobile(context)
                                        ? Container()
                                        : const SizedBox(width: 10),
                                    Responsive.isMobile(context)
                                        ? Container()
                                        : const Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Category',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                    Responsive.isMobile(context)
                                        ? Container()
                                        : const SizedBox(width: 10),
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Location',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Date',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex:
                                          Responsive.isMobile(context) ? 1 : 1,
                                      child: const Text(
                                        'Action',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Properties List')
                                    .where('user',
                                        isEqualTo: _auth.currentUser?.uid)
                                    // .orderBy('DateTime',
                                    //     descending: true)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  return snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : snapshot.data!.docs.length == 0
                                          ? const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Center(
                                                  child: Text(
                                                      'No Properties Found',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white))),
                                            )
                                          : ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                DocumentSnapshot data =
                                                    snapshot.data!.docs[index];

                                                return MouseRegion(
                                                  cursor: SystemMouseCursors
                                                      .click, //hand click cursor
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Provider.of<menuController>(
                                                              context,
                                                              listen: false)
                                                          .navmenueSelect(
                                                              'Shop');
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ProductDetails(
                                                                    data: data,
                                                                    dashboard:
                                                                        'true',
                                                                  )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Row(
                                                          children: [
                                                            Responsive.isMobile(
                                                                    context)
                                                                ? Container()
                                                                : const SizedBox(
                                                                    width: 10),
                                                            Responsive.isMobile(
                                                                    context)
                                                                ? Container()
                                                                : Expanded(
                                                                    flex: Responsive.isMobile(
                                                                            context)
                                                                        ? 1
                                                                        : 1,
                                                                    child: Text(
                                                                      data.get(
                                                                          'id'),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12.0,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                            Expanded(
                                                              flex: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 3
                                                                  : 6,
                                                              child: Text(
                                                                data.get(
                                                                    'title'),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black),
                                                                        maxLines: 3,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Expanded(
                                                              flex: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 2
                                                                  : 2,
                                                              child: Text(
                                                                data.get(
                                                                    'price'),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            Responsive.isMobile(
                                                                    context)
                                                                ? Container()
                                                                : const SizedBox(
                                                                    width: 10),
                                                            Responsive.isMobile(
                                                                    context)
                                                                ? Container()
                                                                : Expanded(
                                                                    flex: 2,
                                                                    child: Text(
                                                                      data.get(
                                                                          'category'),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12.0,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                data.get(
                                                                    'location'),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                _date(
                                                                  data
                                                                      .get(
                                                                          'datetime')
                                                                      .toDate()
                                                                      .toString(),
                                                                ),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  MouseRegion(
                                                                    cursor: SystemMouseCursors
                                                                        .click, //hand click cursor
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        showDeleteConfirmationDialog(
                                                                            context,
                                                                            data.get('datetime'));
                                                                      },
                                                                      child: Image
                                                                          .network(
                                                                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fdelete.png?alt=media&token=3b6ef544-00c0-44e4-8fd2-4f7384844ea3&_gl=1*lpp01d*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5OTQyMjMzNy44NS4xLjE2OTk0MjIzOTQuMy4wLjA.',
                                                                        width: Responsive.isMobile(context)
                                                                            ? 20
                                                                            : 20,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // delete dialog
  Future<void> deleteDocument(var documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Properties List')
          .where('datetime', isEqualTo: documentId)
          .get()
          .then((value) async {
        final List<DocumentSnapshot> documents = value.docs;

        for (DocumentSnapshot document in documents) {
          await document.reference.delete().then((value) {
            Fluttertoast.showToast(
              msg: "Successfully Deleted",
              toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
              gravity: ToastGravity
                  .BOTTOM, // You can change the gravity to position the toast
              timeInSecForIosWeb: 1, // Duration in seconds
              backgroundColor: Colors.grey, // Background color of the toast
              textColor: Colors.white, // Text color of the toast
              fontSize: 16.0, // Font size
            );
            Navigator.pop(context);
          });
        }
      });
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, var documentId) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this Listing?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                deleteDocument(documentId);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _date(String _timestamp) {
    String formattedDate =
        DateFormat('dd MMM, yyyy').format(DateTime.parse(_timestamp));
    return formattedDate;
  }
}
