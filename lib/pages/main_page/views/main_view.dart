import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qlevar_local_manager/pages/main_page/tree/widget.dart';
import '../../import_page/import_icon.dart';
import 'options_row.dart';
import 'exit_icon.dart';
import 'add_language.dart';
import '../local_item/controller.dart';
import '../local_item/widget.dart';
import '../../settings_page/settings_icon.dart';
import '../../export_page/views/export_icon.dart';
import '../local_item/binder.dart';
import '../local_node/binder.dart';
import '../../../models/qlocal.dart';
import '../controllers/main_controller.dart';
import 'save_data_widget.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(controller.appfile.name),
          actions: const [
            SaveDataWidget(),
            ExportIcon(),
            ImportIcon(),
            AddLanguageIcon(),
            SettingsIcon(),
            ExitIcon(),
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(5),
              child: Obx(() => controller.loading.isTrue
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink()))),
      body: _buildList,
    );
  }

  Widget get _buildList => Obx(() => Row(
        children: [
          Container(
              color: Get.theme.bottomAppBarColor,
              width: 200,
              child: TreeWidget(controller.locals.value)),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                OptionsRow(),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: LocalItemWidget(
                    controller: LocalItemController(
                        QlevarLocalItem(key: 'Keys')
                          ..values.addEntries(controller
                              .locals()
                              .languages
                              .map((e) => MapEntry(e, e))),
                        [0]),
                    isHeader: true,
                  ),
                ),
                Expanded(
                  child: ListView(shrinkWrap: true, primary: true, children: [
                    ...controller.getItem.map((e) => LocalItemBinder(
                          key: ValueKey(e.index),
                          item: e,
                          // ignore: prefer_const_literals_to_create_immutables
                          indexMap: [0],
                          startPadding: 8,
                        )),
                    ...controller.getNodes.map((e) => LocalNodeBinder(
                          key: ValueKey(e.index),
                          item: e,
                          // ignore: prefer_const_literals_to_create_immutables
                          indexMap: [0],
                          startPadding: 8,
                        )),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ));
}
