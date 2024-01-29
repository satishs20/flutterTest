import 'package:example/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../../class/user_detail_entity.dart';
import '../../store/user.dart';
import '../../ui/components/button/elevated_button.dart';

Route<void> get quizProfileRoute => MaterialPageRoute(builder: (_) => const ProfilePage());

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final UserDetailEntity? user;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    // Retrieve user from SharedPreferences
    final loadedUser = await SharedPreferencesService.getUser();
    setState(() {
      user = loadedUser;
      isLoading = false;
    });
  }

  Future<void> _signOut() async {
    try {
      await SharedPreferencesService.clear();
      await Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePageBody()));
      // Navigate to the sign-in or home page after sign out
      // You can use Navigator.pushReplacement or any navigation method you prefer
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        leading: IconButton(
          onPressed: () async {
            if (user != null) {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePageBody()));
            } else {
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.adaptive.arrow_back),
        ),
      ),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Display Name: ${user?.displayName}'),
                  const SizedBox(height: 10),
                  Text('Email: ${user?.email}'),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: PTElevatedButton(
                      caption: 'Sign Out',
                      onPressed: _signOut,
                    ),
                  ),
                ],
              )
            : const Text('User not logged in'),
      ),
    );
  }
}
