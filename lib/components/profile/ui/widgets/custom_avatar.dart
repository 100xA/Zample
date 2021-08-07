import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zample/components/profile/bloc/cubit/profile_cubit.dart';
import 'package:zample/core/services/service_locator.dart';

class CustomAvatar extends StatelessWidget {
  final String imageUrl;

  const CustomAvatar({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => app.get<ProfileCubit>().pickNewImage(context),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? "assets/images/blank-profile-picture.png",
              imageBuilder: (context, imageProvider) => Container(
                width: 130,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
              ),
              errorWidget: (context, url, error) => ClipRRect(
                child: Image.asset('assets/images/blank-profile-picture.png'),
              ),
            )));
  }
}
