import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';
import 'seed_data.dart';

/// Lớp trung gian giao tiếp với Firebase Firestore.
///
/// Firestore được bật chế độ cache offline (persistence) nên dữ liệu vẫn
/// đọc được khi mất mạng — phù hợp với app sinh tồn ngoại tuyến.
///
/// Cấu trúc Firestore:
///   species/{id}        → loài động-thực vật
///   guides/{id}         → hướng dẫn sinh tồn
///   first_aid/{id}      → hướng dẫn sơ cứu
///   journal/{id}        → nhật ký lộ trình (đọc/ghi)
class FirebaseService {
  FirebaseService._();
  static final FirebaseService instance = FirebaseService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Bật cache offline cho Firestore (gọi 1 lần khi khởi động).
  static void enableOfflinePersistence() {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  // ---------- SEED: nạp dữ liệu gốc lên Firestore lần đầu ----------
  /// Nạp/bổ sung dữ liệu mẫu lên Firestore.
  /// Tự thêm các tài liệu còn thiếu (vd khi thêm loài mới vào seed_data).
  Future<void> seedIfEmpty() async {
    try {
      final batch = _db.batch();
      // species
      final spSnap = await _db.collection('species').get();
      if (spSnap.docs.length < SeedData.species.length) {
        for (final s in SeedData.species) {
          batch.set(_db.collection('species').doc(s.id), s.toMap());
        }
      }
      // guides
      final gSnap = await _db.collection('guides').get();
      if (gSnap.docs.length < SeedData.guides.length) {
        for (final g in SeedData.guides) {
          batch.set(_db.collection('guides').doc(g.id), g.toMap());
        }
      }
      // first_aid
      final fSnap = await _db.collection('first_aid').get();
      if (fSnap.docs.length < SeedData.firstAid.length) {
        for (final f in SeedData.firstAid) {
          batch.set(_db.collection('first_aid').doc(f.id), f.toMap());
        }
      }
      await batch.commit();
    } catch (_) {
      // Bỏ qua nếu offline — sẽ dùng SeedData làm fallback.
    }
  }

  // ---------- ĐỌC DỮ LIỆU (có fallback offline) ----------
  Future<List<Species>> getSpecies() async {
    try {
      final snap = await _db.collection('species').get();
      if (snap.docs.isEmpty) return SeedData.species;
      return snap.docs.map((d) => Species.fromMap(d.id, d.data())).toList();
    } catch (_) {
      return SeedData.species; // fallback offline
    }
  }

  Future<List<SurvivalGuide>> getGuides() async {
    try {
      final snap = await _db.collection('guides').orderBy('priority').get();
      if (snap.docs.isEmpty) return SeedData.guides;
      return snap.docs.map((d) => SurvivalGuide.fromMap(d.id, d.data())).toList();
    } catch (_) {
      final list = [...SeedData.guides]..sort((a, b) => a.priority.compareTo(b.priority));
      return list;
    }
  }

  Future<List<FirstAid>> getFirstAid() async {
    try {
      final snap = await _db.collection('first_aid').get();
      if (snap.docs.isEmpty) return SeedData.firstAid;
      return snap.docs.map((d) => FirstAid.fromMap(d.id, d.data())).toList();
    } catch (_) {
      return SeedData.firstAid;
    }
  }

  // ---------- NHẬT KÝ LỘ TRÌNH (đọc/ghi realtime) ----------
  Stream<List<JournalEntry>> journalStream() {
    return _db
        .collection('journal')
        .orderBy('time', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => JournalEntry.fromMap(d.id, d.data())).toList());
  }

  Future<void> addJournalEntry(JournalEntry e) async {
    await _db.collection('journal').add(e.toMap());
  }

  Future<void> deleteJournalEntry(String id) async {
    await _db.collection('journal').doc(id).delete();
  }
}
