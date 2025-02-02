import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../helpers/constants.dart';
import '../../settings_page/settings.dart';
import '../../../models/qlocal.dart';

class MainController extends GetxController {
  final AppLocalFile appfile;
  final Rx<QlevarLocal> locals;
  final openAllNodes = false.obs;
  final loading = false.obs;
  final filter = ''.obs;
  late final treeController = ScrollController();
  late final gridController = ScrollController();
  MainController({required this.appfile, required QlevarLocal locals})
      : locals = locals.obs;

  int get listItemsCount => locals().items.length + locals().nodes.length;

  Iterable<QlevarLocalItem> get getItem => filter.isEmpty
      ? locals().items
      : locals().items.where((i) => i.filter(filter()));

  Iterable<QlevarLocalNode> get getNodes => filter.isEmpty
      ? locals().nodes
      : locals().nodes.where((i) => i.filter(filter()));

  void addItem(List<int> indexMap, String key) {
    QlevarLocalNode node = locals();
    for (var i = 1; i < indexMap.length; i++) {
      node = node.nodes.firstWhere((e) => e.index == indexMap[i]);
    }
    if (node.items.any((e) => e.key == key)) {
      showError('Error', 'Key with name $key already exist');
      return;
    }
    final item = QlevarLocalItem(key: key);
    item.ensureAllLanguagesExist(locals().languages);
    item.values[locals().languages.first] = key;
    node.items.add(item);
    locals.refresh();
  }

  void addNode(List<int> indexMap, String key) {
    QlevarLocalNode node = locals();
    for (var i = 1; i < indexMap.length; i++) {
      node = node.nodes.firstWhere((e) => e.index == indexMap[i]);
    }
    if (node.items.any((e) => e.key == key)) {
      showError('Error', 'Key with name $key already exist');
      return;
    }
    final item = QlevarLocalNode(key: key);
    node.nodes.add(item);
    locals.refresh();
  }

  void updateLocalItem(List<int> indexMap, String language, String value) {
    QlevarLocalNode node = locals();
    for (var i = 1; i < indexMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.index == indexMap[i]);
    }
    final item = node.items.firstWhere((e) => e.index == indexMap.last);
    item.values[language] = value;
    locals.refresh();
  }

  void updateLocalItemKey(List<int> indexMap, String value) {
    QlevarLocalNode node = locals();
    for (var i = 1; i < indexMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.index == indexMap[i]);
    }
    if (node.items.any((e) => e.index != indexMap.last && e.key == value)) {
      showError('Error', 'Key with name $value already exist');
      update();
      return;
    }
    final item = node.items.firstWhere((e) => e.index == indexMap.last);
    item.key = value;
    locals.refresh();
  }

  void removeItem(List<int> indexMap) {
    QlevarLocalNode node = locals();
    for (var i = 1; i < indexMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.index == indexMap[i]);
    }
    final item = node.items.firstWhere((e) => e.index == indexMap.last);
    node.items.remove(item);
    locals.refresh();
  }

  void removeNode(List<int> indexMap) {
    QlevarLocalNode node = locals();
    for (var i = 1; i < indexMap.length - 1; i++) {
      node = node.nodes.firstWhere((e) => e.index == indexMap[i]);
    }
    final item = node.nodes.firstWhere((e) => e.index == indexMap.last);
    node.nodes.remove(item);
    locals.refresh();
  }

  Future<void> saveData() async {
    loading(true);
    final data = locals().toData();
    await File(appfile.path).writeAsString(data.toJson());
    loading(false);
  }

  @override
  void onClose() {
    treeController.dispose();
    gridController.dispose();
    super.onClose();
  }
}
