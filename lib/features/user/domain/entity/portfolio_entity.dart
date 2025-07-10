import 'package:equatable/equatable.dart';

class PortfolioEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String image;
  final String link;

  const PortfolioEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.link,
  });

  factory PortfolioEntity.fromJson(Map<String, dynamic> json) {
    return PortfolioEntity(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      link: json['link'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, title, description, image, link];
}
