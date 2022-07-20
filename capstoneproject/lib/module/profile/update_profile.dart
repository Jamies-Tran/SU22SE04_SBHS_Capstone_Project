// import 'package:flutter/material.dart';
//
// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';
//
// class UpdateProfile extends StatefulWidget {
//   final String name, photoProfile, uid;
//   const UpdateProfile({
//     Key? key,
//     required this.name,
//     required this.photoProfile,
//     required this.uid,
//   }) : super(key: key);
//
//   @override
//   _UpdateProfileState createState() => _UpdateProfileState();
// }
//
// class _UpdateProfileState extends State<UpdateProfile> {
//   late TextEditingController nameController, countryController, cityController;
//   String name = "";
//   var profilePicUrl;
//   File? _image;
//   late String filename;
//   late String data;
//   bool imageUpload = true;
//   Future getData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String dataIn = prefs.getString("clockin") ?? 'default';
//     return dataIn;
//   }
//
//   callme() async {
//     await Future.delayed(const Duration(seconds: 15));
//     getData().then((value) => {
//           setState(() {
//             data = value;
//             data = "test";
//           })
//         });
//   }
//
//   @override
//   void initState() {
//     if (profilePicUrl == null) {
//       setState(() {
//         profilePicUrl = widget.photoProfile;
//       });
//     }
//
//     callme();
//     nameController = TextEditingController(text: widget.name);
//     super.initState();
//   }
//
//   // Future getImage() async {
//   //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//   //
//   //   setState(() {
//   //     _image = File(image!.path);
//   //     print('Image Path $_image');
//   //   });
//   // }
//
//   Future uploadPic(BuildContext context) async {
//     // String fileName = basename(_image.path);
//     // FirebaseStorage storage = FirebaseStorage.instance;
//
//     // Reference ref = storage.ref().child("image1" + DateTime.now().toString());
//     // UploadTask uploadTask = ref.putFile(_image);
//     // uploadTask.then((res) {
//     //   res.ref.getDownloadURL();
//     // });
//     // setState(() {
//     //   print("Profile Picture uploaded");
//     //   ScaffoldMessenger.of(context)
//     //       .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
//     // });
//
//     // setState(() {
//     //   print("Profile Picture uploaded");
//     //   ScaffoldMessenger.of(context)
//     //       .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
//     // });
//   }
//
//   // Future selectPhoto() async {
//   //   // ignore: deprecated_member_use
//   //   await ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
//   //     setState(() {
//   //       _image = File(image!.path);
//   //       filename = basename(_image!.path);
//   //       uploadImage();
//   //     });
//   //   });
//   // }
//
//   Future uploadImage() async {}
//   //   FirebaseStorage storage = FirebaseStorage.instance;
//
//   //   Reference ref = storage.ref().child("image1" + DateTime.now().toString());
//   //   UploadTask uploadTask = ref.putFile(_image);
//
//   //   // Waits till the file is uploaded then stores the download url
//   //   // Uri location = (await uploadTask.).downloadUrl;
//   //   // TaskSnapshot taskSnapshot =
//   //   //     await ref.putFile(_image).whenComplete(() => ref.getDownloadURL());
//   //   // print("dsad" + taskSnapshot.ref.getDownloadURL().toString());
//
//   //   String image = "dsadas";
//   //   FirebaseStorage.instance
//   //       .refFromURL(image)
//   //       .getDownloadURL()
//   //       .then((url) async {
//   //     print("irl " + url);
//   //   });
//
//   //   uploadTask.then((res) {
//   //     String linkPP = res.ref.getDownloadURL().toString();
//   //     print(linkPP);
//   //     // print('File Uploaded');
//   //     profilePicUrl = res.toString();
//   //     if (profilePicUrl == null) {
//   //       imageUpload = false;
//   //     }
//   //     setState(() {
//   //       profilePicUrl = res.toString();
//   //     });
//
//   //     print("download urls = $linkPP");
//   //     return linkPP;
//   //   });
//   // }
//
//   updateData() async {
//     // await FirebaseFirestore.instance
//     //     .collection('users')
//     //     .doc(widget.uid)
//     //     .update({
//     //   "name": nameController.text,
//     //   'photoProfile': profilePicUrl.toString(),
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             )),
//         elevation: 0.0,
//         title: const Text('Edit Profile',
//             style: TextStyle(
//                 fontFamily: "Poppins", fontSize: 17.0, color: Colors.black)),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             const SizedBox(
//               height: 30.0,
//             ),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     height: 140.0,
//                     width: 140.0,
//                     decoration: BoxDecoration(
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(80.0)),
//                         color: Colors.blueAccent,
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.black12.withOpacity(0.1),
//                               blurRadius: 10.0,
//                               spreadRadius: 4.0)
//                         ]),
//                     child: imageUpload
//                         // ignore: unnecessary_null_comparison
//                         ? _image == null
//                             ? Stack(
//                                 children: <Widget>[
//                                   CircleAvatar(
//                                     backgroundColor: Colors.blueAccent,
//                                     radius: 170.0,
//                                     backgroundImage:
//                                         NetworkImage(widget.photoProfile),
//                                   ),
//                                   Align(
//                                     alignment: Alignment.bottomRight,
//                                     child: InkWell(
//                                       onTap: () {
//                                         // selectPhoto();
//                                       },
//                                       child: Container(
//                                         height: 45.0,
//                                         width: 45.0,
//                                         decoration: const BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(50.0)),
//                                           color: Colors.blueAccent,
//                                         ),
//                                         child: const Center(
//                                           child: Icon(
//                                             Icons.camera_alt,
//                                             color: Colors.white,
//                                             size: 18.0,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             // ignore: unnecessary_null_comparison
//                             : data == null
//                                 ? const CircularProgressIndicator(
//                                     backgroundColor: Colors.red,
//                                   )
//                                 : CircleAvatar(
//                                     backgroundImage: FileImage(_image!),
//                                     radius: 220.0,
//                                   )
//                         : const CircularProgressIndicator(
//                             backgroundColor: Colors.white,
//                           ),
//                   ),
//                   const SizedBox(
//                     height: 10.0,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 50.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//               child: Container(
//                 height: 50.0,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                           blurRadius: 10.0,
//                           color: Colors.black12.withOpacity(0.1)),
//                     ],
//                     color: Colors.white,
//                     borderRadius:
//                         const BorderRadius.all(Radius.circular(40.0))),
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//                     child: Theme(
//                       data: ThemeData(
//                         highlightColor: Colors.white,
//                         hintColor: Colors.white,
//                       ),
//                       child: TextFormField(
//                           style: const TextStyle(
//                               color: Colors.black87, fontFamily: "Sofia"),
//                           controller: nameController,
//                           decoration: const InputDecoration(
//                             hintText: 'Name',
//                             hintStyle: TextStyle(
//                                 color: Colors.black54, fontFamily: "Sofia"),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.white,
//                                   width: 1.0,
//                                   style: BorderStyle.none),
//                             ),
//                           )),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 80.0,
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.only(left: 15.0, right: 15.0, top: 150.0),
//                 child: InkWell(
//                   onTap: () {
//                     updateData();
//                     _showDialog(context);
//                   },
//                   child: Container(
//                     height: 55.0,
//                     width: double.infinity,
//                     child: const Center(
//                       child: Text('Update Profile',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 17.0,
//                               fontFamily: "Sofia")),
//                     ),
//                     decoration: const BoxDecoration(
//                       color: Color(0xFF09314F),
//                       borderRadius: BorderRadius.all(Radius.circular(40.0)),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// Card Popup if success payment
// _showDialog(BuildContext ctx) {
//   showDialog(
//     context: ctx,
//     barrierDismissible: true,
//     builder: (BuildContext context) => SimpleDialog(
//       children: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Padding(
//                 padding: const EdgeInsets.only(left: 10.0),
//                 child: InkWell(
//                     onTap: () {
//                       Navigator.of(ctx).pop();
//                     },
//                     child: const Icon(
//                       Icons.close,
//                       size: 30.0,
//                     ))),
//             const SizedBox(
//               width: 10.0,
//             )
//           ],
//         ),
//         Container(
//             padding: const EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
//             color: Colors.white,
//             child: const Icon(
//               Icons.check_circle,
//               size: 150.0,
//               color: Colors.green,
//             )),
//         const Center(
//             child: Padding(
//           padding: EdgeInsets.only(top: 16.0),
//           child: Text(
//             'Success',
//             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0),
//           ),
//         )),
//         const Center(
//             child: Padding(
//           padding: EdgeInsets.only(top: 30.0, bottom: 40.0),
//           child: Text(
//             'Update Profile Success',
//             style: TextStyle(fontSize: 17.0),
//           ),
//         )),
//       ],
//     ),
//   );
// }
