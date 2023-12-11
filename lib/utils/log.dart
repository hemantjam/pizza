import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share/share.dart';

class AppLogs {
  static List<String> logs = [];

  static add(String appLog) {
    logs.add("$appLog\n\n");
  }

  static Future<File> createLogFile() async {
    var pdf = pw.Document();
    pdf.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(10),
       // maxPages: 1500,
        build: (pw.Context context) {
          return
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: logs
                  .map(
                    (e) => pw.Text("[Log]:$e"),
                  )
                  .toList(),
            );

        }));

    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    File file = File("$documentPath/$id.pdf");
    file.writeAsBytesSync(await pdf.save());
    Get.back();
    return file;
  }

  static shareLogFile() async {
    File file = await createLogFile();
    await Share.shareFiles(
      [file.path],
      text: "Save the logs for share!",
    );
  }
}
