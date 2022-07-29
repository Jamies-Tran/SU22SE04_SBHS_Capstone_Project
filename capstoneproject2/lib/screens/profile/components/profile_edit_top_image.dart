import 'package:capstoneproject2/navigator/component/spinkit_component.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_clound_firestore_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';


class ProfileEditScreenTopImage extends StatefulWidget {
  const ProfileEditScreenTopImage({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  State<ProfileEditScreenTopImage> createState() => _ProfileEditScreenTopImageState();
}

class _ProfileEditScreenTopImageState extends State<ProfileEditScreenTopImage> {
  @override
  Widget build(BuildContext context) {
    String photoUrl = widget.user!.photoURL!;
    String displayName = widget.user!.displayName!;
    return Column(
      children: [
        const SizedBox(width: defaultPadding / 2),
        Text(
          displayName.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: AdvancedAvatar(
                  image: NetworkImage(photoUrl),
              )
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
