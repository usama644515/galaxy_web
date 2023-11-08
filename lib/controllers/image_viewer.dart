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
      // appBar: AppBar(backgroundColor: Colors.black,),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: widget.images.length,
            pageController: widget.controller,
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                    color: const Color(0xffF9A51F),
                    value: event == null ? 0 : 2),
              ),
            ),
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          // ios back button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.03,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/galaxy-realtors-builders.appspot.com/o/icon%2Farrow%20left.png?alt=media&token=4f23b9ce-7c61-4223-940c-ea3f5bd14c24&_gl=1*blgm6y*_ga*MjA0NDc2NTQ3NC4xNjk1ODk1OTcx*_ga_CW55HF8NVT*MTY5ODkwNjA5My43Ny4xLjE2OTg5MDY2MTAuNjAuMC4w',
                width: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
