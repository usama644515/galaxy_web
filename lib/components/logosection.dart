import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../responsive.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Responsive.isMobile(context) ? 230 : 170,
      decoration: const BoxDecoration(color: Color(0xffF0F0F0)),
      child: Padding(
        padding: EdgeInsets.only(
            left: Responsive.isMobile(context) ? 30 : 150.0,
            right: Responsive.isMobile(context) ? 20 : 150.0),
        child: Responsive.isMobile(context)
            ? MobileLogoSection()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/societies%20logos%2Fbuch%20logo.png?alt=media&token=27e97fa4-e6ef-49f3-b284-bcecbaef960d', // Replace with your image URL
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the radius here
                      child: Image(
                        image: imageProvider,
                        width: 120, // Set the desired width
                        height: 120, // Set the desired height
                        fit: BoxFit.cover,
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xffF9A51F))),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  CachedNetworkImage(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/societies%20logos%2Fdha%20logo.png?alt=media&token=dd551dd5-8e56-497e-8010-21c21d811860', // Replace with your image URL
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the radius here
                      child: Image(
                        image: imageProvider,
                        width: 120, // Set the desired width
                        height: 120, // Set the desired height
                        fit: BoxFit.cover,
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xffF9A51F))),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  CachedNetworkImage(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/societies%20logos%2Fcity%20housing%20logo.png?alt=media&token=eb7a9b26-154f-422c-ad36-4238a6e9bab3', // Replace with your image URL
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the radius here
                      child: Image(
                        image: imageProvider,
                        width: 120, // Set the desired width
                        height: 120, // Set the desired height
                        fit: BoxFit.cover,
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xffF9A51F))),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  CachedNetworkImage(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/societies%20logos%2Fadam%20housing%20logo.png?alt=media&token=acac2ba3-fea0-4ab7-a90d-f3c454a63b6c', // Replace with your image URL
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the radius here
                      child: Image(
                        image: imageProvider,
                        width: 120, // Set the desired width
                        height: 120, // Set the desired height
                        fit: BoxFit.cover,
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xffF9A51F))),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  CachedNetworkImage(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/societies%20logos%2Fsmart%20city%20logo.png?alt=media&token=f923c7e2-f81b-4511-ab19-4128fa544d66', // Replace with your image URL
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the radius here
                      child: Image(
                        image: imageProvider,
                        width: 120, // Set the desired width
                        height: 120, // Set the desired height
                        fit: BoxFit.cover,
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xffF9A51F))),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  CachedNetworkImage(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/societies%20logos%2Froyal%20orchard%20logo.png?alt=media&token=4c9c1229-7735-4e00-9819-d22eaa7ece31', // Replace with your image URL
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the radius here
                      child: Image(
                        image: imageProvider,
                        width: 120, // Set the desired width
                        height: 120, // Set the desired height
                        fit: BoxFit.cover,
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xffF9A51F))),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ],
              ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MobileLogoSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/societies%20logos%2Fbuch%20logo.png?alt=media&token=27e97fa4-e6ef-49f3-b284-bcecbaef960d', // Replace with your image URL
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Set the radius here
                child: Image(
                  image: imageProvider,
                  width: 90, // Set the desired width
                  height: 90, // Set the desired height
                  fit: BoxFit.cover,
                ),
              ),
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: Color(0xffF9A51F))),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/societies%20logos%2Fdha%20logo.png?alt=media&token=dd551dd5-8e56-497e-8010-21c21d811860', // Replace with your image URL
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Set the radius here
                child: Image(
                  image: imageProvider,
                  width: 90, // Set the desired width
                  height: 90, // Set the desired height
                  fit: BoxFit.cover,
                ),
              ),
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: Color(0xffF9A51F))),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/societies%20logos%2Fcity%20housing%20logo.png?alt=media&token=eb7a9b26-154f-422c-ad36-4238a6e9bab3', // Replace with your image URL
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Set the radius here
                child: Image(
                  image: imageProvider,
                  width: 90, // Set the desired width
                  height: 90, // Set the desired height
                  fit: BoxFit.cover,
                ),
              ),
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: Color(0xffF9A51F))),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/societies%20logos%2Fadam%20housing%20logo.png?alt=media&token=acac2ba3-fea0-4ab7-a90d-f3c454a63b6c', // Replace with your image URL
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Set the radius here
                child: Image(
                  image: imageProvider,
                  width: 90, // Set the desired width
                  height: 90, // Set the desired height
                  fit: BoxFit.cover,
                ),
              ),
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: Color(0xffF9A51F))),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/societies%20logos%2Fsmart%20city%20logo.png?alt=media&token=f923c7e2-f81b-4511-ab19-4128fa544d66', // Replace with your image URL
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Set the radius here
                child: Image(
                  image: imageProvider,
                  width: 90, // Set the desired width
                  height: 90, // Set the desired height
                  fit: BoxFit.cover,
                ),
              ),
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: Color(0xffF9A51F))),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/societies%20logos%2Froyal%20orchard%20logo.png?alt=media&token=4c9c1229-7735-4e00-9819-d22eaa7ece31', // Replace with your image URL
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Set the radius here
                child: Image(
                  image: imageProvider,
                  width: 90, // Set the desired width
                  height: 90, // Set the desired height
                  fit: BoxFit.cover,
                ),
              ),
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: Color(0xffF9A51F))),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        ),
      ],
    );
  }
}
