import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/core/services/purchase_service.dart';

final purchaseServiceProvider = Provider<IPurchaseService>((ref) {
  return MockPurchaseService(); // Replace with your actual implementation of IPurchaseService
});
