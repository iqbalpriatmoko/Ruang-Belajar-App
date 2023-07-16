import 'package:flutter/material.dart';
import 'package:pencacatantugas/models/materipelajaran.dart';

import '../widgets/list_pelajaran.dart';

class CatatanMateri extends StatefulWidget {
  final List<MateriPelajaran> listPelajaran;

  const CatatanMateri({Key? key, required this.listPelajaran})
      : super(key: key);

  @override
  State<CatatanMateri> createState() => _CatatanMateriState();
}

class _CatatanMateriState extends State<CatatanMateri> {
  final _matakuliah = TextEditingController();
  final _catatan = TextEditingController();

  _deleteCatatan(String id) {
    setState(() {
      widget.listPelajaran.removeWhere((tx) => tx.id == id);
    });
  }

  _updateCatatan(String id) {
    setState(() {
      MateriPelajaran mapel = widget.listPelajaran.firstWhere(
        (mapel) => mapel.id == id,
        orElse: () => MateriPelajaran(id: '', matakuliah: '', deskripsi: ''),
      );
      if (mapel.id != null) {
        _updateBottomSheet(mapel.id, mapel.matakuliah, mapel.deskripsi);
      }
    });
  }

  _updateBottomSheet(String id, String matakuliah, String deskripsi) {
    _matakuliah.text = matakuliah;
    _catatan.text = deskripsi;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Mata Kuliah'),
                    controller: _matakuliah,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Deskripsi'),
                    controller: _catatan,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Find the index of the task in the list
                            int index = widget.listPelajaran
                                .indexWhere((catatan) => catatan.id == id);

                            if (index != -1) {
                              // Update the task with the new values
                              widget.listPelajaran[index] = MateriPelajaran(
                                id: id,
                                matakuliah: _matakuliah.text,
                                deskripsi: _catatan.text,
                              );
                              _matakuliah.clear();
                              _catatan.clear();
                            }
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text('UPDATE'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Mata Pelajaran'),
                    controller: _matakuliah,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Catatan'),
                    controller: _catatan,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.listPelajaran.add(MateriPelajaran(
                              id: DateTime.now().toString(),
                              matakuliah: _matakuliah.text,
                              deskripsi: _catatan.text,
                            ));
                            _matakuliah.clear();
                            _catatan.clear();
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Materi Pelajaran'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListPelajaran(
              widget.listPelajaran,
              _deleteCatatan,
              _updateCatatan,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
