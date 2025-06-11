import 'package:flutter/material.dart';
import 'models/regex_syntax.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryName;
  final List<RegexComponent> categoryItems;

  const CategoryDetailsScreen(this.categoryName, this.categoryItems,
      {super.key});

  // Function to highlight matches in the test string
  List<TextSpan> _highlightMatches(String testString, RegExp pattern) {
    final matches = pattern.allMatches(testString);
    List<TextSpan> highlightedText = [];
    int start = 0;

    for (var match in matches) {
      if (match.start > start) {
        highlightedText
            .add(TextSpan(text: testString.substring(start, match.start)));
      }
      highlightedText.add(TextSpan(
        text: testString.substring(match.start, match.end),
        style: TextStyle(
            backgroundColor:
                const Color(0xFF006989).withAlpha((0.3 * 255).toInt())),
      ));
      start = match.end;
    }

    if (start < testString.length) {
      highlightedText.add(TextSpan(text: testString.substring(start)));
    }

    return highlightedText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF006989),
      ),
      body: ListView.builder(
        itemCount: categoryItems.length,
        itemBuilder: (context, index) {
          final item = categoryItems[index];

          return Card(
            child: ExpansionTile(
              shape: const Border(),
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                item.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF006989),
                ),
              ),
              subtitle: Text(item.regexPattern),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.description),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Sample Pattern: ${item.regExp.pattern}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: _highlightMatches(
                              item.testString ?? '', item.regExp),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
