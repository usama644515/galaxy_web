import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:galaxy_web/controllers/image_viewer.dart';

class ProductDetailsMobile extends StatefulWidget {
  const ProductDetailsMobile({super.key, this.data});
  final data;
  @override
  State<ProductDetailsMobile> createState() => _ProductDetailsMobileState();
}

class _ProductDetailsMobileState extends State<ProductDetailsMobile> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _message = '';
  bool _isHovered = false;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 250.0,
                  viewportFraction: 1,
                  aspectRatio: 16 / 9,
                  autoPlay: true,

                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          // shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.only(top: 40.0),
                        child: const CircularProgressIndicator(
                          color: Color(0xffE5B920),
                          // color: AppColor.primary,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  "PKR ${widget.data['price']}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  widget.data['title'],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 22.0, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
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
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 10.0),
                          child: Text(
                            'Overview',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 23.0, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Divider(color: Colors.grey, thickness: 0.5),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
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
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: const BoxDecoration(
                              color: Color(0xffF8F8F8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 11.0,
                                  bottom: 11.0),
                              child: Stack(
                                children: [
                                  const Text(
                                    'Property ID:',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        0.34,
                                    child: Text(
                                      widget.data['id'],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: const BoxDecoration(
                              color: Color(0xffF8F8F8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 11.0,
                                  bottom: 11.0),
                              child: Stack(
                                children: [
                                  const Text(
                                    'Price:',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        0.34,
                                    child: Text(
                                      "PKR ${widget.data['price']}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: const BoxDecoration(
                              color: Color(0xffF8F8F8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 11.0,
                                  bottom: 11.0),
                              child: Stack(
                                children: [
                                  const Text(
                                    'Locality:',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        0.34,
                                    child: Text(
                                      "${widget.data['location']}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: const BoxDecoration(
                              color: Color(0xffF8F8F8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 11.0,
                                  bottom: 11.0),
                              child: Stack(
                                children: [
                                  const Text(
                                    'City:',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        0.34,
                                    child: Text(
                                      "${widget.data['city']}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: const BoxDecoration(
                              color: Color(0xffF8F8F8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 11.0,
                                  bottom: 11.0),
                              child: Stack(
                                children: [
                                  const Text(
                                    'Size:',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        0.34,
                                    child: Text(
                                      "${widget.data['size']}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: const BoxDecoration(
                              color: Color(0xffF8F8F8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 11.0,
                                  bottom: 11.0),
                              child: Stack(
                                children: [
                                  const Text(
                                    'Rooms:',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        0.34,
                                    child: Text(
                                      "${widget.data['rooms']}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: const BoxDecoration(
                              color: Color(0xffF8F8F8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 11.0,
                                  bottom: 11.0),
                              child: Stack(
                                children: [
                                  const Text(
                                    'Bath:',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        0.34,
                                    child: Text(
                                      "${widget.data['bath']}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: const BoxDecoration(
                              color: Color(0xffF8F8F8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 11.0,
                                  bottom: 11.0),
                              child: Stack(
                                children: [
                                  const Text(
                                    'Car Porch:',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Positioned(
                                    left: MediaQuery.of(context).size.width *
                                        0.34,
                                    child: Text(
                                      "${widget.data['garage']}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 30.0),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.text,
                            child: ExpandableText(
                              widget.data['description'],
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.justify,
                              expandText: 'Show More',
                              collapseText: 'Show Less',
                              linkColor: const Color(0xffE5B920),
                              maxLines:
                                  5, // Adjust the maximum number of lines to show initially
                              expanded: _isExpanded,
                              onExpandedChanged: (isExpanded) {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
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

  bool _isExpanded = false;
}
