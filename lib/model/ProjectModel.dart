class ProjectModel {
  final int pkProjectId;
  final String projectName;
  final String projectStart;
  final String projectEnd;
  final int fkTypeId;
  final String description;
  final int createdBy;
  final String status;
  final String createdAt;
  final String updatedAt;

  ProjectModel({
    required this.pkProjectId,
    required this.projectName,
    required this.projectStart,
    required this.projectEnd,
    required this.fkTypeId,
    required this.description,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      pkProjectId: json['PK_PROJECT_ID'],
      projectName: json['PROJECT_NAME'],
      projectStart: json['PROJECT_START'],
      projectEnd: json['PROJECT_END'],
      fkTypeId: json['FK_TYPE_ID'],
      description: json['DESCRIPTION'],
      createdBy: json['CREATED_BY'],
      status: json['STATUS'],
      createdAt: json['CREATED_AT'],
      updatedAt: json['UPDATED_AT'],
    );
  }
}