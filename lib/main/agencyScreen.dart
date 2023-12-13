import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/components/add_product_store.dart';
import 'package:galaxy_web/components/agencyScreenMobile.dart';
import 'package:galaxy_web/components/footer.dart';
import 'package:galaxy_web/components/footer_mobile.dart';
import 'package:galaxy_web/components/productlist.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/controllers/image_viewer.dart';
import 'package:galaxy_web/main/bottomBar.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:galaxy_web/router/routes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/mobile_navbar.dart';
import '../components/navbar.dart';
import '../components/side_drawer.dart';
import '../responsive.dart';

class AgencyScreen extends StatefulWidget {
  const AgencyScreen(
      {super.key, this.data, this.dashboard, this.shop, this.id});
  final data, dashboard, shop, id;
  @override
  State<AgencyScreen> createState() => _AgencyScreenState();
}

class _AgencyScreenState extends State<AgencyScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _message = '';
  bool _isHovered = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController message = TextEditingController();
// Function to open a URL
  _openURL(var link) async {
    final url = link; // Replace with your desired URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to open WhatsApp
  _openWhatsApp(var phoneNumber, var title) async {
    // final phoneNumber =
    //     '923000335875'; // Replace with the recipient's phone number
    // Replace with your message
    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(title)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  var loader = false;

  formdataupload(data) {
    FirebaseFirestore.instance.collection('Properties Query').doc().set({
      'propertyId': data['id'],
      'name': _name,
      'email': _email,
      'phone': _phoneNumber,
      'message': _message,
    }, SetOptions(merge: true)).then((value) {
      setState(() {
        loader = false;
        name.clear();
        email.clear();
        phone.clear();
        message.clear();
      });
    });
  }

  Future<bool> onBackPress() async {
    setState(() {
      if (widget.dashboard == 'true') {
        Navigator.pop(context);
        Provider.of<menuController>(context, listen: false)
            .navmenueSelect('dashboard');
      } else if (widget.shop == 'true') {
        Navigator.pop(context);
        Provider.of<menuController>(context, listen: false)
            .navmenueSelect('Shop');
      } else {
        Provider.of<menuController>(context, listen: false)
            .navmenueSelect('Home');
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(
        //     builder: (context) => kIsWeb ? Home() : Bar(ind: 0),
        //   ),
        //   (route) => false, // Always return false to remove all routes
        // );
        // Navigate back to the previous screen using FluroRouter
        RouteHandler.router.pop(context);
      }
    });
    return Future.value(false);
  }

  @override
  void initState() {
    getData();
    Provider.of<menuController>(context, listen: false)
        .navmenueSelect('Agents');
    super.initState();
  }

  var data;
  getData() {
    FirebaseFirestore.instance
        .collection('Agents')
        .doc(widget.id)
        .get()
        .then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        backgroundColor: const Color(0xffF7F7F7),
        key: scaffoldKey,
        drawer: const SideDrawer(),
        body: Stack(
          children: [
            data == null
                ? Center(
                    child: CircularProgressIndicator(
                    color: Color(0xffF9A51F),
                  ))
                : ListView(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration:
                                const BoxDecoration(color: Colors.black),
                          ),
                          Responsive.isMobile(context)
                              ? MobileNavBar(scaffoldKey, context)
                              : const NavBar(),
                        ],
                      ),
                      Responsive.isMobile(context)
                          ? const SizedBox()
                          : const SizedBox(
                              height: 0,
                            ),
                      Responsive.isMobile(context)
                          ? AgencyScreenMobile(data: data)
                          : DesktopAgencyScreen(data: data),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Responsive.isMobile(context) ? 20 : 50.0,
                            top: 10.0,
                            right: Responsive.isMobile(context) ? 20 : 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Projects",
                              style: TextStyle(
                                  fontSize: Responsive.isMobile(context)
                                      ? 20.0
                                      : 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      ProductList(
                        fromgegency: 'true',
                        agencyuid: data['UID'],
                      ),
                      Responsive.isMobile(context)
                          ? const FooterMobile()
                          : const Footer(),
                    ],
                  ),
            Responsive.isMobile(context)
                ? Positioned(
                    bottom: Responsive.isMobile(context) ? 20.0 : 15,
                    left: Responsive.isMobile(context) ? 10.0 : 15,
                    child: GestureDetector(
                      onTap: () {
                        // getWhatsappClick(widget.id);
                        _openWhatsApp(data['phone'], data['Name']);
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) {
                          setState(() {
                            _isHovered = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _isHovered = false;
                          });
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     spreadRadius: 3,
                            //     blurRadius: 4,
                            //     offset: const Offset(0, 3),
                            //   ),
                            // ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fwhatsapp%20icon.png?alt=media&token=0c59daba-322a-4cb3-b9ed-2f65dede9ea2&_gl=1*1tpr174*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODMyMDU2NC42Mi4xLjE2OTgzMjA3MjYuMzIuMC4w',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  _showBottomSheet(context) {
    showModalBottomSheet(
      // backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          // bottomLeft: Radius.circular(20.0),
          // bottomRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          // color: Theme.of(context).backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          child: Column(
            children: [
              const SizedBox(width: 40, child: Divider(thickness: 3.0)),
              const SizedBox(height: 15.0),
              const Text('MAKE AN ENQUIRY',
                  style:
                      TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 7.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.44,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value!;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          // You can add more email validation here if needed
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: phone,
                        decoration:
                            const InputDecoration(labelText: 'Phone Number'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _phoneNumber = value!;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: message,
                        decoration: const InputDecoration(labelText: 'Message'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a message';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _message = value!;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     if (_formKey.currentState!.validate()) {
                      //       _formKey.currentState!.save();

                      //       // Form data is valid, you can handle the submission here.
                      //       print('Name: $_name');
                      //       print('Email: $_email');
                      //       print('Phone Number: $_phoneNumber');
                      //       print('Message: $_message');
                      //     }
                      //   },
                      //   child: Text('Submit'),
                      // ),
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _isHovered = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _isHovered = false;
                          });
                        },
                        child: InkWell(
                          onTap: () {
                            // Handle button click here
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() {
                                loader = true;
                              });
                              formdataupload(data);
                              // Form data is valid, you can handle the submission here.
                              print('Name: $_name');
                              print('Email: $_email');
                              print('Phone Number: $_phoneNumber');
                              print('Message: $_message');
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.25,
                                right:
                                    MediaQuery.of(context).size.width * 0.25),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xffF9A51F), // Change color on hover
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: loader
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.white))
                                  : const Center(
                                      child: Text(
                                        'SUBMIT',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getWhatsappClick(var id) {
    FirebaseFirestore.instance.collection('Properties List').doc(id).set({
      'whatsapp': FieldValue.increment(1),
    }, SetOptions(merge: true));
  }
}

class DesktopAgencyScreen extends StatefulWidget {
  const DesktopAgencyScreen({super.key, this.data});
  final data;
  @override
  State<DesktopAgencyScreen> createState() => _DesktopAgencyScreenState();
}

class _DesktopAgencyScreenState extends State<DesktopAgencyScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _message = '';
  bool _isHovered = false;
  var loader = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController message = TextEditingController();
  formdataupload(data) {
    FirebaseFirestore.instance.collection('Properties Query').doc().set({
      'propertyId': data['id'],
      'name': _name,
      'email': _email,
      'phone': _phoneNumber,
      'message': _message,
    }, SetOptions(merge: true)).then((value) {
      setState(() {
        loader = false;
        name.clear();
        email.clear();
        phone.clear();
        message.clear();
      });
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fbanner.jpg?alt=media&token=ef817b41-1399-4972-993d-63324cc646d0&_gl=1*1n1923a*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5Nzk1OTcxNS40Ni4xLjE2OTc5NjA5MTIuNTEuMC4w',
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width * 0.9
                    : MediaQuery.of(context).size.width * 0.5),
          ],
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                            // shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.data['img']),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.data['Name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 35.0, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Flocation%20icon.png?alt=media&token=0a3ac270-0c1a-4cd9-aee8-8acab0afb3cb',
                                    width: 18.0),
                                const SizedBox(width: 5.0),
                                Text(
                                  '${widget.data['city']}, Pakistan',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
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
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 500,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
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
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const Divider(color: Colors.grey, thickness: 0.5),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 40.0, right: 40.0, top: 15.0),
                                child: MouseRegion(
                                    cursor: SystemMouseCursors.text,
                                    child: Text(widget.data['description'],
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.29,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // Offset from the top
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: 30.0,
                        bottom: 30.0),
                    child: Column(
                      children: [
                        const Text('Get in touch today!',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 7.0,
                        ),
                        const Divider(color: Colors.grey),
                        const SizedBox(
                          height: 7.0,
                        ),
                        TextFormField(
                          controller: name,
                          decoration: const InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value!;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: email,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            // You can add more email validation here if needed
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: phone,
                          decoration:
                              const InputDecoration(labelText: 'Phone Number'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _phoneNumber = value!;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: message,
                          decoration:
                              const InputDecoration(labelText: 'Message'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a message';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _message = value!;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     if (_formKey.currentState!.validate()) {
                        //       _formKey.currentState!.save();

                        //       // Form data is valid, you can handle the submission here.
                        //       print('Name: $_name');
                        //       print('Email: $_email');
                        //       print('Phone Number: $_phoneNumber');
                        //       print('Message: $_message');
                        //     }
                        //   },
                        //   child: Text('Submit'),
                        // ),
                        MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              _isHovered = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isHovered = false;
                            });
                          },
                          child: InkWell(
                            onTap: () {
                              // Handle button click here
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                setState(() {
                                  loader = true;
                                });
                                formdataupload(widget.data);
                                // Form data is valid, you can handle the submission here.
                                print('Name: $_name');
                                print('Email: $_email');
                                print('Phone Number: $_phoneNumber');
                                print('Message: $_message');
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              decoration: BoxDecoration(
                                color: _isHovered
                                    ? const Color.fromARGB(255, 196, 131, 28)
                                    : const Color(
                                        0xffF9A51F), // Change color on hover
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: loader
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                  : const Text(
                                      'SUBMIT',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
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
}
