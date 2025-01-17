import 'package:flutter/material.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Número de actividades
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: const Text(
            'Images Examples',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.tealAccent,
            labelColor: Colors.tealAccent,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(
                icon: Icon(Icons.image_outlined),
                text: 'Internet Images',
              ),
              Tab(
                icon: Icon(Icons.blur_on_outlined),
                text: 'Fade In Images',
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade600],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const TabBarView(
            children: [
              DisplayInternetImagesExample(),
              FadeInImagesPlaceholderExample(),
            ],
          ),
        ),
      ),
    );
  }
}

// Activity 1: Display images from the internet
class DisplayInternetImagesExample extends StatelessWidget {
  const DisplayInternetImagesExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://picsum.photos/300/200', // Nueva URL
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return SizedBox(
                width: 300,
                height: 200,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.tealAccent,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(
                width: 300,
                height: 200,
                child: Center(
                  child: Icon(Icons.error, size: 50, color: Colors.red),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Activity 2: Fade in images with a placeholder
class FadeInImagesPlaceholderExample extends StatelessWidget {
  const FadeInImagesPlaceholderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif', // Placeholder local
            image: 'https://picsum.photos/300/200', // Nueva URL
            fadeInDuration: const Duration(seconds: 1),
            fadeOutDuration: const Duration(seconds: 1),
            placeholderErrorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.error, size: 50, color: Colors.red),
              );
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ImagesScreen(),
  ));
}
