import 'package:logger/logger.dart';
export 'package:Soulna/utils/nav.dart';
export 'package:flutter/material.dart';
export 'package:Soulna/generated/codegen_loader.g.dart';
export 'package:Soulna/generated/locale_keys.g.dart';
export 'package:Soulna/manager/alert_manager.dart';
export 'package:Soulna/models/appinfo_model.dart';
export 'package:Soulna/network/api_calls.dart';
export 'package:Soulna/network/error_code.dart';
export 'package:Soulna/network/network_manager.dart';
export 'package:Soulna/utils/const.dart';

export 'package:Soulna/utils/theme_setting.dart';
export 'package:Soulna/utils/utils.dart';
export 'package:Soulna/widgets/custom_button_widget.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:get_it/get_it.dart';
export 'package:go_router/go_router.dart';
export 'package:provider/provider.dart';
export 'package:Soulna/widgets/icon_button_widget.dart';

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 3,
    errorMethodCount: 8,
    lineLength: 4096,
    colors: true,
    printEmojis: false,
    printTime: false,
  ),
);