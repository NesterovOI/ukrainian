abstract class IPurchaseService {
  Future<bool> buySubscription();
  Future<bool> checkSubscriptionStatus();
  Future<void> restorePurchases();
}

class MockPurchaseService implements IPurchaseService {
  @override
  Future<bool> buySubscription() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<bool> checkSubscriptionStatus() async => false;

  @override
  Future<void> restorePurchases() async {}
}
