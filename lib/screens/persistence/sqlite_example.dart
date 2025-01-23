import 'package:flutter/material.dart';

class SQLiteExample extends StatefulWidget {
  const SQLiteExample({Key? key}) : super(key: key);

  @override
  _SQLiteExampleState createState() => _SQLiteExampleState();
}

class _SQLiteExampleState extends State<SQLiteExample> {
  final List<String> _users = ['John Doe', 'Jane Smith'];

  void _addUser(String name) {
    setState(() {
      _users.add(name);
    });
  }

  void _deleteUser(int index) {
    setState(() {
      _users.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(
          'SQLite Example',
          style: TextStyle(color: Colors.tealAccent),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[800],
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.tealAccent,
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    title: Text(
                      _users[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.tealAccent),
                      onPressed: () => _deleteUser(index),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                _addUser('User ${_users.length + 1}');
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Random User'),
            ),
          ),
        ],
      ),
    );
  }
}