import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skincare_app/controller/homescreen_controller.dart';

import 'package:skincare_app/view/widgets/route_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Homescreencontroller(),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        //home: Splash(),
        routerConfig: router,
      ),
    );
  }
}
