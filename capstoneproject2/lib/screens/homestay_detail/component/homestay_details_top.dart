import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/screens/home_page/home_page_screen.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_cloud_storage_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
import 'package:flutter/material.dart';

class HomestayDetailsTop extends StatefulWidget {
  const HomestayDetailsTop({Key? key, required this.homestayImages}) : super(key: key);
  final List<HomestayImageModel> homestayImages;

  State<HomestayDetailsTop> createState() => _HomestayDetailsTopState();
}

class _HomestayDetailsTopState extends State<HomestayDetailsTop> {
  var topImageUrl;
  final firebaseStorage = locator.get<IFirebaseCloudStorage>();
  int selectedIndex = -1;

  @override
  void initState() {
    topImageUrl = widget.homestayImages[0].url;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        FutureBuilder(
            future: firebaseStorage.getImageDownloadUrl(topImageUrl),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 150,
                  width: double.infinity,
                  // padding: const EdgeInsets.only(right: 10),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/default-image.jpg"), fit: BoxFit.fitWidth),
                  ),
                );
              } else if(snapshot.hasData) {
                String snapshotData = snapshot.data as String;
                return  Container(
                  height: 150,
                  width: double.infinity,
                  // padding: const EdgeInsets.only(right: 10),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(snapshotData), fit: BoxFit.fitWidth),
                  ),
                );
              }

              return const HomePageScreen();
            },
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.homestayImages.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                height: 10,
                width: 250,
                child: FutureBuilder(
                  future: firebaseStorage.getImageDownloadUrl(widget.homestayImages[index].url),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      String snapshotData = snapshot.data as String;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            topImageUrl = widget.homestayImages[index].url;
                            selectedIndex = index;
                          });
                        },

                        child: Container(
                          height: 20,
                          width: 100,
                          // padding: const EdgeInsets.only(right: 10),
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(snapshotData),
                                fit: BoxFit.fill,
                            ),
                            border: Border.all(color: selectedIndex == index ? Colors.green : Colors.grey, width: 4)
                          ),
                        ),
                      );
                    }else if(snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: 100,
                        width: 100,
                        //padding: const EdgeInsets.only(right: 10),
                        margin: const EdgeInsets.only(right: 5),
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/default-image.jpg"), fit: BoxFit.fill),
                        ),
                      );
                    }

                    return const HomePageScreen();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
