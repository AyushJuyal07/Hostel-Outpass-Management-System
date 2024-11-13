import 'package:cu_hostel/core/warden/models/pass_model.dart';
import 'package:cu_hostel/utils/enums.dart';
import 'package:flutter/material.dart';

class PassCard extends StatelessWidget {
  const PassCard({
    super.key,
    required this.pass,
  });
  final PassModel pass;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pass.isDayPass ? "Day Pass" : "Night Pass",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Align(
                child: CircleAvatar(
                  backgroundColor: pass.status == PassStatus.opened
                      ? Colors.yellow
                      : Colors.green,
                  radius: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text("${pass.name} - ${pass.uid}"),
          Text("")
        ],
      ),
    );
  }
}
