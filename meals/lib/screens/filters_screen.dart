import 'package:flutter/material.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(
    this.currentFilters,
    this.saveFilters,
  );

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;
  bool _vegan = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vagan'];

    super.initState();
  }

  Widget _buildListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          title: Text(title),
          subtitle: Text(description),
          value: currentValue,
          onChanged: updateValue,
        ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          _buildListTile(
            'Gluten-free',
            'Only include gluten-free meals.',
            _glutenFree,
            (newValue) {
              setState(
                () {
                  _glutenFree = newValue;
                },
              );
            },
          ),
          _buildListTile(
            'Lactose-free',
            'Only include gluten-free meals.',
            _lactoseFree,
            (newValue) {
              setState(
                () {
                  _lactoseFree = newValue;
                },
              );
            },
          ),
          _buildListTile(
            'Vegetarian',
            'Only include vegetarian meals.',
            _vegetarian,
            (newValue) {
              setState(
                () {
                  _vegetarian = newValue;
                },
              );
            },
          ),
          _buildListTile(
            'Vegan',
            'Only include Vegan meals.',
            _vegan,
            (newValue) {
              setState(
                () {
                  _vegan = newValue;
                },
              );
            },
          ),
          Expanded(
            child: SizedBox(),
          ),
          RaisedButton(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            color: Theme.of(context).primaryColor,
            child: Text(
              'SAVE',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vagan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);

              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
