import 'package:flutter/material.dart';
import '../../models/chat.dart';

class ChatDetailPage extends StatefulWidget {
  final String workerId;
  final String workerName;
  final String workerImage;

  const ChatDetailPage({
    super.key,
    required this.workerId,
    required this.workerName,
    required this.workerImage,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> messages = [];
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _loadMessages();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        messages = [
          ChatMessage(
            id: '1',
            senderId: 'worker',
            senderName: widget.workerName,
            message: 'Halo! Saya ${widget.workerName}. Apa yang bisa saya bantu?',
            time: DateTime.now().subtract(const Duration(minutes: 10)),
            isMe: false,
          ),
          ChatMessage(
            id: '2',
            senderId: 'user',
            senderName: 'Anda',
            message: 'Halo pak, rumah saya ada masalah listrik di kamar',
            time: DateTime.now().subtract(const Duration(minutes: 8)),
            isMe: true,
            status: MessageStatus.read,
          ),
          ChatMessage(
            id: '3',
            senderId: 'worker',
            senderName: widget.workerName,
            message: 'Baik, bisa saya tahu alamatnya dan kapan bisa saya datang?',
            time: DateTime.now().subtract(const Duration(minutes: 5)),
            isMe: false,
          ),
          ChatMessage(
            id: '4',
            senderId: 'user',
            senderName: 'Anda',
            message: 'Jl. Merdeka 123',
            time: DateTime.now().subtract(const Duration(minutes: 3)),
            isMe: true,
            status: MessageStatus.delivered,
          ),
        ];
      });
      _scrollToBottom();
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final ChatMessage newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'user',
      senderName: 'Anda',
      message: _messageController.text.trim(),
      time: DateTime.now(),
      isMe: true,
      status: MessageStatus.sent,
    );

    setState(() {
      messages.add(newMessage);
    });
    _messageController.clear();
    _scrollToBottom();

    // Simulasi: sent → delivered
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() {
        final index = messages.indexWhere((m) => m.id == newMessage.id);
        if (index != -1) {
          messages[index] = ChatMessage(
            id: newMessage.id,
            senderId: newMessage.senderId,
            senderName: newMessage.senderName,
            message: newMessage.message,
            time: newMessage.time,
            isMe: true,
            status: MessageStatus.delivered,
          );
        }
      });
    });

    // Simulasi: delivered → read (centang 2 biru)
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        final index = messages.indexWhere((m) => m.id == newMessage.id);
        if (index != -1) {
          messages[index] = ChatMessage(
            id: newMessage.id,
            senderId: newMessage.senderId,
            senderName: newMessage.senderName,
            message: newMessage.message,
            time: newMessage.time,
            isMe: true,
            status: MessageStatus.read,
          );
        }
      });
    });

    // Simulasi: balasan otomatis dari worker
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        messages.add(ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: widget.workerId,
          senderName: widget.workerName,
          message: 'Oke, saya catat. Saya akan konfirmasi jadwalnya.',
          time: DateTime.now(),
          isMe: false,
        ));
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _toggleSidePopup() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  void _closeSidePopup() {
    _animationController.reverse();
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (now.difference(time).inDays > 0) {
      return '${time.day}/${time.month}';
    }
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _showComingSoonDialog(String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(_getFeatureIcon(feature), color: _getFeatureColor(feature)),
            const SizedBox(width: 12),
            Expanded(child: Text(feature)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.construction, size: 64, color: Colors.orange[300]),
            const SizedBox(height: 16),
            const Text(
              'Fitur ini sedang dalam tahap pengembangan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Kami akan segera meluncurkannya!',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  IconData _getFeatureIcon(String feature) {
    switch (feature) {
      case 'Telepon':
        return Icons.phone;
      case 'Video Call':
        return Icons.videocam;
      case 'Info':
        return Icons.info;
      case 'Search':
        return Icons.search;
      case 'Media':
        return Icons.photo_library;
      case 'Links':
        return Icons.link;
      default:
        return Icons.info;
    }
  }

  Color _getFeatureColor(String feature) {
    switch (feature) {
      case 'Telepon':
        return Colors.green;
      case 'Video Call':
        return Colors.blue;
      case 'Info':
        return const Color(0xFF1976D2);
      case 'Search':
        return Colors.grey[700]!;
      case 'Media':
        return Colors.purple;
      case 'Links':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  // ─── WIDGET: STATUS ICON (read receipt) ───────────────────────────────────
  Widget _buildStatusIcon(MessageStatus status) {
  switch (status) {
    case MessageStatus.sent:
      return const Icon(Icons.check, color: Colors.white70, size: 14);

    case MessageStatus.delivered:
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, color: Colors.white70, size: 14),
          Transform.translate(
            offset: const Offset(-8, 0),
            child: const Icon(Icons.check, color: Colors.white70, size: 14),
          ),
        ],
      );

    case MessageStatus.read:
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, color: Color(0xFF34B7F1), size: 14),
          Transform.translate(
            offset: const Offset(-6, 0),
            child: const Icon(Icons.check, color: Color(0xFF34B7F1), size: 14),
          ),
        ],
      );

    default:
      return const SizedBox();
  }
}

  // ─── WIDGET: MESSAGE BUBBLE ───────────────────────────────────────────────
  Widget _buildMessageBubble(ChatMessage message) {
    final bool isMe = message.isMe;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF1976D2) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Teks pesan
            Text(
              message.message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),

            // Baris waktu + status icon
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _formatTime(message.time),
                  style: TextStyle(
                    color: isMe ? Colors.white60 : Colors.grey[500],
                    fontSize: 11,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  _buildStatusIcon(message.status),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── WIDGET: MENU ITEM (side panel) ───────────────────────────────────────
  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _getFeatureColor(title).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: _getFeatureColor(title), size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          _toggleSidePopup();
          Future.delayed(const Duration(milliseconds: 300), onTap);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.grey[50],
      ),
    );
  }

  // ─── BUILD ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.workerImage),
              onBackgroundImageError: (_, __) {},
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.workerName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Online',
                    style: TextStyle(fontSize: 12, color: Colors.green[300]),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.white),
            onPressed: () => _showComingSoonDialog('Telepon'),
            tooltip: 'Telepon',
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () => _showComingSoonDialog('Video Call'),
            tooltip: 'Video Call',
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: _toggleSidePopup,
            tooltip: 'Opsi Lainnya',
          ),
        ],
      ),
      body: Stack(
        children: [
          // ── KONTEN UTAMA CHAT ──
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) =>
                      _buildMessageBubble(messages[index]),
                ),
              ),

              // ── INPUT BAR ──
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Ketik pesan...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF1F5F9),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1976D2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.send, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ── BACKDROP OVERLAY (saat side panel terbuka) ──
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              if (_fadeAnimation.value == 0) return const SizedBox.shrink();
              return GestureDetector(
                onTap: _closeSidePopup,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.4 * _fadeAnimation.value),
                ),
              );
            },
          ),

          // ── SIDE PANEL (slide dari kanan) ──
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Transform.translate(
                  offset: Offset(
                    MediaQuery.of(context).size.width * 0.65 * _slideAnimation.value,
                    0,
                  ),
                  child: Opacity(
                    opacity: _fadeAnimation.value.clamp(0.0, 1.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(-8, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Header side panel
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 56, 8, 16),
                            child: Row(
                              children: [
                                const Text(
                                  'Opsi Lainnya',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1976D2),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.close, size: 26),
                                  onPressed: _closeSidePopup,
                                  tooltip: 'Tutup',
                                ),
                              ],
                            ),
                          ),

                          // Menu items
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              children: [
                                _buildMenuItem('Info', Icons.info_outline,
                                    () => _showComingSoonDialog('Info')),
                                _buildMenuItem('Search', Icons.search,
                                    () => _showComingSoonDialog('Search')),
                                _buildMenuItem('Media', Icons.photo_library_outlined,
                                    () => _showComingSoonDialog('Media')),
                                _buildMenuItem('Links', Icons.link_outlined,
                                    () => _showComingSoonDialog('Links')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}