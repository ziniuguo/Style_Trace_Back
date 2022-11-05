import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'controller.dart';
import 'random_words.dart';

class InfScroller extends StatefulWidget {
  const InfScroller({super.key});

  @override
  _InfScrollerState createState() => _InfScrollerState();
}

class _InfScrollerState extends State<InfScroller> {
  var _isVisible = false;

  @override
  void initState() {
    super.initState();
    Controller.controller.addListener(() {
      if (Controller.controller.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          setState(() {
            _isVisible = false;
          });
        }
        debugL("scrolling reverse! current state: $_isVisible");
      } else if (Controller.controller.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isVisible == false) {
          setState(() {
            _isVisible = true;
          });
        }
        debugL("scrolling forward! current state: $_isVisible");
      }
      if (Controller.controller.offset <
          100 + Controller.controller.position.minScrollExtent) {
        debugL("offset: ${Controller.controller.offset}");
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
        body: const Center(child: RandomWords()),
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
                      Controller.controller.animateTo(
                          Controller.controller.position.minScrollExtent,
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
    print("inf_scroller.dart: - $o");
  }
}
