import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _items = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
  List<String> _filteredItems = [];
  String _sortOption = 'Ascending';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_items);
  }

  void _onSearch(String query) {
    setState(() {
      _errorMessage = '';
      try {
        _filteredItems = _items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (_filteredItems.isEmpty) {
          _errorMessage = 'No results found.';
        }
      } catch (e) {
        _errorMessage = 'An error occurred while searching.';
      }
    });
  }

  void _onSort(String option) {
    setState(() {
      _sortOption = option;
      if (option == 'Ascending') {
        _filteredItems.sort((a, b) => a.compareTo(b));
      } else {
        _filteredItems.sort((a, b) => b.compareTo(a));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _onSort,
            itemBuilder: (context) => [
              PopupMenuItem(value: 'Ascending', child: Text('Sort Ascending')),
              PopupMenuItem(value: 'Descending', child: Text('Sort Descending')),
            ],
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _onSearch('');
                      },
                    ),
                  ),
                  onChanged: _onSearch,
                ),
                SizedBox(height: 16),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                if (_errorMessage.isEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_filteredItems[index]),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
