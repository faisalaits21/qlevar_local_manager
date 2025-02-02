import 'dart:io';

import '../../helpers/constants.dart';
import '../../models/local_data.dart';

class EasyLocalizationExporterService {
  final LocalData data;
  EasyLocalizationExporterService({required this.data});

  void export(String toFolder) {
    try {
      for (var lan in data.data) {
        _export('$toFolder/${lan.name}.json', lan);
      }
    } catch (e) {
      showError('Error Exporting', e.toString());
    }
  }

  void _export(String toFile, LocalNode node) async {
    final file = File(toFile);
    if (await file.exists() == false) {
      file.create(recursive: true);
    }
    await file.writeAsString(node.toJson());
  }
}
