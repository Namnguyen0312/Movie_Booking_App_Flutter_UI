import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/services/search_movie.dart';
import '../../../utils/constants.dart';

class SearchBarFirm extends StatefulWidget {
  const SearchBarFirm({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<SearchBarFirm> createState() => _SearchBarFirmState();
}

class _SearchBarFirmState extends State<SearchBarFirm> {
  late SearchMovie _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = SearchMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: kMinPadding, right: kDefaultPadding),
      child: SizedBox(
        height: widget.size.height / 24,
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              onTap: () {
                controller.openView();
              },
              onChanged: (String query) {
                _search(query);
                controller.openView();
              },
              leading: const Icon(Icons.search),
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List.generate(
              _searchController.filteredMovies.length,
              (int index) {
                final String item =
                    _searchController.filteredMovies[index].title;
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _search(String query) {
    _searchController.search(query); // Gọi hàm tìm kiếm từ SearchController
  }
}
