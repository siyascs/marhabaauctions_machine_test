import '../../domain/entities/reel_entity.dart';
import '../../domain/repositories/reel_repository.dart';
import '../datasource/reels_remote_data_source.dart';

class ReelsRepositoryImpl implements ReelsRepository {
  final ReelsRemoteDataSource remoteDataSource;

  ReelsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ReelEntity>> getReels(int page) {
    return remoteDataSource.getReels(page);
  }
}
