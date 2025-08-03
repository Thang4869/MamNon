class HocSinhLop {
  final String idHS;
  final String idLop;
  final double diemChuyenCan;

  HocSinhLop({
    required this.idHS,
    required this.idLop,
    required this.diemChuyenCan,
  });

  factory HocSinhLop.fromJson(Map<String, dynamic> json) => HocSinhLop(
        idHS: json['idHS'],
        idLop: json['idLop'],
        diemChuyenCan: (json['diemChuyenCan'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'idHS': idHS,
        'idLop': idLop,
        'diemChuyenCan': diemChuyenCan,
      };
}
