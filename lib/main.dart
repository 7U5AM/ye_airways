import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ye_airways/provider/destination_provider.dart';
import 'package:ye_airways/provider/flight_provider.dart';
import 'package:ye_airways/route.dart';
import 'package:ye_airways/shared/components/components.dart';
import 'package:ye_airways/shared/components/constantes.dart';
import 'package:ye_airways/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ye_airways/view/screen/splash/splash_page.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHlper.init();
  await Firebase.initializeApp();
  uid = CacheHlper.getData(key: "uid") ?? "";
  print("User = ${uid != "" ? uid : Null} =-=-=-=-=-=-=-=-=-=-");

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DestinationProvider(),
        ),
        ChangeNotifierProvider(create: (context) => FlightProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (!snapshot.hasData && uid == "") {
              // return VerifyEmailPage();
              return const SplashHome(); // home() OR verify email
            } else {
              return const SplashHome();
            }
          },
        ),
        debugShowCheckedModeBanner: false,
        title: 'YEMENAI Reservation System',
        routes: routes,
      ),
    );
  }
}
