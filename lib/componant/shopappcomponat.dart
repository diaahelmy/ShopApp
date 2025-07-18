import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/log_addacount/cubit/ShopHomeViewModel.dart';
import 'package:shopapp/model/productmodel.dart';
import 'package:shopapp/screen/ShopHomeScreen.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinsh(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
  (Route<dynamic> route) => false,
);
Widget buildProductCard({required ProductModel product , required BuildContext  context} )  =>
   Container(
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((0.1 * 255).round()),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  product.images.first,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(Icons.favorite_border, size: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),

              const SizedBox(height: 6),
              Text(
                '${product.price} EGP',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey,

                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
Widget productBuilder({
  required List<ProductModel> products,
  required ScrollController scrollController,
  bool showCategories = true,
  List<CategoryModel> categories = const [],
}) =>
    SafeArea(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showCategories) buildCategoryList(categories),
              GridView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.58,
                ),
                itemBuilder: (context, index) =>
                    buildProductCard(product: products[index], context: context),
              ),
            ],
          ),
        ),
      ),
    );


Widget defaultFormField({
  Function(String)? onSubmit,
  Function(String)? onChange,
  required TextEditingController controler,
  required TextInputType type,
  String? Function(String?)? validator,
  bool obscuretext = false,
  required IconData prefix,
  IconData? suffixIcon,
  required String lable,
  VoidCallback? click,
  bool isClickable = true,
  VoidCallback? onSuffixTap,
}) => TextFormField(
  obscureText: obscuretext,
  controller: controler,
  keyboardType: type,
  onTap: click,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validator,
  decoration: InputDecoration(
    suffixIcon: suffixIcon != null
        ? IconButton(icon: Icon(suffixIcon), onPressed: onSuffixTap)
        : null,
    labelText: lable,
    prefixIcon: Icon(prefix),
    border: OutlineInputBorder(),
  ),
);

Widget defaultButton({
  required String label,
  required VoidCallback onPressed,
  Color? backgroundColor,
}) => SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    child: Text(
      label,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),
);

String? validateRequiredField(String? value, String label) {
  if (value == null || value.isEmpty) {
    return 'Please enter your $label';
  }
  return null;
}

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { Success, Error, Warning }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.Success:
      color = Colors.green;
      break;
    case ToastStates.Error:
      color = Colors.red;
      break;
    case ToastStates.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}
