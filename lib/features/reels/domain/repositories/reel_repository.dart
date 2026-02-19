import '../entities/reel_entity.dart';

abstract class ReelsRepository {
  Future<List<ReelEntity>> getReels(int page);
}
