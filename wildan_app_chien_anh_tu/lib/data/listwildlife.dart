import '../models/wildlife.dart';

class ListWildlife {
  List<Wildlife> wildlifes = [];

  // Create: Thêm mới một báo cáo hiểm họa
  void addWildlife(int id, String name, String danger, String behavior, String counter, bool isPoison) {
    wildlifes.add(Wildlife(
      id: id,
      name: name,
      dangerLevel: danger,
      behavior: behavior,
      counterAction: counter,
      isPoisonous: isPoison,
    ));
  }

  // Update: Cập nhật trực tiếp thông tin/mức độ nguy hiểm
  void editWildlife(int id, String newDangerLevel, String newCounterAction) {
    for (var wildlife in wildlifes) {
      if (wildlife.id == id) {
        wildlife.dangerLevel = newDangerLevel;
        wildlife.counterAction = newCounterAction;
      }
    }
  }

  // Delete: Xóa bản ghi khỏi danh sách
  void deleteWildlife(int id) {
    wildlifes.removeWhere((wildlife) => wildlife.id == id);
  }
}