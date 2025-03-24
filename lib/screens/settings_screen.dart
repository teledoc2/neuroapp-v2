import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      theme: settingsProvider.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('App Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preferences',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 16),
                  SwitchListTile(
                    title: Text('Dark Theme'),
                    value: settingsProvider.isDarkTheme,
                    onChanged: (value) {
                      try {
                        settingsProvider.toggleTheme(value);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error toggling theme')),
                        );
                      }
                    },
                  ),
                  Divider(),
                  SwitchListTile(
                    title: Text('Enable Notifications'),
                    value: settingsProvider.notificationsEnabled,
                    onChanged: (value) {
                      try {
                        settingsProvider.toggleNotifications(value);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error toggling notifications')),
                        );
                      }
                    },
                  ),
                  Divider(),
                  SizedBox(height: 16),
                  Text(
                    'Other Settings',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    title: Text('Privacy Policy'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navigate to Privacy Policy screen
                    },
                  ),
                  ListTile(
                    title: Text('Terms of Service'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navigate to Terms of Service screen
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SettingsProvider extends ChangeNotifier {
  bool _isDarkTheme = false;
  bool _notificationsEnabled = true;

  bool get isDarkTheme => _isDarkTheme;
  bool get notificationsEnabled => _notificationsEnabled;

  void toggleTheme(bool value) {
    _isDarkTheme = value;
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }
}
