class ThongBaoModel {
  final String title;
  final String content;
  final String date;
  final bool isPinned;

  ThongBaoModel({
    required this.title,
    required this.content,
    required this.date,
    required this.isPinned,
  });

  factory ThongBaoModel.fromMap(Map<String, dynamic> map) {
    return ThongBaoModel(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      date: map['date'] ?? '',
      isPinned: map['isPinned'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date,
      'isPinned': isPinned,
    };
  }
}
