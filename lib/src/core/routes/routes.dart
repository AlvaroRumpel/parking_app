import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/parking_space_data_source.dart';
import '../../data/data_sources/parking_space_data_source_impl.dart';
import '../../data/data_sources/price_data_source.dart';
import '../../data/data_sources/price_data_source_impl.dart';
import '../../data/repositories/parking_repository_impl.dart';
import '../../data/repositories/price_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/parking_space_repository.dart';
import '../../domain/repositories/price_repository.dart';
import '../../domain/usecases/parking_space/parking_space_usecase.dart';
import '../../domain/usecases/price/price_usecase.dart';
import '../../domain/usecases/user/login_usecase.dart';
import '../../presentation/blocs/login/login_cubit.dart';
import '../../presentation/blocs/parking_space/parking_space_cubit.dart';
import '../../presentation/pages/login/login_page.dart';
import '../../presentation/pages/parking_space/parking_space_page.dart';
import '../../presentation/pages/splash/splash_page.dart';

part 'routes_names.dart';

final routes = <String, Widget Function(BuildContext)>{
  SPLASH: (_) => const SplashPage(),
  LOGIN: (_) => RepositoryProvider(
        create: (context) => LoginUsecase(context.read<AuthRepository>()),
        child: BlocProvider(
          create: (context) => LoginCubit(context.read<LoginUsecase>()),
          child: const LoginPage(),
        ),
      ),
  PARKING_SPACE: (_) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ParkingSpaceDataSource>(
            create: (_) => ParkingSpaceDataSourceImpl(),
          ),
          RepositoryProvider<PriceDataSource>(
            create: (_) => PriceDataSourceImpl(),
          ),
          RepositoryProvider<ParkingSpaceRepository>(
            create: (context) => ParkingSpaceRepositoryImpl(
              context.read<ParkingSpaceDataSource>(),
            ),
          ),
          RepositoryProvider<PriceRepository>(
            create: (context) => PriceRepositoryImpl(
              context.read<PriceDataSource>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => AddParkingSpaceUsecase(
              context.read<ParkingSpaceRepository>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => FetchParkingSpacesUsecase(
              context.read<ParkingSpaceRepository>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => DeleteParkingSpaceUsecase(
              context.read<ParkingSpaceRepository>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => UpdateParkingSpaceUsecase(
              context.read<ParkingSpaceRepository>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => CalculatePriceUsecase(),
          ),
          RepositoryProvider(
            create: (context) => StartTimerUsecase(
              context.read<ParkingSpaceRepository>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => StopTimerUsecase(
              context.read<ParkingSpaceRepository>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => FetchPriceUsecase(
              repository: context.read<PriceRepository>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => UpdatePriceUsecase(
              repository: context.read<PriceRepository>(),
            ),
          ),
        ],
        child: BlocProvider(
          create: (context) => ParkingSpaceCubit(
            addUsecase: context.read<AddParkingSpaceUsecase>(),
            fetchUsecase: context.read<FetchParkingSpacesUsecase>(),
            deleteUsecase: context.read<DeleteParkingSpaceUsecase>(),
            updateUsecase: context.read<UpdateParkingSpaceUsecase>(),
            calculatePriceUsecase: context.read<CalculatePriceUsecase>(),
            startTimerUsecase: context.read<StartTimerUsecase>(),
            stopTimerUsecase: context.read<StopTimerUsecase>(),
            fetchPriceUsecase: context.read<FetchPriceUsecase>(),
            updatePriceUsecase: context.read<UpdatePriceUsecase>(),
          ),
          child: const ParkingSpacePage(),
        ),
      ),
};
