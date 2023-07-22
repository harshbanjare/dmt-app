class ChatBean {
  ChatBean({
    this.status,
    this.messages,
  });

  ChatBean.fromJson(dynamic json) {
    status = json['status'];
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
      });
    }
  }
  bool? status;
  List<Messages>? messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (messages != null) {
      map['messages'] = messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Messages {
  Messages({
    this.id,
    this.conversationId,
    this.senderId,
    this.receiverId,
    this.body,
    this.read,
    this.doc,
    this.createdAt,
    this.updatedAt,
  });

  Messages.fromJson(dynamic json) {
    id = json['id'];
    conversationId = json['conversation_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    body = json['body'];
    read = json['read'];
    doc = json['doc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? conversationId;
  String? senderId;
  String? receiverId;
  String? body;
  int? read;
  String? doc;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['conversation_id'] = conversationId;
    map['sender_id'] = senderId;
    map['receiver_id'] = receiverId;
    map['body'] = body;
    map['read'] = read;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
