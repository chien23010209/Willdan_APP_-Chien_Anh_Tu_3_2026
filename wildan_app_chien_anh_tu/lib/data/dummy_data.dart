import '../models/animal.dart';
import '../models/plant.dart';
import '../models/skill.dart';
import '../models/tool.dart';

class DummyData {
  static List<Animal> animals = [
    Animal(id: 1, name: 'Vắt Rừng Cúc Phương', dangerLevel: 'Khó chịu, Dễ nhiễm trùng', description: 'Cực kỳ phổ biến mùa mưa. Tiết chất chống đông máu.', firstAid: 'Dùng lửa, chanh, muối để vắt tự nhả. Rửa sạch và băng ép.'),
    Animal(id: 2, name: 'Rắn Lục Đuôi Đỏ', dangerLevel: 'Độc Máu - Cực Nguy Hiểm', description: 'Thân xanh, đuôi đỏ, nguỵ trang rất tốt trong thảm thực vật.', firstAid: 'Bất động chi bị cắn, không garo, đưa đi cấp cứu ngay.'),
    Animal(id: 3, name: 'Muỗi Anophen', dangerLevel: 'Truyền bệnh sốt rét', description: 'Hoạt động mạnh lúc chập choạng tối ở nơi nước đọng.', firstAid: 'Uống thuốc dự phòng, mắc màn khi ngủ.'),
    Animal(id: 4, name: 'Lợn Rừng', dangerLevel: 'Rất Nguy Hiểm', description: 'Hung dữ khi bảo vệ con hoặc bị giật mình, có răng nanh lớn.', firstAid: 'Không bỏ chạy. Tìm cây cao trèo lên ngay lập tức.'),
  ];

  static List<Plant> plants = [
    Plant(id: 1, name: 'Dây Gắm (Lấy nước)', toxicity: 'Uống được', description: 'Dây leo thân gỗ lớn, thường nhả nước khi chặt.', usage: 'Chặt chữ V sát gốc. Nước trong, không mùi mới được uống.'),
    Plant(id: 2, name: 'Nấm Độc Tán Trắng', toxicity: 'Tử vong', description: 'Trắng muốt, mọc ở thảm lá mục. Giống nấm ăn thông thường.', usage: 'TUYỆT ĐỐI KHÔNG CHẠM. Không có thuốc giải đặc hiệu.'),
    Plant(id: 3, name: 'Cây Móc', toxicity: 'An toàn (Đọt non)', description: 'Cây họ cọ, phổ biến ở rừng ẩm.', usage: 'Lấy phần lõi non (đọt) để ăn sống hoặc luộc chín.'),
  ];

  static List<Skill> skills = [
    Skill(id: 1, name: 'Định hướng bằng thảm thực vật', description: 'Phương pháp thô sơ khi mất la bàn.', steps: ['Tìm cây cổ thụ lớn.', 'Phía Bắc thường ẩm hơn, rêu và dương xỉ mọc dày hơn.', 'Quan sát hướng dòng chảy của suối nhỏ (đổ ra sông lớn).']),
    Skill(id: 2, name: 'Lọc nước bằng đất, cát', description: 'Làm sạch nước suối đục.', steps: ['Tạo phễu bằng lá chuối hoặc nilon.', 'Lót lần lượt: sỏi, cát, than củi (từ đống lửa), cát mịn.', 'Lọc nhiều lần và LUÔN đun sôi 10 phút.']),
    Skill(id: 3, name: 'Dựng sập cách đất', description: 'Tránh ẩm ướt và côn trùng.', steps: ['Tìm 4 chạc cây chắc chắn.', 'Đan khung giường bằng tre/nứa/gỗ cách mặt đất 50cm.', 'Phủ lá chuối hoặc cỏ tranh làm đệm.']),
  ];

  static List<Tool> tools = [
    Tool(id: 1, name: 'Dao rựa (Machete)', importance: 'Bắt buộc', description: 'Công cụ đa năng số 1 trong rừng nhiệt đới.', usage: 'Phát quang bụi rậm, tự vệ, chặt củi, dựng lán.'),
    Tool(id: 2, name: 'Bật lửa & Bùi nhùi', importance: 'Bắt buộc', description: 'Sinh tồn ở rừng ẩm Cúc Phương rất khó tạo lửa bằng ma sát.', usage: 'Bọc bật lửa trong túi nilon chống nước. Mang theo bông gòn tẩm vaseline làm bùi nhùi.'),
    Tool(id: 3, name: 'Thuốc lào / Muối hột', importance: 'Cần thiết', description: 'Vật dụng rẻ tiền chống vắt cực hiệu quả.', usage: 'Xát quanh cổ chân, tất, giày trước khi đi vào đường mòn.'),
  ];
}