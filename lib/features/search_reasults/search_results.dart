import 'package:flutter/material.dart';
import 'package:shoe_store/features/home_page/home_page_footer.dart';
import 'package:shoe_store/shared/models/product.dart';
import 'package:shoe_store/shared/widgets/custom_app_bar.dart';

class SearchResultsScreen extends StatelessWidget {
  final List<Product> searchResults;

  const SearchResultsScreen({
    this.searchResults = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Kết quả tìm kiếm",
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: searchResults.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Số cột
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65, // Tỉ lệ giữa chiều rộng và cao
          ),
          itemBuilder: (context, index) {
            return CaterogyCart(product: searchResults[index]);
          },
        ),
      ),
    );
  }
}
