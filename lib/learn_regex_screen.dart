import 'package:flutter/material.dart';

import 'category_details_screen.dart';
import 'data/regex_syntax_data.dart';
import 'models/regex_syntax.dart';

class LearnRegexScreen extends StatelessWidget {
  const LearnRegexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learn Regex',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF006989),
      ),
      body: ListView.builder(
        itemBuilder: (_, i) {
          List<RegexComponent> categoryItems =
              regexComponents.keys.elementAt(i);
          Map<String, dynamic> categoryDetails =
              regexComponents[categoryItems]!;
          String categoryName = categoryDetails['name'];
          String categoryDescription = categoryDetails['description'];
          IconData icon = categoryDetails['icon'];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      CategoryDetailsScreen(categoryName, categoryItems),
                ),
              );
            },
            child: Card(
              child: ListTile(
                title: Text(
                  categoryName,
                  style: const TextStyle(
                      color: Color(0xFF006989), fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                    categoryDescription), // Adjust this to show additional info if needed
                leading: Icon(
                  icon,
                  color: const Color(0xFF006989),
                ),
              ),
            ),
          );
        },
        itemCount: regexComponents.length,
      ),
    );
  }
}
