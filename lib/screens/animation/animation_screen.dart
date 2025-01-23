import 'dart:math';
import 'package:flutter/material.dart';

class AnimationScreen extends StatelessWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[900],
          title: Text(
            'Animation Gallery',
            style: TextStyle(
              color: Colors.tealAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.tealAccent,
            labelColor: Colors.tealAccent,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(icon: Icon(Icons.swap_horiz), text: 'Transition'),
              Tab(icon: Icon(Icons.animation), text: 'Physics'),
              Tab(icon: Icon(Icons.gradient), text: 'Container'),
              Tab(icon: Icon(Icons.opacity), text: 'Fade'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AnimatePageTransitionExample(),
            AnimatePhysicsSimulationExample(),
            AnimateContainerExample(),
            FadeInOutExample(),
          ],
        ),
      ),
    );
  }
}

// Example 1: Modern Page Transition
class AnimatePageTransitionExample extends StatelessWidget {
  const AnimatePageTransitionExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.tealAccent,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 6,
        ),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const PageTransitionExample(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutQuint,
                    )),
                    child: child,
                  ),
                );
              },
            ),
          );
        },
        child: const Text(
          'Show Transition Demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class PageTransitionExample extends StatelessWidget {
  const PageTransitionExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Transition Demo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.tealAccent),
      ),
      body: Center(
        child: Card(
          color: Colors.grey[800],
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 64,
                  color: Colors.tealAccent,
                ),
                const SizedBox(height: 16),
                Text(
                  'Transition Complete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Example 2: Enhanced Physics Animation
class AnimatePhysicsSimulationExample extends StatefulWidget {
  const AnimatePhysicsSimulationExample({Key? key}) : super(key: key);

  @override
  _AnimatePhysicsSimulationExampleState createState() =>
      _AnimatePhysicsSimulationExampleState();
}

class _AnimatePhysicsSimulationExampleState
    extends State<AnimatePhysicsSimulationExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.grey[800],
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SlideTransition(
            position: _animation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.science,
                  size: 48,
                  color: Colors.tealAccent,
                ),
                const SizedBox(height: 16),
                Text(
                  'Physics Animation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Using Bounce Curve',
                  style: TextStyle(
                    color: Colors.tealAccent,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Example 3: Modern Animated Container
class AnimateContainerExample extends StatefulWidget {
  const AnimateContainerExample({Key? key}) : super(key: key);

  @override
  _AnimateContainerExampleState createState() => _AnimateContainerExampleState();
}

class _AnimateContainerExampleState extends State<AnimateContainerExample> {
  double _width = 150;
  double _height = 150;
  Color _color = Colors.tealAccent;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(16);
  double _rotation = 0;

  void _randomize() {
    setState(() {
      final random = Random();
      _width = random.nextInt(200).toDouble() + 100;
      _height = random.nextInt(200).toDouble() + 100;
      _color = Color.fromARGB(
        255,
        random.nextInt(100) + 100,
        random.nextInt(100) + 100,
        random.nextInt(100) + 100,
      );
      _borderRadius = BorderRadius.circular(random.nextInt(50).toDouble() + 16);
      _rotation = random.nextDouble() * 2 * pi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: _rotation),
          duration: const Duration(seconds: 1),
          builder: (context, double rotation, child) {
            return Transform.rotate(
              angle: rotation,
              child: AnimatedContainer(
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: _borderRadius,
                  boxShadow: [
                    BoxShadow(
                      color: _color.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _randomize,
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.refresh),
        label: const Text('Animate'),
        elevation: 6,
      ),
    );
  }
}

// Example 4: Enhanced Fade Animation
class FadeInOutExample extends StatefulWidget {
  const FadeInOutExample({Key? key}) : super(key: key);

  @override
  _FadeInOutExampleState createState() => _FadeInOutExampleState();
}

class _FadeInOutExampleState extends State<FadeInOutExample> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.grey[800],
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 48,
                      color: Colors.tealAccent,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Fade Animation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _visible = !_visible;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _visible ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(_visible ? 'Hide' : 'Show'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}