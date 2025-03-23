// ignore_for_file: file_names, recursive_getters

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Font? normalFont;
pw.Font? BooldFont;

void printingpage(
    {required pw.Document doc,
    required List<pw.Font> myFont,
    required pw.ImageProvider image}) {
  normalFont = myFont[0];
  BooldFont = myFont[1];

  var theme = themecostom(image: image, myFont: normalFont!);

  return doc.addPage(pw.MultiPage(
      header: (context) {
        return pw.Column(children: [
          pw.Container(
            padding: pw.EdgeInsets.symmetric(horizontal: 10),
            height: 90,
            child: pw
                .Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Container(
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text("وزارة التعليم العالي والبحث العلمي",
                          style: pw.TextStyle(font: BooldFont)),
                      pw.Text("كلية الهندسة",
                          style: pw.TextStyle(font: BooldFont)),
                      pw.Text("قسم الدراسات العليا",
                          style: pw.TextStyle(font: BooldFont)),
                      pw.Text("العام الدراسي 2023-2024",
                          style: pw.TextStyle(font: BooldFont))
                    ]),
              ),
              pw.Spacer(),
              pw.Container(
                  margin: pw.EdgeInsets.only(left: 40),
                  child: pw.Image(image, height: 75)),
              pw.Spacer(),
              pw.Container(
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text("NO : 12344567890",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text("Date : 11/11/1111",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text("Time :11:11 AM",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text("Ver : 1",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                    ]),
              ),
            ]),
          ),
          pw.Divider(thickness: 2)
        ]);
      },
      pageTheme: theme,
      build: (pw.Context context) {
        return [
          pw.Container(
            margin:
                pw.EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
            width: double.infinity,
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      //المعلومات الشخصية

                      children: [
                        pw.Container(child: pw.Image(image, height: 80)),
                        pw.Container(
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                              textwithtitle(
                                  title: "الاسم الرباعي",
                                  text: " محمد ماجد محمد عبد الحسن"),
                              textwithtitle(
                                  title: "اسم الام الثلاثي",
                                  text: " محمد ماجد محمد عبد الحسن"),
                              pw.Row(children: [
                                textwithtitle(
                                    title: "تاريخ الميلاد", text: "1996/05/12"),
                                textwithtitle(
                                    title: "البريد الالكتروني",
                                    text: "mmm.12440@gmail.com"),
                              ]),
                              pw.Row(children: [
                                textwithtitle(
                                    title: "رقم الهاتف", text: "07725726783"),
                                textwithtitle(
                                    title: "عنوان السكن",
                                    text: "كربلاء/الحر/السواده"),
                              ])
                            ])),
                      ]),
                  pw.Container(
                      //معلومات القبول
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                        titleText(title: "معلومات القبول"),
                        textwithtitle(
                            title: "الدراسة المطلوبة",
                            text:
                                "ماجستير / جامعة كربلاء / كلية الهندسة /قسم تكنلوجيا المعلومات"),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              textwithtitle(
                                  title: "قناة التقديم", text: "نفقه خاصة"),
                              textwithtitle(title: "عدد المقاعد", text: "10"),
                            ])
                      ])),
                  //معلومات القبول

                  pw.Container(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                        titleText(title: "معلومات شهادة البكلوريوس "),
                        textwithtitle(
                            title: "الجه المانحة للشهادة",
                            text:
                                "العراق/جامعة كربلاء/ كلية الهندسة / هندسة تقنياة الحاسوب"),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              textwithtitle(
                                  title: "سنة التخرج", text: "2023/2024"),
                              textwithtitle(title: "المعدل", text: "85.90"),
                              textwithtitle(
                                  title: "تاريخ الحصول على الشهادة",
                                  text: "11/11/1111"),
                            ]),
                        //معلومات شهادة البكلوريوس

                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              textwithtitle(title: "رقم الكتاب", text: "115"),
                              textwithtitle(
                                  title: "معدل الطالب الاول", text: "85.90"),
                              textwithtitle(
                                  title: "تاريخ الوثيقة", text: "11/11/1111"),
                              textwithtitle(title: "الوثيقة", text: "447"),
                              textwithtitle(
                                  title: "تاريخ الكتاب", text: "11/11/1111"),
                            ])
                      ])),
                  //هل لديك ترقين قيد

                  pw.Container(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                        titleText(
                            title:
                                "هل لديك ترقين قيد او الغاء قبول بدراسة عليا سابقا"),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              textwithtitle(title: "ج", text: "كلا "),
                              textwithtitle(title: "السبب", text: "لايوجد "),
                            ])
                      ])),

                  //معلومات الوظيفة
                  pw.Container(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                        titleText(title: "معلومات الوظيفية"),
                        textwithtitle(
                            title: "محل العمل",
                            text:
                                " وزارة التعليم العالي / جامعة كربلاء / رئاسة الجامعة"),
                        textwithtitle(title: "نوع التوضيف", text: "ملاك دائم"),
                        textwithtitle(
                            title: "تاريخ المباشرة بعد اخر شهادة",
                            text: "11/11/1111"),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              textwithtitle(
                                  title: "رقم كتاب عدم الممانعة ",
                                  text: "15151"),
                              textwithtitle(
                                  title: "تاريخ كتاب عدم الممانعة",
                                  text: "11/11/1111"),
                            ]),
                        textwithtitle(
                            title: "نوع الاجازة حسب كتاب عدم الممانعة",
                            text: "اجازة دراسية")
                      ]))
                  //معلومات شهادات الكفائة
                  ,
                  pw.Container(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                        titleText(title: "معلومات شهادات الكفائة"),
                        textwithtitle(
                          iscotation: true,
                          title:
                              "حاصل على شهادة كفاءة الحاسوب من جامعة كربلاء وبتقدير جيد",
                        ),
                        textwithtitle(
                          iscotation: true,
                          title:
                              "حاصل على شهادة كفاءة اللغة العربية من جامعة كربلاء وبتقدير جيد",
                        ),
                        textwithtitle(
                          iscotation: true,
                          title:
                              "حاصل على شهادة كفاءة اللغة الانكليزية من جامعة كربلاء وبتقدير جيد",
                        ),
                      ]))
                ]),
          )
//التعهد والتوقيع
          ,
          pw.Container(
              margin: const pw.EdgeInsets.only(right: 20),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    titleText(title: "التعهد والتوقيع"),
                    textwithtitle(
                      iscotation: true,
                      title:
                          "- اتعهد بالاستمرار في الخدمة الوظيفية بع حصولي على الشهادة",
                    ),
                    textwithtitle(
                      iscotation: true,
                      title:
                          "- اتعهد بعدم ترقين قيدي او الغاء قبولي او انهاء علاقتي في الدراسات العليا سابقا",
                    ),
                    textwithtitle(
                      iscotation: true,
                      title:
                          "- اتعهد بصحة المعلومات اعلاه وبخلاف ذلك اتحمل كافة المسؤولية القانونية",
                    ),
                  ])),
          pw.Container(
              padding: const pw.EdgeInsets.only(top: 20),
              child: pw.Row(children: [
                pw.SizedBox(width: 100),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      textwithtitle(
                        iscotation: true,
                        title: "الاسم الرباعي والتوقيع ",
                      ),
                      textwithtitle(
                        iscotation: true,
                        title: " \n ",
                      ),
                      textwithtitle(
                        iscotation: true,
                        title: " محمد ماجد محمد عبدالحسن ",
                      ),
                    ])
              ]))
        ];
      }));
}

pw.PageTheme themecostom(
    {required pw.ImageProvider image, required pw.Font myFont}) {
  return pw.PageTheme(
    textDirection: pw.TextDirection.rtl,
    buildBackground: (context) => pw.Opacity(
      opacity: 0.1,
      child: pw.Center(
        child: pw.Image(image),
      ),
    ),
    margin: const pw.EdgeInsets.only(bottom: 10),
    // theme: pw.ThemeData.withFont(
    //   base: myFont,
    // ),
    pageFormat: PdfPageFormat.a4,
  );
}

pw.TextStyle get titleprinting => const pw.TextStyle(
      fontSize: 14,
    );
pw.TextStyle get lableprinting => const pw.TextStyle(fontSize: 11);

pw.Container titleText({required String title}) {
  return pw.Container(
    constraints: const pw.BoxConstraints(maxWidth: 400),
    margin: const pw.EdgeInsets.only(bottom: 10),
    decoration: const pw.BoxDecoration(
        border: pw.Border(
            bottom: pw.BorderSide(
      width: 1.0, // Underline thickness
    ))),
    child: pw.Text(title, style: titleprinting.copyWith(font: BooldFont)),
  );
}

pw.Container textwithtitle(
    {required String title, String text = "", bool iscotation = false}) {
  return pw.Container(
      // margin: const pw.EdgeInsets.only(top: 4),
      child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
    pw.Text("$title ${iscotation ? "" : ":"} ",
        style: lableprinting.copyWith(font: BooldFont)),
    pw.Text(text, style: lableprinting.copyWith(font: BooldFont)),
    pw.SizedBox(width: 10),
  ]));
}
