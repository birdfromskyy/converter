import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> units = [
    {'title': 'Длина', 'route': '/length'},
    {'title': 'Площадь', 'route': '/area'},
    {'title': 'Объём', 'route': '/volume'},
    {'title': 'Скорость', 'route': '/speed'},
    {'title': 'Масса', 'route': '/mass'},
    {'title': 'Температура', 'route': '/temperature'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Конвертер величин',
          style: TextStyle(
            color: Colors.orange,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: units.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, units[index]['route']!),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  units[index]['title']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
