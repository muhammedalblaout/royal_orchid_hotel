class StaffStatus{
  final int total_requests;
  final int answered_requests;
  final int accepted_requests;
  final int rejected_requests;
  List<MonthlyStatus>? monthlyStatus;

   StaffStatus({
    required this.total_requests,
    required this.answered_requests,
    required this.accepted_requests,
    required this.rejected_requests,
     this.monthlyStatus
  });


  }

class MonthlyStatus{
  final String month;
  final int count;

  const MonthlyStatus({
    required this.month,
    required this.count,
  });


}