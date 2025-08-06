import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mamnon/features/phu_huynh/support/back_button_circle.dart';

Future<bool> submitReport(String idPH, String date, String description) async {
  final url = Uri.parse('http://10.0.2.2:5005/api/ReportIssues');
  final body = {
    'idPh': idPH.trim(), 
    'ngayBaoCao': "${date}T00:00:00",
    'moTa': description,
    'trangThai': 'Đang chờ phản hồi', 
    'phanHoi': null, 
  };

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(body),
  );

  debugPrint("📤 Gửi báo cáo: ${jsonEncode(body)}");
  debugPrint("📥 Kết quả trả về: ${response.statusCode} - ${response.body}");

  return response.statusCode == 200 || response.statusCode == 201;
}

class ReportIssueScreen extends StatefulWidget {
  final String idPH;

  const ReportIssueScreen({super.key, required this.idPH});

  @override
  State<ReportIssueScreen> createState() => _ReportIssueFormState();
}

class _ReportIssueFormState extends State<ReportIssueScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("📝 ReportIssueScreen nhận idPH: ${widget.idPH}");
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonCircle(),
        title: const Text('Báo cáo sự cố'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Mô tả sự cố'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Chọn ngày'),
                ),
                const SizedBox(width: 10),
                Text(_selectedDate == null
                    ? 'Chưa chọn'
                    : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final description = _descriptionController.text.trim();
                if (description.isEmpty || _selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nhập đủ thông tin')),
                  );
                  return;
                }

                final dateStr =
                    '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}';

                final ok =
                    await submitReport(widget.idPH, dateStr, description);
                if (ok) {
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gửi thất bại')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
