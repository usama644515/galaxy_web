import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
// ...


class ImageViewer extends StatefulWidget {
  final images, controller;
  const ImageViewer({Key? key, this.images, this.controller}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // PhotoViewController controller = PhotoViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                disableGestures: true,
                imageProvider:CachedNetworkImageProvider(widget.images[index]),
                initialScale: PhotoViewComputedScale.contained * 0.9,
                heroAttributes: PhotoViewHeroAttributes(tag: widget.images[index]),
              );
            },
            itemCount: widget.images.length,
            pageController: widget.controller,
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  color: const Color(0xffF9A51F),
                  value: event == null
                      ? 0: 2
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

