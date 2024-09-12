import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:klontong_app/src/provisioning/domain/usecases/add_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/provisioning/data/datasources/provisioning_remote_data_source.dart';
import '../../src/provisioning/data/repositories/provisioning_repository_impl.dart';
import '../../src/provisioning/domain/repositories/provisioning_repository.dart';
import '../../src/provisioning/domain/usecases/delete_product.dart';
import '../../src/provisioning/domain/usecases/get_all_products.dart';
import '../../src/provisioning/domain/usecases/get_product_by_id.dart';
import '../../src/provisioning/domain/usecases/update_product.dart';
import '../../src/provisioning/presentation/bloc/provisioning_bloc.dart';
import '../services/api.dart';

part 'injection_container.main.dart';
