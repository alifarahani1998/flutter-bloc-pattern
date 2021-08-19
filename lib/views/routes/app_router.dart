import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_proj/cubits/printer_cubit.dart';
import 'package:flutter_bloc_proj/views/screens/home_screen.dart';
import 'package:flutter_bloc_proj/views/screens/second_screen.dart';
import 'package:flutter_bloc_proj/views/screens/third_screen.dart';


class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                HomeScreen(
                  title: "HomeScreen",
                  color: Colors.blueAccent,
                ));
        break;
      case '/second':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider<PrinterCubit>(
                  create: (context) => PrinterCubit(),
                  child: SecondScreen(
                    title: "SecondScreen",
                    color: Colors.redAccent,
                  ),
                ));
        break;
      case '/third':
        return MaterialPageRoute(
            builder: (_) =>
                ThirdScreen(
                  title: "ThirdScreen",
                  color: Colors.greenAccent,
                ));
        break;
      default:
        debugPrint('this is null page');
        return null;
    }
  }
}
