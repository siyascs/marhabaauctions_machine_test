import '../../domain/entities/reel_entity.dart';

class ReelModel extends ReelEntity {
  ReelModel({
    required super.id,
    required super.title,
    required super.videoUrl,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      videoUrl: json['video_url'] ??
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    );
  }
}
