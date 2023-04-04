import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRepositoryProvider extends StatelessWidget {
  final Widget child;

  const AppRepositoryProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [], child: child);
  }
}
