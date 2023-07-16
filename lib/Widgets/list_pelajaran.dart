import 'package:flutter/material.dart';
import '../models/materipelajaran.dart';

class ListPelajaran extends StatelessWidget {
  final List<MateriPelajaran> listCatatan;
  final Function deleteCatatan;
  final Function updateCatatan;

  const ListPelajaran(this.listCatatan, this.deleteCatatan, this.updateCatatan);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: EdgeInsets.all(15),
      child: listCatatan.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(height: 100),
                Text(
                  'Belum Ada Catatan',
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
                return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${listCatatan[index].matakuliah}'),
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
                                listCatatan[index].deskripsi,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              updateCatatan(listCatatan[index].id);
                            },
                            child: Icon(
                              Icons.update,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              deleteCatatan(listCatatan[index].id);
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
              itemCount: listCatatan.length,
            ),
    );
  }
}
