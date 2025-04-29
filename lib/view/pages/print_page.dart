import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/Models/college_authorized.dart';
import 'package:graduate_gtudiesV2/controller/home_page_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart' as ini;
import '../../Enums/CertificateCompetency.dart';
import '../../Enums/CertificateType.dart';
import '../../Models/full_student_data.dart';
import '../../controller/PrintDataController.dart';

class PrintingUserPage {
  HomePageController homePageController = Get.find();
  CollegeAuthorize? collegeAuthorized = CollegeAuthorize();

  Future<Uint8List> printingPage(StudentDataController controller) async {
    collegeAuthorized = await homePageController.getCollageAuth();
    StudentDataController controller = Get.find();
    final doc = Document();
    var base = await PdfGoogleFonts.amiriRegular();
    final netImage = await controller.fetchImage(
        controller.studentSingleDataModule?.imageInformation?.personalPhoto);
    final img = await rootBundle.load('assets/icons/Logo.png');
    String dateTimeStamp(int? unixTimestamp) {
      if (unixTimestamp != null) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimestamp);
        return "${date.year}-${date.month}-${date.day}";
      }

      return DateTime.now().toString();
    }

    String timeStamp(int? unixTimestamp) {
      if (unixTimestamp != null) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimestamp);
        ini.DateFormat formatter =
            ini.DateFormat('h:mm a'); // Using 'a' for AM/PM
        return formatter.format(date);
      }

      // If no timestamp is provided, return the current time in the same format
      return ini.DateFormat('h:mm a').format(DateTime.now());
    }

    doc.addPage(MultiPage(
        pageTheme: PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const EdgeInsets.all(8),
          textDirection: TextDirection.rtl,
          theme: ThemeData.withFont(base: base),
          buildBackground: (context) => Container(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                  child: Opacity(
                      opacity: 0.1,
                      child: Image(MemoryImage(img.buffer.asUint8List()))))),
        ),
        // footer: (context) => Center(
        //     child: Text('${context.pageNumber} of ${context.pagesCount}')),
        header: (context) {
          return Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: PdfPageFormat.a4.width / 3,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("وزارة التعليم العالي والبحث العلمي",
                            style: TextStyle(font: base)),
                        Text(
                            '${controller.universities(universitiesId: controller.department(departmentId: controller.studentSingleDataModule?.personalInformation?.first.submission?.departmentId)?.universityId)?.universityName}/${controller.colleges(collegesId: controller.department(departmentId: controller.studentSingleDataModule?.personalInformation?.first.submission?.departmentId)?.collegesId)?.collegesName}',
                            style: TextStyle(font: base)),
                        Text("قسم الدراسات العليا",
                            style: TextStyle(font: base)),
                        Text(
                            "العام الدراسي ${DateTime.now().year}-${DateTime.now().year + 1}",
                            style: TextStyle(font: base))
                      ]),
                ),
                Spacer(),
                Container(
                    width: PdfPageFormat.a4.width / 3,
                    margin: const EdgeInsets.only(left: 40),
                    child: Image(MemoryImage(img.buffer.asUint8List()),
                        height: 75)),
                Spacer(),
                Container(
                  width: PdfPageFormat.a4.width / 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BarcodeWidget(
                            width: 130,
                            height: 65,
                            color: PdfColors.black,
                            data:
                                "Serial : ${controller.studentSingleDataModule?.serial}\n Date : ${dateTimeStamp(controller.studentSingleDataModule?.serial)} \n Time : ${timeStamp(controller.studentSingleDataModule?.serial)}",
                            barcode: Barcode.qrCode()),
                      ]),
                ),
              ]),
            ),
            Divider(thickness: 2)
          ]);
        },
        // pageTheme: theme,
        build: (Context context) {
          return [
            titleText(title: "المعلومات الشخصية"),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //المعلومات الشخصية

                children: [
                  if (controller.studentSingleDataModule?.personalInformation !=
                      null)
                    for (var personalInformation in controller
                        .studentSingleDataModule!.personalInformation!)
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            textwithtitle(
                                title: "الاسم الرباعي",
                                text:
                                    "${personalInformation.firstName} ${personalInformation.secondName} ${personalInformation.thirdName} ${personalInformation.fourthName}"),
                            textwithtitle(
                                title: "اسم الام الثلاثي",
                                text:
                                    "${personalInformation.firstMothersName} ${personalInformation.secondMothersName} ${personalInformation.thirdMothersName}"),
                            Row(children: [
                              textwithtitle(
                                  title: "تاريخ الميلاد",
                                  text: "${personalInformation.dateOfBirth}"),
                              textwithtitle(
                                  title: "البريد الالكتروني",
                                  text: "${personalInformation.firstName}"),
                            ]),
                            Row(children: [
                              textwithtitle(
                                  title: "رقم الهاتف",
                                  text: "${personalInformation.phone}"),
                              if (personalInformation.addresses!.isNotEmpty)
                                if (personalInformation.addresses != null &&
                                    personalInformation.addresses!.isNotEmpty)
                                  textwithtitle(
                                      title: "عنوان السكن",
                                      text:
                                          "${personalInformation.addresses?.first.state ?? ''}  ${personalInformation.addresses?.first.neighborhood ?? ''} / ${personalInformation.addresses?.first.mahalla ?? ''}/${personalInformation.addresses?.first.district ?? ''}/${personalInformation.addresses?.first.alley ?? ''}"),
                            ]),
                            Row(children: [
                              textwithtitle(
                                  title: "القومية",
                                  text: "${personalInformation.nationality}"),
                              textwithtitle(
                                  title: "الجنس",
                                  text: "${personalInformation.gender}"),
                            ])
                          ])),
                  if (netImage != null)
                    Container(
                        child: Image(MemoryImage(netImage),
                            height: 80, width: 60)),
                ]),
            if (controller.studentSingleDataModule?.personalInformation != null)
              titleText(title: "معلومات القبول"),
            if (controller.studentSingleDataModule?.personalInformation != null)
              Container(
                  //معلومات القبول
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    for (var personalinfo in controller
                        .studentSingleDataModule!.personalInformation!)
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            textwithtitle(
                                title: "الدراسة المطلوبة",
                                text:
                                    "${personalinfo.typeofStudy!.isEmpty ? "" : personalinfo.typeofStudy?[0].typeofStudy?.first.typeofStudyName} / ${controller.universities(universitiesId: controller.department(departmentId: controller.studentSingleDataModule?.personalInformation?.first.submission?.departmentId)?.universityId)?.universityName}  /  ${controller.colleges(collegesId: controller.department(departmentId: controller.studentSingleDataModule?.personalInformation?.first.submission?.departmentId)?.collegesId)?.collegesName} /  ${controller.department(departmentId: controller.studentSingleDataModule?.personalInformation?.first.submission?.departmentId)?.departmentName} "),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  textwithtitle(
                                      title: "قناة التقديم",
                                      text:
                                          "${personalinfo.admissionChannel != null && personalinfo.admissionChannel!.isNotEmpty ? controller.channelsData(channelsDataId: personalinfo.admissionChannel?.first.channelsId)?.name : ""}"),
                                  textwithtitle(
                                      title: "عدد المقاعد",
                                      text:
                                          "${personalinfo.admissionChannel != null && personalinfo.admissionChannel!.isNotEmpty ? (personalinfo.admissionChannel?.first.numberOfSeats) : ""}"),
                                  if (personalinfo.submission?.relativeId !=
                                      null)
                                    textwithtitle(
                                        title: "صلة القرابة",
                                        text:
                                            "${controller.Relative(id: personalinfo.submission?.relativeId)?.namerelation}"),
                                ]),
                            textwithtitle(
                                title:
                                    "هل لديك ترقين قيد او الغاء قبول بدراسة عليا سابقا",
                                text: personalinfo.isRegistrationUpgraded == 1
                                    ? 'نعم'
                                    : 'كلا'),
                          ])
                  ])),
            // معلومات القبول

            if (controller.studentSingleDataModule?.academicInformation != null)
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    titleText(title: "الشهادات الحاصل عليها"),
                    for (FullDataAcademicInformation acinfo in controller
                        .studentSingleDataModule!.academicInformation!)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: [
                              textWithTitle(
                                  title: CertificateType.values
                                      .where((c) =>
                                          c.id == acinfo.certificateTypeId)
                                      .first
                                      .name),
                              textwithtitle(
                                  title: "الجه المانحة للشهادة",
                                  text:
                                      "${acinfo.certificateIssuedBy}/${controller.universities(universitiesId: int.tryParse("${acinfo.universityId}"))?.universityName ?? acinfo.universityId}/${controller.colleges(collegesId: int.tryParse("${acinfo.collegesId}"))?.collegesName ?? acinfo.collegesId}/${controller.department(departmentId: int.tryParse('${acinfo.departmentId}'))?.departmentName ?? acinfo.departmentId}"),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    textwithtitle(
                                        title: "سنة التخرج",
                                        text: "${acinfo.academicYear}"),
                                    textwithtitle(
                                        title: "المعدل",
                                        text: "${acinfo.average}"),
                                  ]),
                              if (acinfo.documents != null &&
                                  acinfo.documents!.isNotEmpty)
                                textwithtitle(
                                    title: "رقم وتاريخ الكتاب",
                                    text:
                                        "${acinfo.documents?.first.documentsNumber} في ${acinfo.documents?.first.documentsDate}"),
                            ]),

                            //معلومات شهادة البكلوريوس
                          ]),
                  ])),
            // هل لديك ترقين قيد

            if (controller.studentSingleDataModule?.sportChampion != null &&
                controller.studentSingleDataModule!.sportChampion!.isNotEmpty)
              Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    titleText(title: "هل انت بطل رياضي؟"),
                    textwithtitle(
                        title: 'الاسم',
                        text:
                            '${controller.studentSingleDataModule?.sportChampion?.first.name}'),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      textwithtitle(
                          title: 'رقم الكتاب',
                          text:
                              '${controller.studentSingleDataModule?.sportChampion?.first.documents?.documentsNumber}'),
                      textwithtitle(
                          title: 'تاريخ الكتاب',
                          text:
                              '${controller.studentSingleDataModule?.sportChampion?.first.documents?.documentsDate}'),
                    ])
                  ])),
            controller.studentSingleDataModule?.careerInformation == null &&
                    controller
                        .studentSingleDataModule!.careerInformation!.isNotEmpty
                ? Container()
                : Column(children: [
                    for (var elemnt in controller
                        .studentSingleDataModule!.careerInformation!)
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            titleText(title: "معلومات الوظيفية"),
                            textwithtitle(
                                title: "نوع التوضيف",
                                text:
                                    "${controller.employmentStatusData(employmentstatusDataid: elemnt.employmentStatusId)?.statusName}"),
                            if (controller
                                    .ministries(ministriesId: elemnt.ministryId)
                                    ?.name !=
                                null)
                              Column(children: [
                                textwithtitle(
                                    title: "محل العمل",
                                    text:
                                        "${controller.ministries(ministriesId: elemnt.ministryId)?.name}/${elemnt.organizationName ?? ''}"),
                                textwithtitle(
                                    title: "تاريخ المباشرة بعد اخر شهادة",
                                    text: "${elemnt.dateCommencement}"),
                                elemnt.documents == null
                                    ? Container()
                                    : Column(children: [
                                        for (var doc in elemnt.documents!)
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                textwithtitle(
                                                    title: "نوع الكتاب",
                                                    text:
                                                        "${controller.documentstypes(doc.documentsTypeId)?.documentsTypeName}"),
                                                textwithtitle(
                                                    title: "رقم الكتاب",
                                                    text:
                                                        "${doc.documentsNumber}"),
                                                textwithtitle(
                                                    title: "تاريخ الكتاب",
                                                    text:
                                                        "${doc.documentsDate}"),
                                              ]),
                                      ]),
                                textwithtitle(
                                    title: "نوع الاجازة حسب كتاب عدم الممانعة",
                                    text: "اجازة دراسية"),
                                textwithtitle(
                                    title: "العنوان الوظيفي",
                                    text:
                                        "${controller.scientificTitles(scientifictitlesid: controller.studentSingleDataModule?.careerInformation?.first.scientificTitleId)?.name}")
                              ])
                          ]))
                    //معلومات شهادات الكفائة
                    ,
                  ]), //معلومات الوظيفة

            if (controller.studentSingleDataModule?.certificateCompetency !=
                null)
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText(title: "معلومات شهادات الكفائة"),
                      for (var certificatecompetency in controller
                          .studentSingleDataModule!.certificateCompetency!)
                        textWithTitle(
                          iscotation: true,
                          title:
                              "حاصل على شهادة  ${CertificateCompetencyTypes.values.where((c) => c.id == certificatecompetency.certificateCompetencyTypeId).first.name} من ${ certificatecompetency.examCenter} وبدرجة ${certificatecompetency.appreciation}",
                        ),
                    ]),
              )
//التعهد والتوقيع
            ,
            Container(
                margin: const EdgeInsets.only(right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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

            Container(
                padding: const EdgeInsets.only(top: 20),
                child: Row(children: [
                  Spacer(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textwithtitle(
                          iscotation: true,
                          title: "الاسم الرباعي والتوقيع ",
                        ),
                        textwithtitle(
                          iscotation: true,
                          title: " \n ",
                        ),
                        if (controller.studentSingleDataModule
                                    ?.personalInformation !=
                                null &&
                            controller.studentSingleDataModule!
                                .personalInformation!.isNotEmpty)
                          textwithtitle(
                            iscotation: true,
                            title:
                                "${controller.studentSingleDataModule?.personalInformation?.first.firstName} ${controller.studentSingleDataModule?.personalInformation?.first.secondName} ${controller.studentSingleDataModule?.personalInformation?.first.thirdName} ${controller.studentSingleDataModule?.personalInformation?.first.fourthName}",
                          ),
                      ]),
                  Spacer(flex: 3),
                  if (controller.studentSingleDataModule?.collegeAuthorized !=
                      null)
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textwithtitle(
                            iscotation: true,
                            title:
                                "${controller.studentSingleDataModule?.collegeAuthorized}",
                          ),
                        ]),
                  Spacer(),
                ]))
          ];
        }));

    return doc.save();
  }

  PageTheme themecostom({required ImageProvider image, required Font myFont}) {
    return PageTheme(
      textDirection: TextDirection.rtl,
      buildBackground: (context) => Opacity(
        opacity: 0.1,
        child: Center(
          child: Image(image),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      // theme: ThemeData.withFont(
      //   base: myFont,
      // ),
      pageFormat: PdfPageFormat.a4,
    );
  }

  TextStyle get titleprinting => const TextStyle(
        fontSize: 14,
      );

  TextStyle get lableprinting => const TextStyle(fontSize: 11);

  Container titleText({required String title}) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1.0, // Underline thickness
      ))),
      child: Text(title, style: titleprinting),
    );
  }

  Container textwithtitle({
    required String title,
    String text = "",
    bool iscotation = false,
  }) {
    return Container(
        // margin: const EdgeInsets.only(top: 4),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text("$title ${iscotation ? "" : ":"} ", style: lableprinting),
      Text(text, style: lableprinting),
      SizedBox(width: 10),
    ]));
  }
}

//   Future<Uint8List> printingpage(StudentDataController controllers) async {
//     collegeAuthorized = await homePageController.getCollageAuth();
//     print('${collegeAuthorized?.collegeAuthorized?.name}');
//     final doc = Document();
//     var base = await PdfGoogleFonts.changaRegular();
//     final netImage = await controllers.fetchImage(
//         controllers.studentSingleDataModule?.imageInformation?.personalPhoto);
//     final img = await rootBundle.load('assets/icons/Logo.png');
//     // final True = await rootBundle.load('assets/icons/true.svg');
//     String DateTimeStamp(int? unixTimestamp) {
//       if (unixTimestamp != null) {
//         DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimestamp);
//         return "${date.year}-${date.month}-${date.day}";
//       }
//
//       return DateTime.now().toString();
//     }
//
//     String TimeStamp(int? unixTimestamp) {
//       if (unixTimestamp != null) {
//         DateTime date = DateTime.fromMillisecondsSinceEpoch(unixTimestamp);
//         ini.DateFormat formatter =
//             ini.DateFormat('h:mm a'); // Using 'a' for AM/PM
//         return formatter.format(date);
//       }
//
//       // If no timestamp is provided, return the current time in the same format
//       return ini.DateFormat('h:mm a').format(DateTime.now());
//     }
//
//     doc.addPage(MultiPage(
//         pageTheme: PageTheme(
//           pageFormat: PdfPageFormat.a4,
//           margin: const EdgeInsets.all(8),
//           textDirection: TextDirection.rtl,
//           theme: ThemeData.withFont(base: base),
//           buildBackground: (context) => Container(
//               width: double.infinity,
//               height: double.infinity,
//               child: Center(
//                   child: Opacity(
//                       opacity: 0.1,
//                       child: Image(MemoryImage(img.buffer.asUint8List()))))),
//         ),
//         footer: (context) => Center(
//             child: Text('${context.pageNumber} of ${context.pagesCount}')),
//         header: (context) {
//           return Column(children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child:
//                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 Container(
//                   width: PdfPageFormat.a4.width / 3,
//                   child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("وزارة التعليم العالي والبحث العلمي",
//                             style: TextStyle(font: base)),
//                         Text(
//                             '${controllers.universities(universitiesId: controllers.department(departmentId: controllers.studentSingleDataModule?.personalInformation?.first.submission?.departmentId)?.universityId)?.universityName}/${controllers.colleges(collegesId: controllers.department(departmentId: controllers.studentSingleDataModule?.personalInformation?.first.submission?.departmentId)?.collegesId)?.collegesName}',
//                             style: TextStyle(font: base)),
//                         Text("قسم الدراسات العليا",
//                             style: TextStyle(font: base)),
//                         Text(
//                             "العام الدراسي ${DateTime.now().year}-${DateTime.now().year + 1}",
//                             style: TextStyle(font: base))
//                       ]),
//                 ),
//                 Spacer(),
//                 Container(
//                     width: PdfPageFormat.a4.width / 3,
//                     margin: const EdgeInsets.only(left: 40),
//                     child: Image(MemoryImage(img.buffer.asUint8List()),
//                         height: 75)),
//                 Spacer(),
//                 Container(
//                   width: PdfPageFormat.a4.width / 3,
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         BarcodeWidget(
//                             width: 130,
//                             height: 65,
//                             color: PdfColors.black,
//                             data:
//                                 "Serial : ${controllers.studentSingleDataModule?.serial}\n Date : ${DateTimeStamp(controllers.studentSingleDataModule?.serial)} \n Time : ${TimeStamp(controllers.studentSingleDataModule?.serial)}",
//                             barcode: Barcode.qrCode()),
//                       ]),
//                 ),
//               ]),
//             ),
//             Divider(thickness: 2)
//           ]);
//         },
//         // pageTheme: theme,
//
//         build: (Context context) {
//           return [
//             Container(),
//             Row(
//                 //المعلومات الشخصية
//
//                 children: [
//                   if (netImage != null)
//                     Container(
//                         child: Image(MemoryImage(netImage),
//                             height: 80, width: 60)),
//                   SizedBox(width: 10),
//                   if (controllers.studentSingleDataModule?.personalInformation !=
//                       null)
//                     for (var personalInformation in controllers
//                         .studentSingleDataModule!.personalInformation!)
//                       Container(
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                             textWithTitle(
//                                 title: "الاسم الرباعي",
//                                 text:
//                                     "${personalInformation.firstName} ${personalInformation.secondName} ${personalInformation.thirdName} ${personalInformation.fourthName}"),
//                             textWithTitle(
//                                 title: "اسم الام الثلاثي",
//                                 text:
//                                     "${personalInformation.firstMothersName} ${personalInformation.secondMothersName} ${personalInformation.thirdMothersName}"),
//                             Row(children: [
//                               textWithTitle(
//                                   title: "تاريخ الميلاد",
//                                   text: "${personalInformation.dateOfBirth}"),
//                               textWithTitle(
//                                   title: "البريد الالكتروني",
//                                   text: "${personalInformation.firstName}"),
//                             ]),
//                             Row(children: [
//                               textWithTitle(
//                                   title: "رقم الهاتف",
//                                   text: "${personalInformation.phone}"),
//                               if (personalInformation.addresses!.isNotEmpty)
//                                 if (personalInformation.addresses != null &&
//                                     personalInformation.addresses!.isNotEmpty)
//                                   textWithTitle(
//                                       title: "عنوان السكن",
//                                       text:
//                                           "${personalInformation.addresses?.first.state ?? ''}  ${personalInformation.addresses?.first.neighborhood ?? ''} / ${personalInformation.addresses?.first.mahalla ?? ''}/${personalInformation.addresses?.first.district ?? ''}/${personalInformation.addresses?.first.alley ?? ''}"),
//                             ]),
//                             Row(children: [
//                               textWithTitle(
//                                   title: "القومية",
//                                   text: "${personalInformation.nationality}"),
//                               textWithTitle(
//                                   title: "الجنس",
//                                   text: "${personalInformation.gender}"),
//                             ])
//                           ])),
//                 ]),
//
//             if (controllers.studentSingleDataModule?.personalInformation != null)
//               Container(
//                   //معلومات القبول
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                     for (var personalinfo in controllers
//                         .studentSingleDataModule!.personalInformation!)
//                       Column(children: [
//                         titleText(title: "معلومات القبول"),
//                         textWithTitle(
//                             title: "الدراسة المطلوبة",
//                             text:
//                                 "${personalinfo.typeofStudy!.isEmpty ? "" : personalinfo.typeofStudy?[0].typeofStudy} / ${controllers.universities(universitiesId: controllers.department(departmentId: controllers.studentSingleDataModule?.personalInformation?.first.submission?.departmentId)?.universityId)?.universityName}  /  ${controllers.colleges(collegesId: controllers.department(departmentId: controllers.studentSingleDataModule?.personalInformation?.first.submission?.departmentId)?.collegesId)?.collegesName} /  ${controllers.department(departmentId: controllers.studentSingleDataModule?.personalInformation?.first.submission?.departmentId)?.departmentName} "),
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               textWithTitle(
//                                   title: "قناة التقديم",
//                                   text:
//                                       "${personalinfo.admissionChannel != null && personalinfo.admissionChannel!.isNotEmpty ? controllers.channelsData(channelsDataId: personalinfo.admissionChannel?.first.channelsId)?.name : ""}"),
//                               textWithTitle(
//                                   title: "عدد المقاعد",
//                                   text:
//                                       "${personalinfo.admissionChannel != null && personalinfo.admissionChannel!.isNotEmpty ? (personalinfo.admissionChannel?.first.numberOfSeats) : ""}"),
//                               if (personalinfo.submission?.relativeId != null)
//                                 textWithTitle(
//                                     title: "صلة القرابة",
//                                     text:
//                                         "${controllers.Relative(id: personalinfo.submission?.relativeId)?.namerelation}"),
//                             ]),
//                         textWithTitle(
//                             title:
//                                 "هل لديك ترقين قيد او الغاء قبول بدراسة عليا سابقا",
//                             text: personalinfo.isRegistrationUpgraded == 1
//                                 ? 'نعم'
//                                 : 'كلا'),
//                       ])
//                   ])),
//             //معلومات القبول
//             if (controllers.studentSingleDataModule?.academicInformation != null)
//               Container(
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                     titleText(title: "الشهادات الحاصل عليها"),
//                     for (FullDataAcademicInformation acinfo in controllers
//                         .studentSingleDataModule!.academicInformation!)
//                       Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(children: [
//                               textWithTitle(
//                                   title: CertificateType.values
//                                       .where((c) =>
//                                           c.id == acinfo.certificateTypeId)
//                                       .first
//                                       .name),
//                               textWithTitle(
//                                   title: "الجهة المانحة للشهادة",
//                                   text:
//                                       "${acinfo.certificateIssuedBy}/${controllers.universities(universitiesId: int.tryParse("${acinfo.universityId}"))?.universityName ?? acinfo.universityId}/${controllers.colleges(collegesId: int.tryParse("${acinfo.collegesId}"))?.collegesName ?? acinfo.collegesId}/${controllers.department(departmentId: int.tryParse('${acinfo.departmentId}'))?.departmentName ?? acinfo.departmentId}"),
//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     textWithTitle(
//                                         title: "سنة التخرج",
//                                         text: "${acinfo.academicYear}"),
//                                     textWithTitle(
//                                         title: "المعدل",
//                                         text: "${acinfo.average}"),
//                                   ]),
//                               if (acinfo.documents != null &&
//                                   acinfo.documents!.isNotEmpty)
//                                 textWithTitle(
//                                     title: "رقم وتاريخ الكتاب",
//                                     text:
//                                         "${acinfo.documents?.first.documentsNumber} في ${acinfo.documents?.first.documentsDate}"),
//                             ]),
//
//                             //معلومات شهادة البكلوريوس
//                           ]),
//                   ])),
//             //هل لديك ترقين قيد
//
//             if (controllers.studentSingleDataModule?.sportChampion != null &&
//                 controllers.studentSingleDataModule!.sportChampion!.isNotEmpty)
//               Container(
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                     titleText(title: "هل انت بطل رياضي؟"),
//                     textWithTitle(
//                         title: 'الاسم',
//                         text:
//                             '${controllers.studentSingleDataModule?.sportChampion?.first.name}'),
//                     Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//                       textWithTitle(
//                           title: 'رقم الكتاب',
//                           text:
//                               '${controllers.studentSingleDataModule?.sportChampion?.first.documents?.documentsNumber}'),
//                       textWithTitle(
//                           title: 'تاريخ الكتاب',
//                           text:
//                               '${controllers.studentSingleDataModule?.sportChampion?.first.documents?.documentsDate}'),
//                     ])
//                   ])),
//             controllers.studentSingleDataModule?.certificateCompetency != null &&
//                     controllers.studentSingleDataModule!.certificateCompetency!
//                         .isNotEmpty
//                 ? Container()
//                 : Column(children: [
//                     for (var elemnt in controllers
//                         .studentSingleDataModule!.careerInformation!)
//                       Container(
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                             titleText(title: "معلومات الوظيفية"),
//                             textWithTitle(
//                                 title: "نوع التوضيف",
//                                 text:
//                                     "${controllers.employmentStatusData(employmentstatusDataid: elemnt.employmentStatusId)?.statusName}"),
//                             if (controllers
//                                     .ministries(ministriesId: elemnt.ministryId)
//                                     ?.name !=
//                                 null)
//                               Column(children: [
//                                 textWithTitle(
//                                     title: "محل العمل",
//                                     text:
//                                         "${controllers.ministries(ministriesId: elemnt.ministryId)?.name}/${elemnt.organizationName ?? ''}"),
//                                 textWithTitle(
//                                     title: "تاريخ المباشرة بعد اخر شهادة",
//                                     text: "${elemnt.dateCommencement}"),
//                                 elemnt.documents == null
//                                     ? Container()
//                                     : Column(children: [
//                                         for (var doc in elemnt.documents!)
//                                           Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               children: [
//                                                 textWithTitle(
//                                                     title: "نوع الكتاب",
//                                                     text:
//                                                         "${controllers.documentstypes(doc.documentsTypeId)?.documentsTypeName}"),
//                                                 textWithTitle(
//                                                     title: "رقم الكتاب",
//                                                     text:
//                                                         "${doc.documentsNumber}"),
//                                                 textWithTitle(
//                                                     title: "تاريخ الكتاب",
//                                                     text:
//                                                         "${doc.documentsDate}"),
//                                               ]),
//                                       ]),
//                                 textWithTitle(
//                                     title: "نوع الاجازة حسب كتاب عدم الممانعة",
//                                     text: "اجازة دراسية"),
//                                 textWithTitle(
//                                     title: "العنوان الوظيفي",
//                                     text:
//                                         "${controllers.scientificTitles(scientifictitlesid: controllers.studentSingleDataModule?.careerInformation?.first.scientificTitleId)?.name}")
//                               ])
//                           ]))
//                     //معلومات شهادات الكفائة
//                     ,
//                   ]), //معلومات الوظيفة
//
//             if (controllers.studentSingleDataModule?.certificateCompetency !=
//                 null)
//               Container(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       titleText(title: "معلومات شهادات الكفائة"),
//                       for (var certificatecompetency in controllers
//                           .studentSingleDataModule!.certificateCompetency!)
//                         textWithTitle(
//                           iscotation: true,
//                           title:
//                               "حاصل على شهادة  ${CertificateCompetencyTypes.values.where((c) => c.id == certificatecompetency.certificateCompetencyTypeId).first.name} من ${controllers.centers(centersId: certificatecompetency.examCenterId)?.name} وبدرجة ${certificatecompetency.appreciation}",
//                         ),
//                     ]),
//               )
// //التعهد والتوقيع
//             ,
//             Container(
//                 margin: const EdgeInsets.only(right: 20),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       titleText(title: "التعهد والتوقيع"),
//                       textWithTitle(
//                         iscotation: true,
//                         title:
//                             "- اتعهد بالاستمرار في الخدمة الوظيفية بع حصولي على الشهادة",
//                       ),
//                       textWithTitle(
//                         iscotation: true,
//                         title:
//                             "- اتعهد بعدم ترقين قيدي او الغاء قبولي او انهاء علاقتي في الدراسات العليا سابقا",
//                       ),
//                       textWithTitle(
//                         iscotation: true,
//                         title:
//                             "- اتعهد بصحة المعلومات اعلاه وبخلاف ذلك اتحمل كافة المسؤولية القانونية",
//                       ),
//                     ])),
//             Row(children: [
//               Container(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: Row(children: [
//                     SizedBox(width: 100),
//                     Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           textWithTitle(
//                             iscotation: true,
//                             title: "الاسم الرباعي والتوقيع ",
//                           ),
//                           textWithTitle(
//                             iscotation: true,
//                             title: " \n ",
//                           ),
//                           if (controllers.studentSingleDataModule
//                                       ?.personalInformation !=
//                                   null &&
//                               controllers.studentSingleDataModule!
//                                   .personalInformation!.isNotEmpty)
//                             textWithTitle(
//                               iscotation: true,
//                               title:
//                                   "${controllers.studentSingleDataModule?.personalInformation?.first.firstName} ${controllers.studentSingleDataModule?.personalInformation?.first.secondName} ${controllers.studentSingleDataModule?.personalInformation?.first.thirdName} ${controllers.studentSingleDataModule?.personalInformation?.first.fourthName}",
//                             ),
//                         ])
//                   ])),
//               SizedBox(width: 120),
//               Container(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: Row(children: [
//                     SizedBox(width: 100),
//                     Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           textWithTitle(
//                             iscotation: true,
//                             title: "مخول الكلية ",
//                           ),
//                           textWithTitle(
//                             iscotation: true,
//                             title: " \n ",
//                           ),
//                           // if (controllers.studentSingleDataModule
//                           //             ?.personalInformation !=
//                           //         null &&
//                           //     controllers.studentSingleDataModule!
//                           //         .personalInformation!.isNotEmpty)
//                             textWithTitle(
//                               iscotation: true,
//                               title: "${collegeAuthorized?.collegeAuthorized?.name}",
//                             ),
//                         ])
//                   ]))
//             ]),
//           ];
//         }));
//
//     return doc.save();
//   }

PageTheme themecostom({required ImageProvider image, required Font myFont}) {
  return PageTheme(
    textDirection: TextDirection.rtl,
    buildBackground: (context) => Opacity(
      opacity: 0.1,
      child: Center(
        child: Image(image),
      ),
    ),
    margin: const EdgeInsets.only(bottom: 10),
    // theme: ThemeData.withFont(
    //   base: myFont,
    // ),
    pageFormat: PdfPageFormat.a4,
  );
}

TextStyle get titleprinting => const TextStyle(
      fontSize: 14,
    );

TextStyle get lableprinting => const TextStyle(fontSize: 11);

Container titleText({required String title}) {
  return Container(
    constraints: const BoxConstraints(maxWidth: 400),
    margin: const EdgeInsets.only(bottom: 10),
    decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
      width: 1.0, // Underline thickness
    ))),
    child: Text(title, style: titleprinting),
  );
}

Container textWithTitle({
  required String title,
  String text = "",
  bool iscotation = false,
}) {
  return Container(
      // margin: const EdgeInsets.only(top: 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
    Text("$title ${iscotation ? "" : ":"} ", style: lableprinting),
    Text(text, style: lableprinting),
    SizedBox(width: 10),
  ]));
}
