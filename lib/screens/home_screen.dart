import 'package:flutter/material.dart';
import 'design/design_screen.dart';
import 'forms/forms_screen.dart';
import 'images/images_screen.dart';
import 'lists/lists_screen.dart';
import 'navigation/navigation_screen.dart';
import 'first_app_screen.dart';
import 'persistence/persistence_screen.dart';
import 'networking/networking_screen.dart';
import 'animation/animation_screen.dart';
import 'effects/effects_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2A2D3E),
              Color(0xFF1F1D2B),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: const [
                    Text(
                      'Flutter',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      ' Cookbook',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    const Text(
                      'Choose a Section',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildCustomButton(
                      context,
                      title: 'Design',
                      subtitle: 'Learn UI/UX principles',
                      icon: Icons.design_services,
                      color: const Color(0xFF6C61AF),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DesignScreen()),
                      ),
                    ),
                    _buildCustomButton(
                      context,
                      title: 'Forms',
                      subtitle: 'Create interactive forms',
                      icon: Icons.text_fields,
                      color: const Color(0xFFFF6B6B),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FormsScreen()),
                      ),
                    ),
                    _buildCustomButton(
                      context,
                      title: 'Images',
                      subtitle: 'Handle images and assets',
                      icon: Icons.image,
                      color: const Color(0xFF4ECDC4),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ImagesScreen()),
                      ),
                    ),
                    _buildCustomButton(
                      context,
                      title: 'Lists',
                      subtitle: 'Display data collections',
                      icon: Icons.list,
                      color: const Color(0xFFFFBE0B),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ListsScreen()),
                      ),
                    ),
                    _buildCustomButton(
                      context,
                      title: 'Navigation',
                      subtitle: 'Route management',
                      icon: Icons.navigation,
                      color: const Color(0xFF3D84A8),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NavigationScreen()),
                      ),
                    ),
                    _buildCustomButton(
                      context,
                      title: 'First App',
                      subtitle: 'Start your journey',
                      icon: Icons.create,
                      color: const Color(0xFF72B01D),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FirstAppScreen()),
                      ),
                    ),
                    _buildCustomButton(
                      context,
                      title: 'Persistence',
                      subtitle: 'Data storage solutions',
                      icon: Icons.save,
                      color: Colors.brown,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PersistenceScreen()),
                      ),
                    ),
                    _buildCustomButton(
                      context,
                      title: 'Networking',
                      subtitle: 'API integration',
                      icon: Icons.network_wifi,
                      color: Colors.blueGrey,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NetworkingScreen()),
                      ),
                    ),
                    _buildCustomButton(
                      context,
                      title: 'Animation',
                      subtitle: 'Animate UI elements',
                      icon: Icons.animation,
                      color: const Color(0xFFFFA726),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AnimationScreen()),
                      ),
                    ),
                    _buildCustomButton(
                      context,
                      title: 'Effects',
                      subtitle: 'Add visual effects',
                      icon: Icons.visibility,
                      color: const Color(0xFF8E24AA),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EffectsScreen()),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: color.withOpacity(0.15),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 24, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.white54,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}