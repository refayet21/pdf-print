import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import '../../../data/model/person.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:bijoy_helper/bijoy_helper.dart';

import '../../preview/views/preview_view.dart';

class HomeController extends GetxController {
  RxList<Person> data = <Person>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Populate data with sample Person objects
    data.addAll([
      Person(name: 'সঞ্জিত কুমার গুহ', age: 11, height: 5.3),
      Person(name: 'অনিকা রহমান', age: 25, height: 5.4),
      Person(name: 'রোহিত সরকার', age: 32, height: 5.9),
      Person(name: 'মিতা দাস', age: 45, height: 5.4),
      Person(name: 'রহিম মিয়া', age: 35, height: 5.6),
      Person(name: 'তাসকিনা খান', age: 24, height: 5.4),
      Person(name: 'আলমগীর হোসেন', age: 36, height: 5.4),
      Person(name: 'জয়া ইসলাম', age: 30, height: 5.5),
      Person(name: 'নাজিম হাসান', age: 22, height: 5.3),
      Person(name: 'সুমন আহমেদ', age: 20, height: 5.7),
      Person(name: 'তারিন ইসলাম', age: 27, height: 5.8),
    ]);
  }

  Future<void> displayPdf() async {
    final doc = pw.Document();
    try {
      final fontData =
          await rootBundle.load("assets/fonts/siyamrupaliansi.ttf");
      final ttf = pw.Font.ttf(fontData);
      final fallbackfontData =
          await rootBundle.load("assets/fonts/siyamrupali.ttf");

      final List<String> headers = [
        unicodeToBijoy('নাম'),
        unicodeToBijoy('বয়স'),
        unicodeToBijoy('উচ্চতা'),
      ];

      final List<List<String>> body = data
          .map((person) => [
                unicodeToBijoy(person.name),
                _convertToBengaliNumber(person.age),
                _convertToBengaliNumber(person.height),
              ])
          .toList();

      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.roll80,
          theme: pw.ThemeData.withFont(
            base: ttf,
          ),
          build: (pw.Context context) {
            return pw.Expanded(
              child: pw.Padding(
                padding: pw.EdgeInsets.all(5),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Table.fromTextArray(
                      headerStyle: pw.TextStyle(
                        fontSize: 10,
                        font: ttf,
                        fontFallback: [pw.Font.ttf(fallbackfontData)],
                      ),
                      cellStyle: pw.TextStyle(
                        fontSize: 9,
                        font: ttf,
                        fontFallback: [pw.Font.ttf(fallbackfontData)],
                      ),
                      headers: headers,
                      data: body,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      Get.to(() => PreviewView(doc: doc));
    } catch (e) {
      print('Error is $e');
    }
  }

  String _convertToBengaliNumber(dynamic input) {
    if (input is String) {
      const Map<String, String> bengaliDigits = {
        '0': '০',
        '1': '১',
        '2': '২',
        '3': '৩',
        '4': '৪',
        '5': '৫',
        '6': '৬',
        '7': '৭',
        '8': '৮',
        '9': '৯',
      };

      String result = '';
      for (int i = 0; i < input.length; i++) {
        final char = input[i];
        if (bengaliDigits.containsKey(char)) {
          result += bengaliDigits[char]!;
        } else {
          result += char;
        }
      }
      return result;
    }
    return input.toString();
  }
}
