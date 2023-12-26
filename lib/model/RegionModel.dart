class RegionResponse {
  final String message;
  final List<RegionData> data;

  RegionResponse({
    required this.message,
    required this.data,
  });

  factory RegionResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonData = json['data'];
    List<RegionData> regionDataList =
    jsonData.map((data) => RegionData.fromJson(data)).toList();

    return RegionResponse(
      message: json['message'],
      data: regionDataList,
    );
  }
}

class RegionData {
  final int regionId;
  final String regionName;

  RegionData({
    required this.regionId,
    required this.regionName,
  });

  factory RegionData.fromJson(Map<String, dynamic> json) {
    return RegionData(
      regionId: json['PK_REGION_ID'],
      regionName: json['REGION_NAME'],
    );
  }
}
