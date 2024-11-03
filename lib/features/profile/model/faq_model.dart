class FaqModel {
  int id;
  String question;
  String answer;

//<editor-fold desc="Data Methods">
  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FaqModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          question == other.question &&
          answer == other.answer);

  @override
  int get hashCode => id.hashCode ^ question.hashCode ^ answer.hashCode;

  @override
  String toString() {
    return 'FaqModel{' +
        ' id: $id,' +
        ' question: $question,' +
        ' answer: $answer,' +
        '}';
  }

  FaqModel copyWith({
    int? id,
    String? question,
    String? answer,
  }) {
    return FaqModel(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'question': this.question,
      'answer': this.answer,
    };
  }

  factory FaqModel.fromMap(Map<String, dynamic> map) {
    return FaqModel(
      id: map['id'] as int,
      question: map['question'] as String,
      answer: map['answer'] as String,
    );
  }

//</editor-fold>
}
