class NotificationModel {
  int? id;
  String? title;
  String? body;
  String? type;
  int? isread;

  NotificationModel({  this.isread, this.id, this.title, this.body, this.type});
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['content'],
      type: json['type'],
      isread: json['is_read'],
    );
  }

  

}
