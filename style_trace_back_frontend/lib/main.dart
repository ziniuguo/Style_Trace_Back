import 'package:flutter/material.dart';
import 'package:style_trace_back_frontend/common/AppColor.dart';
import 'package:style_trace_back_frontend/common/AppIcon.dart';
import 'package:style_trace_back_frontend/common/AppTextStyle.dart';
import 'package:style_trace_back_frontend/screens/ScanResultPage.dart';
import 'package:style_trace_back_frontend/screens/ImageScannerPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Style Trace Back',
      theme: ThemeData(
          primaryColor: AppColor.primaryGreen,
          primaryColorDark: AppColor.primaryGreenDark,
          primaryColorLight: AppColor.primaryGreenLight),
      home: const AppSkeleton(),
    );
  }
}

class AppSkeleton extends StatefulWidget {
  const AppSkeleton({super.key});

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        alignment: Alignment.center,
        index: currentIndex,
        children: const [
          ImageScannerPage(),
          ScanResultPage(),
          // RunningWidget.homePage,
          //const HomePage(),
          //const ImgScanPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        currentIndex: currentIndex,
        iconSize: 32.0,
        backgroundColor: AppColor.primaryGreen,
        unselectedLabelStyle: AppTextStyle.navBarLabelTextStyle,
        selectedItemColor: AppColor.black,
        unselectedItemColor: AppColor.white,
        items: const [
          BottomNavigationBarItem(icon: AppIcon.bottomNavSu, label: "SU"),
          BottomNavigationBarItem(
              icon: AppIcon.bottomNavStreet, label: "STREET"),
          BottomNavigationBarItem(icon: AppIcon.bottomNavMe, label: "ME"),
        ],
      ),
    );
  }
}
