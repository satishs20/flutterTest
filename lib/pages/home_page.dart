import 'package:example/handlers/notification_handler.dart';
import 'package:example/pages/firebase_auth/firebase_sign_in.dart';
import 'package:example/pages/quiz/success_page.dart';
import 'package:example/pages/quiz/welcome_page.dart';
import 'package:example/ui/components/button/elevated_button.dart';
import 'package:example/ui/style/test_style.dart';
import 'package:example/ui/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../class/user_detail_entity.dart';
import '../store/user.dart';
import 'firebase_auth/firebase_profile.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     final user = _auth.currentUser;
//     return PTScaffold(
//       body: BlocConsumer<AuthCubit, AuthState>(
//         listener: (context, state) async {
//           if (state case AuthStateAuthenticated()) {
//             await Navigator.push(context, profileRoute);
//           } else if (state case AuthStateUnauthenticated()) {
//             if (state.showError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Login failed')),
//               );
//             }
//           }
//         },
//         builder: (context, state) {
//           return switch (state) {
//             AuthStateLoading() => const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             _ => const _HomePageBody(),
//           };
//         },
//       ),
//     );
//   }
// }

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
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

  Future<void> _showNotification() async {
    final notificationHandler = context.read<NotificationHandler>();
    await notificationHandler.triggerLocalNotification(
      title: 'Testing 1,2,3',
      onPressed: () => Navigator.of(context).push(successRoute),
      onError: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PTElevatedButton(
          caption: user == null ? 'Sign In with Firbase' : 'View Profile',
          onPressed: () => user == null ? Navigator.push(context, quizSignInRoute) : Navigator.push(context, quizProfileRoute),
        ),
        const _TextSeparator(),
        PTElevatedButton(
          caption: 'Go to the quiz',
          onPressed: () => Navigator.push(context, quizWelcomeRoute),
        ),
        const _TextSeparator(),
        PTElevatedButton(
          caption: 'Send notification',
          onPressed: _showNotification,
        ),
      ],
    ).horizontallyPadded24;
  }
}

class _TextSeparator extends StatelessWidget {
  const _TextSeparator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 45),
      child: Text(
        'or',
        style: PTTextStyles.h4,
      ),
    );
  }
}
