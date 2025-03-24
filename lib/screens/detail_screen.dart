import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContentProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailScreen(),
    );
  }
}

class ContentProvider extends ChangeNotifier {
  String? content;
  bool isLoading = false;
  String? error;

  void fetchContent() async {
    isLoading = true;
    error = null;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    try {
      // Simulate fetching data
      content = "This is the detailed content fetched from the server.";
      error = null;
    } catch (e) {
      error = "Failed to load content.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail View'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (provider.isLoading)
                  Center(child: CircularProgressIndicator())
                else if (provider.error != null)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          provider.error!,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: provider.fetchContent,
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  )
                else if (provider.content != null)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        provider.content!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                else
                  Center(
                    child: ElevatedButton(
                      onPressed: provider.fetchContent,
                      child: Text('Load Content'),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
