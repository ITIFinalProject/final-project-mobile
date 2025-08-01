import '../models/memory_model.dart';

abstract class MemoryState {}

class MemoryInitial extends MemoryState {}

class MemoryLoading extends MemoryState {}

class MemoryUploaded extends MemoryState {}

class MemoryError extends MemoryState {
  final String message;
  MemoryError(this.message);
}

class MemoriesLoaded extends MemoryState {
  final List<MemoryModel> memories;
  MemoriesLoaded(this.memories);
}
