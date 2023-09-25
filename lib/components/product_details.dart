import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_web/components/footer.dart';
import 'package:galaxy_web/components/footer_mobile.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      height: 30,
                    ),
              Responsive.isMobile(context)
                  ? ProductDetailsMobile(data: widget.data)
                  : DesktopProductDetails(data: widget.data),
              const SizedBox(
                height: 25,
              ),
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
                      _showBottomSheet(context);
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
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isHovered
                                ? const Color.fromARGB(255, 202, 136, 29)
                                : const Color(0xffF9A51F),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: const Offset(0, 3), // Shadow offset
                              ),
                            ],
                          ),
                          child: const Icon(Icons.email,
                              color: Colors.white, size: 27)),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
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
                              child: const Center(
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                        return CachedNetworkImage(
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
                              backgroundColor: Colors.grey,
                              // color: AppColor.primary,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
                              child: const Text(
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
                        // Container(
                        //   width: MediaQuery.of(context).size.width * 0.43,
                        //   decoration: const BoxDecoration(
                        //     color: Color(0xffF8F8F8),
                        //   ),
                        //   child:  Padding(
                        //     padding: const EdgeInsets.only(
                        //         left: 15.0,
                        //         right: 15.0,
                        //         top: 11.0,
                        //         bottom: 11.0),
                        //     child: Row(
                        //       children: [
                        //         const Text(
                        //           'Baths',
                        //           overflow: TextOverflow.ellipsis,
                        //           style: TextStyle(
                        //               fontSize: 17.0,
                        //               fontWeight: FontWeight.w500),
                        //         ),
                        //         SizedBox(width: MediaQuery.of(context).size.width*0.2),
                        //         const Text(
                        //           '3',
                        //           overflow: TextOverflow.ellipsis,
                        //           style: TextStyle(
                        //               fontSize: 17.0,
                        //               fontWeight: FontWeight.w500),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
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