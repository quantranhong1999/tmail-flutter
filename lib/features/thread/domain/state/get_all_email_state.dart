import 'package:core/core.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:model/model.dart';

class GetAllEmailSuccess extends UIState {
  final List<PresentationEmail> emailList;
  final State? currentEmailState;

  GetAllEmailSuccess({required this.emailList, this.currentEmailState});

  @override
  List<Object?> get props => [emailList, currentEmailState];
}

class GetAllEmailFailure extends FeatureFailure {
  final exception;

  GetAllEmailFailure(this.exception);

  @override
  List<Object> get props => [exception];
}