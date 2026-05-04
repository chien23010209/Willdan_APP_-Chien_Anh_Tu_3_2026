class Wildlife {
  int id;
  String name;
  String dangerLevel; // Mức độ nguy hiểm: Thấp, Trung Bình, Cao
  String behavior; // Tập tính
  String counterAction; // Hành động đối phó
  bool isPoisonous; // Có độc hay không

  Wildlife({
    required this.id,
    required this.name,
    required this.dangerLevel,
    required this.behavior,
    required this.counterAction,
    required this.isPoisonous,
  });

  // Phương thức hiển thị nhanh hướng dẫn thoát thân
  String getEmergencyNote() {
    if (isPoisonous) {
      return "⚠️ CẢNH BÁO ĐỘC TÍNH: Tuyệt đối không chạm vào! $counterAction";
    }
    return "💡 Hướng dẫn đối phó: $counterAction";
  }
}