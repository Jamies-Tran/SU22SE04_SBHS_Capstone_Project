import 'package:capstoneproject/ui_kit/colors.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String imageUrl;

  const ImageView({Key? key, required this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(214, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: BookHotelColors.darkBlueColor),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            )),
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: InteractiveViewer(
            panEnabled: false, // Set it to false
            boundaryMargin: const EdgeInsets.all(80),
            minScale: 1,
            maxScale: 4,
            child: Image.network(
              "https://airj18.skqist225.xyz" + imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
