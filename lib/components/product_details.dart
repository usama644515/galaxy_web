import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/components/footer.dart';
import 'package:galaxy_web/components/footer_mobile.dart';
import 'package:galaxy_web/components/productlist.dart';
import 'package:galaxy_web/controllers/MenuController.dart';
import 'package:galaxy_web/controllers/image_viewer.dart';
import 'package:galaxy_web/main/home.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../responsive.dart';
import 'mobile_navbar.dart';
import 'navbar.dart';
import 'product_details_mobile.dart';
import 'side_drawer.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, this.data});
  final data;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
  _openWhatsApp() async {
    final phoneNumber =
        '923000335875'; // Replace with the recipient's phone number
    final message = 'Hello from Flutter!'; // Replace with your message
    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';

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
      Provider.of<menuController>(context, listen: false)
          .navmenueSelect('Home');
    });
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Home()),
      (route) => false, // Always return false to remove all routes
    );
    return Future.value(false);
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
            ListView(
              children: [
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
                Responsive.isMobile(context)
                    ? const SizedBox()
                    : const SizedBox(
                        height: 0,
                      ),
                Responsive.isMobile(context)
                    ? ProductDetailsMobile(data: widget.data)
                    : DesktopProductDetails(data: widget.data),
                widget.data['videoUrl'] == ''
                    ? const SizedBox()
                    : const SizedBox(
                        height: 25,
                      ),
                widget.data['videoUrl'] == ''
                    ? const SizedBox()
                    : Padding(
                        padding: EdgeInsets.only(
                            left: Responsive.isMobile(context) ? 20 : 50.0,
                            right: Responsive.isMobile(context)
                                ? 20
                                : MediaQuery.of(context).size.width * 0.65,
                            top: 5.0),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              _openURL(widget.data['videoUrl']);
                            },
                            child: Container(
                              height: Responsive.isMobile(context) ? 200 : 230,
                              width: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey, // Shadow color
                                    offset:
                                        Offset(0, 3), // Offset of the shadow
                                    blurRadius: 6, // Spread of the shadow
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${widget.data['img'][0]}'), // Replace with your image asset path
                                  fit: BoxFit
                                      .cover, // You can choose how the image is displayed (cover, contain, etc.)
                                ),
                              ),
                              child: Center(
                                child: Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/youtube%20(1).png?alt=media&token=6866c794-63ef-493a-86cc-a14af27e143e&_gl=1*11bm5bg*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NjE0MzA5MS42LjEuMTY5NjE0MzIwNi40Ny4wLjA.',
                                  height: 50.0,
                                  width: 50.0,
                                ),
                              ),
                            ),
                          ),
                        )),
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
                        "Recent Projects",
                        style: TextStyle(
                            fontSize:
                                Responsive.isMobile(context) ? 20.0 : 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const ProductList(),
                Responsive.isMobile(context)
                    ? const FooterMobile()
                    : const Footer(),
              ],
            ),
            Responsive.isMobile(context)
                ? Positioned(
                    bottom: 15.0,
                    right: 15.0,
                    child: GestureDetector(
                      onTap: () {
                        _openWhatsApp();
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
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Fwhatsapp.png?alt=media&token=89a781dc-cdc9-424c-96dc-d996eaabd8ae&_gl=1*tgw0tl*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5NzcwOTk0Ni40MC4xLjE2OTc3MDk5ODMuMjMuMC4w',
                            height: 60,
                            width: 60),
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
                              formdataupload(widget.data);
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
}

class DesktopProductDetails extends StatefulWidget {
  const DesktopProductDetails({super.key, this.data});
  final data;
  @override
  State<DesktopProductDetails> createState() => _DesktopProductDetailsState();
}

class _DesktopProductDetailsState extends State<DesktopProductDetails> {
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
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 500.0,
                        viewportFraction: 1,
                        aspectRatio: 16 / 9,
                        autoPlay: false,

                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        // enlargeCenterPage: true,
                      ),
                      itemCount: widget.data['img'].length,
                      itemBuilder: (context, itemIndex, realIndex) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageViewer(
                                          images: widget.data['img'],
                                          controller: controller,
                                        )));
                          },
                          child: CachedNetworkImage(
                            imageUrl: widget.data['img'][itemIndex],
                            imageBuilder: (context, imageProvider) => Container(
                              height: 500.0,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              alignment: Alignment.topCenter,
                              margin: const EdgeInsets.only(top: 40.0),
                              child: const CircularProgressIndicator(
                                color: Color(0xffF9A51F),
                                // color: AppColor.primary,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "PKR ${widget.data['price']}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.data['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w700),
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
                        const Text('MAKE AN ENQUIRY',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600)),
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
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                    child: Text(
                      'Overview',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Divider(color: Colors.grey, thickness: 0.5),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                    child: Text(
                      'Details & Description',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: const BoxDecoration(
                            color: Color(0xffF8F8F8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 11.0,
                                bottom: 11.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Property ID:',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2),
                                Text(
                                  widget.data['id'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: const BoxDecoration(
                            color: Color(0xffF8F8F8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 11.0,
                                bottom: 11.0),
                            child: Row(
                              children: [
                                const Text(
                                  'City:',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2),
                                Text(
                                  widget.data['city'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: const BoxDecoration(
                            color: Color(0xffF8F8F8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 11.0,
                                bottom: 11.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Locality:',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2),
                                Text(
                                  widget.data['location'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: const BoxDecoration(
                            color: Color(0xffF8F8F8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 11.0,
                                bottom: 11.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Size:',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2),
                                Text(
                                  widget.data['size'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: const BoxDecoration(
                            color: Color(0xffF8F8F8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 11.0,
                                bottom: 11.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Rooms:',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2),
                                Text(
                                  widget.data['rooms'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: const BoxDecoration(
                            color: Color(0xffF8F8F8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 11.0,
                                bottom: 11.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Baths:',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2),
                                Text(
                                  widget.data['bath'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: const BoxDecoration(
                            color: Color(0xffF8F8F8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 11.0,
                                bottom: 11.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Price:',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2),
                                Text(
                                  "PKR ${widget.data['price']}",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: const BoxDecoration(
                            color: Color(0xffF8F8F8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 11.0,
                                bottom: 11.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Car Porch',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2),
                                Text(
                                  widget.data['garage'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 30.0),
                    child: MouseRegion(
                        cursor: SystemMouseCursors.text,
                        child: Text(widget.data['description'],
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w400))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
