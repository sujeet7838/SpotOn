class ProjectDetails {
  final int projectId;
  final String projectName;
  final String projectStart;
  final String projectEnd;
  final String description;
  final String status;
  final List<MediaUrl> images;
  final List<Activity> activities;
  final List<Card> cards;

  ProjectDetails({
    required this.projectId,
    required this.projectName,
    required this.projectStart,
    required this.projectEnd,
    required this.description,
    required this.status,
    required this.images,
    required this.activities,
    required this.cards,
  });

  factory ProjectDetails.fromJson(Map<String, dynamic> json) {
    return ProjectDetails(
      projectId: json['PK_PROJECT_ID'],
      projectName: json['PROJECT_NAME'],
      projectStart: json['PROJECT_START'],
      projectEnd: json['PROJECT_END'],
      description: json['DESCRIPTION'],
      status: json['STATUS'],
      images: (json['get_images'] as List<dynamic>?)
              ?.map((imageJson) => MediaUrl.fromJson(imageJson))
              .toList() ??
          [],
      activities: (json['get_activities'] as List<dynamic>?)
              ?.map((activityJson) => Activity.fromJson(activityJson))
              .toList() ??
          [],
      cards: (json['get_cards'] as List<dynamic>?)
              ?.map((cardJson) => Card.fromJson(cardJson))
              .toList() ??
          [],
    );
  }
}

class MediaUrl {
  final String mediaUrl;

  MediaUrl({required this.mediaUrl});

  factory MediaUrl.fromJson(Map<String, dynamic> json) {
    return MediaUrl(
      mediaUrl: json['media_url'] ?? '',
    );
  }
}

class Activity {
  final int userId;
  final String username;
  final String profileImage;
  final List<MediaUrl> images;
  final String comment;

  Activity({
    required this.userId,
    required this.username,
    required this.profileImage,
    required this.images,
    required this.comment,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      userId: json['userid'] ?? 0,
      username: json['username'] ?? '',
      profileImage: json['profileImage'] ?? '',
      images: (json['images'] as List<dynamic>)
          .map((imageJson) => MediaUrl.fromJson(imageJson))
          .toList(),
      comment: json['comment'] == "" ? '' : json['comment'] ?? '',
    );
  }
}

class Card {
  final int cardId;
  final String cardName;
  final String cardDescription;
  final List<MediaUrl> media;
  final List<Activity> activities;
  final List<Card> childCards;

  Card({
    required this.cardId,
    required this.cardName,
    required this.cardDescription,
    required this.media,
    required this.activities,
    required this.childCards,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      cardId: json['PK_CARD_ID'] ?? 0,
      cardName: json['CARD_NAME'] ?? '',
      cardDescription: json['CARD_DESCRIPTION'] ?? '',
      media: (json['MEDIA'] as List<dynamic>?)
              ?.map((mediaJson) => MediaUrl.fromJson(mediaJson))
              .toList() ??
          [],
      activities: (json['ACTIVITY'] as List<dynamic>?)
              ?.map((activityJson) => Activity.fromJson(activityJson))
              .toList() ??
          [],
      childCards: (json['CHILD_CARD'] as List<dynamic>?)
              ?.map((cardJson) => Card.fromJson(cardJson))
              .toList() ??
          [],
    );
  }
}
