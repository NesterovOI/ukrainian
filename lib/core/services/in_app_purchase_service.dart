import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:ukrainian/core/services/purchase_service.dart';

class InAppPurchaseService implements IPurchaseService {
  final InAppPurchase _iap = InAppPurchase.instance;
  static const String _subscriptionId =
      'your_subscription_id'; // Replace with your actual subscription ID

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  InAppPurchaseService() {
    _initialize();
  }

  void _initialize() {
    final purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: () => _subscription?.cancel(),
      onError: (error) {
        // Handle error
      },
    );
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        if (purchaseDetails.pendingCompletePurchase) {
          _iap.completePurchase(purchaseDetails);
        }
      }
    }
  }

  @override
  Future<bool> buySubscription() async {
    final isAvailable = await _iap.isAvailable();
    if (isAvailable) return false;

    final ProductDetailsResponse response = await _iap.queryProductDetails({
      _subscriptionId,
    });

    if (response.notFoundIDs.isNotEmpty || response.productDetails.isEmpty) {
      // Handle product not found
      return false;
    }

    final ProductDetails productDetails = response.productDetails.first;
    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: productDetails,
    );

    return await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  Future<bool> checkSubscriptionStatus() async {
    final isAvailable = await _iap.isAvailable();
    if (!isAvailable) return false;

    await _iap.restorePurchases();
    return false; //
  }

  @override
  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  void dispose() {
    _subscription?.cancel();
  }
}
