// arabic_word_list.dart

class ArabicWord {
  final String word;
  final String meaning;

  ArabicWord({
    required this.word,
    required this.meaning,
  });
}

// Static list of Arabic words
final List<ArabicWord> arabicWords = [
  ArabicWord(word: "سلام", meaning: "Peace"),
  ArabicWord(word: "حب", meaning: "Love"),
  ArabicWord(word: "شكر", meaning: "Thanks"),
  ArabicWord(word: "نور", meaning: "Light"),
  ArabicWord(word: "حكمة", meaning: "Wisdom"),
];
