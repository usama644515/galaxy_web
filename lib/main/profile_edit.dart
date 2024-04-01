import 'dart:io' as i;
import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:galaxy_web/responsive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class EditProfile extends StatefulWidget {
  final username, email, phonenumber, pic;
  const EditProfile(
      {super.key, this.username, this.email, this.phonenumber, this.pic});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final bool _isObscure = true;
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController phone = TextEditingController();
  // final TextEditingController color = TextEditingController();
  // final TextEditingController model = TextEditingController();
  // final TextEditingController sample = TextEditingController();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    setState(() {
      name.text = widget.username;
      email.text = widget.email;
      phone.text = widget.phonenumber;
    });

    super.initState();
  }

  var markericon;

  var markerindex = 0;

  _deleteAccountDialog(context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      // body: const Center(
      //   child: Text(
      //     'If the body is specified, then title and description will be ignored, this allows to further customize the dialogue.',
      //     style: TextStyle(fontStyle: FontStyle.italic),
      //   ),
      // ),
      title: 'Delete Account',
      desc: 'Are you Sure to Delete your account?',
      btnOkText: 'Yes',
      btnCancelText: 'No',
      buttonsTextStyle: const TextStyle(fontSize: 17.0),
      btnOkOnPress: () {
        try {
          final uid = _auth.currentUser!.uid;
          _auth.currentUser!.delete().then((value) {
            // Provider.of<MenuController>(context, listen: false).stopTimer();
            firestore.collection('Users').doc(uid).delete();
            firestore
                .collection('chat')
                .where('chatId', arrayContains: uid)
                .get()
                .then((value) {
              for (var element in value.docs) {
                element.reference.delete();
              }
            }).then((value) {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            });
          }).catchError((e) {
            Fluttertoast.showToast(msg: '${e.message}');
          });
        } catch (e) {
          Fluttertoast.showToast(msg: '${e}');
        }
      },
      btnCancelOnPress: () {},
    ).show();
  }

  void handleClick(String value) {
    switch (value) {
      case 'Delete Account?':
        _deleteAccountDialog(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Set to false to remove the back icon
        backgroundColor: const Color(0xffE5B920),
        title: const Text('Edit Profile'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Farrow%20left.png?alt=media&token=4f23b9ce-7c61-4223-940c-ea3f5bd14c24&_gl=1*blgm6y*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODkwNjA5My43Ny4xLjE2OTg5MDY2MTAuNjAuMC4w',
                width: 10,
              ),
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Delete Account?'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    loadAssets();
                  },
                  child: Stack(
                    children: [
                      _imgObjs.isEmpty
                          ? CachedNetworkImage(
                              imageUrl: "${_auth.currentUser?.photoURL}",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  // shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: kIsWeb
                                  ? Image.network(_imgObjs[0].path,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover)
                                  : Image.file(File(_imgObjs[0].path),
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover),
                            ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 60,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(100),
                                  bottomRight: Radius.circular(100))),
                          child: const Icon(
                            Icons.camera_alt_sharp,
                            color: Colors.white,
                            size: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formGlobalKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Responsive.isMobile(context)
                            ? 0
                            : MediaQuery.of(context).size.width * 0.2,
                        right: Responsive.isMobile(context)
                            ? 0
                            : MediaQuery.of(context).size.width * 0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 35),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value == "") {
                                  return "Enter Name";
                                }
                              },
                              keyboardType: TextInputType.text,
                              onChanged: (value) {},
                              controller: name,
                              autofocus: false,
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                              decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // width: 3,
                                      color: Colors.red), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // width: 3,
                                      color: Colors.red), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // width: 3,
                                      color: Colors.grey), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    // width: 3,
                                    color: Color(0xff552C88),
                                  ), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Name',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 20.0, top: 20.0),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10.0),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: Text(
                            'City',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value == "") {
                                  return "Enter City";
                                }
                              },
                              keyboardType: TextInputType.text,
                              onChanged: (value) {},
                              controller: city,
                              autofocus: false,
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                              decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // width: 3,
                                      color: Colors.red), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // width: 3,
                                      color: Colors.red), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // width: 3,
                                      color: Colors.grey), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    // width: 3,
                                    color: Color(0xff552C88),
                                  ), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter City',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 20.0, top: 20.0),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10.0),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value == "") {
                                  return "Enter Phone Number";
                                }
                              },
                              keyboardType: TextInputType.text,
                              onChanged: (value) {},
                              controller: phone,
                              autofocus: false,
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                              decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // width: 3,
                                      color: Colors.red), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // width: 3,
                                      color: Colors.red), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // width: 3,
                                      color: Colors.grey), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    // width: 3,
                                    color: Color(0xff552C88),
                                  ), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Phone Number',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 20.0, top: 20.0),
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 10.0),
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 30.0, vertical: 10.0),
                        //   child: Text(
                        //     'Date of Birth',
                        //     style: TextStyle(
                        //       fontSize: 15.0,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        //   // ignore: avoid_unnecessary_containers
                        //   child: Container(
                        //     child: TextFormField(
                        //       validator: (value) {
                        //         if (value == "") {
                        //           return "Enter Date of Birth";
                        //         }
                        //       },
                        //       keyboardType: TextInputType.emailAddress,
                        //       onChanged: (value) {},
                        //       controller: dob,
                        //       autofocus: false,
                        //       style: const TextStyle(
                        //           fontSize: 15.0,
                        //           color: Color.fromRGBO(0, 0, 0, 1)),
                        //       decoration: InputDecoration(
                        //         icon: GestureDetector(
                        //             child: new Icon(
                        //               Icons.calendar_today,
                        //               color: const Color(0xffFB7959),
                        //             ),
                        //             onTap: () async {
                        //               final datePick = await showDatePicker(
                        //                   context: context,
                        //                   builder: (context, child) {
                        //                     return Theme(
                        //                       data: Theme.of(context).copyWith(
                        //                         colorScheme: ColorScheme.light(
                        //                           primary: const Color(
                        //                               0xffFB7959), // <-- SEE HERE
                        //                           onPrimary: Colors
                        //                               .white, // <-- SEE HERE
                        //                           // onSurface: Colors
                        //                           //     .blueAccent, // <-- SEE HERE
                        //                         ),
                        //                         // textButtonTheme:
                        //                         //     TextButtonThemeData(
                        //                         //   style: TextButton.styleFrom(
                        //                         //     primary: const Color(0xffFB7959), // button text color
                        //                         //   ),
                        //                         // ),
                        //                       ),
                        //                       child: child!,
                        //                     );
                        //                   },
                        //                   initialDate: new DateTime.now(),
                        //                   firstDate: new DateTime(1900),
                        //                   lastDate: new DateTime(2100));
                        //               if (datePick != null &&
                        //                   datePick != birthDate) {
                        //                 setState(() {
                        //                   birthDate = datePick;
                        //                   isDateSelected = true;

                        //                   // put it here
                        //                   birthDateInString =
                        //                       "${birthDate?.month}/${birthDate?.day}/${birthDate?.year}";
                        //                   dob.text = birthDateInString!;
                        //                   print(birthDateInString); // 08/14/2019
                        //                 });
                        //               }
                        //             }),
                        //         focusedErrorBorder: OutlineInputBorder(
                        //           borderSide: const BorderSide(
                        //               // width: 3,
                        //               color: Colors.red), //<-- SEE HERE
                        //           borderRadius: BorderRadius.circular(20.0),
                        //         ),
                        //         errorBorder: OutlineInputBorder(
                        //           borderSide: const BorderSide(
                        //               // width: 3,
                        //               color: Colors.red), //<-- SEE HERE
                        //           borderRadius: BorderRadius.circular(20.0),
                        //         ),
                        //         enabledBorder: OutlineInputBorder(
                        //           borderSide: const BorderSide(
                        //               // width: 3,
                        //               color: Colors.grey), //<-- SEE HERE
                        //           borderRadius: BorderRadius.circular(20.0),
                        //         ),
                        //         focusedBorder: OutlineInputBorder(
                        //           borderSide: const BorderSide(
                        //             // width: 3,
                        //             color: Color(0xffFB7959),
                        //           ), //<-- SEE HERE
                        //           borderRadius: BorderRadius.circular(20.0),
                        //         ),
                        //         filled: true,
                        //         fillColor: Colors.white,
                        //         hintText: 'Ex 08/14/2019',
                        //         contentPadding: const EdgeInsets.only(
                        //             left: 14.0, bottom: 20.0, top: 20.0),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 10.0),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            child: TextFormField(
                              // maxLines: 3,
                              validator: (value) {
                                if (value == "") {
                                  return "Enter Email";
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              readOnly: true, // Make the text field read-only
                              onChanged: (value) {},
                              controller: email,
                              autofocus: false,
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                              decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // width: 3,
                                      color: Colors.red), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // width: 3,
                                      color: Colors.red), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // width: 3,
                                      color: Colors.grey), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    // width: 3,
                                    color: Color(0xff552C88),
                                  ), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter Vehicle Number',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 20.0, top: 20.0),
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 30.0, vertical: 0.0),
                        //   child: Text(
                        //     'Select Gender',
                        //     style: TextStyle(
                        //       fontSize: 15.0,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // ),
                        // getWidget(true, true),

                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              if (formGlobalKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                if (_imgObjs[0] == null) {
                                  saveUserData(null, null);
                                } else {
                                  // pickImageAndUpload();
                                  uploadFile();
                                }
                              }
                            },
                            child: Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5B920),
                                    borderRadius: BorderRadius.circular(25.0)),
                                child: Center(
                                    child: loading == true
                                        ? const CircularProgressIndicator(
                                            color: Colors.white)
                                        : const Text('Confirm',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool loading = false;

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

  firebase_storage.Reference? ref;
  Future uploadFile() async {
    // progressDialogue(context);
    for (var img in _imgObjs) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Profile Images/${img.path}');
      kIsWeb
          ? await ref!
              .putData(await img.readAsBytes(),
                  SettableMetadata(contentType: 'image/jpeg'))
              .then((value) async {
              await ref!.getDownloadURL().then((value) {
                // imageUrl.add(value);
                saveUserData(value, null);
              });
            })
          : await ref!.putFile(i.File(img.path)).whenComplete(() async {
              await ref!.getDownloadURL().then((value) {
                // imgRef!.add({'url': value});
                // imageUrl.add(value);
                saveUserData(value, null);
              });
            });
    }
  }

  saveUserData(var imageurl, carimage) {
    Map<String, dynamic> userdata = {
      'Email': email.text,
      'Name': name.text,
      'UID': _auth.currentUser!.uid,
      'img': imageurl == null ? _auth.currentUser?.photoURL : imageurl,
      'phone': phone.text,
      'city': city.text
    };
    FirebaseFirestore.instance
        .collection('AllUsers')
        .doc(_auth.currentUser!.uid)
        .set(userdata, SetOptions(merge: true))
        .whenComplete(() {
      // savemarkerData();
      // _auth.currentUser?.updateDisplayName(_firstNameController.text);
      _auth.currentUser?.updatePhotoURL(
        imageurl == null ? _auth.currentUser?.photoURL : imageurl,
      );
      _auth.currentUser?.updateDisplayName(name.text).then((value) {
        setState(() {
          loading = false;
        });
        Navigator.pop(context);
      });

      // Get.off(() => const BottomBar());
    });
  }

  savemarkerData() {
    Map<String, dynamic> markerdata = {
      'marker': markericon,
    };
    FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .set(markerdata, SetOptions(merge: true));
  }

  Future<void> _showChoiceDialog(BuildContext context, bool carimage) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Choose Opton',
              style: TextStyle(
                color: Colors.blue[200],
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 0,
                    color: Colors.blue[50],
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: const Text('Gallery'),
                    leading: const Icon(
                      Icons.image,
                      color: Color(0xFF394d7f),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue[50],
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      // _getFromCamera(carimage);
                    },
                    title: const Text('Camera'),
                    leading: const Icon(
                      Icons.camera_alt_rounded,
                      color: Color(0xFF394d7f),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
