import 'dart:core';
import 'package:flutter/material.dart';

import '../models/regex_syntax.dart';

final List<RegexComponent> allComponents = [
  ...regexAnchor,
  ...regexCC,
  ...regexEC,
  ...regexFlags,
  ...regexGR,
  ...regexLookaround,
  ...regexQuantifiers,
  ...regexSubstitution,
];

final Map<List<RegexComponent>, Map<String, dynamic>> regexComponents = {
  regexAnchor: {
    'name': 'Anchors',
    'description': 'Where to Find Matches',
    'icon': Icons.location_on,
  },
  regexCC: {
    'name': 'Character Classes',
    'description': 'Types of Characters',
    'icon': Icons.font_download,
  },
  regexEC: {
    'name': 'Escaped Characters',
    'description': 'Special Symbols',
    'icon': Icons.euro_rounded,
  },
  regexFlags: {
    'name': 'Flags',
    'description': 'How to Modify Searches',
    'icon': Icons.settings,
  },
  regexGR: {
    'name': 'Groups and References',
    'description': 'Grouping and References',
    'icon': Icons.link,
  },
  regexLookaround: {
    'name': 'Lookaround',
    'description': 'Look Around for Patterns',
    'icon': Icons.search,
  },
  regexQuantifiers: {
    'name': 'Quantifiers',
    'description': 'How Many Times to Match',
    'icon': Icons.repeat,
  },
  regexSubstitution: {
    'name': 'Substitution',
    'description': 'Replacing Matches',
    'icon': Icons.swap_horiz,
  },
};

final Map<IconData, List<RegexComponent>> regexIcons = {
  Icons.location_on: regexAnchor,
  Icons.font_download: regexCC,
  Icons.code: regexEC,
  Icons.settings: regexFlags,
  Icons.group: regexGR,
  Icons.search: regexLookaround,
  Icons.repeat: regexQuantifiers,
  Icons.swap_horiz: regexSubstitution,
};

final Map<String, List<RegexComponent>> regexComponentDetails = {
  'Where to Find Matches': regexAnchor,
  'Types of Characters': regexCC,
  'Special Symbols': regexEC,
  'How to Modify Searches': regexFlags,
  'Grouping and Referring Back': regexGR,
  'Look Around for Patterns': regexLookaround,
  'How Many Times to Match': regexQuantifiers,
  'Replacing Matches': regexSubstitution,
};

final Map<String, List<RegexComponent>> regexComponentMap = {
  'Anchors': regexAnchor,
  'Character Classes': regexCC,
  'Escaped Characters': regexEC,
  'Flags': regexFlags,
  'Groups And References': regexGR,
  'Lookaround': regexLookaround,
  'Quantifiers': regexQuantifiers,
  'Substitution': regexSubstitution,
};

final Set<int> uniqueCatIds = {};
final List<RegexComponent> filteredComponents =
    allComponents.where((component) {
  if (uniqueCatIds.contains(component.catid)) {
    return false;
  } else {
    uniqueCatIds.add(component.catid);
    return true;
  }
}).toList();

//regex Character Classes
final List<RegexComponent> regexCC = [
  RegexComponent(
    id: 1,
    catid: 1,
    category: 'Character Classes',
    name: 'Character Set',
    description: 'Matches any one of the characters inside the brackets.',
    regexPattern: r'[ABC]',
    sample: RegExp(r'[aeiou]'),
    testString: 'glib jocks vex dwarves!',
  ),
  RegexComponent(
    id: 2,
    catid: 1,
    category: 'Character Classes',
    name: 'Negated Set',
    description: 'Matches any character that is not inside the brackets.',
    regexPattern: r'[^ABC]',
    sample: RegExp(r'[^aeiou]'),
    testString: 'glib jocks vex dwarves!',
  ),
  RegexComponent(
    id: 3,
    catid: 1,
    category: 'Character Classes',
    name: 'Range',
    description: 'Matches a character in the specified range.',
    regexPattern: r'[a-z]',
    sample: RegExp(r'[a-z]'),
    testString: 'abcdefghijklmnopqrstuvwxyz',
  ),
  RegexComponent(
    id: 4,
    catid: 1,
    category: 'Character Classes',
    name: 'Dot',
    description: 'Matches any character except newline.',
    regexPattern: r'.',
    sample: RegExp(r'.'),
    testString: 'glib jocks vex dwarves!',
  ),
  RegexComponent(
    id: 5,
    catid: 1,
    category: 'Character Classes',
    name: 'Match Any',
    description: 'Matches any character including newlines.',
    regexPattern: r'[\s\S]',
    testString: 'glib jocks vex dwarves!',
  ),
  RegexComponent(
    id: 6,
    catid: 1,
    category: 'Character Classes',
    name: 'Word',
    description: 'Matches any word character (alphanumeric and underscore).',
    regexPattern: r'\w',
    testString: 'bonjour, mon frère',
  ),
  RegexComponent(
    id: 7,
    catid: 1,
    category: 'Character Classes',
    name: 'Not Word',
    description: 'Matches any character that is not a word character.',
    regexPattern: r'\W',
    testString: 'bonjour, mon frère',
  ),
  RegexComponent(
    id: 8,
    catid: 1,
    category: 'Character Classes',
    name: 'Digit',
    description: 'Matches any digit (0-9). Equivalent to [0-9]',
    regexPattern: r'\d',
    testString: '+1-(444)-555-1234',
  ),
  RegexComponent(
    id: 9,
    catid: 1,
    category: 'Character Classes',
    name: 'Not Digit',
    description:
        'Matches any character that is not a digit. Equivalent to [^0-9]',
    regexPattern: r'\D',
    testString: '+1-(444)-555-1234',
  ),
  RegexComponent(
    id: 10,
    catid: 1,
    category: 'Character Classes',
    name: 'Whitespace',
    description: 'Matches any whitespace character.',
    regexPattern: r'\s',
    testString: 'glib jocks vex dwarves!',
  ),
  RegexComponent(
    id: 11,
    catid: 1,
    category: 'Character Classes',
    name: 'Not Whitespace',
    description: 'Matches any character that is not a whitespace.',
    regexPattern: r'\S',
    testString: 'glib jocks vex dwarves!',
  ),
];

//Regex Anchors
final List<RegexComponent> regexAnchor = [
  RegexComponent(
    id: 1,
    catid: 2,
    category: 'Anchors',
    name: 'Beginning',
    description: 'Matches the start of a string.',
    regexPattern: r'^',
    sample: RegExp(r'^\w+'),
    testString: 'she sells seashells',
  ),
  RegexComponent(
    id: 2,
    catid: 2,
    category: 'Anchors',
    name: 'End',
    description: 'Matches the end of a string.',
    regexPattern: r'$',
    sample: RegExp(r'\w+$'),
    testString: 'she sells seashells',
  ),
  RegexComponent(
    id: 3,
    catid: 2,
    category: 'Anchors',
    name: 'Word Boundary',
    description:
        'Matches a word boundary position between a word character and non-word character or position.',
    regexPattern: r'\b',
    sample: RegExp(r's\b'),
    testString: 'she sells seashells',
  ),
  RegexComponent(
    id: 4,
    catid: 2,
    category: 'Anchors',
    name: 'Not Word Boundary',
    description:
        'Matches any position that is not a word boundary. This matches a position, not a character.',
    regexPattern: r'\B',
    sample: RegExp(r's\B'),
    testString: 'she sells seashells',
  ),
];

//Escaped Characters
final List<RegexComponent> regexEC = [
  RegexComponent(
    id: 1,
    catid: 3,
    category: 'Escaped Characters',
    name: 'Reserved Characters',
    description:
        r'The following character have special meaning, and should be preceded by a \ (backslash) to represent a literal character: +*?^$\.[]{}()|/ Within a character set, only \, -, and ] need to be escaped.',
    regexPattern: r'\+',
    sample: RegExp(r'\+'),
    testString: '1 + 1 = 2',
  ),
  RegexComponent(
    id: 2,
    catid: 3,
    category: 'Escaped Characters',
    name: 'Octal Escape',
    description:
        r'Octal escaped character in the form \000. Value must be less than 255 (\377).',
    regexPattern: r'\000',
    sample: RegExp(r'\251'),
    testString: 'Regex lab is ©2024',
  ),
  RegexComponent(
    id: 3,
    catid: 3,
    category: 'Escaped Characters',
    name: 'Hexadecimal Escape',
    description: 'Hexadecimal escaped character in the form \xFF.',
    regexPattern: r'\xFF',
    sample: RegExp(r'\xA9'),
    testString: 'Regex lab is ©2024',
  ),
  RegexComponent(
    id: 4,
    catid: 3,
    category: 'Escaped Characters',
    name: 'Unicode Escape',
    description: 'Matches a Unicode escape sequence.',
    regexPattern: r'\uFFFF',
    sample: RegExp(r'\u00A9'),
    testString: 'Regex lab is ©2024',
  ),
  RegexComponent(
    id: 5,
    catid: 3,
    category: 'Escaped Characters',
    name: 'Control Character Escape',
    description: 'Matches a control character escape sequence.',
    regexPattern: r'\cI',
    testString: '',
  ),
  RegexComponent(
    id: 6,
    catid: 3,
    category: 'Escaped Characters',
    name: 'Tab',
    description: 'Matches a tab character.',
    regexPattern: r'\t',
    testString: '',
  ),
  RegexComponent(
    id: 7,
    catid: 3,
    category: 'Escaped Characters',
    name: 'Line Feed',
    description: 'Matches a line feed character.',
    regexPattern: r'\n',
    testString: '',
  ),
  RegexComponent(
    id: 8,
    catid: 3,
    category: 'Escaped Characters',
    name: 'Vertical Tab',
    description: 'Matches a vertical tab character.',
    regexPattern: r'\v',
    testString: '',
  ),
  RegexComponent(
    id: 9,
    catid: 3,
    category: 'Escaped Characters',
    name: 'Form Feed',
    description: 'Matches a form feed character.',
    regexPattern: r'\f',
    testString: '',
  ),
  RegexComponent(
    id: 10,
    catid: 3,
    category: 'Escaped Characters',
    name: 'Carriage Return',
    description: 'Matches a carriage return character.',
    regexPattern: r'\r',
    testString: '',
  ),
  RegexComponent(
    id: 11,
    catid: 3,
    category: 'Escaped Characters',
    name: 'Null',
    description: 'Matches a null character.',
    regexPattern: r'\0',
    testString: '',
  ),
];

// Group and References
final List<RegexComponent> regexGR = [
  RegexComponent(
    id: 1,
    catid: 4,
    category: 'Group and References',
    name: 'Capturing Group',
    description: 'Matches and captures the content of the group.',
    regexPattern: r'(ABC)',
    sample: RegExp(r'(ha)+'),
    testString: 'hahaha haa hah!',
  ),
  RegexComponent(
    id: 2,
    catid: 4,
    category: 'Group and References',
    name: 'Named Capturing Group',
    description: 'Captures the content of the group with a name.',
    regexPattern: r'(?<name>ABC)',
    testString: '',
  ),
  RegexComponent(
    id: 3,
    catid: 4,
    category: 'Group and References',
    name: 'Numeric Reference',
    description: 'Refers to a previously captured group by its number.',
    regexPattern: r'\1',
    sample: RegExp(r'(\w)a\1'),
    testString: 'hah dad bad dab gag gab',
  ),
  RegexComponent(
    id: 4,
    catid: 4,
    category: 'Group and References',
    name: 'Non-Capturing Group',
    description: 'Groups content without capturing it.',
    regexPattern: r'(?:ABC)',
    sample: RegExp(r'(?:ha)+'),
    testString: 'hahaha haa hah!',
  ),
];

// Lookaround: Lookahead and Lookbehind assertions in regex
final List<RegexComponent> regexLookaround = [
  RegexComponent(
    id: 1,
    catid: 5,
    category: 'Lookaround',
    name: 'Positive Lookahead',
    description:
        'Matches a group after the main expression without including it in the result.',
    regexPattern: r'(?=ABC)',
    sample: RegExp(r'\d(?=px)'),
    testString: '1pt 2px 3em 4px',
  ),
  RegexComponent(
    id: 2,
    catid: 5,
    category: 'Lookaround',
    name: 'Negative Lookahead',
    description:
        'Specifies a group that can not match after the main expression (if it matches, the result is discarded).',
    regexPattern: r'(?!ABC)',
    sample: RegExp(r'\d(?!px)'),
    testString: '1pt 2px 3em 4px',
  ),
  RegexComponent(
    id: 3,
    catid: 5,
    category: 'Lookaround',
    name: 'Positive Lookbehind',
    description:
        'Matches a group before the main expression without including it in the result.',
    regexPattern: r'(?<=ABC)',
    testString: '',
  ),
  RegexComponent(
    id: 4,
    catid: 5,
    category: 'Lookaround',
    name: 'Negative Lookbehind',
    description:
        'Specifies a group that can not match before the main expression (if it matches, the result is discarded).',
    regexPattern: r'(?<!ABC)',
    testString: '',
  ),
];

// Quantifiers and Alterations: Define how many times a pattern must match, or how alternations can be used.
final List<RegexComponent> regexQuantifiers = [
  RegexComponent(
    id: 1,
    catid: 6,
    category: 'Quantifiers and Alterations',
    name: 'Plus',
    description: 'Matches 1 or more occurrences of the preceding element.',
    regexPattern: r'+',
    sample: RegExp(r'b\w+'),
    testString: 'b be bee beer beers',
  ),
  RegexComponent(
    id: 2,
    catid: 6,
    category: 'Quantifiers and Alterations',
    name: 'Star',
    description: 'Matches 0 or more occurrences of the preceding element.',
    regexPattern: r'*',
    sample: RegExp(r'b\w*'),
    testString: 'b be bee beer beers',
  ),
  RegexComponent(
    id: 3,
    catid: 6,
    category: 'Quantifiers and Alterations',
    name: 'Quantifier {1,3}',
    description:
        'Matches between 1 and 3 occurrences of the preceding element.',
    regexPattern: r'\d{1,3}',
    sample: RegExp(r'b\w{2,3}'),
    testString: 'b be bee beer beers',
  ),
  RegexComponent(
    id: 4,
    catid: 6,
    category: 'Quantifiers and Alterations',
    name: 'Optional',
    description: 'Matches 0 or 1 occurrence of the preceding element.',
    regexPattern: r'ABC?',
    sample: RegExp(r'colou?r'),
    testString: 'color colour',
  ),
  RegexComponent(
    id: 5,
    catid: 6,
    category: 'Quantifiers and Alterations',
    name: 'Lazy',
    description: 'Matches as few characters as possible.',
    regexPattern: r'abc??',
    sample: RegExp(r'b\w+?'),
    testString: 'b be bee beer beers',
  ),
  RegexComponent(
    id: 6,
    catid: 6,
    category: 'Quantifiers and Alterations',
    name: 'Alternation',
    description: 'Matches either the pattern on the left or right of the |.',
    regexPattern: r'abc|xyz',
    sample: RegExp(r'b(a|e|i)d'),
    testString: 'bad bud bod bed bid',
  ),
];

// Substitution: Specifies how to refer to parts of a match and perform substitutions in the regex engine.
final List<RegexComponent> regexSubstitution = [
  RegexComponent(
    id: 1,
    catid: 7,
    category: 'Substitution',
    name: 'Match',
    description: 'Inserts the matched text.',
    regexPattern: r'$&',
    testString: '',
  ),
  RegexComponent(
    id: 2,
    catid: 7,
    category: 'Substitution',
    name: 'Capture Group',
    description:
        r'Inserts the results of the specified capture group. For example, $3 would insert the third capture group.',
    regexPattern: r'$1',
    testString: '',
  ),
  RegexComponent(
    id: 3,
    catid: 7,
    category: 'Substitution',
    name: 'Before Match',
    description: 'Refers to the text before the match.',
    regexPattern: r'$`',
    testString: '',
  ),
  RegexComponent(
    id: 4,
    catid: 7,
    category: 'Substitution',
    name: 'After Match',
    description: 'Refers to the text after the match.',
    regexPattern: r"$'",
    testString: '',
  ),
  RegexComponent(
    id: 5,
    catid: 7,
    category: 'Substitution',
    name: r'Escaped $',
    description: 'Represents a literal dollar sign.',
    regexPattern: r'$$',
    testString: '',
  ),
  RegexComponent(
    id: 6,
    catid: 7,
    category: 'Substitution',
    name: 'Escaped Characters',
    description: 'Represents escaped characters in the replacement string.',
    regexPattern: r'\n',
    testString: '',
  ),
];

// Flags: Specifies additional options for modifying regex behavior.
final List<RegexComponent> regexFlags = [
  RegexComponent(
    id: 1,
    catid: 8,
    category: 'Flags',
    name: 'Ignore Case',
    description: 'Makes the regex case-insensitive.',
    regexPattern: r'i',
    testString: '',
  ),
  RegexComponent(
    id: 2,
    catid: 8,
    category: 'Flags',
    name: 'Multiline',
    description:
        r'Changes the behavior of `^` and `$` to match at the start and end of each line.',
    regexPattern: r'm',
    testString: '',
  ),
];
