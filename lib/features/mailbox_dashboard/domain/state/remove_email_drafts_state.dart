import 'package:core/core.dart';

class RemoveEmailDraftsSuccess extends UIState {

  RemoveEmailDraftsSuccess();

  @override
  List<Object?> get props => [];
}

class RemoveEmailDraftsFailure extends FeatureFailure {
  final exception;

  RemoveEmailDraftsFailure(this.exception);

  @override
  List<Object> get props => [exception];
}