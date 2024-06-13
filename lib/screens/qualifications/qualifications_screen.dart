import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:school_student_app/utils/my_colors.dart';

import '../../controllers/management/management_controller.dart';
import '../../controllers/management/period_controller.dart';
import '../../controllers/qualifications_controller.dart/qualifications_controller.dart';
import '../../models/management.dart';
import '../../models/period.dart';
import '../../models/qualification.dart';
import '../../models/student.dart';

class QualificationScreen extends StatefulWidget {
  final Student student;

  const QualificationScreen({super.key, required this.student});

  @override
  State<QualificationScreen> createState() => _QualificationScreenState();
}

class _QualificationScreenState extends State<QualificationScreen> {
  final PeriodController _periodController = PeriodController();
  final ManagementController _managementController = ManagementController();
  final QualificationsController _qualificationsController =
      QualificationsController();

  @override
  void initState() {
    super.initState();

    // Se ejecuta despues del metodo build
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _periodController.init(context, refresh);
      _managementController.init(context, refresh);
      _qualificationsController.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Period>? periods = _periodController.periodsRequest;
    List<Management>? managements = _managementController.managementsRequest;

    _qualificationsController.selectedStudent = widget.student;

    // final Future<List<Period>?> periods = Future<List<Period>?>.delayed(
    //   const Duration(seconds: 1),
    //   () {
    //     studentsRequest = _periodController.periodsRequest;
    //     return studentsRequest;
    //   },
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calificaciones'),
      ),
      body: SizedBox(
        width: double.infinity, // Ocupar todo el ancho
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                _dropDownManagements(managements),
                const SizedBox(height: 10),
                _dropDownPeriods(periods),
                const SizedBox(height: 10),
                _buttonSend(),
                const SizedBox(height: 10),
                // _qualificationsController.isLoading
                //     ? const CircularProgressIndicator()
                //     : _qualificationsList(),
                _qualificationsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropDownPeriods(List<Period>? periods) {
    return Material(
      elevation: 2.0,
      color: MyColors.primarySwatch[50],
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.search,
                  color: MyColors.primaryColor,
                ),
                const SizedBox(width: 15),
                Text(
                  'Períodos',
                  style: TextStyle(
                    color: MyColors.primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButton<Period>(
                value: _qualificationsController.selectedPeriod,
                underline: Container(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_drop_down_circle,
                    color: MyColors.primaryColor,
                  ),
                ),
                elevation: 3,
                isExpanded: true,
                hint: Text(
                  'Seleccione un período',
                  style: TextStyle(color: MyColors.primaryColor, fontSize: 16),
                ),
                items: periods?.map((Period? period) {
                  return DropdownMenuItem<Period>(
                      value: period,
                      // child: _card(period),
                      child: Text(period?.tipoPeriodo ?? ''));
                }).toList(),
                onChanged: (Period? newValue) {
                  setState(() {
                    _qualificationsController.selectedPeriod = newValue;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDownManagements(List<Management>? managements) {
    return Material(
      elevation: 2.0,
      color: MyColors.primarySwatch[50],
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.search,
                  color: MyColors.primaryColor,
                ),
                const SizedBox(width: 15),
                Text(
                  'Gestiones',
                  style: TextStyle(
                    color: MyColors.primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButton<Management>(
                value: _qualificationsController.selectedManagement,
                underline: Container(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_drop_down_circle,
                    color: MyColors.primaryColor,
                  ),
                ),
                elevation: 3,
                isExpanded: true,
                hint: Text(
                  'Seleccione una gestión',
                  style: TextStyle(color: MyColors.primaryColor, fontSize: 16),
                ),
                items: managements?.map((Management? management) {
                  return DropdownMenuItem<Management>(
                      value: management, child: Text(management?.year ?? ''));
                }).toList(),
                onChanged: (Management? newValue) {
                  setState(() {
                    _qualificationsController.selectedManagement = newValue;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonSend() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _qualificationsController.getQualificationsByStudent,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text('Obtener calificaciones'),
      ),
    );
  }

  Widget _qualificationsList() {
    List<Qualification> qualifications =
        _qualificationsController.qualificationsRequest ?? [];
    return qualifications.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: qualifications.length,
            itemBuilder: (context, index) {
              final qualification = qualifications[index];
              return ListTile(
                title: Text(qualification.materia),
                subtitle: Text('Nota: ${qualification.nota}'),
              );
            },
          )
        : const Text('No hay resultados');
  }


  void refresh() {
    setState(() {});
  }
}
