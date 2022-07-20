import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:mime_type/mime_type.dart';

class FowImagePickerView extends StatefulWidget {
  final String title;
  final ValueChanged<File> onPicker;
  final BoxShape boxShape;
  final double ratio;
  final TextStyle? style;
  final String url;
  final Widget? placeHolder;

  FowImagePickerView(
      {required this.title,
      required this.onPicker,
      this.style,
      this.ratio = 1.0,
      this.url = '',
      this.placeHolder,
      this.boxShape = BoxShape.circle});

  @override
  _FowImagePickerViewState createState() => _FowImagePickerViewState();
}

class _FowImagePickerViewState extends State<FowImagePickerView> {
  File? _file;

  Widget buildShape() {
    return widget.boxShape == BoxShape.circle
        ? ClipOval(
            child: Image.file(
              _file!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(
              _file!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          );
  }

  Widget buildShapeUrl() {
    return widget.boxShape == BoxShape.circle
        ? ClipOval(
            child: CachedNetworkImage(
              imageUrl: widget.url,
              fit: BoxFit.cover,
              width: 128,
              height: 128,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: widget.url,
              fit: BoxFit.cover,
              width: 128,
              height: 128,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.placeHolder ??
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: RDottedLineBorder.all(
              width: 2,
              dottedLength: 10,
              dottedSpace: 4,
            ),
          ),
          child: Center(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: widget.style ??
                  GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black),
            ),
          ),
        );
    if (_file != null)
      child = buildShape();
    else if (widget.url.isNotEmpty) child = buildShapeUrl();

    return Container(
        child: AspectRatio(
      aspectRatio: widget.ratio,
      child: InkWell(
        onTap: () {
          showPickImageBottomSheet();
        },
        child: child,
      ),
    ));
  }

  void showPickImageBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 128,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.picture_in_picture),
                  title: Text("Gallery"),
                  onTap: () async {
                    pickImage(ImageSource.gallery);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                  onTap: () async {
                    pickImage(ImageSource.camera);
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> pickImage(ImageSource imageSource) async {
    final _picker = ImagePicker();
    Navigator.pop(context);
    final pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      _file = File(pickedFile.path);

      // String? mimeType = mime(_file!.path);
      // if(mimeType == 'image/gif' || mimeType == 'image/webp'){
      //   showNotification();
      //   _file = null;
      // }
      widget.onPicker(_file!);
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  // void showNotification(){
  //   showDialog(context: context, builder: (context)=> NotificationDialog(
  //       title: labels.updateProfile2Text53,
  //       content: labels.updateProfile2Text54,
  //       onPositiveTap: (){
  //         Navigator.pop(context);
  //       },
  //       onNegativeTap: (){},
  //       positive: labels.updateProfile2Text45,
  //       isShowNegative: false,
  //     ),
  //   );
  // }
}
