import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
class EditOrAddTripOptionMenu extends StatelessWidget {
  const EditOrAddTripOptionMenu({super.key, this.editTrip, this.removeTrip,this.saveTrip});
  final void Function()? editTrip;
  final void Function()? removeTrip;
  final void Function()? saveTrip;
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
        style: const MenuStyle(
            backgroundColor: MaterialStatePropertyAll(thirdColor)
        ),
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(Icons.more_vert_rounded,color:Color(0xff66757F)),
            tooltip: 'Show menu',
          );
        },
        menuChildren:[
          removeTrip!=null?
          MenuItemButton(
              onPressed: editTrip,
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Edit Trip'),
                  SizedBox(width: 20,),
                  Icon(Icons.edit_rounded,color: basicColor,)
                ],
              )):
          const SizedBox(),
          editTrip!=null?
          MenuItemButton(
              onPressed: removeTrip,
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('remove a Trip'),
                  SizedBox(width: 20,),
                  Icon(Icons.delete_rounded,color: closeColor,)
                ],
              )):
          const SizedBox(),
          saveTrip!=null?
          MenuItemButton(
              onPressed: saveTrip,
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Save the Trip'),
                  SizedBox(width: 20,),
                  Icon(Icons.save_alt_outlined,color: closeColor,)
                ],
              )):
          const SizedBox(),
        ]
    );
  }
}