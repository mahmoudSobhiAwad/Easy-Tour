import 'package:flutter/material.dart';
class ItemOfLanguage extends StatelessWidget {
  const ItemOfLanguage({super.key,this.value,this.onTap,this.prefs});
final String?value;
final void Function()?onTap;
final Set<String>?prefs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(5),
      decoration: BoxDecoration(color: const Color(0xffECECEC),borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           SizedBox(width:150,child: Text(value??"",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),
          InkWell(
              onTap: (){
                prefs?.remove(value);
              },
              child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: Color(0xffF57366),
                  child: Center(child: Icon(Icons.close,color: Colors.white,size: 16,)))),
        ],
      ),
    );
  }
}