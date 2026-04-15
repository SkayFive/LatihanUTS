import 'package:firebase_database/firebase_database.dart';

class NarapidanaService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref().child(
    'narapidana',
  );

  // Create
  Future<void> tambahdata(
    String nama,
    String jk,
    String umur,
    String kasus,
  ) async {
    final newData = _db.push();

    await newData.set({
      'nama': nama,
      'jenis Kelamin': jk,
      'umur': umur,
      'kasus': kasus,
    });
  }

  Future<void> hapusData(String id) async {
    await _db.child(id).remove();
  }

  // Read
  Stream<DatabaseEvent> getData() {
    return _db.onValue;
  }
}
