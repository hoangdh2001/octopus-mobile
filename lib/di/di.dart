import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopus/blocs/verify_email/bloc/verify_email_bloc.dart';

class AppDependencyProvider extends StatelessWidget {
  final Widget child;

  const AppDependencyProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => VerifyEmailBloc(),
        ),
      ],
      child: child,
    );
  }
}
