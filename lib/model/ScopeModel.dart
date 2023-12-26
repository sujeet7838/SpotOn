class ScopeModel {
  final String message;
  final List<ScopeData> data;

  ScopeModel({
    required this.message,
    required this.data,
  });

  factory ScopeModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonData = json['data'];
    List<ScopeData> scopeDataList =
    jsonData.map((data) => ScopeData.fromJson(data)).toList();

    return ScopeModel(
      message: json['message'],
      data: scopeDataList,
    );
  }
}

class ScopeData {
  final int scopeId;
  final String scopeEntity;
  final String status;
  final String createdAt;
  final String? updatedAt; // It can be null

  ScopeData({
    required this.scopeId,
    required this.scopeEntity,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory ScopeData.fromJson(Map<String, dynamic> json) {
    return ScopeData(
      scopeId: json['PK_SCOPE_ID'],
      scopeEntity: json['SCOPE_ENTITY'],
      status: json['STATUS'],
      createdAt: json['CREATED_AT'],
      updatedAt: json['UPDATED_AT'],
    );
  }
}
