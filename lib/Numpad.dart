import 'package:flutter/material.dart';
import 'package:multimedia_demo/my_libraries/globals.dart';

class Numpad extends StatefulWidget {
  final length;
  final onChange;
  Numpad({Key? key, this.length, this.onChange}) : super(key: key);

  @override
  _NumpadState createState() => _NumpadState();
}

class _NumpadState extends State<Numpad> {
  String number = '';

  setValue(String val) {
    if (number.length < widget.length)
      setState(() {
        number += val;
        widget.onChange(number);
      });
  }

  backspace(String text) {
    if (text.length > 0) {
      setState(() {
        number = text.split('').sublist(0, text.length - 1).join('');
        widget.onChange(number);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 4 * SizeConfig.blockSizeHorizontal),
      child: Column(
        children: <Widget>[
          //Preview(text: number, length: widget.length),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '1',
                onPressed: () => setValue('1'),
              ),
              NumpadButton(
                text: '2',
                onPressed: () => setValue('2'),
              ),
              NumpadButton(
                text: '3',
                onPressed: () => setValue('3'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '4',
                onPressed: () => setValue('4'),
              ),
              NumpadButton(
                text: '5',
                onPressed: () => setValue('5'),
              ),
              NumpadButton(
                text: '6',
                onPressed: () => setValue('6'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '7',
                onPressed: () => setValue('7'),
              ),
              NumpadButton(
                text: '8',
                onPressed: () => setValue('8'),
              ),
              NumpadButton(
                text: '9',
                onPressed: () => setValue('9'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NumpadButton(haveBorder: false),
              Padding(
                  padding: EdgeInsets.only(
                      right: 2.5 * SizeConfig.blockSizeHorizontal)),
              NumpadButton(
                text: '0',
                onPressed: () => setValue('0'),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      right: 2 * SizeConfig.blockSizeHorizontal)),
              NumpadButton(
                haveBorder: false,
                icon: Icons.backspace,
                onPressed: () => backspace(number),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Preview extends StatelessWidget {
  final length;
  final text;
  const Preview({Key? key, this.length, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> previewLength = [];
    for (var i = 0; i < length; i++) {
      previewLength.add(Dot(isActive: text.length >= i + 1));
    }
    return Container(
        padding:
            EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.blockSizeVertical),
        child: Wrap(children: previewLength));
  }
}

class Dot extends StatelessWidget {
  final bool isActive;
  const Dot({Key? key, this.isActive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: 1.2 * SizeConfig.blockSizeHorizontal,
        height: 2.4 * SizeConfig.blockSizeVertical,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
          border: Border.all(width: 1.0, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}

class NumpadButton extends StatelessWidget {
  final text;
  final icon;
  final haveBorder;
  final onPressed;
  const NumpadButton(
      {Key? key, this.text, this.icon, this.haveBorder = true, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle = TextStyle(
        fontSize: 3.5 * SizeConfig.blockSizeVertical,
        color: Colors.black /*Theme.of(context).primaryColor*/);
    Widget label = icon != null
        ? Icon(
            icon,
            color: Colors.black.withOpacity(
                0.8) /*Theme.of(context).primaryColor.withOpacity(0.8)*/,
            size: 5.8 * SizeConfig.blockSizeVertical,
          )
        : Text(this.text ?? '', style: buttonStyle);

    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 1.6 * SizeConfig.blockSizeVertical),
      child: OutlinedButton(
        style: ButtonStyle(
          side: haveBorder
              ? MaterialStateProperty.all<BorderSide>(BorderSide(
                  color: Colors.black,
                ))
              : MaterialStateProperty.all<BorderSide>(BorderSide.none),
          //highlightedBorderColor: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.3),
          //splashColor: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.all(3.3 * SizeConfig.blockSizeVertical)),
          shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
        ),
        onPressed: onPressed,
        child: label,
      ),
    );
  }
}
