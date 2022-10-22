// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'controller.dart';
import 'random_words.dart';

void main() {
  runApp(const InfScroller());
}

class InfScroller extends StatelessWidget {
  const InfScroller({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: const Center(child: RandomWords()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
debugL("scrolling!");
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Controller.controller.animateTo(
                  Controller.controller.position.minScrollExtent,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn);
            });
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.navigation),
        ),
      ),
    );
  }
}
void debugL(Object o)  {
  if (kDebugMode) {
    print("inf_scroller.dart: - $o");
  }
}
