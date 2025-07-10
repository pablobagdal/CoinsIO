
import 'dart:async';

import 'package:coinio_app/domain/repositories/account_repository.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';
import 'package:coinio_app/domain/repositories/transaction_repository.dart';

class SyncService {
  final TransactionRepository _transactionRepository;
  final CategoryRepository _categoryRepository;
  final AccountRepository _accountRepository;
  
  final NetworkInfo _networkInfo;
  
  Timer? _syncTimer;
  bool _isSyncing = false;

  SyncServiceImpl({
    required ItemRepository itemRepository,
    required UserRepository userRepository,
    required NetworkInfo networkInfo,
  })  : _itemRepository = itemRepository,
        _userRepository = userRepository,
        _networkInfo = networkInfo;

  @override
  void startPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (_) async {
      await _performSync();
    });
  }

  @override
  Future<void> syncNow() async {
    await _performSync();
  }

  @override
  void stopSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  @override
  bool get isSyncing => _isSyncing;

  Future<void> _performSync() async {
    if (_isSyncing || !await _networkInfo.isConnected) return;

    _isSyncing = true;
    try {
      await _syncItems();
      await _syncUserData();
    } catch (e) {
      // Обработка ошибок синхронизации
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _syncItems() async {
    final unsyncedItems = await _itemRepository.getUnsyncedItems();
    for (final item in unsyncedItems) {
      await _itemRepository.syncItem(item);
    }
  }

  Future<void> _syncUserData() async {
    // Аналогичная логика для пользовательских данных
  }
}