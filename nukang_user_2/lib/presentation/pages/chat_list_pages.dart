import 'package:flutter/material.dart';
import 'package:nukang_user_2/presentation/pages/chat_detail_pages.dart'; // ✅ HAPUS DUPLIKAT
import '../../models/chat.dart'; // ✅ IMPORT MODEL CHAT
import 'kategori_worker_pages.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<Chat> chats = [];

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  void _loadChats() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        chats = [
          Chat(
            id: '1',
            workerId: '1',
            workerName: 'Budi Listrik Expert',
            workerImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
            lastMessage: 'Oke, saya bisa datang besok jam 9 pagi',
            lastTime: '14:30',
            isRead: false,
            unreadCount: 3,
          ),
          Chat(
            id: '2',
            workerId: '191',
            workerName: 'Udin Tukang Ledeng',
            workerImage: 'https://images.unsplash.com/photo-1541643601528-2b278ef798a2?w=150',
            lastMessage: 'Sudah selesai perbaikannya',
            lastTime: '10:15',
            isRead: true,
          ),
          Chat(
            id: '3',
            workerId: '251',
            workerName: 'Bambang AC Service',
            workerImage: 'https://images.unsplash.com/photo-1592621917627-68e8dd7069e8?w=150',
            lastMessage: 'Berapa biaya service AC?',
            lastTime: '09:45',
            isRead: true,
          ),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Chat', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: chats.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: chats.length,
              itemBuilder: (context, index) => _buildChatCard(chats[index]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF1976D2),
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey[400]),
          ),
          const SizedBox(height: 24),
          const Text(
            'Belum ada chat',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Hubungi tukang favoritmu\nuntuk memulai chat',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildChatCard(Chat chat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailPage(
                  workerId: chat.workerId,
                  workerName: chat.workerName,
                  workerImage: chat.workerImage,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Profile
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(chat.workerImage),
                ),
                const SizedBox(width: 16),
                
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.workerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 200,
                        child: Text(
                          chat.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: chat.isRead ? Colors.grey[600] : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Time & Unread
                Column(
                  children: [
                    Text(
                      chat.lastTime,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    if (!chat.isRead)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1976D2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${chat.unreadCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}