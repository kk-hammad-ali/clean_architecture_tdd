import 'package:clean_architecture_tdd/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultFutureVoid<T> = Future<Either<Failure, void>>;

typedef DataMap = Map<String, dynamic>;
