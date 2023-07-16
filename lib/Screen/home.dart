import 'package:flutter/material.dart';
import 'package:ruang_belajar/screen/matapelajaran.dart';
import 'package:ruang_belajar/screen/profile.dart';
import '../models/materipelajaran.dart';
import '../models/tugas.dart';
import './tugasharian.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  late List<Tugas> _listTugas; 
  late List<MateriPelajaran> _listMataPelajaran; 

  List<Widget> tabs = []; 

  @override
  void initState() {
    _listTugas = [
      Tugas(id: '1', matakuliah: 'Pemrograman Mobile', deskripsi: 'Ngoding', status: 'false')
    ];

    _listMataPelajaran = [
      MateriPelajaran(id: '1', matakuliah: 'Pemrograman Mobile', deskripsi: 'Flutter adalah blablabla')
    ];

    tabs = [
      TugasHarian(listTugas: _listTugas.toList()),
      CatatanMateri(listPelajaran: _listMataPelajaran.toList()),
      ProfileScreen()
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Materi Pelajaran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
