class PhaseModel {
  String message;
  List<Datum> data;

  PhaseModel({
    required this.message,
    required this.data,
  });

  factory PhaseModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonData = json['data'];
    List<Datum> phaseDataList =
        jsonData.map((data) => Datum.fromJson(data)).toList();

    return PhaseModel(
      message: json['message'],
      data: phaseDataList,
    );
  }
}

class Datum {
  int pkCardId;
  String cardName;
  String cardDescription;
  String estimateStartTime;
  String estimateEndTime;
  List<dynamic> media;
  List<dynamic> activity;
  List<dynamic> childCard;

  Datum({
    required this.pkCardId,
    required this.cardName,
    required this.cardDescription,
    required this.estimateStartTime,
    required this.estimateEndTime,
    required this.media,
    required this.activity,
    required this.childCard,
  });
  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      pkCardId: json['PK_CARD_ID'],
      cardName: json['CARD_NAME'],
      childCard: [],
      cardDescription: '',
      estimateStartTime: json['PROJECT_START'],
      estimateEndTime: json['PROJECT_END'],
      media: [],
      activity: [],
    );
  }
}
