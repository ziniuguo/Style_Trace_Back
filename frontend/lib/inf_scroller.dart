// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
    RandomWords randomWords = const RandomWords();
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to Flutter'),
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      child: const Text('To Top'),
                      onPressed: () async {
                        // Delay to make sure the frames are rendered properly
                        await Future.delayed(const Duration(milliseconds: 300));
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Controller.controller.animateTo(
                              Controller.controller.position.minScrollExtent,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastOutSlowIn);
                        });
                      }),
                  ElevatedButton(
                      child: const Text('To Bottom'),
                      onPressed: () {

                      }),
                ],
              ),
              Expanded(
                child: Center(
                  child: randomWords,
                )
              )
            ],
          )),
    );
  }
}
