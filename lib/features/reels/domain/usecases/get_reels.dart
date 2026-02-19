import '../entities/reel_entity.dart';
import '../repositories/reel_repository.dart';

class GetReels {
  final ReelsRepository repository;

  GetReels(this.repository);

  Future<List<ReelEntity>> call(int page) {
    return repository.getReels(page);
  }
}
