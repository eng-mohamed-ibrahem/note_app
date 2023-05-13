import 'package:flutter/material.dart';
import '../../localization/localization_output/app_localizations.dart';

class DismissbleWidget extends StatelessWidget {
  final void Function(DismissDirection)? onDismissed;
  final Key dismisskey;
  final Widget child;
  const DismissbleWidget(
      {super.key,
      required this.dismisskey,
      required this.child,
      this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: dismisskey,
      onDismissed: onDismissed,
      direction: DismissDirection.startToEnd,
      dismissThresholds: const <DismissDirection, double>{
        DismissDirection.startToEnd: 0.25,
      },
      background: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.red),
              width: MediaQuery.of(context).size.width * 0.25,
              child: Center(
                  child: Text(
                AppLocalizations.of(context)!.deleteDismissText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
      child: child,
    );
  }
}
