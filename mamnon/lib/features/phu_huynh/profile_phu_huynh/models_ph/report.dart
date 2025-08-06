class ReportIssue {
  final int idReport;
  final String idPH;
  final String ngayBaoCao;
  final String moTa;
  final String trangThai;
  final String? phanHoi;

  ReportIssue({
    required this.idReport,
    required this.idPH,
    required this.ngayBaoCao,
    required this.moTa,
    required this.trangThai,
    this.phanHoi,
  });

  factory ReportIssue.fromJson(Map<String, dynamic> json) {
    return ReportIssue(
      idReport: json['idReport'],
      idPH: json['idPH']?.trim() ?? '',
      ngayBaoCao: json['ngayBaoCao'] ?? '',
      moTa: json['moTa'] ?? '',
      trangThai: json['trangThai'] ?? '',
      phanHoi: json['phanHoi'],
    );
  }
}
