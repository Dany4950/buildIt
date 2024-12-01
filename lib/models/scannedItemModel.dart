class InventoryItem {
  final String locationBarcode;
  final String itemBarcode;
  final int quantity;

  InventoryItem({
    required this.locationBarcode,
    required this.itemBarcode,
    required this.quantity,
  });

  // Factory method to create an instance from JSON
  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      locationBarcode: json['locationBarcode'],
      itemBarcode: json['itemBarcode'],
      quantity: json['quantity'],
    );
  }
}
