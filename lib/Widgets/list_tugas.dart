import 'package:flutter/material.dart';
import '../models/tugas.dart';

class ListTugas extends StatelessWidget {
  final List<Tugas> listTugas;
  final Function deleteTugas;
  final Function updateStatus;
  final Function updateTugas;

  const ListTugas(
      this.listTugas, this.deleteTugas, this.updateStatus, this.updateTugas);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: EdgeInsets.all(15),
      child: listTugas.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(height: 100),
                Text(
                  'Belum Ada Tugas',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 100),
                Container(
                  height: 200,
                  child: Image.asset('images/listtugas.png', fit: BoxFit.cover),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                final bool isChecked = listTugas[index].status == 'true';
                return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${listTugas[index].matakuliah}'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                listTugas[index].deskripsi,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ),
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) =>
                                updateStatus(listTugas[index].id),
                          ),
                          GestureDetector(
                            onTap: () {
                              updateTugas(listTugas[index].id);
                            },
                            child: Icon(
                              Icons.update,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              deleteTugas(listTugas[index].id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.delete,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: listTugas.length,
            ),
    );
  }
}
