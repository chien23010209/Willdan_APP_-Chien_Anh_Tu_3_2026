import '../models/survivalkit.dart'; // Đã sửa lại import cho khớp

class ListSurvivalKit {
  List<SurvivalKit> kits = [];

  // Create
  void createKit(int id, String name, String func, int qty) {
    kits.add(SurvivalKit(id: id, name: name, function: func, quantity: qty));
  }

  // Update
  void editKit(int id, String newName, int newQty) {
    for (var kit in kits) {
      if (kit.id == id) {
        kit.name = newName;
        kit.quantity = newQty;
      }
    }
  }

  // Delete
  void deleteKit(int id) {
    kits.removeWhere((kit) => kit.id == id);
  }
}