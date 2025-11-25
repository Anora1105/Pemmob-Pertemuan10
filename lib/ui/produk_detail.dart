import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;
  const ProdukDetail({super.key, this.produk});

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    final p = widget.produk;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk Ariza'),
      ),
      body: p == null
          ? const Center(child: Text('Produk tidak ditemukan'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Kode : ${p.kodeProduk ?? '-'}", style: const TextStyle(fontSize: 20.0)),
                  const SizedBox(height: 8),
                  Text("Nama : ${p.namaProduk ?? '-'}", style: const TextStyle(fontSize: 18.0)),
                  const SizedBox(height: 8),
                  Text("Harga : Rp. ${p.hargaProduk ?? '-'}", style: const TextStyle(fontSize: 18.0)),
                  const SizedBox(height: 20),
                  _tombolHapusEdit()
                ],
              ),
            ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            if (widget.produk != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdukForm(produk: widget.produk!),
                ),
              );
            }
          },
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            // panggil delete sesuai modul, lalu navigasi ke ProdukPage
            Navigator.pop(context); // tutup dialog
          },
        ),
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
