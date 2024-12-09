import 'package:flutter/material.dart';
import '../widgets/custom_keyboard.dart';

class VolumeConversionScreen extends StatefulWidget {
  @override
  _VolumeConversionScreenState createState() => _VolumeConversionScreenState();
}

class _VolumeConversionScreenState extends State<VolumeConversionScreen> {
  String selectedUnitFrom = 'л';
  String selectedUnitTo = 'мл';
  String activeField = 'from';
  String inputValue = '0';
  String convertedValue = '0';

  void _updateConversion() {
    double input = double.tryParse(inputValue) ?? 0.0;
    setState(() {
      if (selectedUnitFrom == selectedUnitTo) {
        convertedValue = _formatNumber(input);
      } else if (selectedUnitFrom == 'л' && selectedUnitTo == 'мл') {
        convertedValue = _formatNumber(input * 1000);
      } else if (selectedUnitFrom == 'л' && selectedUnitTo == 'м³') {
        convertedValue = _formatNumber(input / 1000);
      } else if (selectedUnitFrom == 'мл' && selectedUnitTo == 'л') {
        convertedValue = _formatNumber(input / 1000);
      } else if (selectedUnitFrom == 'мл' && selectedUnitTo == 'м³') {
        convertedValue = _formatNumber(input / 1000000);
      } else if (selectedUnitFrom == 'м³' && selectedUnitTo == 'л') {
        convertedValue = _formatNumber(input * 1000);
      } else if (selectedUnitFrom == 'м³' && selectedUnitTo == 'мл') {
        convertedValue = _formatNumber(input * 1000000);
      }
    });
  }

  String _formatNumber(double number) {
    return number
        .toStringAsFixed(6)
        .replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');
  }

  void _handleKeyPress(String key) {
    setState(() {
      if (key == 'C') {
        inputValue = '0';
      } else if (key == 'DEL') {
        inputValue = inputValue.length > 1
            ? inputValue.substring(0, inputValue.length - 1)
            : '0';
      } else if (key == '.' && inputValue.contains('.')) {
        return;
      } else {
        inputValue = inputValue == '0' ? key : inputValue + key;
      }
      _updateConversion();
    });
  }

  Future<void> _selectUnit(BuildContext context, bool isFrom) async {
    final units = ['л', 'мл', 'м³'];
    final selectedUnit = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Выберите единицу'),
        children: units
            .map((unit) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, unit),
                  child: Text(unit),
                ))
            .toList(),
      ),
    );

    if (selectedUnit != null) {
      setState(() {
        if (isFrom) {
          selectedUnitFrom = selectedUnit;
        } else {
          selectedUnitTo = selectedUnit;
        }
        _updateConversion();
      });
    }
  }

  void _swapUnits() {
    setState(() {
      String temp = selectedUnitFrom;
      selectedUnitFrom = selectedUnitTo;
      selectedUnitTo = temp;
      _updateConversion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Перерасчёт объёма'),
        leading: BackButton(),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                activeField = 'from';
              });
            },
            child: ListTile(
              title: Text(selectedUnitFrom),
              trailing: Text(
                inputValue,
                style: TextStyle(
                  color: activeField == 'from' ? Colors.orange : Colors.black,
                ),
              ),
              onTap: () => _selectUnit(context, true),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                activeField = 'to';
              });
            },
            child: ListTile(
              title: Text(selectedUnitTo),
              trailing: Text(
                convertedValue,
                style: TextStyle(
                  color: activeField == 'to' ? Colors.orange : Colors.black,
                ),
              ),
              onTap: () => _selectUnit(context, false),
            ),
          ),
          Spacer(),
          CustomKeyboard(
            onKeyPressed: _handleKeyPress,
            onSwapPressed: _swapUnits,
          ),
        ],
      ),
    );
  }
}
