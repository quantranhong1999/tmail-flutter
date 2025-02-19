import 'package:core/core.dart';
import 'package:get/get.dart';
import 'package:tmail_ui_user/features/base/base_bindings.dart';
import 'package:tmail_ui_user/features/caching/state_cache_client.dart';
import 'package:tmail_ui_user/features/destination_picker/presentation/destination_picker_controller.dart';
import 'package:tmail_ui_user/features/mailbox/data/datasource/mailbox_datasource.dart';
import 'package:tmail_ui_user/features/mailbox/data/datasource/state_datasource.dart';
import 'package:tmail_ui_user/features/mailbox/data/datasource_impl/mailbox_cache_datasource_impl.dart';
import 'package:tmail_ui_user/features/mailbox/data/datasource_impl/mailbox_datasource_impl.dart';
import 'package:tmail_ui_user/features/mailbox/data/datasource_impl/state_datasource_impl.dart';
import 'package:tmail_ui_user/features/mailbox/data/network/mailbox_api.dart';
import 'package:tmail_ui_user/features/mailbox/data/local/mailbox_cache_manager.dart';
import 'package:tmail_ui_user/features/mailbox/data/repository/mailbox_repository_impl.dart';
import 'package:tmail_ui_user/features/mailbox/domain/repository/mailbox_repository.dart';
import 'package:tmail_ui_user/features/mailbox/domain/usecases/get_all_mailbox_interactor.dart';
import 'package:tmail_ui_user/features/mailbox/presentation/model/mailbox_tree_builder.dart';

class DestinationPickerBindings extends BaseBindings {

  @override
  void dependencies() {
    _bindingsUtils();
    super.dependencies();
  }

  void _bindingsUtils() {
    Get.lazyPut(() => TreeBuilder());
  }

  @override
  void bindingsController() {
    Get.lazyPut(() => DestinationPickerController(
        Get.find<GetAllMailboxInteractor>(),
        Get.find<TreeBuilder>(),
    ));
  }

  @override
  void bindingsDataSource() {
    Get.lazyPut<MailboxDataSource>(() => Get.find<MailboxDataSourceImpl>());
    Get.lazyPut<StateDataSource>(() => Get.find<StateDataSourceImpl>());
  }

  @override
  void bindingsDataSourceImpl() {
    Get.lazyPut(() => MailboxDataSourceImpl(Get.find<MailboxAPI>()));
    Get.lazyPut(() => MailboxCacheDataSourceImpl(Get.find<MailboxCacheManager>()));
    Get.lazyPut(() => StateDataSourceImpl(Get.find<StateCacheClient>()));
  }

  @override
  void bindingsInteractor() {
    Get.lazyPut(() => GetAllMailboxInteractor(Get.find<MailboxRepository>()));
  }

  @override
  void bindingsRepository() {
    Get.lazyPut<MailboxRepository>(() => Get.find<MailboxRepositoryImpl>());
  }

  @override
  void bindingsRepositoryImpl() {
    Get.lazyPut(() => MailboxRepositoryImpl(
        {
          DataSourceType.network: Get.find<MailboxDataSource>(),
          DataSourceType.local: Get.find<MailboxCacheDataSourceImpl>()
        },
        Get.find<StateDataSource>()
    ));
  }
}