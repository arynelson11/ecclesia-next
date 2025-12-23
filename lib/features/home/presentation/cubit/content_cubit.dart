import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/data/mock_database.dart';

// STATES
abstract class ContentState extends Equatable {
  const ContentState();
  @override
  List<Object> get props => [];
}

class ContentLoading extends ContentState {}

class ContentLoaded extends ContentState {
  final List<Map<String, String>> devotionals;
  final List<Map<String, dynamic>> events;

  const ContentLoaded({required this.devotionals, this.events = const []});

  @override
  List<Object> get props => [devotionals, events];
}

// CUBIT
class ContentCubit extends Cubit<ContentState> {
  final MockDatabase _db = MockDatabase();

  ContentCubit() : super(ContentLoading()) {
    _loadInitialContent();
  }

  Future<void> _loadInitialContent() async {
    // Simulate Network Delay for Skeleton
    await Future.delayed(const Duration(seconds: 2));
    _refresh();
  }

  void addDevotional(Map<String, String> newDevotional) {
    _db.addDevotional(newDevotional);
    _refresh();
  }

  void _refresh() {
    emit(ContentLoaded(
      devotionals: _db.getDevotionals(),
      events: _db.getEvents(),
    ));
  }
}
