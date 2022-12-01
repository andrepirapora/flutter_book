import 'dart:math';

import 'package:flutter/material.dart';

import '../models/book.dart';

class MainBookAppConcept extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: BookAppConcept(),
    );
  }
}

class BookAppConcept extends StatefulWidget {
  @override
  _BookAppConceptState createState() => _BookAppConceptState();
}

class _BookAppConceptState extends State<BookAppConcept> {
  final _controller = PageController();
  final _notifierScroll = ValueNotifier(0.0);

  void _listener() {
    _notifierScroll.value = _controller.page!;
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bookHeight = size.height * 0.40;
    final bookWidth = size.width * 0.6;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              bookAppBackground,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: kToolbarHeight,
              child: AppBar(
                centerTitle: false,
                leadingWidth: 0,
                title: const Text(
                  'Bookio',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.cloud_download_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () => null,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.bookmarks_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () => null,
                  )
                ],
              ),
            ),
          ),
          ValueListenableBuilder<double?>(
            valueListenable: _notifierScroll,
            builder: (context, value, _) {
              return PageView.builder(
                itemCount: books.length,
                controller: _controller,
                itemBuilder: (context, index) {
                  final book = books[index];
                  final percentage = index - value!;
                  final num rotation = percentage.clamp(0.0, 1.0);
                  final fixRotation = pow(rotation, 0.35);
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                height: bookHeight,
                                width: bookWidth,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 20,
                                      offset: Offset(8.0, 8.0),
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Transform(
                                alignment: Alignment.centerLeft,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.002)
                                  ..rotateY(1.8 * fixRotation)
                                  ..translate(-rotation * size.width * 0.8)
                                  ..scale(1 + rotation / 3),
                                child: Image.asset(
                                  book.image,
                                  fit: BoxFit.cover,
                                  height: bookHeight,
                                  width: bookWidth,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 90),
                        Opacity(
                          opacity: 1 - (rotation as double),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'By ${book.author}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            left: 25,
            right: 25,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MaterialButton(
                      color: Colors.grey[200],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Children\'s Fiction'),
                      onPressed: () => null,
                    ),
                    const SizedBox(width: 10),
                    MaterialButton(
                      color: Colors.grey[200],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('General Fiction'),
                      onPressed: () => null,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 5,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.green,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                color: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      '34%',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
