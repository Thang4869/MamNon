class ThongBaoModel {
  final int idTitle;
  final String idPh;
  final String? title;
  final String? noiDung;
  final String? tepDinhKem;
  final DateTime ngayTao;
  bool isRead;

  ThongBaoModel({
    required this.idTitle,
    required this.idPh,
    this.title,
    this.noiDung,
    this.tepDinhKem,
    required this.ngayTao,
    required this.isRead,
  });

  factory ThongBaoModel.fromJson(Map<String, dynamic> json) {
    return ThongBaoModel(
      idTitle: json['idTitle'],
      idPh: json['idPH'],
      title: json['title'],
      noiDung: json['noiDung'],
      tepDinhKem: json['tepDinhKem'],
      ngayTao: DateTime.parse(json['ngayTao']),
      isRead: json['isRead'],
    );
  }
}
