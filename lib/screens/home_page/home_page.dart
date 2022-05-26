import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_controle_financeiro/bloc/app_bloc.dart';
import 'package:projeto_controle_financeiro/utils/constants/routes_names.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AppBloc>().add(AppLogoutRequested());
                Navigator.pushReplacementNamed(context, initialPath);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(user.email ?? ''),
            const SizedBox(height: 10),
            Text(user.name ?? ''),
            const SizedBox(height: 10),
            Text(user.id)
          ],
        ),
      ),
    );
  }
}
