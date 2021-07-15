import 'package:flutter_text_recognititon/main.dart';
import 'package:flutter_text_recognititon/model/subscriptionModel.dart';
import 'package:flutter_text_recognititon/services/baseService.dart';
import 'package:flutter_text_recognititon/utils/constants.dart';

import 'package:nb_utils/nb_utils.dart';

class SubscriptionService extends BaseService {
  SubscriptionService() {
    ref = db.collection('subscription');
  }

  Future<List<SubscriptionModel>> getSubscription() {
    return ref.where('userId', isEqualTo: getStringAsync(USER_ID)).get().then((value) {
      return value.docs.map((e) => SubscriptionModel.fromJson(e.data() as Map<String, dynamic>)).toList();
    });
  }

  Stream<List<SubscriptionModel>> subscription() {
    return ref.where('userId', isEqualTo: getStringAsync(USER_ID)).snapshots().map((event) => event.docs.map((e) => SubscriptionModel.fromJson(e.data() as Map<String, dynamic>)).toList());
  }
}
