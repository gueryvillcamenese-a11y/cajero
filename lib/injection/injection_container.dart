import 'package:cajero/data/repositories/product_repository_impl.dart';
import 'package:cajero/data/repositories/user_repository_impl.dart';
import 'package:cajero/data/repositories/reports_repository_impl.dart';
import 'package:cajero/data/repositories/supervision_repository_impl.dart';
import 'package:cajero/domain/repositories/i_product_repository.dart';
import 'package:cajero/domain/repositories/i_user_repository.dart';
import 'package:cajero/domain/repositories/i_reports_repository.dart';
import 'package:cajero/domain/usecases/product/get_products_usecase.dart';
import 'package:cajero/domain/usecases/user/login_usecase.dart';
import 'package:cajero/domain/usecases/reports/get_shift_summary_usecase.dart';
import 'package:cajero/domain/usecases/supervision/get_supervision_data_usecase.dart';

class InjectionContainer {
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;
  InjectionContainer._internal();

  // Repositories
  late final IUserRepository userRepository = UserRepositoryImpl();
  late final IProductRepository productRepository = ProductRepositoryImpl();
  late final IReportsRepository reportsRepository = ReportsRepositoryImpl();
  late final ISupervisionRepository supervisionRepository = SupervisionRepositoryImpl();

  // Use Cases
  late final LoginUseCase loginUseCase = LoginUseCase(userRepository);
  late final GetProductsUseCase getProductsUseCase = GetProductsUseCase(productRepository);
  late final GetShiftSummaryUseCase getShiftSummaryUseCase = GetShiftSummaryUseCase(reportsRepository);
  late final GetSupervisionDataUseCase getSupervisionDataUseCase = GetSupervisionDataUseCase(supervisionRepository);
}

final sl = InjectionContainer(); // sl stands for Service Locator
