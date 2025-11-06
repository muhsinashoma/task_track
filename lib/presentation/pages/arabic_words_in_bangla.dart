import 'package:flutter/material.dart';
import 'arabic_word_list.dart';

class ArabicWordListPage extends StatelessWidget {
  const ArabicWordListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arabic Words"),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView.builder(
        itemCount: arabicWords.length,
        itemBuilder: (context, index) {
          final word = arabicWords[index];
          return ListTile(
            leading: const Icon(Icons.language, color: Colors.lightBlue),
            title: Text(word.word, style: const TextStyle(fontSize: 18)),
            subtitle: Text(word.meaning),
          );
        },
      ),
    );
  }
}
