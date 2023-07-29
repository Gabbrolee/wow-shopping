import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wow_shopping/app/assets.dart';
import 'package:wow_shopping/app/theme.dart';
import 'package:wow_shopping/models/product_item.dart';
import 'package:wow_shopping/utils/formatting.dart';
import 'package:wow_shopping/widgets/common.dart';

@immutable
class WishlistItem extends StatelessWidget {
  const WishlistItem({
    super.key,
    required this.item,
    required this.onPressed,
    this.onToggleSelection,
    this.selected,
  });

  final ProductItem item;
  final ValueChanged<ProductItem> onPressed;
  final void Function(ProductItem item, bool value)? onToggleSelection;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: appButtonRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onPressed(item),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              horizontalMargin24,
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 112.0,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Ink.image(
                      image: AssetImage(item.photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              horizontalMargin12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    verticalMargin4,
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      item.subTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: AppTheme.of(context).appColorLight,
                      ),
                      maxLines: 1,
                    ),
                    verticalMargin8,
                    Text(
                      formatCurrency(item.price),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      formatCurrency(item.priceWithTax),
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                    ),
                    verticalMargin4,
                  ],
                ),
              ),
              if (selected case bool selected) //
                InkResponse(
                  onTap: onToggleSelection != null //
                      ? () => onToggleSelection!.call(item, !selected)
                      : null,
                  child: Padding(
                    padding: allPadding24,
                    child: SvgPicture.asset(
                      selected //
                          ? Assets.iconCheckFilled
                          : Assets.iconCheckEmpty,
                    ),
                  ),
                )
              else
                horizontalMargin24,
            ],
          ),
        ),
      ),
    );
  }
}