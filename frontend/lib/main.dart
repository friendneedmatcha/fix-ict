import 'package:flutter/material.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:frontend/screens/formPage.dart';
import 'package:frontend/screens/historryPaage.dart';
import 'package:frontend/screens/homePage.dart';
import 'package:frontend/screens/loginPage.dart';
import 'package:frontend/screens/profilePage.dart';
import 'package:frontend/screens/reportPage.dart';
import 'package:frontend/screens/reportlistPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/widgets/navbar.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
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
  int _selectedPage = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedPage = index);
  }

  final List<Widget> _pages = [
    const HomePage(),
    const FormPage(),
    const HistoryPage(),
    const Loginpage(),
  ];

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: IndexedStack(index: _selectedPage, children: _pages),
      bottomNavigationBar: Navbar(
        selectedIndex: _selectedPage,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
