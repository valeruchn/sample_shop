import 'package:sample_shop/common/helpers/constants/text_constants.dart';

String convertOrderStatus(String status) {
  switch (status) {
    case 'incoming':
      return kNewOrderStatusText;
    case 'accepted':
      return kAcceptedOrderStatusText;
    case 'completed':
      return kCompletedOrderStatusText;
    default:
      return '';
  }
}
