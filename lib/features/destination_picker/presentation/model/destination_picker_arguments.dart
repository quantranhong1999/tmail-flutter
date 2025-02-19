
import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:tmail_ui_user/features/mailbox/presentation/model/mailbox_actions.dart';

class DestinationPickerArguments with EquatableMixin {
  final AccountId accountId;
  final MailboxActions mailboxAction;

  DestinationPickerArguments(this.accountId, this.mailboxAction);

  @override
  List<Object?> get props => [accountId, mailboxAction];
}