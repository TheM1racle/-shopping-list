import '../../domain/entities/shopping_item.dart';
import '../../domain/repositories/shopping_repository.dart';
import 'notification_service.dart';

class ShoppingSessionService {
  ShoppingSessionService({
    required NotificationService notificationService,
    required ShoppingRepository shoppingRepository,
  })  : _notificationService = notificationService,
        _shoppingRepository = shoppingRepository;

  final NotificationService _notificationService;
  final ShoppingRepository _shoppingRepository;

  static const _notificationId = 1001;

  bool _isActive = false;
  List<ShoppingItem> _queue = [];

  bool get isActive => _isActive;

  Future<void> start({
    required String notificationTitle,
    required String boughtLabel,
    required void Function() onItemsChanged,
  }) async {
    final items = await _shoppingRepository.getItems();
    _queue = items.where((item) => !item.isPurchased).toList();

    if (_queue.isEmpty) {
      return;
    }

    _isActive = true;
    await _showCurrent(
      notificationTitle: notificationTitle,
      boughtLabel: boughtLabel,
    );
  }

  Future<void> handleNotificationTap({
    required String? itemId,
    required String notificationTitle,
    required String boughtLabel,
    required void Function() onItemsChanged,
  }) async {
    if (!_isActive || itemId == null) {
      return;
    }

    final index = _queue.indexWhere((item) => item.id == itemId);
    if (index == -1) {
      return;
    }

    final item = _queue[index];
    await _shoppingRepository.updateItem(item.copyWith(isPurchased: true));
    _queue.removeAt(index);
    onItemsChanged();

    if (_queue.isEmpty) {
      await stop();
      return;
    }

    await _showCurrent(
      notificationTitle: notificationTitle,
      boughtLabel: boughtLabel,
    );
  }

  Future<void> stop() async {
    _isActive = false;
    _queue = [];
    await _notificationService.cancelAll();
  }

  Future<void> _showCurrent({
    required String notificationTitle,
    required String boughtLabel,
  }) async {
    if (_queue.isEmpty) {
      return;
    }

    final current = _queue.first;
    await _notificationService.showShoppingItem(
      notificationId: _notificationId,
      title: notificationTitle,
      body: '${current.name} × ${current.quantity}\n$boughtLabel',
      itemId: current.id,
    );
  }
}
