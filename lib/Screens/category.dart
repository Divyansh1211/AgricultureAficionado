import 'package:agriculture_aficionado/Components/category_list.dart';
import 'package:agriculture_aficionado/Screens/analysis.dart';
import 'package:agriculture_aficionado/Screens/chat_screen.dart';
import 'package:agriculture_aficionado/Screens/weather_screen.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = 'Category_Screen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, WeatherScreen.id);
            },
            child: const Row(
              children: [
                Text(
                  '28°',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
        backgroundColor: const Color(0xFFF5C228),
        title: const Image(
          image: AssetImage('images/Logo_inverted.png'),
          height: 40,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ChatScreen.id);
              },
              child: CategoryList(
                txt: 'Community Tab',
              ),
            ),
            CategoryList(
              txt: 'Disease Detection',
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Analysis.id);
              },
              child: CategoryList(
                txt: 'AI Analysis',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
