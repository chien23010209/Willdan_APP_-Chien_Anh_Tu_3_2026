// Các model dữ liệu của Wildan, ánh xạ trực tiếp tới Firestore.

/// Loài động-thực vật trong Thư viện
class Species {
  final String id;
  final String emoji;
  final String name; // Tên tiếng Việt
  final String scientificName; // Tên khoa học
  final String type; // 'plant' | 'animal'
  final String category; // 'edible' | 'danger' | 'medicine' | 'useful'
  final String description;
  final List<String> identification; // Đặc điểm nhận dạng
  final String usage; // Cách sử dụng
  final String warning; // Cảnh báo
  final String habitat; // Nơi thường gặp

  Species({
    required this.id,
    required this.emoji,
    required this.name,
    required this.scientificName,
    required this.type,
    required this.category,
    required this.description,
    required this.identification,
    required this.usage,
    required this.warning,
    required this.habitat,
  });

  factory Species.fromMap(String id, Map<String, dynamic> m) => Species(
        id: id,
        emoji: m['emoji'] ?? '❓',
        name: m['name'] ?? '',
        scientificName: m['scientificName'] ?? '',
        type: m['type'] ?? 'plant',
        category: m['category'] ?? 'useful',
        description: m['description'] ?? '',
        identification: List<String>.from(m['identification'] ?? const []),
        usage: m['usage'] ?? '',
        warning: m['warning'] ?? '',
        habitat: m['habitat'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'emoji': emoji,
        'name': name,
        'scientificName': scientificName,
        'type': type,
        'category': category,
        'description': description,
        'identification': identification,
        'usage': usage,
        'warning': warning,
        'habitat': habitat,
      };
}

/// Một bước trong hướng dẫn sinh tồn
class GuideStep {
  final String text;
  final bool isWarning; // true => hiển thị màu vàng/đỏ
  GuideStep(this.text, {this.isWarning = false});

  factory GuideStep.fromMap(Map<String, dynamic> m) =>
      GuideStep(m['text'] ?? '', isWarning: m['isWarning'] ?? false);

  Map<String, dynamic> toMap() => {'text': text, 'isWarning': isWarning};
}

/// Hướng dẫn sinh tồn (6 danh mục: Nước, Trú ẩn, Lửa, Thức ăn, Định hướng, Cứu hộ)
class SurvivalGuide {
  final String id;
  final String emoji;
  final String title;
  final int priority; // thứ tự ưu tiên (1 = cao nhất)
  final String color; // category color key
  final List<GuideStep> steps;
  final String localInfo; // Thông tin địa phương (Cúc Phương)

  SurvivalGuide({
    required this.id,
    required this.emoji,
    required this.title,
    required this.priority,
    required this.color,
    required this.steps,
    required this.localInfo,
  });

  factory SurvivalGuide.fromMap(String id, Map<String, dynamic> m) =>
      SurvivalGuide(
        id: id,
        emoji: m['emoji'] ?? '📌',
        title: m['title'] ?? '',
        priority: m['priority'] ?? 99,
        color: m['color'] ?? 'info',
        steps: (m['steps'] as List? ?? [])
            .map((e) => GuideStep.fromMap(Map<String, dynamic>.from(e)))
            .toList(),
        localInfo: m['localInfo'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'emoji': emoji,
        'title': title,
        'priority': priority,
        'color': color,
        'steps': steps.map((e) => e.toMap()).toList(),
        'localInfo': localInfo,
      };
}

/// Hướng dẫn sơ cứu khẩn cấp (5 tình huống)
class FirstAid {
  final String id;
  final String emoji;
  final String title;
  final List<String> doSteps; // Việc cần làm
  final List<String> dontSteps; // ❌ KHÔNG được làm
  final bool callEmergency; // 🚨 Gọi cấp cứu ngay

  FirstAid({
    required this.id,
    required this.emoji,
    required this.title,
    required this.doSteps,
    required this.dontSteps,
    required this.callEmergency,
  });

  factory FirstAid.fromMap(String id, Map<String, dynamic> m) => FirstAid(
        id: id,
        emoji: m['emoji'] ?? '🩹',
        title: m['title'] ?? '',
        doSteps: List<String>.from(m['doSteps'] ?? const []),
        dontSteps: List<String>.from(m['dontSteps'] ?? const []),
        callEmergency: m['callEmergency'] ?? false,
      );

  Map<String, dynamic> toMap() => {
        'emoji': emoji,
        'title': title,
        'doSteps': doSteps,
        'dontSteps': dontSteps,
        'callEmergency': callEmergency,
      };
}

/// Điểm đánh dấu trong Nhật ký lộ trình
class JournalEntry {
  final String id;
  final String type; // 'water' | 'shelter' | 'danger' | 'mark'
  final String title;
  final String note;
  final double lat;
  final double lng;
  final DateTime time;

  JournalEntry({
    required this.id,
    required this.type,
    required this.title,
    required this.note,
    required this.lat,
    required this.lng,
    required this.time,
  });

  factory JournalEntry.fromMap(String id, Map<String, dynamic> m) =>
      JournalEntry(
        id: id,
        type: m['type'] ?? 'mark',
        title: m['title'] ?? '',
        note: m['note'] ?? '',
        lat: (m['lat'] ?? 0).toDouble(),
        lng: (m['lng'] ?? 0).toDouble(),
        time: DateTime.tryParse(m['time'] ?? '') ?? DateTime.now(),
      );

  Map<String, dynamic> toMap() => {
        'type': type,
        'title': title,
        'note': note,
        'lat': lat,
        'lng': lng,
        'time': time.toIso8601String(),
      };

  static String emojiFor(String type) {
    switch (type) {
      case 'water':
        return '💧';
      case 'shelter':
        return '🏕️';
      case 'danger':
        return '⚠️';
      default:
        return '📍';
    }
  }

  static String labelFor(String type) {
    switch (type) {
      case 'water':
        return 'Nguồn nước';
      case 'shelter':
        return 'Trú ẩn';
      case 'danger':
        return 'Nguy hiểm';
      default:
        return 'Điểm đánh dấu';
    }
  }
}
