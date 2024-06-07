import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/routes/routes.dart';
import 'src/core/theme/pk_theme.dart';
import 'src/data/data_sources/auth_data_source.dart';
import 'src/data/data_sources/auth_data_source_impl.dart';
import 'src/data/repositories/auth_repository_impl.dart';
import 'src/domain/repositories/auth_repository.dart';

void main() {
  PKTheme.initialize(const String.fromEnvironment('FLAVOR'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthDataSource>(
          create: (context) => AuthDataSourceImpl(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            context.read<AuthDataSource>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: PKTheme.i.buildThemeData(),
        initialRoute: SPLASH,
        routes: routes,
      ),
    );
  }
}
