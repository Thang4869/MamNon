class TKB {
  final String idLop;
  final String ngay;
  final String caHoc;
  final String idMH;

  TKB({
    required this.idLop,
    required this.ngay,
    required this.caHoc,
    required this.idMH,
  });

  factory TKB.fromJson(Map<String, dynamic> json) => TKB(
        idLop: json['idLop'],
        ngay: json['ngay'],
        caHoc: json['caHoc'],
        idMH: json['idMH'],
      );

  Map<String, dynamic> toJson() => {
        'idLop': idLop,
        'ngay': ngay,
        'caHoc': caHoc,
        'idMH': idMH,
      };
}
