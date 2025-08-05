import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mamnon/features/hoc_sinh/models/hocsinh_lop.dart';
import 'package:mamnon/features/hoc_sinh/page/so_buoi_vang_screen.dart';
import 'package:mamnon/features/hoc_sinh/page/tien_do_hoc_tap_screen.dart';
import 'package:mamnon/features/hoc_sinh/widget/function_card.dart';
import '../models/child.dart';
import '../models/diemdanh.dart';
import '../data_loader/data_loader.dart';

class HoSoHocSinhScreen extends StatefulWidget {
  const HoSoHocSinhScreen({super.key});

  @override
  State<HoSoHocSinhScreen> createState() => _HoSoHocSinhScreenState();
}

class _HoSoHocSinhScreenState extends State<HoSoHocSinhScreen> {
  File? _imageFile;
  List<DiemDanh> diemDanhList = [];
  List<HocSinhLop> hocSinhLopList = [];

  @override
  void initState() {
    super.initState();
    _loadDiemDanhData();
    _loadHocSinhLopData();
  }

  Future<void> _loadDiemDanhData() async {
    final data = await JsonLoader.loadDiemDanh();
    setState(() {
      diemDanhList = data;
    });
  }
  Future<void> _loadHocSinhLopData() async {
  final data = await JsonLoader.loadHocSinhLop(); 
  setState(() {
    hocSinhLopList = data;
  });
}

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> json = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Child child = Child.fromJson(json);

    return Scaffold(
      appBar: AppBar(
        title: Text(child.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFD0F5DF),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD0F5DF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : const AssetImage('assets/images/avatar.jpg') as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit, size: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text('@${child.name.toLowerCase().replaceAll(" ", "")}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(child.className, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Thông tin bé',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.deepOrange),
              title: const Text('Tên', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(child.name),
            ),
            ListTile(
              leading: const Icon(Icons.male, color: Colors.deepOrange),
              title: const Text('Giới tính', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(child.gender),
            ),
            ListTile(
              leading: const Icon(Icons.group, color: Colors.deepOrange),
              title: const Text('Lớp', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(child.className),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book, color: Colors.deepOrange),
              title: const Text('Môn học', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(child.subjects.join(', ')),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: FunctionCard(
                      icon: Icons.local_activity,
                      title: 'Buổi vắng',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SoBuoiVangScreen(
                              child: child,
                              allDiemDanh: diemDanhList,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FunctionCard(
                      icon: Icons.bar_chart,
                      title: 'Tiến độ học',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TienDoHocTapScreen(
                              child: child,
                              diemDanhList: diemDanhList,
                              hocSinhLopList: hocSinhLopList,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
