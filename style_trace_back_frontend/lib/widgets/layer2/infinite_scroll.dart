/*
import 'dart:html';

import 'package:flutter/material.dart';

class InfiniteScroll extends StatefulWidget {
  const InfiniteScroll({super.key});

  @override
  State<InfiniteScroll> createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  late bool _hasMorePage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  late List<dynamic> _records;
  final int _numberOfRecordsPerRequest = 10;
  final int _nextPageTrigger =
      3; // request more data when 3 more records left to view on the page

  @override
  void initState() {
    super.initState();
    _pageNumber = 0;
    _records = [];
    _hasMorePage = true;
    _loading = true;
    _error = false;
    //fetchData();
  }
}


// class InfiniteScroll extends StatefulWidget {
//   const InfiniteScroll(this.controller, {super.key});
//   final ScrollController controller;

//   @override
//   State<InfiniteScroll> createState() => _InfiniteScrollState();
// }

// class _InfiniteScrollState extends State<InfiniteScroll> {
//   final _suggestions = <WordPair>[];

//   @override
//   Widget build(BuildContext context) {
//     ListView listView = ListView.builder(
//       controller: widget.controller,
//       // itemCount: 20,

//       padding: const EdgeInsets.all(16.0),
//       itemBuilder: /*1*/ (context, i) {
//         if (i.isOdd) return const Divider(); /*2*/

//         final index = i ~/ 2; /*3*/
//         if (index >= _suggestions.length) {
//           _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//         }
//         return ListTile(
//           title: Text(
//             _suggestions[index].asPascalCase,
//             style: _biggerFont,
//           ),
//         );
//       },
//     );
//     return listView;
//   }
// }

*/