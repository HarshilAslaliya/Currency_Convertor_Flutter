import 'package:currency_convertor/controller/themeprovider.dart';
import 'package:currency_convertor/model/globals.dart';
import 'package:currency_convertor/views/screens/homepage.dart';
import 'package:currency_convertor/views/screens/splashpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          theme: provider.theme,
          debugShowCheckedModeBanner: false,
          initialRoute: 'splash',
          routes: {
            '/': (context) => HomePage(),
            'splash':(context)=>SplashPage(),
          },
        );
      },
    );
  }
}
