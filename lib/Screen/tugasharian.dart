import 'package:flutter/material.dart';
import 'package:pencacatantugas/widgets/list_tugas.dart';

import '../models/tugas.dart';

class TugasHarian extends StatefulWidget {
  final List<Tugas> listTugas;

  const TugasHarian({Key? key, required this.listTugas}) : super(key: key);

  @override
  State<TugasHarian> createState() => _TugasHarianState();
}

class _TugasHarianState extends State<TugasHarian> {
  final _matakuliah = TextEditingController();
  final _deskripsi = TextEditingController();

  _deleteTugas(String id) {
    setState(() {
      widget.listTugas.removeWhere((tx) => tx.id == id);
    });
  }

  _updateTugas(String id) {
    setState(() {
      Tugas tugas = widget.listTugas.firstWhere(
        (tugas) => tugas.id == id,
        orElse: () => Tugas(id: '', matakuliah: '', deskripsi: '', status: ''),
      );
      if (tugas.id != null) {
        _updateBottomSheet(
            tugas.id, tugas.matakuliah, tugas.deskripsi, tugas.status);
      }
    });
  }

  _updateStatus(String id) {
    setState(() {
      Tugas tugas = widget.listTugas.firstWhere(
        (tugas) => tugas.id == id,
        orElse: () => Tugas(id: '', matakuliah: '', deskripsi: '', status: ''),
      );
      if (tugas.id != null) {
        if (tugas.status == 'true') {
          tugas.status = 'false';
        } else {
          tugas.status = 'true';
        }
      }
    });
  }

  _updateBottomSheet(
      String id, String matakuliah, String deskripsi, String status) {
    _matakuliah.text = matakuliah;
    _deskripsi.text = deskripsi;
    bool isChecked = status == 'true';

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
                    controller: _deskripsi,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text('Status'),
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
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
                            int index = widget.listTugas
                                .indexWhere((tugas) => tugas.id == id);

                            if (index != -1) {
                              // Update the task with the new values
                              widget.listTugas[index] = Tugas(
                                id: id,
                                matakuliah: _matakuliah.text,
                                deskripsi: _deskripsi.text,
                                status: isChecked ? 'true' : 'false',
                              );
                              _matakuliah.clear();
                              _deskripsi.clear();
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
                    decoration: InputDecoration(labelText: 'Mata Kuliah'),
                    controller: _matakuliah,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Deskripsi'),
                    controller: _deskripsi,
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
                            widget.listTugas.add(Tugas(
                              id: DateTime.now().toString(),
                              matakuliah: _matakuliah.text,
                              deskripsi: _deskripsi.text,
                              status: 'false',
                            ));
                            _matakuliah.clear();
                            _deskripsi.clear();
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
        title: Text('Tugas Harian'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTugas(
              widget.listTugas,
              _deleteTugas,
              _updateStatus,
              _updateTugas,
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
