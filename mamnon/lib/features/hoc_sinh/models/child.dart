class Child {
  final String idHS;
  final String name;
  final String gender;
  final String className;
  final List<String> subjects;

  Child({
    required this.idHS,
    required this.name,
    required this.gender,
    required this.className,
    required this.subjects,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        idHS: json['idHS'],
        name: json['name'],
        gender: json['gender'],
        className: json['className'],
        subjects: List<String>.from(json['subjects']),
      );

  Map<String, dynamic> toJson() => {
        'idHS': idHS,
        'name': name,
        'gender': gender,
        'className': className,
        'subjects': subjects,
      };
}
