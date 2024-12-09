import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/length_conversion_screen.dart';
import 'screens/area_conversion_screen.dart';
import 'screens/speed_conversion_screen.dart';
import 'screens/mass_conversion_screen.dart';
import 'screens/temperature_conversion_screen.dart';
import 'screens/volume_conversion_screen.dart';

void main() => runApp(UnitConverterApp());

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/length': (context) => LengthConversionScreen(),
        '/area': (context) => AreaConversionScreen(),
        '/speed': (context) => SpeedConversionScreen(),
        '/mass': (context) => MassConversionScreen(),
        '/temperature': (context) => TemperatureConversionScreen(),
        '/volume': (context) => VolumeConversionScreen(),
      },
    );
  }
}
