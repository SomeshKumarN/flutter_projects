import 'package:flutter/material.dart';

void main() {
  runApp(AyyappaDevotionalApp());
}

class AyyappaDevotionalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ayyappa Devotional App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lord Ayyappa Devotional App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildMenuCard(
              context,
              title: 'History of Lord Ayyappa',
              icon: Icons.history,
              destination: HistoryScreen(),
            ),
            _buildMenuCard(
              context,
              title: '108 Saranam',
              icon: Icons.format_list_numbered,
              destination: SaranamScreen(),
            ),
            _buildMenuCard(
              context,
              title: 'Ayyappa Songs (Tamil)',
              icon: Icons.music_note,
              destination: SongsScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget destination,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.deepOrange),
            SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History of Lord Ayyappa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            'The history of Lord Ayyappa goes back to... (Add full history here)',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class SaranamScreen extends StatelessWidget {
  final List<String> saranamList = List.generate(
    108,
    (index) => 'Saranam $index', // Replace with actual saranam mantras
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('108 Saranam'),
      ),
      body: ListView.builder(
        itemCount: saranamList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(saranamList[index]),
          );
        },
      ),
    );
  }
}

class SongsScreen extends StatelessWidget {
  final List<String> songsList = [
    'Song 1 - Tamil Devotional',
    'Song 2 - Tamil Devotional',
    'Song 3 - Tamil Devotional',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayyappa Songs (Tamil)'),
      ),
      body: ListView.builder(
        itemCount: songsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.play_arrow),
            title: Text(songsList[index]),
            onTap: () {
              // Audio playback logic can be implemented here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Playing ${songsList[index]}')),
              );
            },
          );
        },
      ),
    );
  }
}
