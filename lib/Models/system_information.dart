class SystemInformation {
  String? student;
  int? serial;
  Systemconfig? systemconfig;

  SystemInformation({this.student, this.serial, this.systemconfig});

  SystemInformation.fromJson(Map<String, dynamic> json) {
    student = json['student'];
    serial = json['serial'];
    systemconfig = json['systemconfig'] != null
        ? Systemconfig.fromJson(json['systemconfig'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student'] = student;
    data['serial'] = serial;
    if (systemconfig != null) {
      data['systemconfig'] = systemconfig!.toJson();
    }
    return data;
  }
}

class Systemconfig {
  List<FormMessage>? formMessage;
  String? openSystem;
  String? openEdit;

  Systemconfig({this.formMessage, this.openSystem, this.openEdit});

  Systemconfig.fromJson(Map<String, dynamic> json) {
    if (json['Formmessage'] != null) {
      formMessage = <FormMessage>[];
      json['Formmessage'].forEach((v) {
        formMessage!.add(FormMessage.fromJson(v));
      });
    }
    openSystem = json['opensystem'];
    openEdit = json['OpenEdit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (formMessage != null) {
      data['Formmessage'] = formMessage!.map((v) => v.toJson()).toList();
    }
    data['opensystem'] = openSystem;
    data['OpenEdit'] = openEdit;
    return data;
  }
}

class FormMessage {
  int? id;
  int? serial;
  String? audit;
  String? message;
  String? auditAt;
  String? approveAt;
  String? modifiedAt;

  FormMessage(
      {this.id,
        this.serial,
        this.audit,
        this.message,
        this.auditAt,
        this.approveAt,
        this.modifiedAt});

  FormMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serial = json['Serial'];
    audit = json['Audit'];
    message = json['Message'];
    auditAt = json['AuditAt'];
    approveAt = json['ApproveAt'];
    modifiedAt = json['ModifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Serial'] = serial;
    data['Audit'] = audit;
    data['Message'] = message;
    data['AuditAt'] = auditAt;
    data['ApproveAt'] = approveAt;
    data['ModifiedAt'] = modifiedAt;
    return data;
  }
}
