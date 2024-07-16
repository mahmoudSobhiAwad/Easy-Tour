import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/get_social_widget.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';

class ContactInfoButton extends StatelessWidget {
  const ContactInfoButton({super.key,
    required this.height,
    this.openLauncherApp,
    this.socialLinks
  });
  final double height;
  final Map<String, dynamic>?socialLinks;
  final void Function(int?index)?openLauncherApp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.11,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text('Contact Info', style: CustomTextStyle.fontNormal16),
          const Expanded(child: SizedBox(height: 10,)),
          ProfileSettingItem(
            height: height * 0.07,
            rightWidget: Row(
              children: [
                ...List.generate(socialLinks?.length ?? 0, (index) =>
                    GestureDetector(
                      onTap: () {
                        openLauncherApp!(
                            index
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: getSocialIcon(
                            socialLinks?.keys.elementAt(index) ?? ""),
                      ),
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}