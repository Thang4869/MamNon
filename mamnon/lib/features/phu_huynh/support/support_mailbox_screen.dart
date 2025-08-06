import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mamnon/features/phu_huynh/profile_phu_huynh/models_ph/report.dart';
import 'package:mamnon/features/phu_huynh/profile_phu_huynh/widgets/support_message_card.dart';
import 'package:mamnon/features/phu_huynh/support/back_button_circle.dart';
import 'package:mamnon/features/phu_huynh/support/report_issue_screen.dart';

Future<List<ReportIssue>> fetchReports(String idPH) async {
  final url = Uri.parse('http://10.0.2.2:5005/api/ReportIssues/$idPH');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.map((e) => ReportIssue.fromJson(e)).toList();
  } else {
    throw Exception("Không tải được dữ liệu");
  }
}

class SupportMailboxScreen extends StatefulWidget {
  final String idPH;

  const SupportMailboxScreen({super.key, required this.idPH});

  @override
  State<SupportMailboxScreen> createState() => _SupportMailboxScreenState();
}

class _SupportMailboxScreenState extends State<SupportMailboxScreen> {
  late Future<List<ReportIssue>> _futureReports;

  @override
  void initState() {
    super.initState();
    debugPrint("📩 SupportMailboxScreen nhận idPH: ${widget.idPH}");
    _futureReports = fetchReports(widget.idPH);
  }

  void _reloadReports() {
    setState(() {
      _futureReports = fetchReports(widget.idPH);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hộp thư hỗ trợ')),
      body: FutureBuilder<List<ReportIssue>>(
        future: _futureReports,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final reports = snapshot.data!;
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final r = reports[index];
              return ListTile(
                title: Text(r.moTa),
                subtitle: Text(r.phanHoi ?? 'Đang chờ phản hồi'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final added = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReportIssueScreen(idPH: widget.idPH),
            ),
          );
          if (added == true) {
            _reloadReports();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
