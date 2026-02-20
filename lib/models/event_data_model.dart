class EventDataModel {
  static const String collectionName = "EventCollection" ;
  String? eventId;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  String eventCategoryId;
  String categoryImg;
  bool isFavorite;

  EventDataModel({
    this.eventId,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.eventCategoryId,
    required this.categoryImg,
    this.isFavorite = false,
  });

  factory EventDataModel.fromFireStore(Map<String, dynamic> json) {
    return EventDataModel(
      eventId: json["eventId"],
      eventTitle: json["eventTitle"],
      eventDescription: json["eventDescription"],
      eventDate: DateTime.fromMillisecondsSinceEpoch(json["eventDate"]),
      eventCategoryId: json["eventCategoryId"],
      categoryImg: json["categoryImg"],
      isFavorite: json["isFavorite"] ?? false,
    );
  }

  Map<String ,dynamic> toFireStore(){
    return{
      "eventId" : eventId ,
      "eventTitle" : eventTitle ,
      "eventDescription" : eventDescription ,
      "eventDate" : eventDate.millisecondsSinceEpoch ,
      "eventCategoryId" : eventCategoryId ,
      "categoryImg" : categoryImg ,
      "isFavorite" : isFavorite
    };
  }

}

