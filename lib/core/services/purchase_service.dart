abstract class IPurchaseService {
  Future<bool> buySubscription();
  Future<bool> checkSubscriptionStatus();
  Future<void> restorePurchases();
}

class MockPurchaseService implements IPurchaseService {
  bool _isPurchased = false;

  @override
  Future<bool> buySubscription() async {
    _isPurchased = true;
    return true;
  }

  @override
  Future<bool> checkSubscriptionStatus() async => _isPurchased;

  @override
  Future<void> restorePurchases() async => _isPurchased = true;
}
