import 'package:campus_benefit_app/view_models/base/system_static_model.dart';
import 'package:campus_benefit_app/view_models/base/user_model.dart';
import 'package:campus_benefit_app/view_models/course/course_page_model.dart';
import 'package:campus_benefit_app/view_models/job/job_page_model.dart';
import 'package:campus_benefit_app/view_models/shop/shop_page_model.dart';
import 'package:campus_benefit_app/view_models/theme_model.dart';
import 'package:campus_benefit_app/view_models/user/user_page_model.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<ThemeModel>(
    create: (context) => ThemeModel(),
  ),
  ChangeNotifierProvider<UserModel>(
    create: (context) => UserModel(),
  ),
  ChangeNotifierProvider<SystemStaticModel>(
    create: (context) => SystemStaticModel(),
  ),
  ChangeNotifierProvider<BaseQQZJobDataListModel>(
    create: (context) => BaseQQZJobDataListModel(),
  ),
  ChangeNotifierProvider<YYCategoryDataListModel>(
    create: (context) => YYCategoryDataListModel(),
  ),
  ChangeNotifierProvider<YYGoodListModel>(
    create: (context) => YYGoodListModel(),
  ),
  ChangeNotifierProvider<CourseDataListModel>(
    create: (context) => CourseDataListModel(),
  ),
  ChangeNotifierProvider<EarnSumDataModel>(
    create: (context) => EarnSumDataModel(),
  ),
    ChangeNotifierProvider<CourseAutomationModel>(
    create: (context) => CourseAutomationModel(),
  ),
];

/// 需要依赖的model
///
/// UserModel依赖globalFavouriteStateModel
//List<SingleChildCloneableWidget> dependentServices = [
//  ChangeNotifierProxyProvider<GlobalFavouriteStateModel, UserModel>(
//    create: null,
//    update: (context, globalFavouriteStateModel, userModel) =>
//    userModel ??
//        UserModel(globalFavouriteStateModel: globalFavouriteStateModel),
//  )
//];

List<SingleChildCloneableWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
