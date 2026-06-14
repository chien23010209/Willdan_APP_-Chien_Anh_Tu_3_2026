import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Chatbot sơ cứu AI hoạt động OFFLINE bằng thuật toán cục bộ (rule-based).
/// 6 tình huống nhanh + chat tự do với cơ sở tri thức nội bộ.
class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});
  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _Msg {
  final String text;
  final bool fromUser;
  _Msg(this.text, this.fromUser);
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final List<_Msg> _messages = [
    _Msg('Xin chào! Tôi là trợ lý sơ cứu offline. Hãy chọn tình huống bên dưới '
        'hoặc gõ câu hỏi của bạn.', false),
  ];

  // 6 tình huống nhanh
  final Map<String, String> _quick = {
    '🐍 Bị rắn cắn':
        'BỊ RẮN CẮN:\n1. GIỮ BÌNH TĨNH, hạn chế cử động.\n2. Giữ vùng bị cắn THẤP HƠN tim.\n3. Tháo nhẫn/vòng đề phòng sưng.\n❌ KHÔNG cắt, KHÔNG hút độc, KHÔNG băng garô chặt.\n🚨 Gọi 115 NGAY và ghi nhớ đặc điểm con rắn.',
    '🦴 Trật khớp/Bong gân':
        'TRẬT KHỚP / BONG GÂN:\n1. Cố định bằng nẹp (cành, tre).\n2. Đắp lạnh giảm sưng 15-20 phút.\n3. Giữ yên, nâng cao vùng bị thương.\n❌ KHÔNG cố nắn lại khớp/xương.',
    '🩸 Vết thương chảy máu':
        'VẾT THƯƠNG CHẢY MÁU:\n1. Ấn trực tiếp 10-15 phút bằng vải sạch.\n2. Nâng cao vùng bị thương lên trên tim.\n3. Băng thêm, KHÔNG tháo băng cũ.\n→ Nếu máu phun thành tia: ép động mạch phía trên vết thương.',
    '🔥 Bỏng':
        'BỎNG:\n1. Làm mát bằng nước sạch 10-20 phút.\n2. Che bằng vải sạch, ẩm.\n3. Uống nhiều nước.\n❌ KHÔNG thoa kem/dầu/bơ. KHÔNG làm vỡ phồng nước.',
    '☀️ Sốc nhiệt/Say nắng':
        'SỐC NHIỆT / SAY NẮNG:\n1. Đưa vào bóng râm, cởi bớt áo.\n2. Làm mát: lau nước mát lên cổ, nách, bẹn.\n3. Cho uống nước từ từ nếu còn tỉnh.\n🚨 Gọi cấp cứu nếu lơ mơ, co giật.',
    '🤢 Ngộ độc thức ăn':
        'NGỘ ĐỘC THỨC ĂN:\n1. Uống nhiều nước sạch để bù nước.\n2. Nghỉ ngơi, theo dõi triệu chứng.\n❌ KHÔNG tự gây nôn nếu nuốt chất ăn mòn.\n🚨 Gọi 115 nếu nôn nhiều, co giật, khó thở.',
  };

  void _send(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(_Msg(text, true));
      _messages.add(_Msg(_answer(text), false));
    });
    _controller.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  // Thuật toán cục bộ: so khớp từ khoá
  String _answer(String q) {
    final t = q.toLowerCase();
    if (_quick.containsKey(q)) return _quick[q]!;
    if (t.contains('rắn') || t.contains('cắn')) return _quick['🐍 Bị rắn cắn']!;
    if (t.contains('máu') || t.contains('chảy') || t.contains('cắt')) {
      return _quick['🩸 Vết thương chảy máu']!;
    }
    if (t.contains('bỏng') || t.contains('phỏng')) return _quick['🔥 Bỏng']!;
    if (t.contains('gãy') || t.contains('khớp') || t.contains('bong')) {
      return _quick['🦴 Trật khớp/Bong gân']!;
    }
    if (t.contains('nắng') || t.contains('nhiệt') || t.contains('ngất')) {
      return _quick['☀️ Sốc nhiệt/Say nắng']!;
    }
    if (t.contains('độc') || t.contains('ăn') || t.contains('nôn')) {
      return _quick['🤢 Ngộ độc thức ăn']!;
    }
    if (t.contains('nước')) {
      return 'TÌM NƯỚC: Theo dấu động vật, côn trùng, tiếng nước chảy. '
          'Lọc qua cát/than/vải rồi ĐUN SÔI 1-3 phút trước khi uống.';
    }
    if (t.contains('lửa')) {
      return 'TẠO LỬA: Chuẩn bị mồi lửa (vỏ tre khô), củi nhỏ→lớn. '
          'Xếp hình chóp. Cẩn thận tre có thể NỔ khi nóng.';
    }
    return 'Tôi chưa rõ tình huống. Hãy chọn một nút tình huống bên dưới, '
        'hoặc gõ từ khoá như: "rắn cắn", "bỏng", "chảy máu", "say nắng", "nước", "lửa".';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💬 Sơ cứu AI (Offline)')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                return Align(
                  alignment:
                      m.fromUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                        maxWidth:
                            MediaQuery.of(context).size.width * 0.78),
                    decoration: BoxDecoration(
                      color: m.fromUser
                          ? AppColors.info
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: m.fromUser
                          ? null
                          : Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Text(m.text,
                        style: TextStyle(
                            color: m.fromUser ? Colors.white : null)),
                  ),
                );
              },
            ),
          ),
          // Nút tình huống nhanh
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: _quick.keys
                  .map((k) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ActionChip(
                          label: Text(k),
                          onPressed: () => _send(k),
                        ),
                      ))
                  .toList(),
            ),
          ),
          // Ô nhập
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Hỏi về tình huống sơ cứu...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24)),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: _send,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppColors.info,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () => _send(_controller.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
