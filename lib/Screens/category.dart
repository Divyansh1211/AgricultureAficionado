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
            child: Row(
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
        backgroundColor: Color(0xFFF5C228),
        title: Image(
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
            CategoryList(
              txt: 'Expert Analysis',
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final String? txt;
  CategoryList({
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(15),
        height: 100,
        width: 350,
        decoration: BoxDecoration(
          color: Color(0xFFADADAD),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
            child: Text(
          txt!,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
