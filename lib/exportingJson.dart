import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:face_recogintion_project/DB/databaseHelper.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({Key? key}) : super(key: key);

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  bool _isExporting = false;

  void _exportAndShare() async {
    setState(() {
      _isExporting = true;
    });

    try {
      final dbHelper = DatabaseHelper();
      await dbHelper.init();
      final file = await dbHelper.exportToJson();

      // Share the exported file
      await Share.shareXFiles([XFile(file.path)],
          text: "Here is the exported face.json");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exported and shared successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error exporting: $e")),
      );
    } finally {
      setState(() {
        _isExporting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Export Faces"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _isExporting ? null : _exportAndShare,
          child: _isExporting
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text("Export & Share JSON"),
        ),
      ),
    );
  }
}
