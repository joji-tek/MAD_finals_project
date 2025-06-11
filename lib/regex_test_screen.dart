// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'DbHelper/database_helper.dart';
import 'data/regex_syntax_data.dart';
import 'models/regex_syntax.dart';

class RegexTester extends StatefulWidget {
  const RegexTester({super.key});

  @override
  _RegexTesterState createState() => _RegexTesterState();
}

class _RegexTesterState extends State<RegexTester> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _regexController = TextEditingController();
  final TextEditingController _testController = TextEditingController();
  final TextEditingController _sessionName = TextEditingController();
  bool _isCaseSensitive = true;
  bool _isMultiline = false;
  String _testString = '';
  String _regexPattern = '';
  String _errorMessage = '';
  List<RegExpMatch> _matches = [];
  List<Map<String, dynamic>> sessions = [];

  void _loadSessionData(Map<String, dynamic> session) {
    setState(() {
      _sessionName.text = session['name'];
      _regexController.text = session['regex_pattern'];
      _testController.text = session['test_string'];
      _findMatches();
    });
  }

  void _findMatches() {
    setState(() {
      _regexPattern = _regexController.text;
      _testString = _testController.text;
      _errorMessage = '';

      try {
        final regex = RegExp(
          _regexPattern,
          caseSensitive: _isCaseSensitive,
          multiLine: _isMultiline,
        );
        _matches = regex.allMatches(_testString).toList();
      } catch (e) {
        _errorMessage = 'Invalid regex pattern: ${e.toString().substring(17)}';
        _matches = [];
      }
    });
  }

  void _saveSession() async {
    final session = {
      'name': _sessionName.text,
      'regex_pattern': _regexController.text,
      'test_string': _testController.text,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    await _dbHelper.insertSession(session);
    _loadSessions();
  }

  void _loadSessions() async {
    final loadedSessions = await _dbHelper.getAllSessions();
    setState(() {
      sessions = loadedSessions;
    });
  }

  void _updateSession(int id) async {
    final updatedSession = {
      'name': _sessionName.text,
      'regex_pattern': _regexController.text,
      'test_string': _testController.text,
      'updated_at': DateTime.now().toIso8601String(),
    };

    await _dbHelper.updateSession(updatedSession, id);
    _loadSessions();
  }

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text(
                  "Regex Cheatsheet",
                  style: TextStyle(
                    color: Color(0xFF006989),
                  ),
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  child: Drawer(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: ListView.builder(
                      itemBuilder: (_, i) {
                        String categoryName =
                            regexComponentMap.keys.elementAt(i);
                        List<RegexComponent> categoryItems =
                            regexComponentMap[categoryName]!;
                        return Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          child: ExpansionTile(
                            shape: const Border(),
                            title: Text(categoryName),
                            children: [
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxHeight: 400),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (_, j) {
                                    return ListTile(
                                      leading: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _regexController.text =
                                                _regexController.text +
                                                    categoryItems[j]
                                                        .regexPattern;
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                title: const Text(
                                                  "Inserted",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                content: const Text(
                                                    "Syntax added to textfield"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                        },
                                        icon: const Icon(Icons.copy),
                                      ),
                                      title: Text(
                                        categoryItems[j].regexPattern,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      subtitle: Text(categoryItems[j].name),
                                    );
                                  },
                                  itemCount: categoryItems.length,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: regexComponentMap.length,
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: const Color(0xFF006989),
        foregroundColor: Colors.white,
        child: const Icon(Icons.assignment_outlined, size: 30),
      ),
      appBar: AppBar(
        title: const Text(
          'Regex Tester',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFF006989),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      endDrawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      'Regex Sessions',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006989),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _sessionName,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'Session Name',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(167, 0, 105, 137),
                          backgroundColor: null,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Color(0xFF006989),
                          ),
                          onPressed: () {
                            if (_sessionName.text.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'Session name cannot be empty'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              _saveSession();
                              _sessionName.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    final session = sessions[index];
                    final sessionId = session['id']; // Ensure this is integer
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          session['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF006989),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${session['regex_pattern']}',
                            ),
                            Text(
                              session['updated_at'].toString().substring(0, 10),
                            ),
                          ],
                        ),
                        onTap: () {
                          _loadSessionData(session);
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xFF006989),
                              ),
                              onPressed: () {
                                _loadSessionData(session);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Update Session'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: _sessionName,
                                            decoration: const InputDecoration(
                                                labelText: 'Session Name',
                                                labelStyle: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                          TextField(
                                            controller: _regexController,
                                            decoration: const InputDecoration(
                                              labelText: 'Regex Pattern',
                                            ),
                                          ),
                                          TextField(
                                            controller: _testController,
                                            decoration: const InputDecoration(
                                              labelText: 'Test String',
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _updateSession(sessionId);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Update'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Deletion'),
                                      content: const Text(
                                          'Are you sure you want to delete this session?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await _dbHelper
                                                .deleteSession(sessionId);
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                            _loadSessions();
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _regexController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _regexController.clear();
                      });
                    },
                    icon: Icon(Icons.clear)),
                labelText: 'Enter Regex Pattern',
                filled: true,
                fillColor:
                    const Color(0xFFF3F7EC), // Background color for input
                labelStyle:
                    const TextStyle(color: Color(0xFF006989)), // Label color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => _findMatches(),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: TextField(
                controller: _testController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _testController.clear();
                        });
                      },
                      icon: Icon(Icons.clear)),
                  labelText: 'Enter Test String',
                  filled: true,
                  fillColor: const Color(0xFFF3F7EC),
                  labelStyle:
                      const TextStyle(color: Color(0xFF006989)), // Label color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => _findMatches(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildToggleSwitch('Case Sensitive(i)', _isCaseSensitive,
                    (value) {
                  setState(() {
                    _isCaseSensitive = value;
                    _findMatches();
                  });
                }),
                _buildToggleSwitch('Multi Line(m)', _isMultiline, (value) {
                  setState(() {
                    _isMultiline = value;
                    _findMatches();
                  });
                }),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _errorMessage.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(),
                    _buildHighlightedText(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSwitch(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: [
        Text(title,
            style: const TextStyle(
                color: Color(0xFF006989), fontWeight: FontWeight.bold)),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF006989),
        ),
      ],
    );
  }

  Widget _buildHighlightedText() {
    if (_matches.isEmpty) {
      return const SizedBox(
        child: Text("No matches Found"),
      ); // No matches
    }

    List<Widget> widgets = [];
    int lastMatchEnd = 0;

    for (var match in _matches) {
      if (match.start > lastMatchEnd) {
        widgets.add(Text(
          _testString.substring(lastMatchEnd, match.start),
          style: const TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
          ),
        ));
      }

      widgets.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: const Color(0xFF006989).withAlpha((0.3 * 255).toInt()),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          _testString.substring(match.start, match.end),
          style: const TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
          ),
        ),
      ));

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < _testString.length) {
      widgets.add(Text(
        _testString.substring(lastMatchEnd),
        style: const TextStyle(
          color: Colors.black,
          letterSpacing: 1.5,
        ),
      ));
    }

    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: widgets,
    );
  }
}
