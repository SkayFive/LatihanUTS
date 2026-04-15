import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:napiapp/services/service_firebase.dart';

class TambahScreen extends StatefulWidget {
  const TambahScreen({super.key});

  @override
  _TambahScreenState createState() => _TambahScreenState();
}

class _TambahScreenState extends State<TambahScreen> {
  final service = NarapidanaService();
  final nama = TextEditingController();
  // final jk = TextEditingController();
  final umur = TextEditingController();
  final kasus = TextEditingController();

  String? jenisKelamin = 'Laki-laki';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Data')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nama,

                decoration: InputDecoration(
                  hintText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 18),

              DropdownButtonFormField<String>(
                // controller: jk,
                value: jenisKelamin,
                decoration: InputDecoration(
                  hintText: 'Jenis Kelamin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.wc_outlined),
                ),
                items: ['Laki-laki', 'Perempuan']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    jenisKelamin = value;
                  });
                },
              ),
              const SizedBox(height: 18),

              TextField(
                controller: umur,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: 'Umur',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 18),

              TextField(
                controller: kasus,
                decoration: InputDecoration(
                  hintText: 'Kasus',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.gavel_rounded),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await service.tambahdata(
                      nama.text,
                      jenisKelamin ?? '',
                      umur.text,
                      kasus.text,
                    );
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 90, 175, 245),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Simpan', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
