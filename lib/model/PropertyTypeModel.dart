class PropertyTypeModel {
  final int pkTypeId;
  final String propertyTypeEntity;
  final String status;
  final String createdAt;
  final String? updatedAt;

  PropertyTypeModel({
    required this.pkTypeId,
    required this.propertyTypeEntity,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory PropertyTypeModel.fromJson(Map<String, dynamic> json) {
    return PropertyTypeModel(
      pkTypeId: json['PK_TYPE_ID'],
      propertyTypeEntity: json['PROPERTY_TYPE_ENTITY'],
      status: json['STATUS'],
      createdAt: json['CREATED_AT'],
      updatedAt: json['UPDATED_AT'],
    );
  }
}
