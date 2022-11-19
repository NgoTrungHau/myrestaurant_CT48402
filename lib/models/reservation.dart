import 'table_item.dart';

class ReservationItem {
  final String? id;
  final double amount;
  final List<TableItem> products;
  final String tableTitle;
  final DateTime dateTime;

  int get productCount {
    return products.length;
  }

  ReservationItem({
    this.id,
    required this.amount,
    required this.products,
    required this.tableTitle,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  ReservationItem copyWith({
    String? id,
    double? amount,
    List<TableItem>? products,
    String? tableTitle,
    DateTime? dateTime,
  }) {
    return ReservationItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      tableTitle: tableTitle ?? this.tableTitle,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'products': products,
  //     'table': tableTitle,
  //     'amount': amount,
  //   };
  // }

  // static ReservationItem fromJson(Map<String, dynamic> json) {
  //   return ReservationItem(
  //     id: json['id'],
  //     amount: json['amount'],
  //     products: json['products'],
  //     tableTitle: json['table'],
  //     dateTime: json['dateTime'],
  //   );
  // }
}
