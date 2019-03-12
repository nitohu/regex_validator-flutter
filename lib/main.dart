import "package:flutter/material.dart";

import "package:shared_preferences/shared_preferences.dart";

import "pages/home.dart";
import "pages/settings.dart";

void main() => runApp(RegexValidator());

class RegexValidator extends StatefulWidget {

  @override
  _RegexValidator createState() {
    return _RegexValidator();
  }

}

class _RegexValidator extends State<RegexValidator> {

  Map<String, bool> settings = {
    "case-sensitive": true,
    "multiline": true,
    "darkmode": false
  };

  void toggleSettings({bool toggleIgnoreCase = false, bool toggleMultiline = false, bool toggleDarkMode = false}) async {
    
    setState(() {
      if(toggleIgnoreCase) {
        settings["case-sensitive"] = !settings["case-sensitive"];
      }

      if(toggleMultiline) {
        settings["multiline"] = !settings["multiline"];
      }

      if(toggleDarkMode) {
        settings["darkmode"] = !settings["darkmode"];
      }
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("case-sensitive", settings["case-sensitive"]);
    await prefs.setBool("multiline", settings["multiline"]);
    await prefs.setBool("darkmode", settings["darkmode"]);
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      settings["case-sensitive"] = prefs.getBool("case-sensitive") ?? true;
      settings["multiline"] = prefs.getBool("multiline") ?? true;
      settings["darkmode"] = prefs.getBool("darkmode") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {

    _loadSettings();

    return MaterialApp(
      theme: settings["darkmode"] == true
        ? ThemeData.dark()
        : ThemeData(
          primaryColor: Colors.teal
        ),
      routes: {
        "/": (BuildContext  context) => HomePage(settings),
        "/settings": (BuildContext context) => SettingsPage(settings, toggleSettings)
      },
    );
  }

}