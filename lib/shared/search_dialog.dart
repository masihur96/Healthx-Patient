import 'package:flutter/material.dart';
import 'package:healthx_patient/shared/providers/language_provider.dart';
import 'package:provider/provider.dart';

/// Generic search dialog for countries and divisions
class SearchDialog<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final T? selectedItem;
  final String Function(T item) getDisplayName;
  final String Function(T item) getDisplayNameBN;
  final String Function(T item)? getSubtitle;
  final String Function(T item)? getSubtitleBN;
  final Widget Function(T item)? getLeading;
  final bool Function(T item, String query) searchFilter;
  final Function(T item) onItemSelected;

  const SearchDialog({
    Key? key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.getDisplayName,
    required this.getDisplayNameBN,
    this.getSubtitle,
    this.getSubtitleBN,
    this.getLeading,
    required this.searchFilter,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<SearchDialog<T>> createState() => _SearchDialogState<T>();
}

class _SearchDialogState<T> extends State<SearchDialog<T>> {
  late TextEditingController _searchController;
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items
            .where((item) => widget.searchFilter(item, query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.search, size: 24, color: Colors.blue[700]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  color: Colors.grey[600],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Search field
            TextField(
              controller: _searchController,
              onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: languageProvider.isBangla ? "খুঁজুন..." : "Search...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _filterItems('');
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Results count
            if (_filteredItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  languageProvider.isBangla
                      ? "${_filteredItems.length} টি ফলাফল পাওয়া গেছে"
                      : "${_filteredItems.length} results found",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),

            // Items list
            Expanded(
              child: _filteredItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            languageProvider.isBangla
                                ? "কোন ফলাফল পাওয়া যায়নি"
                                : "No results found",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            languageProvider.isBangla
                                ? "অন্য কিছু খুঁজে দেখুন"
                                : "Try searching for something else",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        final isSelected = item == widget.selectedItem;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue[50]
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: isSelected
                                ? Border.all(color: Colors.blue[300]!, width: 1)
                                : null,
                          ),
                          child: ListTile(
                            leading: widget.getLeading?.call(item) ??
                                Icon(
                                  isSelected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  color: isSelected
                                      ? Colors.blue[700]
                                      : Colors.grey[600],
                                ),
                            title: Text(
                              languageProvider.isBangla
                                  ? widget.getDisplayNameBN(item)
                                  : widget.getDisplayName(item),
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: isSelected
                                    ? Colors.blue[700]
                                    : Colors.black87,
                              ),
                            ),
                            subtitle: (widget.getSubtitle != null &&
                                    widget.getSubtitleBN != null)
                                ? Text(
                                    languageProvider.isBangla
                                        ? widget.getSubtitleBN!(item)
                                        : widget.getSubtitle!(item),
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  )
                                : null,
                            onTap: () {
                              widget.onItemSelected(item);
                              // Don't call Navigator.pop here - let the onItemSelected handle it
                            },
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
