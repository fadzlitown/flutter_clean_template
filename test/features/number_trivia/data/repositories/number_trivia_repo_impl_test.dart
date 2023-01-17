import 'package:flutter_clean_arch_template/core/platform/network_info.dart';
import 'package:flutter_clean_arch_template/number_trivia/data/data_sources/number_trivia_local_data.dart';
import 'package:flutter_clean_arch_template/number_trivia/data/data_sources/number_trivia_remote_data.dart';
import 'package:flutter_clean_arch_template/number_trivia/data/repositories/number_trivia_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepoImpl repo;
  MockRemoteDataSource mockRemoteData;
  MockLocalDataSource mockLocalData;
  MockNetworkInfo mockNetwork;

  setUp(() {
    mockRemoteData = MockRemoteDataSource();
    mockLocalData = MockLocalDataSource();
    mockNetwork = MockNetworkInfo();
    repo = NumberTriviaRepoImpl(mockRemoteData, mockLocalData, mockNetwork);
  });
}
