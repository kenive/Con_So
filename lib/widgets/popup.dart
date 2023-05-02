import 'package:flutter/material.dart';
import 'package:game_injoy/widgets/button_widget.dart';
import 'package:provider/provider.dart';

import '../helper/helper.dart';
import '../routes/route.dart';
import '../screens/tim_so/tim_so.dart';
import '../themes/app_colors.dart';

void popUpTimSo(BuildContext context) {
  var provider = Provider.of<TimSoLogic>(context, listen: false);
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      isDismissible: false,
      isScrollControlled: false,
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: provider,
          child: Container(
            height: MediaQuery.of(context).size.height / 3.5,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Số lượng ô',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorTextBlack,
                          ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Selector<TimSoLogic, int>(
                      selector: (p0, p1) => p1.valueSlider,
                      builder: (context, value, child) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '10',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.colorTextBlack,
                                      ),
                                ),
                                Text(
                                  value.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.colorTextBlack,
                                      ),
                                ),
                                Text(
                                  '100',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.colorTextBlack,
                                      ),
                                )
                              ],
                            ),
                            SliderTheme(
                              data: const SliderThemeData(
                                showValueIndicator: ShowValueIndicator.always,
                                valueIndicatorColor: Colors
                                    .blue, // This is what you are asking for
                                valueIndicatorTextStyle: TextStyle(
                                    color: AppColors.white, letterSpacing: 2.0),
                                // thumbShape: IndicatorRangeSliderThumbShape(
                                //     enabledThumbRadius: 12.0),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 20.0),
                              ),
                              child: Slider(
                                min: provider.minSlider,
                                max: provider.maxSlider,
                                divisions: 9,
                                label:
                                    int.parse(provider.valueSlider.toString())
                                        .toString(),
                                value: value.toDouble(),
                                onChanged: (value) {
                                  provider.changSlider(value);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ButtonWidget(
                          type: EButton.normal,
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          primary: AppColors.black,
                          child: Text(
                            'Đóng',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                    ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ButtonWidget(
                          type: EButton.normal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Tiếp tục',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                    ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, AppRoutes.timSo);
                            provider.startTimer();
                            provider.xuLyRanDom(
                                int.parse(provider.valueSlider.toString()));
                            // provider.timSo();
                          },
                        )
                      ],
                    ),
                    SizedBox(height: Helper.heightInsets(context))
                  ],
                ),
              ),
            ),
          ),
        );
      },
      context: context);
}

class IndicatorRangeSliderThumbShape<T> extends RangeSliderThumbShape {
  IndicatorRangeSliderThumbShape(this.start, this.end);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(15, 40);
  }

  T start;
  T end;
  late TextPainter labelTextPainter = TextPainter()
    ..textDirection = TextDirection.ltr;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool? isDiscrete,
    bool? isEnabled,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;
    final Paint strokePaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.yellow
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, 7.5, Paint()..color = Colors.white);
    canvas.drawCircle(center, 7.5, strokePaint);
    if (thumb == null) {
      return;
    }
    final value = thumb == Thumb.start ? start : end;
    labelTextPainter.text = TextSpan(
        text: value.toString(),
        style: const TextStyle(fontSize: 14, color: Colors.black));
    labelTextPainter.layout();
    labelTextPainter.paint(
        canvas,
        center.translate(
            -labelTextPainter.width / 2, labelTextPainter.height / 2));
  }
}
