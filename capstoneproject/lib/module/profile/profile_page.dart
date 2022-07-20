import 'dart:io';
import 'dart:io';

import 'package:capstoneproject/data/repository/user_repository.dart';
import 'package:capstoneproject/data/service/user_service.dart';
import 'package:capstoneproject/hive/hive_service.dart';
import 'package:capstoneproject/injection/injection.dart';
import 'package:capstoneproject/module/login/login_page.dart';
import 'package:capstoneproject/module/profile/call_center.dart';
import 'package:capstoneproject/module/profile/credit_card.dart';
import 'package:capstoneproject/module/profile/edit_profile_page.dart';
import 'package:capstoneproject/module/profile/profile_cubit.dart';
import 'package:capstoneproject/module/profile/update_profile.dart';
import 'package:capstoneproject/ui_kit/cubit/loading_cubit.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared_code/model/user_response.dart';
import '../../utils/materials/constant.dart';

class ProfilePage extends StatefulWidget {
  final String userID;

  const ProfilePage({Key? key, required this.userID}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _file;
  late UserService userService = UserService();
  late UserRepository repository = UserRepository(userService: userService);
  late ProfileCubit cubit = ProfileCubit(repository: repository);
  late LoadingCubit loadingCubit = LoadingCubit();
  ValueNotifier<String> avatarUrl = ValueNotifier("");

  @override
  void initState() {
    cubit.getUserInfo();
    cubit.stream.listen((state) {
      if (state is ProfileStateLoading) {
        loadingCubit.showLoading();
      } else if (state is ProfileStateSuccess) {
        loadingCubit.hideLoading();
        avatarUrl.value = state.user.avatarPath!;
      } else if (state is ProfileStateFailure) {
        loadingCubit.hideLoading();
      } else if (state is UpdateProfileStateSucessull) {
        cubit.getUserInfo();
      }
    });
  }

  _logout() async {
    getIt<HiveService>().updateToken("");
    Navigator.pushReplacement(context, LoginPage.route());
  }

  _launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.lvsang.guitar_chords';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 300.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: () {
                        print('xs');
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 16),
                        // margin: const EdgeInsets.only(top: 16),
                        child: Category(
                            txt: 'Edit Profile',
                            image: "assets/image/icon/profile.png",
                            padding: 20.0,
                            tap: () => Navigator.push(context,
                                EditProfilePage.route(profileCubit: cubit))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchURL();
                      },
                      child: Category(
                        txt: 'About Us',
                        image: "assets/image/icon/box.png",
                        padding: 20.0,
                        tap: () => _launchURL(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _logout(),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, left: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Icon(
                                        Icons.login,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Sofia",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black26,
                                    size: 15.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Divider(
                            color: Colors.black12,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is ProfileStateSuccess) {
                      var user = state.user;
                      getIt<HiveService>().updateAvatar(state.user.avatarPath!);
                      return _buildWall(user);
                    } else {
                      return Container();
                    }
                  }),
            ]),
            Air18Loading(loadingCubit: loadingCubit)
          ],
        ),
      ),
    );
  }

  Widget _buildWall(Data user) {
    return Container(
      height: 352.0,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/image/images/bannerProfile.png",
              ),
              fit: BoxFit.cover)),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 67.0, left: 20.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => showPickImageBottomSheet(),
                  child: Container(
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("$baseUrl${user.avatarPath}"),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 10.0,
                              spreadRadius: 2.0)
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user.fullName}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0),
                        ),
                        Text(
                          "${user.email}",
                          style: const TextStyle(
                              color: Colors.black38,
                              fontFamily: "Sofia",
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                      ]),
                ),
              ]),
        ),
      ),
    );
  }

  void showPickImageBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: 128,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.picture_in_picture),
                  title: const Text("Gallery"),
                  onTap: () async {
                    pickImage(ImageSource.gallery);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text("Camera"),
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
      // widget.onPicker(_file!);
      // Map<String, dynamic> data = {
      //   "newAvatar" : File(_file!.path)
      // };

      await cubit.updateAvatar(_file!.path);
      // print(_file);
    } else {
      print('No image selected.');
    }
    setState(() {});
  }
}

/// Component category class to set list
class Category extends StatelessWidget {
  final String txt, image;
  final GestureTapCallback tap;
  final double padding;

  const Category(
      {Key? key,
      required this.txt,
      required this.image,
      required this.tap,
      required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: padding),
                      child: Image.asset(
                        image,
                        height: 25.0,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        txt,
                        style: const TextStyle(
                          fontSize: 14.5,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Sofia",
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black26,
                    size: 15.0,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Divider(
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
