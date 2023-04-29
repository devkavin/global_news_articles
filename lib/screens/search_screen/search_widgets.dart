import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;

  const SearchBar({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search articles...',
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}

class FilterOptions extends StatefulWidget {
  final List<String> options;
  final void Function(String) onOptionSelected;

  const FilterOptions({
    Key? key,
    required this.options,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  late String _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var option in widget.options)
          FilterOption(
            option: option,
            isSelected: option == _selectedOption,
            onTap: () {
              setState(() {
                _selectedOption = option;
              });
              widget.onOptionSelected(option);
            },
          ),
      ],
    );
  }
}

class FilterOption extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterOption({
    Key? key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.blue : Colors.grey[200],
        ),
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
