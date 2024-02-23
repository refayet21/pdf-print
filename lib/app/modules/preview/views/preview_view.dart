import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/preview_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PreviewView extends GetView<PreviewController> {
  final pw.Document? doc;
  const PreviewView({
    Key? key,
    this.doc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: Text("পিডিএফ"),
      ),
      body: PdfPreview(
        build: (format) => doc!.save(),
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.roll80,
        pdfFileName: "mydoc.pdf",
      ),
    );
  }
}
