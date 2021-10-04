import 'dart:io';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final textController = TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();
  final String fileName = 'textPadNote.txt';

  Future<void> _exportToFile(BuildContext context) async {
    final File file = File('${Directory.current.absolute.path}/$fileName');
    final snackBar = SnackBar(content: Text('Saved to: ${file.path}'));

    await file.writeAsString(textController.text);
    globalKey.currentState!.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextPad',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        key: globalKey,
        appBar: AppBar(title: const Text('TextPad'), actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.save),
              tooltip: 'Export to $fileName',
              onPressed: () {
                _exportToFile(context);
              })
        ]),
        body: Center(
          child: TextField(
            controller: textController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            expands: true,
            decoration: const InputDecoration(
                hintText: 'Play with your notes here...',
                contentPadding: EdgeInsets.all(12.0)),
          ),
        ),
      ),
    );
  }
}
