import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'random_words.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isVisible = false;
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset > // 100 + 0
          100 + _controller.position.minScrollExtent) {
        if (_isVisible == false) {
          setState(() {
            _isVisible = true;
          });
        }
      } else {
        if (_isVisible == true) {
          setState(() {
            _isVisible = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(child: RandomWords(_controller)),
        floatingActionButton: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: _isVisible
              ? FloatingActionButton(
                  key: ValueKey(_isVisible),
                  onPressed: () {
                    debugL("Button triggered, scrolling back to top...");
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      _controller.animateTo(
                          _controller.position.minScrollExtent,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn);
                    });
                  },
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.navigation),
                )
              : null,
        ),
      ),
    );
  }
}

void debugL(Object o) {
  if (kDebugMode) {
    print("home_page.dart: - $o");
  }
}
