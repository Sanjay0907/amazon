import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/provider/user_data_provider.dart';
import '../../../../model/user_model.dart';
import '../../../../utils/colors.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    UserModel userData = Provider.of<UserDataProvider>(context).userModel;
    return Container(
      height: height * 0.05,
      width: width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 114, 226, 221),
        Color.fromARGB(255, 162, 236, 233)
      ])),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined),
          Expanded(
            child: Text(
              'Deliver to ${userData.name}-${userData.address}',
              overflow: TextOverflow.ellipsis,
              style: textTheme.headline5!
                  .copyWith(color: black, fontWeight: FontWeight.w700),
            ),
          ),
          const Icon(Icons.arrow_drop_down_sharp)
        ],
      ),
    );
  }
}
