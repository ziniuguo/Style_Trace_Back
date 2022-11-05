import 'package:flutter/material.dart';
import 'running_widget.dart';

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
          RunningWidget.infScroller,
          RunningWidget.imgScanner,
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
          NavigationDestination(icon: Icon(Icons.home), label: 'Commute'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Saved')
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (value) {
      //     // 点击事件，用于改变当前索引，然后刷新
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
