import "package:flutter/material.dart";

class SettingsPage extends StatelessWidget {

  final Map<String, bool> settings;
  final Function toggleSettings;

  SettingsPage(this.settings, this.toggleSettings);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        margin:EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    )
                  ),
                  ListTile(
                    title: Text("Case sensitive"),
                    trailing: Switch(
                      value: settings["case-sensitive"],
                      onChanged: (bool status) {
                        if(status != settings["case-sensitive"]) {
                          toggleSettings(toggleIgnoreCase: true);
                        }
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("Multiline"),
                    trailing: Switch(
                      value: settings["multiline"],
                      onChanged: (bool status) {
                        if(status != settings["multiline"]) {
                          toggleSettings(toggleMultiline: true);
                        }
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("Darkmode"),
                    trailing: Switch(
                      value: settings["darkmode"],
                      onChanged: (bool status) {
                        if(status != settings["darkmode"]) {
                          toggleSettings(toggleDarkMode: true);
                        }
                      },
                    ),
                  )
                ],
              )
            ),
            Text("Created by nitohu")
          ],
        )
      )
    );
  }
}
