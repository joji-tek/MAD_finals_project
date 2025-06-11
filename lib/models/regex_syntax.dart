import 'dart:core';

class RegexComponent {
  final int id;
  final int catid;
  final String category;
  final String name;
  final String description;
  final String regexPattern;
  RegExp? sample;
  String? testString;

  RegexComponent({
    required this.id,
    required this.catid,
    required this.category,
    required this.name,
    required this.description,
    required this.regexPattern,
    this.sample,
    this.testString,
  });

  RegExp get regExp => sample ??= RegExp(regexPattern);
}
