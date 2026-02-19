import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/reel_entity.dart';
import '../../domain/usecases/get_reels.dart';
import 'reels_event.dart';
import 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  final GetReels getReels;

  int page = 1;
  bool isFetching = false;
  List<ReelEntity> reels = [];

  ReelsBloc(this.getReels) : super(ReelsInitial()) {
    on<FetchReels>(_onFetch);
    on<FetchMoreReels>(_onFetchMore);
    on<RefreshReels>(_onRefresh);
  }

  Future<void> _onFetch(FetchReels event, Emitter emit) async {
    emit(ReelsLoading());

    page = 1;
    reels.clear();

    final result = await getReels(page);
    reels = result;

    emit(ReelsLoaded(List.from(reels)));
  }

  Future<void> _onFetchMore(FetchMoreReels event, Emitter emit) async {
    if (isFetching) return;

    isFetching = true;
    page++;

    final more = await getReels(page);
    reels.addAll(more);

    emit(ReelsLoaded(List.from(reels)));

    isFetching = false;
  }

  Future<void> _onRefresh(RefreshReels event, Emitter emit) async {
    page = 1;
    reels.clear();

    emit(ReelsLoading());

    final fresh = await getReels(page);
    reels = fresh;

    emit(ReelsLoaded(List.from(reels)));
  }
}
