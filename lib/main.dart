import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:napiapp/firebase_options.dart';
import 'package:napiapp/screens/napi_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Belanja',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor:  Color.fromARGB(255, 90, 175, 245)),
      ),
      home: const NapiListScreen(),
    );
  }
}
