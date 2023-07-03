import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/cubit/auth_cubit.dart';
import '../../../auth/view/screens/login_screen.dart';
@RoutePage()
class UserProfilePage extends StatefulWidget {
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final AuthCubit _authCubit;
  void _logout(BuildContext context) async {
    await _auth.signOut().then((value) {
Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    });

    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _authCubit = BlocProvider.of<AuthCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ListTile(
              tileColor: Colors.grey[200],
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () {
                _authCubit.logout(); 
                Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()));
                // error catching
              },
            ),
          ],
        ),
      ),
    );
  }
}
