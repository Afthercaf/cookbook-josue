import 'package:flutter/material.dart';

// Definimos una paleta de colores moderna
class AppColors {
  static const primary = Color(0xFF6200EE);
  static const secondary = Color(0xFF03DAC6);
  static const background = Color(0xFFF5F5F5);
  static const surface = Colors.white;
  static const error = Color(0xFFB00020);
  static const onPrimary = Colors.white;
  static const onBackground = Color(0xFF121212);
  static const cardBackground = Colors.white;
}

class DesignScreen extends StatelessWidget {
  const DesignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primary,
          title: const Text(
            'Design Examples',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: AppColors.secondary,
            labelColor: AppColors.onPrimary,
            unselectedLabelColor: AppColors.onPrimary.withOpacity(0.7),
            indicatorWeight: 3,
            tabs: const [
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Drawer', style: TextStyle(fontSize: 16)),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Snackbar', style: TextStyle(fontSize: 16)),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Export Fonts', style: TextStyle(fontSize: 16)),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Orientation UI', style: TextStyle(fontSize: 16)),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Custom Font', style: TextStyle(fontSize: 16)),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Themes', style: TextStyle(fontSize: 16)),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Tabs', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AddDrawerExample(),
            DisplaySnackbarExample(),
            ExportFontsExample(),
            OrientationUIExample(),
            CustomFontExample(),
            ThemesExample(),
            WorkWithTabsExample(),
          ],
        ),
      ),
    );
  }
}

class AddDrawerExample extends StatelessWidget {
  const AddDrawerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: const Text('Modern Drawer'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: AppColors.secondary,
                child: Icon(Icons.person, color: AppColors.onPrimary),
              ),
              accountName: const Text('John Doe'),
              accountEmail: const Text('john.doe@example.com'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Feedback'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Open drawer from left edge',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DisplaySnackbarExample extends StatelessWidget {
  const DisplaySnackbarExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            content: const Text('This is a modern Snackbar!'),
            action: SnackBarAction(
              label: 'UNDO',
              textColor: AppColors.secondary,
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text(
          'Show Snackbar',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class ExportFontsExample extends StatelessWidget {
  const ExportFontsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Modern Typography with RobotoMono',
            style: TextStyle(
              fontFamily: 'RobotoMono',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.onBackground,
            ),
          ),
        ),
      ),
    );
  }
}

class OrientationUIExample extends StatelessWidget {
  const OrientationUIExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.8),
                      AppColors.primary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Item ${index + 1}',
                    style: const TextStyle(
                      color: AppColors.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CustomFontExample extends StatelessWidget {
  const CustomFontExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          _buildFontCard(
            'Bold',
            FontWeight.bold,
            FontStyle.normal,
          ),
          _buildFontCard(
            'Regular',
            FontWeight.w400,
            FontStyle.normal,
          ),
          _buildFontCard(
            'Light',
            FontWeight.w300,
            FontStyle.normal,
          ),
          _buildFontCard(
            'Thin',
            FontWeight.w100,
            FontStyle.normal,
          ),
          _buildFontCard(
            'Medium',
            FontWeight.w500,
            FontStyle.normal,
          ),
          _buildFontCard(
            'Italic',
            FontWeight.normal,
            FontStyle.italic,
          ),
          _buildFontCard(
            'Bold Italic',
            FontWeight.bold,
            FontStyle.italic,
          ),
        ],
      ),
    );
  }

  Widget _buildFontCard(String title, FontWeight weight, FontStyle style) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Roboto Mono - $title',
          style: TextStyle(
            fontFamily: 'RobotoMono',
            fontWeight: weight,
            fontStyle: style,
            fontSize: 20,
            color: AppColors.onBackground,
          ),
        ),
      ),
    );
  }
}

class ThemesExample extends StatelessWidget {
  const ThemesExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Modern Themes'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Theme Example',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'This card uses theme-defined styles for elevation, shape, and typography.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Themed Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkWithTabsExample extends StatelessWidget {
  const WorkWithTabsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primary,
          title: const Text('Modern Tabs'),
          bottom: const TabBar(
            indicatorColor: AppColors.secondary,
            indicatorWeight: 3,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.favorite),
                text: 'Favorites',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Profile',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(
              'Home Tab',
              Icons.home,
              'Welcome to the home section',
            ),
            _buildTabContent(
              'Favorites Tab',
              Icons.favorite,
              'Your favorite items appear here',
            ),
            _buildTabContent(
              'Profile Tab',
              Icons.person,
              'View and edit your profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String title, IconData icon, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 48,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onBackground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.onBackground.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}