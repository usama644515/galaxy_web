// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'dart:io' as i;
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../responsive.dart';

class AddProductStore extends StatefulWidget {
  const AddProductStore({Key? key, this.productdata, this.data})
      : super(key: key);
  final productdata, data;
  @override
  _AddProductStoreState createState() => _AddProductStoreState();
}

class _AddProductStoreState extends State<AddProductStore> {
  void initState() {
    print(_auth.currentUser?.email);
    getphonenumber();
    super.initState();
  }

  var phone;
  getphonenumber() {
    FirebaseFirestore.instance
        .collection('AllUsers')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((value) {
      phone = value.get('phone');
      // employeeList = employeeList + ['usama'];
      // print('----------------${employeeList}---------------');
    });
  }

  bool isChecked = false,
      small = false,
      medium = false,
      large = false,
      refrigeration = false,
      FBS = true;
  var tags = [];
  List scolors = [];
  var variations = [];
  String? vName, vUnit, vPrice, vSellPrice = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _landsize = TextEditingController();
  final TextEditingController _rooms = TextEditingController();
  final TextEditingController _bathroom = TextEditingController();
  final TextEditingController _garage = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _youtubeurl = TextEditingController();
  final TextEditingController _id = TextEditingController();

  List category = ['Residential', 'Commercial', 'Plots', 'Construction', 'Flats'];

  List location = [
    'Buch Executive Villas',
    'DHA Multan',
    'Citi Housing Multan'
  ];

  List select = ['Sell', 'Rent'];

  List<XFile> _imgObjs = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> loadAssets() async {
    final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 50);

    if ((images?.length ?? 0) > 0) {
      setState(() {
        _imgObjs = images!;
      });
    }
  }

  Widget buildGridView() {
    return Scrollbar(
      controller: _imageController,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ReorderableListView.builder(
            scrollController: _imageController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final String productName = _imgObjs[index].name;
              final image = _imgObjs[index];
              return Container(
                height: 140,
                width: 140,
                margin: const EdgeInsets.all(3),
                key: ValueKey(productName),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 140,
                      width: 140,
                      child: kIsWeb
                          ? Image.network(
                              image.path,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(image.path),
                              fit: BoxFit.cover,
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _imgObjs.removeAt(index);
                        });
                      },
                      child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.cancel,
                            size: 24,
                            color: Colors.red,
                          )),
                    ),
                  ],
                ),
              );
            },
            itemCount: _imgObjs.length,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex = newIndex - 1;
                }
                final element = _imgObjs.removeAt(oldIndex);
                _imgObjs.insert(newIndex, element);
              });
            }),
      ),
    );
    //   GridView.count(
    //   crossAxisCount: kIsWeb ? 6 : 3,
    //   children: List.generate(_imgObjs.length, (index) {
    //     final image = _imgObjs[index];
    //     return Padding(
    //       padding: const EdgeInsets.all(2.0),
    //       child: Stack(
    //         children: [
    //           SizedBox(
    //               width: MediaQuery.of(context).size.width * 0.3,
    //               child: kIsWeb
    //                   ? Image.network(
    //                       image.path,
    //                       fit: BoxFit.cover,
    //                     )
    //                   : Image.file(
    //                       File(image.path),
    //                       fit: BoxFit.cover,
    //                     )),
    //           GestureDetector(
    //             onTap: () {
    //               setState(() {
    //                 _imgObjs.removeAt(index);
    //               });
    //             },
    //             child: const Align(
    //                 alignment: Alignment.topRight,
    //                 child: Icon(
    //                   Icons.cancel,
    //                   size: 24,
    //                   color: Colors.red,
    //                 )),
    //           ),
    //         ],
    //       ),
    //     );
    //   }),
    // );
  }

  DateTime? newDateTime;
  firebase_storage.Reference? ref;
  ScrollController _controller = ScrollController();
  ScrollController _subController = ScrollController();
  ScrollController _imageController = ScrollController();
  ScrollController _urlController = ScrollController();

  var imageFile = [];
  List imageUrl = [];
  double val = 0;

  Future uploadFile() async {
    progressDialogue(context);
    for (var img in _imgObjs) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('houses/${_id.text}/${img.path}');
      kIsWeb
          ? await ref!
              .putData(await img.readAsBytes(),
                  SettableMetadata(contentType: 'image/jpeg'))
              .then((value) async {
              await ref!.getDownloadURL().then((value) {
                imageUrl.add(value);
              });
            })
          : await ref!.putFile(i.File(img.path)).whenComplete(() async {
              await ref!.getDownloadURL().then((value) {
                // imgRef!.add({'url': value});
                imageUrl.add(value);
              });
            });
    }
    stringslicing();
  }

  var searchfilter = [];
  stringslicing() {
    for (var i = 0; i < _titleController.text.length; i++) {
      searchfilter.add(_titleController.text.substring(0, i + 1).toLowerCase());
      // if (i + 1 == search.length) {
      //   updatedata();
      // }
    }
    // locatiion
    for (var i = 0; i < condition!.length; i++) {
      searchfilter.add(condition!.substring(0, i + 1).toLowerCase());
    }
    // id
    for (var i = 0; i < _id.text.length; i++) {
      searchfilter.add(_id.text.substring(0, i + 1).toLowerCase());
    }
  }

  progressDialogue(BuildContext context) {
    //set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        color: Colors.white,
        height: 100,
        child: const Center(
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  Text(
                    '  Uploading...',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return alert;
      },
    );
  }

  // Future<void> uploadProduct() async {
  //   progressDialogue(context);
  //   for (int i = 0; i < _imgObjs.length; i++) {
  //
  //     imageFile.add(File(path));
  //   }
  // }

  final _formKey = GlobalKey<FormState>();
  final _popUpFormKey = GlobalKey<FormState>();

  void vAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Add Size'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _popUpFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Size Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            fontFamily: "Montserrat",
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: "  Small",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      validator: (String? value) {
                        return (value!.isNotEmpty) ? null : "";
                      },
                      onChanged: (val) {
                        vName = val;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Unit',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            fontFamily: "Montserrat",
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: "  250mg",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      onChanged: (val) {
                        vUnit = val;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixText: 'Rs.',
                        labelText: 'Price',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            fontFamily: "Montserrat",
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: "  120",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      validator: (String? value) {
                        return (value!.isNotEmpty) ? null : "";
                      },
                      onChanged: (val) {
                        vPrice = val;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixText: 'Rs.',
                        labelText: 'Sell Price (Optional)',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            fontFamily: "Montserrat",
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: "  100",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),

                      // validator: (String? value) {
                      //   return (value!.isNotEmpty)
                      //       ? null
                      //       : "";
                      // },
                      onChanged: (val) {
                        vSellPrice = val;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () {
                    if (_popUpFormKey.currentState!.validate()) {
                      setState(() {
                        variations.add({
                          'name': vName,
                          'unit': vUnit,
                          'price': vPrice,
                          'sellPrice': vSellPrice,
                        });
                        vName = null;
                        vUnit = null;
                        vPrice = null;
                        vSellPrice = '';
                        Navigator.pop(context);
                      });
                    }
                    // your code
                  })
            ],
          );
        });
  }

  changeSubCategories(id) {
    print(id);
    firestore
        .collection('Category')
        .where('name', isEqualTo: id)
        .get()
        .then((value) {
      setState(() {
        subCetegories = value.docs.first.get('subCategory');
      });
    });
  }

  List<DraggableGridItem> _listOfDraggableGridItem = [];

  Widget GridItem(index) {
    return Container(
      child: GestureDetector(
        onTap: () {
          imageUrl.removeAt(index);
          setState(() {});
        },
        child: const Padding(
          padding: EdgeInsets.only(top: 10, right: 10),
          child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.cancel,
                size: 24,
                color: Colors.red,
              )),
        ),
      ),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(imageUrl[index]), fit: BoxFit.cover)),
    );
  }

  List subCetegories = [];

  changeCategories() {
    firestore.collection('Products').get().then((value) {
      value.docs.forEach((element) {
        final cat = element.get('category').first;
        element.reference.set({'category': cat}, SetOptions(merge: true));
      });
    });
  }

  String selectedUnit = 'ft';
  String selectedWeight = 'kg';

  Widget popUpButton() {
    return PopupMenuButton(
        // add icon, by default "3 dot" icon
        icon: Text(
          selectedUnit,
          style: const TextStyle(color: Colors.black),
        ),
        itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: 0,
              child: Text(
                "  Ft",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text(
                "  Inch",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text(
                "  Meter",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            const PopupMenuItem<int>(
              value: 3,
              child: Text(
                "  Cm",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 0) {
            setState(() {
              selectedUnit = 'ft';
            });
          } else if (value == 1) {
            setState(() {
              selectedUnit = 'inch';
            });
          } else if (value == 2) {
            setState(() {
              selectedUnit = 'meter';
            });
          } else {
            setState(() {
              selectedUnit = 'cm';
            });
          }
          print(value);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            changeCategories();
          },
          child: const Text(
            "Add Property",
          ),
        ),
        centerTitle: true,
        // automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color(0xffF9A51F),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  left: Responsive.isMobile(context)
                      ? 0
                      : MediaQuery.of(context).size.width * 0.22,
                  right: Responsive.isMobile(context)
                      ? 0
                      : MediaQuery.of(context).size.width * 0.22),
              child: Column(
                children: [
                  _imgObjs.isEmpty
                      ? MouseRegion(
                          cursor: SystemMouseCursors.click, //hand click cursor
                          child: GestureDetector(
                            onTap: () {
                              loadAssets();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.6),
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.grey.withOpacity(0.1)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload_outlined,
                                      color: Colors.grey.withOpacity(0.6),
                                      size: 45,
                                    ),
                                    Text(
                                      "${"Upload Image"}\n${"You can Upload Multiple Images"}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.grey.withOpacity(0.6),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: buildGridView(),
                        ),
                  widget.data == null
                      ? Container()
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.18,
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.all(4),
                          child: Scrollbar(
                            controller: _urlController,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ReorderableListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  scrollController: _urlController,
                                  itemBuilder: (context, index) {
                                    final String productName = imageUrl[index];
                                    return Container(
                                      height: 140,
                                      width: 140,
                                      key: ValueKey(productName),
                                      margin: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(imageUrl[index]),
                                              fit: BoxFit.cover)),
                                      child: GestureDetector(
                                        onTap: () {
                                          imageUrl.removeAt(index);
                                          setState(() {});
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, right: 10),
                                          child: Align(
                                              alignment: Alignment.topRight,
                                              child: Icon(
                                                Icons.cancel,
                                                size: 24,
                                                color: Colors.red,
                                              )),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: imageUrl.length,
                                  onReorder: (oldIndex, newIndex) {
                                    setState(() {
                                      if (newIndex > oldIndex) {
                                        newIndex = newIndex - 1;
                                      }
                                      final element =
                                          imageUrl.removeAt(oldIndex);
                                      imageUrl.insert(newIndex, element);
                                    });
                                  }),
                            ),
                          ),

                          ///DragableGridview Builder
                          // DraggableGridViewBuilder(
                          //   gridDelegate:
                          //       SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: 1,
                          //     childAspectRatio: 1,
                          //   ),
                          //   scrollDirection: Axis.horizontal,
                          //   children: _listOfDraggableGridItem,
                          //   isOnlyLongPress: true,
                          //   dragCompletion: (List<DraggableGridItem> list,
                          //       int beforeIndex, int afterIndex) {
                          //     print(list);
                          //
                          //     print(
                          //         'onDragAccept: $beforeIndex -> $afterIndex');
                          //   },
                          //   dragFeedback:
                          //       (List<DraggableGridItem> list, int index) {
                          //     return Container(
                          //       child: list[index].child,
                          //       width: 150,
                          //       height: 150,
                          //     );
                          //   },
                          //   dragPlaceHolder:
                          //       (List<DraggableGridItem> list, int index) {
                          //     return PlaceHolderWidget(
                          //       child: Container(
                          //         color: Colors.white,
                          //       ),
                          //     );
                          //   },
                          // )

                          ///simple GridView Builder
                          // GridView.builder(
                          //     scrollDirection: Axis.horizontal,
                          //     itemCount: imageUrl.length,
                          //     gridDelegate:
                          //         const SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: 1,
                          //       childAspectRatio: 1,
                          //     ),
                          //     itemBuilder: (context, index) {
                          //       return Container(
                          //         child: GestureDetector(
                          //           onTap: () {
                          //             imageUrl.removeAt(index);
                          //             setState(() {});
                          //           },
                          //           child: const Padding(
                          //             padding:
                          //                 EdgeInsets.only(top: 10, right: 10),
                          //             child: Align(
                          //                 alignment: Alignment.topRight,
                          //                 child: Icon(
                          //                   Icons.cancel,
                          //                   size: 24,
                          //                   color: Colors.red,
                          //                 )),
                          //           ),
                          //         ),
                          //         margin: const EdgeInsets.all(2),
                          //         decoration: BoxDecoration(
                          //             image: DecorationImage(
                          //                 image: NetworkImage(imageUrl[index]),
                          //                 fit: BoxFit.cover)),
                          //       );
                          //     }),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                              // style: BorderStyle.none
                            ),
                          ),
                          labelText: "Product title",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                          hintText: "  Product title",
                          hintStyle: TextStyle(
                              fontFamily: "Lora",
                              color: Colors.grey,
                              fontSize: 16),
                          errorStyle: TextStyle(
                              color: Colors.red,
                              decorationColor: Colors.white)),
                      validator: (String? value) {
                        return (value!.isNotEmpty)
                            ? null
                            : "Please enter Product title";
                      },
                      controller: _titleController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            // style: BorderStyle.none
                          ),
                        ),
                        labelText: "Primary Price",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: "  Rs. 50",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      validator: (String? value) {
                        return (value!.isNotEmpty)
                            ? null
                            : "Please enter primary price";
                      },
                      controller: _price,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            // style: BorderStyle.none
                          ),
                        ),
                        labelText: "Description",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: "  Type your description here...",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      validator: (String? value) {
                        return (value!.isNotEmpty)
                            ? null
                            : "Please enter description";
                      },
                      controller: _description,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            // style: BorderStyle.none
                          ),
                        ),
                        labelText: "Land Size",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: "  10 Marla",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      validator: (String? value) {
                        return (value!.isNotEmpty)
                            ? null
                            : "Please enter land size";
                      },
                      controller: _landsize,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            // style: BorderStyle.none
                          ),
                        ),
                        labelText: "Rooms",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: "  5",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      validator: (String? value) {
                        return (value!.isNotEmpty)
                            ? null
                            : "Please enter rooms quantity";
                      },
                      controller: _rooms,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            // style: BorderStyle.none
                          ),
                        ),
                        labelText: "Bathroom",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: "  6",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      validator: (String? value) {
                        return (value!.isNotEmpty)
                            ? null
                            : "Please enter bathroom quantity";
                      },
                      controller: _bathroom,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            // style: BorderStyle.none
                          ),
                        ),
                        labelText: "Garage",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: "  1",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      validator: (String? value) {
                        return (value!.isNotEmpty)
                            ? null
                            : "Please enter garage";
                      },
                      controller: _garage,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            // style: BorderStyle.none
                          ),
                        ),
                        labelText: "City",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: "  Multan",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      controller: _city,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            // style: BorderStyle.none
                          ),
                        ),
                        labelText: "Property ID",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: "  f-837",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      controller: _id,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            // style: BorderStyle.none
                          ),
                        ),
                        labelText: "Youtube Video URL",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                        hintText: widget.productdata != null
                            ? widget.productdata['videoUrl'] == ''
                                ? 'Video UnAvailable'
                                : 'Video Available'
                            : "  https://www.youtube.com/",
                        hintStyle: const TextStyle(
                            fontFamily: "Lora",
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                      controller: _youtubeurl,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Category",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: category.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AgeRange(category[index]);
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Location",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: location.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Condition(location[index]);
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Select",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: select.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Warranty(select[index]);
                        }),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click, //hand click cursor
                        child: GestureDetector(
                          onTap: () {
                            if (widget.productdata != null) {
                              if (_youtubeurl.text != '') {
                                firestore
                                    .collection('Properties List')
                                    .doc(widget.productdata.id)
                                    .set({
                                  'videoUrl': _youtubeurl.text,
                                }, SetOptions(merge: true)).then((value) {
                                  Fluttertoast.showToast(
                                      msg: "Product Updated",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                              }
                            } else {
                              if (_formKey.currentState!.validate() &&
                                  _imgObjs.isNotEmpty) {
                                if (int.parse(_price.text.toString()) <=
                                    100000) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Correct Amount",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  uploadFile().then((value) {
                                    firestore
                                        .collection('Properties List')
                                        .doc()
                                        .set({
                                      'img': imageUrl,
                                      'title': _titleController.text,
                                      'price': _price.text,
                                      'description': _description.text,
                                      'size': _landsize.text,
                                      'rooms': _rooms.text,
                                      'bath': _bathroom.text,
                                      'garage': _garage.text,
                                      'city': _city.text,
                                      'id': _id.text,
                                      'videoUrl': _youtubeurl.text,
                                      'category': range,
                                      'location': condition,
                                      'select': warn,
                                      'datetime': DateTime.now(),
                                      'searchquery': searchfilter,
                                      'user': _auth.currentUser?.uid,
                                      'phone': phone,
                                      'call': 0,
                                      'clicks': 0,
                                      'impression': 0,
                                      'whatsapp':0
                                    }, SetOptions(merge: true)).then((value) {
                                      print('upload successful');
                                      Fluttertoast.showToast(
                                          msg: "Product Uploaded",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      // getProducts(context);
                                    });
                                  });
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Please fill all details',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }
                          },
                          child: Container(
                            width: Responsive.isMobile(context)
                                ? MediaQuery.of(context).size.width * 0.9
                                : MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffF9A51F)),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  var expiry;
  String? range;

  Widget AgeRange(value) {
    return Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click, //hand click cursor
        child: GestureDetector(
          onTap: () {
            setState(() {
              range = value;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: range == value ? Colors.black : Colors.white,
                border: Border.all(
                  color: range == value ? Colors.black : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 11.0, right: 11.0, top: 5.0, bottom: 5.0),
              child: Center(
                child: Text(value,
                    style: TextStyle(
                        color: range == value ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? condition;

  Widget Condition(value) {
    return Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click, //hand click cursor
        child: GestureDetector(
          onTap: () {
            if (condition == value) {
              setState(() {
                condition = null;
              });
            } else {
              setState(() {
                condition = value;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: condition == value ? Colors.black : Colors.white,
                border: Border.all(
                  color: condition == value ? Colors.black : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 11.0, right: 11.0, top: 5.0, bottom: 5.0),
              child: Center(
                child: Text(value,
                    style: TextStyle(
                        color: condition == value ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? warn;

  Widget Warranty(value) {
    return Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click, //hand click cursor
        child: GestureDetector(
          onTap: () {
            if (warn == value) {
              setState(() {
                warn = null;
              });
            } else {
              setState(() {
                warn = value;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: warn == value ? Colors.black : Colors.white,
                border: Border.all(
                  color: warn == value ? Colors.black : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 11.0, right: 11.0, top: 5.0, bottom: 5.0),
              child: Center(
                child: Text(value,
                    style: TextStyle(
                        color: warn == value ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  var mainCateg = '';

  Widget MainCategory(var value) {
    return Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click, //hand click cursor
        child: GestureDetector(
          onTap: () {
            _saveSubCateg.clear();
            mainCateg = value;
            changeSubCategories(value);
          },
          child: Container(
            decoration: BoxDecoration(
                color: mainCateg == value ? Colors.black : Colors.white,
                border: Border.all(
                  color: mainCateg == value ? Colors.black : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 11.0, right: 11.0, top: 5.0, bottom: 5.0),
              child: Center(
                child: Text(value,
                    style: TextStyle(
                        color: mainCateg == value ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  var _saveSubCateg = [];

  Widget SubCategory(var index) {
    return Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click, //hand click cursor
        child: GestureDetector(
          onTap: () {
            if (_saveSubCateg.contains(subCetegories[index])) {
              setState(() {
                _saveSubCateg.remove(subCetegories[index]);
              });
            } else {
              setState(() {
                _saveSubCateg.add(subCetegories[index]);
                // mainCateg = _mainCategory[index];
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: _saveSubCateg.contains(subCetegories[index])
                    ? Colors.black
                    : Colors.white,
                border: Border.all(
                  color: _saveSubCateg.contains(subCetegories[index])
                      ? Colors.black
                      : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 11.0, right: 11.0, top: 5.0, bottom: 5.0),
              child: Center(
                child: Text(subCetegories[index],
                    style: TextStyle(
                        color: _saveSubCateg.contains(subCetegories[index])
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
