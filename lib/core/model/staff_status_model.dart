import 'package:royal_orchid_hotel/core/entites/staff_status.dart';

class StaffStatusModel extends StaffStatus {
  StaffStatusModel({required super.total_requests,
    required super.answered_requests,
    required super.accepted_requests,
    required super.rejected_requests,
    super.monthlyStatus});

  factory StaffStatusModel.fromJson(Map<String, dynamic> map) {
    return StaffStatusModel(
      total_requests: map['total_requests'] as int,
      answered_requests: map['answered_requests'] as int,
      accepted_requests: map['accepted_requests'] as int,
      rejected_requests: map['rejected_requests'] as int,
    );
  }

  StaffStatusModel copyWith({
    int? total_requests,
    int? answered_requests,
    int? accepted_requests,
    int? rejected_requests,
    List<MonthlyStatusModel>? monthlyStatus,
  }) {
    return StaffStatusModel(
      total_requests: total_requests ?? this.total_requests,
      answered_requests: answered_requests ?? this.answered_requests,
      accepted_requests: accepted_requests ?? this.accepted_requests,
      rejected_requests: rejected_requests ?? this.rejected_requests,
      monthlyStatus: monthlyStatus ?? this.monthlyStatus,
    );
  }
}

class MonthlyStatusModel extends MonthlyStatus {
  MonthlyStatusModel({required super.month, required super.count});


  factory MonthlyStatusModel.fromJson(Map<String, dynamic> map) {
    return MonthlyStatusModel(
      month: map['month'] as String,
      count: map['count'] as int,
    );
  }
}
