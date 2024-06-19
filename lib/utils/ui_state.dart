

import 'package:equatable/equatable.dart';

abstract class UiState<T> extends Equatable {
  const UiState._();

  const factory UiState.success(T data) = UiStateSuccess<T>;

  const factory UiState.error(String error) = UiStateError<T>;

  const factory UiState.loading() = UiStateLoading<T>;

  const factory UiState.initial() = UiStateInitial<T>;

  get isLoading => this is UiStateLoading;

  bool get isSuccess => this is UiStateSuccess;

  bool get isError => this is UiStateError;

  String get message => (this as UiStateError<T>).message;

  T get data => (this as UiStateSuccess<T>).data;

  W when<W>(
      {required W Function(T data) onSuccess,
      required W Function(String message) onError,
      required W Function() onLoading}) {
    if (this is UiStateSuccess) {
      return onSuccess((this as UiStateSuccess<T>).data);
    } else if (this is UiStateError) {
      return onError(this.message);
    } else {
      return onLoading();
    }
  }
}

class UiStateError<T> extends UiState<T> {
  const UiStateError(this.message) : super._();

  @override
  final String message;

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class UiStateSuccess<T> extends UiState<T> {
  const UiStateSuccess(this.data) : super._();

  @override
  final T data;

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class UiStateLoading<T> extends UiState<T> {
  const UiStateLoading() : super._();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UiStateInitial<T> extends UiState<T> {
  const UiStateInitial() : super._();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

T? castOrNull<T>(dynamic x) => x is T ? x : null;

T castOrFallback<T>(dynamic x, T fallback) => x is T ? x : fallback;
