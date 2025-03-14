import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/theme.dart';
import 'utils/app_routes.dart';

class DDFSApp extends StatelessWidget {
  const DDFSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DDFS Data Extraction Hub',
      theme: AppTheme.darkTheme,
      getPages: AppRoutes.routes,
      initialRoute: '/',
    );
  }
}
