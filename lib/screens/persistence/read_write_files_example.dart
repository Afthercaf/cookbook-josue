import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ReadWriteFilesExample extends StatefulWidget {
  const ReadWriteFilesExample({Key? key}) : super(key: key);

  @override
  _ReadWriteFilesExampleState createState() => _ReadWriteFilesExampleState();
}

class _ReadWriteFilesExampleState extends State<ReadWriteFilesExample> {
  final TextEditingController _controller = TextEditingController();
  String _fileContent = 'File is empty.';

  Future<String> _getFilePath() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return '${directory.path}/my_file.txt';
    } catch (e) {
      throw Exception('Error accessing file path: $e');
    }
  }

  Future<void> _writeToFile(String content) async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      await file.writeAsString(content);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File written successfully!', style: TextStyle(color: Colors.tealAccent)),
          backgroundColor: Colors.grey[900],
        ),
      );
    } catch (e) {
      setState(() {
        _fileContent = 'Error writing to file: $e';
      });
    }
  }

  Future<void> _readFromFile() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      final content = await file.readAsString();
      setState(() {
        _fileContent = content;
      });
    } catch (e) {
      setState(() {
        _fileContent = 'Error reading file: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(
          'Read/Write Files',
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
                  'This activity demonstrates how to read and write files in local storage.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Enter some text',
                labelStyle: const TextStyle(color: Colors.tealAccent),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await _writeToFile(_controller.text);
                    _controller.clear();
                  },
                  child: const Text('Write to File'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _readFromFile,
                  child: const Text('Read from File'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.grey[800],
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'File Content:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _fileContent,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}