import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WalletProvider extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createWallet(String uid) async {
    try {
      await _firestore.collection('wallet').doc(getWalletId(uid)).set({
        'balance': 0.0,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return getWalletId(uid);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateWallet(String uid, double amount,
      {required String refId, required String refType}) async {
    try {
      await _firestore.collection('wallet').doc(getWalletId(uid)).update({
        'balance': FieldValue.increment(amount),
      });
      await _firestore.collection('transactions').add({
        'amount': amount,
        'refId': refId,
        'refType': refType,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deductWallet(String uid, double amount,
      {required String refId, required String refType}) async {
    try {
      await _firestore.collection('wallet').doc(getWalletId(uid)).update({
        'balance': FieldValue.increment(-amount),
      });
      await _firestore.collection('transactions').add({
        'amount': -amount,
        'refId': refId,
        'refType': refType,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<double> getWalletBalance(
    String uid,
  ) async {
    try {
      final wallet =
          await _firestore.collection('wallet').doc(getWalletId(uid)).get();
      log('Wallet balance: ${wallet.data()!['balance']}',
          name: 'WalletProvider');
      return double.parse((wallet.data()!['balance']).toString());
    } catch (e) {
      log('Error: $e', name: 'WalletProvider');
      return 0;
    }
  }

  Stream<double> walletStream(
    String uid,
  ) {
    return _firestore
        .collection('wallet')
        .doc(getWalletId(uid))
        .snapshots()
        .map((event) {
      log('Wallet balance: ${event.data()}', name: 'WalletProvider');
      return double.parse((event.data()!['balance']).toString());
    });
  }

  String getWalletId(String uid) {
    log('Wallet id: $uid', name: 'WalletProvider');
    return 'wallet_$uid';
  }
}
