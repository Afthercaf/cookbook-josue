import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NetworkingScreen extends StatelessWidget {
  const NetworkingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1A2E),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF16213E),
          title: Text(
            'API Explorer',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: const Color(0xFF0F3460),
            labelColor: const Color(0xFF0F3460),
            unselectedLabelColor: Colors.white70,
            tabs: [
              _buildCustomTab(Icons.download, 'GET'),
              _buildCustomTab(Icons.lock, 'AUTH'),
              _buildCustomTab(Icons.upload, 'POST'),
              _buildCustomTab(Icons.edit, 'PUT'),
              _buildCustomTab(Icons.delete, 'DELETE'),
              _buildCustomTab(Icons.sync, 'WebSocket'),
              _buildCustomTab(Icons.data_object, 'JSON'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContainer(const FetchDataExample()),
            _buildTabContainer(const AuthenticatedRequestExample()),
            _buildTabContainer(const SendDataExample()),
            _buildTabContainer(const UpdateDataExample()),
            _buildTabContainer(const DeleteDataExample()),
            _buildTabContainer(const WebSocketExample()),
            _buildTabContainer(const ParseJsonExample()),
          ],
        ),
      ),
    );
  }

  Tab _buildCustomTab(IconData icon, String text) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(width: 8),
            Text(text, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContainer(Widget child) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
// Activity 1: Fetch Data with Modern UI
class FetchDataExample extends StatefulWidget {
  const FetchDataExample({Key? key}) : super(key: key);

  @override
  _FetchDataExampleState createState() => _FetchDataExampleState();
}

class _FetchDataExampleState extends State<FetchDataExample> {
  String _data = 'No data fetched yet';
  bool _isLoading = false;

  void _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
      setState(() {
        _data = response.data.toString();
      });
    } catch (e) {
      setState(() {
        _data = 'Error fetching data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_download,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'GET Request Demo',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _data,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _fetchData,
            icon: const Icon(Icons.refresh),
            label: const Text('Fetch Data'),
          ),
        ],
      ),
    );
  }
}

// Activity 2: Modern Authentication UI
class AuthenticatedRequestExample extends StatefulWidget {
  const AuthenticatedRequestExample({Key? key}) : super(key: key);

  @override
  _AuthenticatedRequestExampleState createState() =>
      _AuthenticatedRequestExampleState();
}

class _AuthenticatedRequestExampleState extends State<AuthenticatedRequestExample> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _data = 'Not authenticated';
  bool _isLoading = false;
  bool _obscurePassword = true;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final dio = Dio();
      final response = await dio.post(
        'https://reqres.in/api/login',
        data: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );
      setState(() {
        _data = 'Token: ${response.data['token']}';
      });
    } catch (e) {
      setState(() {
        _data = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(
                    Icons.security,
                    size: 48,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Authentication',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : FilledButton.icon(
                          onPressed: _login,
                          icon: const Icon(Icons.login),
                          label: const Text('Login'),
                        ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _data,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Activity 3: Modern Send Data UI
class SendDataExample extends StatefulWidget {
  const SendDataExample({Key? key}) : super(key: key);

  @override
  _SendDataExampleState createState() => _SendDataExampleState();
}

class _SendDataExampleState extends State<SendDataExample> {
  String _response = 'No data sent yet';
  bool _isLoading = false;

  void _sendData() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final response = await Dio().post(
        'https://reqres.in/api/users',
        data: {'name': 'John', 'job': 'developer'},
      );
      setState(() {
        _response = response.data.toString();
      });
    } catch (e) {
      setState(() {
        _response = 'Error sending data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_upload,
                    size: 48,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'POST Request Demo',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Data to send:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '{"name": "John", "job": "developer"}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(_response),
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _sendData,
            icon: const Icon(Icons.send),
            label: const Text('Send Data'),
          ),
        ],
      ),
    );
  }
}

// Activity 4: Modern Update Data UI
class UpdateDataExample extends StatefulWidget {
  const UpdateDataExample({Key? key}) : super(key: key);

  @override
  _UpdateDataExampleState createState() => _UpdateDataExampleState();
}

class _UpdateDataExampleState extends State<UpdateDataExample> {
  String _response = 'No updates made yet';
  bool _isLoading = false;

  void _updateData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Dio().put(
        'https://reqres.in/api/users/2',
        data: {'name': 'Jane', 'job': 'manager'},
      );
      setState(() {
        _response = response.data.toString();
      });
    } catch (e) {
      setState(() {
        _response = 'Error updating data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(
                    Icons.update,
                    size: 48,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'PUT Request Demo',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Update data:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '{"name": "Jane", "job": "manager"}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(_response),
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _updateData,
            icon: const Icon(Icons.edit),
            label: const Text('Update Data'),
          ),
        ],
      ),
    );
  }
}

// Activity 5: Modern Delete Data UI
class DeleteDataExample extends StatefulWidget {
  const DeleteDataExample({Key? key}) : super(key: key);

  @override
  _DeleteDataExampleState createState() => _DeleteDataExampleState();
}

class _DeleteDataExampleState extends State<DeleteDataExample> {
  String _response = 'No deletions yet';
  bool _isLoading = false;

  void _deleteData() async {// Continuación de DeleteDataExample
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Dio().delete('https://reqres.in/api/users/2');
      setState(() {
        _response = 'Resource deleted successfully (Status: ${response.statusCode})';
      });
    } catch (e) {
      setState(() {
        _response = 'Error deleting data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(
                    Icons.delete_forever,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'DELETE Request Demo',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Target Resource:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'https://reqres.in/api/users/2',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _response,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.tonalIcon(
            onPressed: _deleteData,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Delete Data'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.errorContainer,
              ),
              foregroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Activity 6: Modern WebSocket UI
class WebSocketExample extends StatefulWidget {
  const WebSocketExample({Key? key}) : super(key: key);

  @override
  _WebSocketExampleState createState() => _WebSocketExampleState();
}

class _WebSocketExampleState extends State<WebSocketExample> {
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );
  final TextEditingController _controller = TextEditingController();
  String _receivedMessage = 'Waiting for messages...';
  List<String> _messageHistory = [];

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
      setState(() {
        _messageHistory.add('Sent: ${_controller.text}');
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(
                    Icons.sync_alt,
                    size: 48,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'WebSocket Demo',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: StreamBuilder(
                      stream: _channel.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _messageHistory.add('Received: ${snapshot.data}');
                        }
                        return ListView.builder(
                          reverse: true,
                          itemCount: _messageHistory.length,
                          itemBuilder: (context, index) {
                            final message = _messageHistory[_messageHistory.length - 1 - index];
                            final isReceived = message.startsWith('Received');
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Align(
                                alignment: isReceived ? Alignment.centerLeft : Alignment.centerRight,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isReceived 
                                      ? Theme.of(context).colorScheme.primaryContainer
                                      : Theme.of(context).colorScheme.secondaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    message,
                                    style: TextStyle(
                                      color: isReceived
                                          ? Theme.of(context).colorScheme.onPrimaryContainer
                                          : Theme.of(context).colorScheme.onSecondaryContainer,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.message),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: _sendMessage,
                icon: const Icon(Icons.send),
                label: const Text('Send'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Activity 7: Modern JSON Parser UI
class ParseJsonExample extends StatelessWidget {
  const ParseJsonExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const jsonString = '''{
      "name": "John",
      "age": 30,
      "city": "New York"
    }''';

    final parsedData = parseJson(jsonString);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(
                    Icons.data_object,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'JSON Parser Demo',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Raw JSON:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          jsonString,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Parsed Data:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        _buildDataRow(context, 'Name', parsedData['name']),
                        _buildDataRow(context, 'Age', parsedData['age'].toString()),
                        _buildDataRow(context, 'City', parsedData['city']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> parseJson(String json) {
    return {
      "name": "John",
      "age": 30,
      "city": "New York",
    };
  }
}