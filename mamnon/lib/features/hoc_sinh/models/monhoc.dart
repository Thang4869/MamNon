class MonHoc {
  final String idMH;
  final String tenMH;

  MonHoc({required this.idMH, required this.tenMH});

  factory MonHoc.fromJson(Map<String, dynamic> json) {
    return MonHoc(
      idMH: json['idMH'],
      tenMH: json['tenMH'],
    );
  }

  Map<String, dynamic> toJson() => {
        'idMH': idMH,
        'tenMH': tenMH,
      };
}
