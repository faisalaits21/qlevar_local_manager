import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../export_page/controller.dart';
import '../controller.dart';

class AutoSaveSection extends StatelessWidget {
  final SettingsController controller;
  const AutoSaveSection(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ExpansionTile(
        title: const Text('Auto Save settings'),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Obx(() => Row(
                children: [
                  SizedBox(
                      width: 150,
                      child: CheckboxListTile(
                          title: const Text('Enabled'),
                          value: controller.settings.value.autoSave.enabled,
                          onChanged: (value) {
                            controller.settings.value.autoSave.enabled =
                                value ?? true;
                            controller.settings.refresh();
                          })),
                  const SizedBox(width: 8),
                  SizedBox(
                      width: 100,
                      child: AbsorbPointer(
                        absorbing: !controller.settings.value.autoSave.enabled,
                        child: TextFormField(
                          initialValue: controller
                              .settings()
                              .autoSave
                              .interval
                              .toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                              label: Text('Interval (Sec)')),
                          onChanged: (s) {
                            controller.settings().autoSave.interval =
                                int.parse(s);
                            controller.settings.refresh();
                          },
                        ),
                      )),
                  const SizedBox(width: 32),
                  SizedBox(
                      width: 125,
                      child: CheckboxListTile(
                          title: const Text('Export'),
                          value: controller.settings.value.autoSave.export,
                          onChanged: (value) {
                            controller.settings.value.autoSave.export =
                                value ?? true;
                            controller.settings.refresh();
                          })),
                  AbsorbPointer(
                    absorbing: !controller.settings.value.autoSave.export,
                    child: ToggleButtons(
                        children: ExportAs.values
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(describeEnum(e)),
                                ))
                            .toList(),
                        onPressed: (i) {
                          controller.settings.value.autoSave.exportAs =
                              ExportAs.values[i];
                          controller.settings.refresh();
                        },
                        isSelected: ExportAs.values
                            .map((e) =>
                                e ==
                                controller.settings.value.autoSave.exportAs)
                            .toList()),
                  ),
                ],
              )),
        ],
      );
}
