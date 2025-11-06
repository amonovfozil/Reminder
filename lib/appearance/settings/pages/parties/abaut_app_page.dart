import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../core/constants/const_data.dart';
import '../../../../core/UI/screens/custom_backgraund_style.dart';

class AbautAppPage extends StatelessWidget {
  const AbautAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgraundStyle(
      title: 'Abaut App',
      appbar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 60,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(CupertinoIcons.back, color: white, size: 32),
        ),
      ),
      headBody: Card(
        color: white.withOpacity(0.90),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        elevation: 1,
        borderOnForeground: false,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: borderWidth,
            color: context.borderColor.withOpacity(0.08),
          ),
          borderRadius: BorderRadius.circular(borderRadVal),
        ),
        child: Container(
          height: appSize.height / 1.35,
          padding: const EdgeInsets.symmetric(
            horizontal: paddingVal,
            vertical: 32,
          ),
          child: Column(
            children: [
              Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadVal),
                  border: Border.all(
                    width: 3,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: context.primaryColor,
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset('assets/dev/logo.jpg', fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        spacing: spacingVal,
        children: [SizedBox(height: 20, width: double.infinity)],
      ),
    );
  }
}
