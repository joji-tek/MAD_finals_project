import 'package:flutter/material.dart';
import 'learn_regex_screen.dart';
import 'regex_test_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Regex Lab',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF006989),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Regex Lab"),
                  content: const Text(
                      'Learn and Test Regular Expressions.\nAn Endterm Project by\nBenito, George Christian, \nBSIT3E\nAcademic Year 2024-2025'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.help_outline),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const LearnRegexScreen(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(29.0),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: SizedBox(
                    height: 100,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.menu_book_outlined,
                            size: 100,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Learn Regex',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const RegexTester(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(32.0),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.integration_instructions_outlined,
                          size: 100,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Test Regex',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
