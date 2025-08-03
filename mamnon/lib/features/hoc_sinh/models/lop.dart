class Lop {
  final String idLop;
  final String tenLop;
  final int siSo;
  final String maST;

  Lop({
    required this.idLop,
    required this.tenLop,
    required this.siSo,
    required this.maST,
  });

  factory Lop.fromJson(Map<String, dynamic> json) => Lop(
        idLop: json['idLop'],
        tenLop: json['tenLop'],
        siSo: json['siSo'],
        maST: json['maST'],
      );

  Map<String, dynamic> toJson() => {
        'idLop': idLop,
        'tenLop': tenLop,
        'siSo': siSo,
        'maST': maST,
      };
}
