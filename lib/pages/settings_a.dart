import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsA extends StatefulWidget {
  const SettingsA({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsA> {
  late SharedPreferences _preferences;
  late double _currentSliderValue;

  @override
  void initState() {
    initPreferences();
    super.initState();
  }

  initPreferences() async {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      setState(() {
        _preferences = sp;
        _currentSliderValue = sp.getDouble('key_slider_text_size_value_a') ?? 18;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text('Настройки'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Размер текста = ${_currentSliderValue.toInt()}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Gilroy',
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Slider(
              activeColor: Colors.teal,
              value: _currentSliderValue,
              min: 14,
              max: 40,
              divisions: 50,
              onChanged: (double value) {
                setState(
                  () {
                    _currentSliderValue = value;
                    _preferences.setDouble('key_slider_text_size_value_a', _currentSliderValue);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
