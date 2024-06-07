import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/routes.dart';
import '../../../domain/repositories/auth_repository.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {},
    ).whenComplete(
      () => context.read<AuthRepository>().isLogged().then(
            (logged) => logged
                ? Navigator.pushReplacementNamed(context, PARKING_SPACE)
                : Navigator.pushReplacementNamed(context, LOGIN),
          ),
    );

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
