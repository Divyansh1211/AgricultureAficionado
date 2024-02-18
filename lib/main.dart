import 'package:agriculture_aficionado/Provider/chatProvider.dart';
import 'package:agriculture_aficionado/Screens/analysis.dart';
import 'package:agriculture_aficionado/Screens/category.dart';
import 'package:agriculture_aficionado/Screens/chat_screen.dart';
import 'package:agriculture_aficionado/Screens/registration_screen.dart';
import 'package:agriculture_aficionado/Screens/weather_screen.dart';
import 'package:agriculture_aficionado/Screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/login_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: Analysis.id,
        routes: {
          WeatherScreen.id: (context) => WeatherScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          CategoryScreen.id: (context) => const CategoryScreen(),
          Analysis.id: (context) => const Analysis(),
        },
      ),
    );
  }
}
