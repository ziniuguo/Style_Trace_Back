import 'package:flutter/material.dart';
import 'package:styletraceback/img_scanner.dart';
import 'package:styletraceback/home_page.dart';

void main() {
  runApp(const NavContainer());
}

class NavContainer extends StatelessWidget {
  const NavContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: IndexedStackPage());
  }
}

class IndexedStackPage extends StatefulWidget {
  const IndexedStackPage({super.key});

  @override
  State<IndexedStackPage> createState() => _IndexedStackPageState();
}

class _IndexedStackPageState extends State<IndexedStackPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        alignment: Alignment.center,
        index: currentIndex,
        children: [
          Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: const Text('Page 1'),
          ),
          // RunningWidget.homePage,
          const HomePage(),
          const ImgScanPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIndex: currentIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Saved')
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (value) {
      //     currentIndex = value;
      //     setState(() {});
      //   },
      //   currentIndex: currentIndex,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Main"),
      //     BottomNavigationBarItem(icon: Icon(Icons.people), label: "Me"),
      //     BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Message"),
      //   ],
      // ),
    );
  }
}
