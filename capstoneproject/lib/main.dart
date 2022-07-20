
 import 'package:capstoneproject/common/common.dart';
 import 'package:capstoneproject/module/home/ui/home_page.dart';
 import 'package:capstoneproject/module/on_boarding/travelSelection.dart';
 import 'package:capstoneproject/module/splash_screen/splash_screen.dart';
 import 'package:capstoneproject/shared_code/connective/connection_status_singleton.dart';
 import 'package:capstoneproject/shared_code/dialog_manager/locator.dart';
 import 'package:capstoneproject/shared_code/dialog_manager/managers/dialog_manager.dart';
 import 'package:flutter/services.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter_dotenv/flutter_dotenv.dart';
 import 'package:google_fonts/google_fonts.dart';
 import 'package:hive_flutter/hive_flutter.dart';
 import 'package:shared_preferences/shared_preferences.dart';

 import 'injection/injection.dart';
 import 'module/login/login_page.dart';
 late SharedPreferences sharedPreferences;
 void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   sharedPreferences = await SharedPreferences.getInstance();
   await dotenv.load(fileName: "assets/config/.env");
   await Hive.initFlutter();
   await Hive.openBox('settings');
   configureInjection();
   setupLocator();
   ConnectionStatusSingleton connectionStatus =
   ConnectionStatusSingleton.getInstance();
   connectionStatus.initialize();

   runApp(const MyApp());
 }

 class MyApp extends StatefulWidget {
   const MyApp({Key? key}) : super(key: key);

   @override
   State<MyApp> createState() => _MyAppState();
 }

 class _MyAppState extends State<MyApp> {
   @override
   Widget build(BuildContext context) {
     ///Set color status bar
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
       statusBarColor: Colors.transparent,
     ));

     /// To set orientation always portrait
     SystemChrome.setPreferredOrientations([
       DeviceOrientation.portraitUp,
       DeviceOrientation.portraitDown,
     ]);
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'Book Hotel',
       theme: ThemeData(
         textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
       ),
       initialRoute: Navigator.defaultRouteName,
       builder: (context, widget) => Navigator(
         onGenerateRoute: (settings) => MaterialPageRoute(
           builder: (context) => DialogManager(
             child: widget,
           ),
         ),
       ),
       routes: <String, WidgetBuilder>{
         Navigator.defaultRouteName: (context) => const SplashPage(),
         Route_Named_LoginPage: (context) => const LoginPage(),
         Route_Named_HomePage: (context) => const MainSelection(userID: "11"),
       },
     );
   }
 }
