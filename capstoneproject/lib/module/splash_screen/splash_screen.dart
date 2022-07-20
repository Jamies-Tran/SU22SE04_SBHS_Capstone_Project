import 'package:capstoneproject/common/common.dart';
import 'package:capstoneproject/common/define_image.dart';
import 'package:capstoneproject/data/shared_preferences/shared_preferences.dart';
import 'package:capstoneproject/hive/hive_service.dart';
import 'package:capstoneproject/injection/injection.dart';
import 'package:capstoneproject/shared_code/responsive/responsive.dart';
import 'package:capstoneproject/utils/materials/app_color.dart';
import 'package:capstoneproject/utils/materials/constant.dart';
import 'package:capstoneproject/utils/materials/system.dart';
import 'package:capstoneproject/utils/methods/common_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:device_info/device_info.dart';

import '../bottom_nav_bar/bottom_nav_bar.dart';

String? cookie;

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  PublishSubject loadConfigurePublishSubject = PublishSubject<dynamic>();
  final deviceInfo = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    _startApp();
    checkPermission();
    _listenConfigureApp();
  }

  @override
  void dispose() {
    super.dispose();
    loadConfigurePublishSubject.close();
  }

  Future<void> _startApp() async {
    // await _loadThemeApp();
    // await _loadLanguageApp();
    await _checkLogin();
  }

  // Future<void> _loadThemeApp() async {
  //   var themeApp = await SPref.instance.get(SPrefCache.THEME_APP);
  //   if (themeApp == null || themeApp.toString().isEmpty) {
  //     themeApp = LIGHT_THEME; // Default Light Mode
  //     await SPref.instance.set(SPrefCache.THEME_APP, themeApp);
  //   }
  //   Provider.of<ThemeState>(context, listen: false).theme = themeApp == LIGHT_THEME ? ThemeType.LIGHT : ThemeType.DARK;
  // }

  // Future<void> _loadLanguageApp() async {
  //   final languageApp = await SPref.instance.getOrDefault(SPrefCache.LANGUAGE_APP, VIETNAMESE_LANGUAGE);
  //   if (languageApp == null || languageApp.toString().isEmpty) {
  //     await SPref.instance.set(SPrefCache.LANGUAGE_APP, VIETNAMESE_LANGUAGE);
  //   }
  //   final languageLocate = languageApp == VIETNAMESE_LANGUAGE
  //       ? EasyLocalization.of(context)!.supportedLocales[0] // Vietnam
  //       : EasyLocalization.of(context)!.supportedLocales[1]; // English
  //   await EasyLocalization.of(context)!.setLocale(languageLocate);
  // }

  Future<void> _checkLogin() async {
    cookie = await SPref.instance.get(SPrefCache.KEY_ACCESS_TOKEN);

    // print Token in console
    printWrappedLog('Token: $cookie');
    loadConfigurePublishSubject.add(cookie);
  }

  void _listenConfigureApp() {
    // Delay 1s
    loadConfigurePublishSubject.stream
        .delay(const Duration(seconds: 1))
        .listen((value) {
      if (value != null && value.toString().isNotEmpty) {
        print('Navigate Splash Screen to Home Page');
        var hive = getIt<HiveService>();
        if (hive.showSelectionPage()) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const BottomNavBar(
                userID: "11",
              ),
            ),
          );
        } else {
          Navigator.pushReplacementNamed(context, Route_Named_HomePage);
        }
        return;
      }
      print('Navigate to Login Page');
      Navigator.pushReplacementNamed(context, Route_Named_LoginPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    sizeDevice = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Image.asset(
                    "assets/images/logo_app.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.scaleDown,
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/banner.png",
                    fit: BoxFit.scaleDown,
                     width: 200,
                    height: 200,
                  ),
                  // const CircularProgressIndicator(
                  //   backgroundColor: Colors.white,
                  //   valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  //   semanticsLabel: 'Loading',
                  // ),
                  const Spacer(),
                  Responsive.isDesktop(context)
                      ? SizedBox()
                      : Container(
                          margin: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '© 2022 - Designed by ',
                                style: TextStyle(
                                  color: AppColor.primaryHintColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Ung_Luan',
                                style: TextStyle(
                                  color: AppColor.colorOrange,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
