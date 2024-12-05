import 'package:buildittt/providers/LoadingNoteBarcodeProvider.dart';
import 'package:buildittt/providers/authProvider/loginScreenProvider.dart';
import 'package:buildittt/providers/authProvider/singupProvider.dart';
import 'package:buildittt/providers/bottomNavBarProvider.dart';
import 'package:buildittt/providers/downloadFIleProvider.dart';
import 'package:buildittt/providers/homeToSearch.dart';
import 'package:buildittt/providers/loadingNoteProvider.dart';
import 'package:buildittt/providers/scanProvider.dart';
import 'package:buildittt/providers/searchBarHomeProvider.dart';
import 'package:buildittt/screens/landingPage.dart';
import 'package:buildittt/utils/appTheme.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Downloadfileprovider()
          ),
  
        ChangeNotifierProvider(
          create: (context) => SignupProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) =>SearchProvider() ,
        ),
        ChangeNotifierProvider(
          create: (context) => Hometosearch(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => scanLocationBarcode(),
        ),
         ChangeNotifierProvider(create: (_) => LoadingNoteProvider()),
        ChangeNotifierProvider(create: (_) => BarcodeProvider()),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Apptheme.theme,
        home: Landingpage(),
      ),
    );
  }
}
