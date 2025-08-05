import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/themes/theme_cubit/theme_cubit.dart';
import 'package:library_management/themes/theme_cubit/theme_state.dart';

class ChangeThemeColorWidget extends StatefulWidget {
  const ChangeThemeColorWidget({super.key});

  @override
  State<ChangeThemeColorWidget> createState() => _ChangeThemeColorWidgetState();
}

class _ChangeThemeColorWidgetState extends State<ChangeThemeColorWidget> {
  bool isExpanded = false;

  final List<Color> colors = [
    Color(0xffCF8F6E),
    Color(0xffFEACD0),
    Color(0xffF67676),
    Color(0xff83C7EE),
    Color(0xffE3ACF1),
    Color(0xffFDDD5C),
    Color(0xffB1CF86),
    Color(0xffFFB347),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).cardColor),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: ExpansionTile(
              tilePadding: EdgeInsets.symmetric(horizontal: 10),
              minTileHeight: 45,
              enableFeedback: false,
              leading: Icon(
                Icons.color_lens_rounded,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Change theme',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: Icon(
                isExpanded
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
              ),
              onExpansionChanged: (expanded) {
                setState(() {
                  isExpanded = expanded;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide.none,
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide.none,
              ),
              children: [
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 10),
                    shrinkWrap: true,
                    primary: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            context.read<ThemeCubit>().changePrimaryColor(
                              colors[index],
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: colors[index],
                            child: state.primaryColor == colors[index]
                                ? Icon(
                                    Icons.check_rounded,
                                    size: 20,
                                    color: Colors.white,
                                  )
                                : Container(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
