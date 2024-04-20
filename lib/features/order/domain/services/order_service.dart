import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart_delivery/api/api_client.dart';
import 'package:sixam_mart_delivery/common/models/response_model.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/ignore_model.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/order_cancellation_body.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/order_details_model.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/order_model.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/update_status_body_model.dart';
import 'package:sixam_mart_delivery/features/order/domain/repositories/order_repository_interface.dart';
import 'package:sixam_mart_delivery/features/order/domain/services/order_service_interface.dart';

class OrderService implements OrderServiceInterface {
  final OrderRepositoryInterface orderRepositoryInterface;
  OrderService({required this.orderRepositoryInterface});

  @override
  Future<List<CancellationData>?> getCancelReasons() async {
    return await orderRepositoryInterface.getCancelReasons();
  }

  @override
  Future<Response> getOrderWithId(int? orderId) async {
    return await orderRepositoryInterface.get(orderId);
  }

  @override
  Future<PaginatedOrderModel?> getCompletedOrderList(int offset) async {
    return await orderRepositoryInterface.getCompletedOrderList(offset);
  }

  @override
  Future<List<OrderModel>?> getCurrentOrders() async {
    return await orderRepositoryInterface.getList();
  }

  @override
  Future<List<OrderModel>?> getLatestOrders() async {
    return await orderRepositoryInterface.getLatestOrders();
  }

  @override
  Future<ResponseModel> updateOrderStatus(UpdateStatusBodyModel updateStatusBody, List<MultipartBody> proofAttachment) async {
    return await orderRepositoryInterface.updateOrderStatus(updateStatusBody, proofAttachment);
  }

  @override
  Future<List<OrderDetailsModel>?> getOrderDetails(int? orderID) async {
    return await orderRepositoryInterface.getOrderDetails(orderID);
  }

  @override
  Future<ResponseModel> acceptOrder(int? orderID) async {
    return await orderRepositoryInterface.acceptOrder(orderID);
  }

  @override
  List<IgnoreModel> getIgnoreList() {
    return orderRepositoryInterface.getIgnoreList();
  }

  @override
  void setIgnoreList(List<IgnoreModel> ignoreList) {
    orderRepositoryInterface.setIgnoreList(ignoreList);
  }

  @override
  List<OrderModel> processLatestOrders(List<OrderModel> latestOrderList, List<int?> ignoredIdList) {
    List<OrderModel> latestOrderList0 = [];
    for (var order in latestOrderList) {
      if(!ignoredIdList.contains(order.id)) {
        latestOrderList0.add(order);
      }
    }
    return latestOrderList0;
  }

  @override
  List<int?> prepareIgnoreIdList(List<IgnoreModel> ignoredRequests) {
    List<int?> ignoredIdList = [];
    for (var ignore in ignoredRequests) {
      ignoredIdList.add(ignore.id);
    }
    return ignoredIdList;
  }

  @override
  List<IgnoreModel> tempList(DateTime currentTime, List<IgnoreModel> ignoredRequests) {
    List<IgnoreModel> tempList = [];
    tempList.addAll(ignoredRequests);
    for(int index = 0; index < tempList.length; index++) {
      if(currentTime.difference(tempList[index].time!).inMinutes > 10) {
        tempList.removeAt(index);
      }
    }
    return tempList;
  }

  @override
  List<MultipartBody> prepareOrderProofImages(List<XFile> pickedPrescriptions) {
    List<MultipartBody> multiParts = [];
    for(XFile file in pickedPrescriptions) {
      multiParts.add(MultipartBody('order_proof[]', file));
    }
    return multiParts;
  }

}