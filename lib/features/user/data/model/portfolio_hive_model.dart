import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:jobmaniaapp/core/constants/hive_table_constant.dart';
import 'package:jobmaniaapp/features/user/domain/entity/portfolio_entity.dart';

part 'portfolio_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.portfolioTableId)
class PortfolioHiveModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String link;

  PortfolioHiveModel({
    String? id,
    required this.title,
    required this.description,
    required this.image,
    required this.link,
  }) : id = id ?? const Uuid().v4();

  const PortfolioHiveModel.initial()
    : id = '',
      title = '',
      description = '',
      image = '',
      link = '';

  factory PortfolioHiveModel.fromEntity(PortfolioEntity entity) {
    return PortfolioHiveModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      image: entity.image,
      link: entity.link,
    );
  }

  PortfolioEntity toEntity() {
    return PortfolioEntity(
      id: id,
      title: title,
      description: description,
      image: image,
      link: link,
    );
  }

  @override
  List<Object?> get props => [id, title, description, image, link];
}
