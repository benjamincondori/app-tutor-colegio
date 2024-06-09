import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


import '../../controllers/home/home_controller.dart';
import '../../utils/my_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _con = HomeController();
  // final String _url = 'http://${Environment.API_URL}';

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: _myDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Student'),
            ElevatedButton(
              onPressed: _con.logout,
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myDrawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            accountName: Text(
              _con.user?.userName ?? 'Nombre del usuario',
              style: const TextStyle(fontSize: 18),
            ),
            accountEmail: Text(_con.user?.userEmail ?? 'correo@example.com'),
            currentAccountPicture: 
            // _con.customer?.photo != null
            //     ? ClipOval(
            //       child: FadeInImage(
            //           placeholder: const AssetImage('assets/img/user_profile.png'),
            //           image: NetworkImage('$_url${_con.customer!.photo!}'),
            //           fadeInDuration: const Duration(milliseconds: 200),
            //           fit: BoxFit.cover,
            //         ),
            //     )
                const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/img/user_profile.png'),
                  ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.home, color: MyColors.primaryColor),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: MyColors.primaryColor,
                  ),
                  title: const Text('Inicio'),
                  onTap: () {
                    Navigator.pop(context); // Cierra el Drawer
                  },
                ),
                ListTile(
                  leading: Icon(Icons.assignment, color: MyColors.primaryColor),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: MyColors.primaryColor,
                  ),
                  title: const Text('Ver calificaciones'),
                  onTap: _con.goToStudentsScreen,
                ),
                ListTile(
                  leading: Icon(Icons.file_copy, color: MyColors.primaryColor),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: MyColors.primaryColor,
                  ),
                  title: const Text('Ver boletines'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.message, color: MyColors.primaryColor),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: MyColors.primaryColor,
                  ),
                  title: const Text('Ver comunicados'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(Icons.edit, color: MyColors.primaryColor),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: MyColors.primaryColor,
                  ),
                  title: const Text('Editar perfil'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(Icons.lock, color: MyColors.primaryColor),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: MyColors.primaryColor,
                  ),
                  title: const Text('Cambiar contraseña'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: _con.logout,
                    child: const Text('Cerrar sesión'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
