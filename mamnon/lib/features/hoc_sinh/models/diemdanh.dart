class DiemDanh {
  final String idDD;
  final String idHS;
  final String idLop;
  final DateTime ngay;
  final int thang;
  final int trangThai;
  final int trangThaiNghi;

  DiemDanh({
    required this.idDD,
    required this.idHS,
    required this.idLop,
    required this.ngay,
    required this.thang,
    required this.trangThai,
    required this.trangThaiNghi,
  });

  factory DiemDanh.fromJson(Map<String, dynamic> json) => DiemDanh(
        idDD: json['idDD'],
        idHS: json['idHS'],
        idLop: json['idLop'],
        ngay: DateTime.parse(json['ngay']),
        thang: json['thang'],
        trangThai: json['trangThai'],
        trangThaiNghi: json['trangThaiNghi'],
      );

  Map<String, dynamic> toJson() => {
        'idDD': idDD,
        'idHS': idHS,
        'idLop': idLop,
        'ngay': ngay.toIso8601String(),
        'thang': thang,
        'trangThai': trangThai,
        'trangThaiNghi': trangThaiNghi,
      };
      
}
