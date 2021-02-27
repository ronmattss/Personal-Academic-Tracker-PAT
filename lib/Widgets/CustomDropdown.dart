import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget
{
  final List<String> selections;
  final Function(String) onSelect;

  const CustomDropDown({Key key, this.selections, this.onSelect}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CustomDropDownState();

}

class _CustomDropDownState extends State<CustomDropDown> {
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedLocation ="A";

  @override
  void initState() {
    // TODO: implement initState
    _selectedLocation = widget.selections[0];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text(_selectedLocation), // Not necessary for Option 1
      value: _selectedLocation,
      onChanged: (newValue) {
        setState(() {
          _selectedLocation = newValue;
          print('$_selectedLocation $newValue');
         // widget.onSelect(_selectedLocation);
        });
      },
      items: widget.selections.map((location) {
        return DropdownMenuItem(
          child: new Text(location),
          value: location,
        );
      }).toList(),
    );

  }
}