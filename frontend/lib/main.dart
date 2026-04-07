import 'package:flutter/material.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:frontend/providers/categoryProvider.dart';
import 'package:frontend/providers/feedbackProvider.dart';
import 'package:frontend/providers/reportProvider.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:frontend/screens/adminScreen.dart';
import 'package:frontend/screens/auth/loginPage.dart';
import 'package:frontend/screens/userScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => Userprovider()),
        ChangeNotifierProvider(create: (context) => ReportProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context_) => Feedbackprovider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fixICT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IBM',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D52)),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (!authProvider.isAuthenticate) {
      return Loginpage();
    }

    if (authProvider.userdata?.role == "ADMIN") {
      return const AdminMainScreen();
    }

    return const UserMainScreen();
  }
}
