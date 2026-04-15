import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:napiapp/screens/tambah_screen.dart';
import 'package:napiapp/services/service_firebase.dart';

class NapiListScreen extends StatefulWidget {
  const NapiListScreen({super.key});

  @override
  State<NapiListScreen> createState() => _NapiListScreenState();
}

class _NapiListScreenState extends State<NapiListScreen> {
  final NarapidanaService service = NarapidanaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Narapidana', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 90, 175, 245),
      ),
      body: StreamBuilder(
        stream: service.getData(),
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!.snapshot.value as Map?;

          if (data == null) {
            return Center(child: Text('Belum ada data'));
          }
          final list = data.entries.toList();

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final key = list[index].key;
              final item = list[index].value;

              return Card(
                elevation: 4,
                child: ListTile(
                  title: Text(item['nama'] ?? '', style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),

                      Row(
                        children: [
                          Icon(Icons.wc, size: 16),
                          SizedBox(width: 5),
                          Text('Jenis Kelamin: ${item['jenis Kelamin']}'),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16),
                          SizedBox(width: 5),
                          Text('Umur: ${item['umur']}'),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.gavel, size: 16),
                          SizedBox(width: 5),
                          Text('Kasus: ${item['kasus']}'),
                        ],
                      ),
                    ],
                  ),
                  //  Text(
                  //  'Jenis Kelamin: ${item['jenis Kelamin']} \nUmur: ${item['umur']} \nkasus: ${item['kasus']}',
                  //  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await service.hapusData(key);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 62, right: 10),
        child: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 90, 175, 245),
          shape: CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TambahScreen()),
            );
          },
        ),
      ),
    );
  }
}
