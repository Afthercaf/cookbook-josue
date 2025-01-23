import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorageExample extends StatefulWidget {
  const KeyValueStorageExample({Key? key}) : super(key: key);

  @override
  _KeyValueStorageExampleState createState() => _KeyValueStorageExampleState();
}

class _KeyValueStorageExampleState extends State<KeyValueStorageExample> {
  late SharedPreferences _prefs;
  String _username = 'Unknown User';
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = _prefs.getString('username') ?? 'Unknown User';
      _usernameController.text = _username;
    });
  }

  Future<void> _savePreferences(String username) async {
    if (username.isNotEmpty) {
      await _prefs.setString('username', username);
      setState(() {
        _username = username;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text(
          'Key-Value Storage',
          style: TextStyle(color: Colors.tealAccent),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.grey[800],
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Stored Username: $_username',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Enter username',
                labelStyle: const TextStyle(color: Colors.tealAccent),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.save, color: Colors.tealAccent),
                  onPressed: () => _savePreferences(_usernameController.text),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: _savePreferences,
            ),
          ],
        ),
      ),
    );
  }
}