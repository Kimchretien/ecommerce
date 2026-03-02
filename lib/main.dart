//import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/pages/redirection_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
   Stripe.publishableKey = "pk_test_51T4KyJBjojLkMY5ejDnPdMgCdWpIW45KI2AFfQe7kUP4Z8X15T6YlwehY6YNRTE0khzwJK4YKr9I0ILa0H6cJTHS00VMJ38Cls";

  await Stripe.instance.applySettings();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,

        // 🎨 Couleur principale
        primaryColor: const Color(0xFF2563EB),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          primary: const Color(0xFF2563EB),
          secondary: const Color(0xFF111827),
          background: const Color(0xFFF3F4F6),
        ),

        scaffoldBackgroundColor: const Color(0xFFF3F4F6),

        // 🟦 AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2563EB),
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        // 🔘 Boutons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1D4ED8),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        // 🧾 Cards
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // 🔤 Texte
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF000000)),
        ),
      ),
      home: const RedirectionPage()
    );
  }
}

