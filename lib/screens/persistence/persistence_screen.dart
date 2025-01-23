import 'package:flutter/material.dart';
import 'sqlite_example.dart';
import 'read_write_files_example.dart';
import 'key_value_storage_example.dart';

class PersistenceScreen extends StatelessWidget {
  const PersistenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Persistence Examples',
            style: TextStyle(color: Colors.tealAccent),
          ),
          bottom: TabBar(
            indicatorColor: Colors.tealAccent,
            labelColor: Colors.tealAccent,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(
                child: Text('SQLite', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Tab(
                child: Text('Read/Write Files', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Tab(
                child: Text('Key-Value Storage', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SQLiteExample(),
            ReadWriteFilesExample(),
            KeyValueStorageExample(),
          ],
        ),
      ),
    );
  }
}