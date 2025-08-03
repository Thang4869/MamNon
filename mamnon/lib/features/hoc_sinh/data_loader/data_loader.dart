import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/child.dart';
import '../models/diemdanh.dart';
import '../models/hocsinh_lop.dart';
import '../models/lop.dart';
import '../models/monhoc.dart';
import '../models/tkb.dart';

class JsonLoader {
  static Future<List<T>> loadList<T>(String path, T Function(Map<String, dynamic>) fromJson) async {
    final jsonString = await rootBundle.loadString(path);
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => fromJson(e)).toList();
  }

  static Future<List<Child>> loadChildren() => loadList('data/child.json', Child.fromJson);
  static Future<List<DiemDanh>> loadDiemDanh() => loadList('data/diemdanh.json', DiemDanh.fromJson);
  static Future<List<HocSinhLop>> loadHocSinhLop() => loadList('data/hocsinh_lop.json', HocSinhLop.fromJson);
  static Future<List<Lop>> loadLop() => loadList('data/lop.json', Lop.fromJson);
  static Future<List<MonHoc>> loadMonHoc() => loadList('data/monhoc.json', MonHoc.fromJson);
  static Future<List<TKB>> loadTKB() => loadList('data/tkb.json', TKB.fromJson);
}
