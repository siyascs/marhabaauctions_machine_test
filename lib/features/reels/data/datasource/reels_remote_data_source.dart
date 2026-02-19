import '../../../../core/network/api_client.dart';
import '../models/reel_model.dart';

abstract class ReelsRemoteDataSource {
  Future<List<ReelModel>> getReels(int page);
}

class ReelsRemoteDataSourceImpl implements ReelsRemoteDataSource {
  final ApiClient apiClient;

  ReelsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<ReelModel>> getReels(int page) async {
    try {
      await apiClient.get(
        "https://api.ulearna.com/bytes/all?page=$page&limit=10&country=United+States",
      );
    } catch (_) {
    }

    return _dummyData(page);
  }

  List<ReelModel> _dummyData(int page) {
    final videoUrls = [
      "https://samplelib.com/lib/preview/mp4/sample-5s.mp4",
      "https://samplelib.com/lib/preview/mp4/sample-10s.mp4",
      "https://samplelib.com/lib/preview/mp4/sample-15s.mp4",
      "https://samplelib.com/lib/preview/mp4/sample-20s.mp4",
      "https://samplelib.com/lib/preview/mp4/sample-30s.mp4",
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
    ];

    return List.generate(15, (index) {
      return ReelModel.fromJson({
        "id": "$page-$index",
        "title": "Reel ${index + 1}",
        "video_url": videoUrls[index % videoUrls.length],
      });
    });
  }
}
