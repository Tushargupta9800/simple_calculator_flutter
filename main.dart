////////////////////////////////////////////////////////////////////////////////////
//                              Made by - Tushar Gupta                            //
//                                    In Flutter                                  //
////////////////////////////////////////////////////////////////////////////////////

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MaterialApp(
    home: Calc()
));

class Calc extends StatefulWidget {
  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  String num1 = '';
  String num2 = '';
  double number1 = 0.0;
  double number2 = 0.0;
  String output = '';
  String operand = "";
  bool isoperand = false;
  bool isnum1 = true;
  bool isnum2 = false;
  bool isnegative = false;
  bool iswedivide = false;

  whattodo(String button){
    if(button == '-'){
      if(isnum1 && num1.length == 0){
        setState(() {
          isnegative = true;
          num1 += button;
        });
      }else if(isnum2 && num2.length == 0){
        setState(() {
          isnegative = true;
          num2 += button;
        });
      }
    }
    if((button == '/' || button == '*' || button == '-' || button == '+') && isnegative == false){
      setState(() {
        if((output != 'To lengthy number' || output != 'To lengthy output') && isnum2 == true && output.length < 12){
          num1 = output;
          output = '';
          num2 = '';
          isoperand = true;
          isnum1 = false;
          isnum2 = true;
          iswedivide = false;
          operand = button;
        }else if(output != 'To lengthy number' && isnum1 == true){
          isoperand = true;
          isnum1 = false;
          isnum2 = true;
          iswedivide = false;
          operand = button;}
      });
    }else if(button == '0' || button == '1' || button == '2' || button == '3' || button == '4' || button == '5'|| button == '6'|| button == '7'|| button == '8'|| button == '9'){
      isoperand = false;
      isnegative = false;
      if(isnum1){
        setState(() {
          if(output != 'To lengthy number' && num1.length < 12){
            num1 += button;}
          if(num1.length > 14){
            output = 'To lengthy number';
          }
        });
      }else if(isnum2){
        setState(() {
          if(output != 'To lengthy number' && num2.length < 12){
            num2 += button;}
          if(num2.length > 14){
            output = 'To lengthy number';
          }
        });
      }
    }else if(button == 'clear'){
      setState(() {
        isnegative = false;
        num1 = '';
        num2 = '';
        output = '';
        operand = '';
        isnum1 = true;
        isnum2 = false;
        iswedivide = false;
      });
    }else if(button == '.' && iswedivide == false){
      iswedivide = true;
      isnegative = false;
      isoperand = false;
      if(isnum1){
        setState(() {
          num1 += button;
        });
      }else{
        setState(() {
          num2 += button;
        });
      }
    }else if(button == '=' && isnum2){
      if(num1 == ''){
        setState(() {
          number1 = double.parse('0.0');
          num1 = number1.toString();
        });

      }
      if(num2 == ''){
        setState(() {
          number2 = double.parse('0.0');
          num2 = number2.toString();
        });
      }
      number1 = double.parse(num1);
      number2 = double.parse(num2);
      if(operand == '+'){
        output = (number1 + number2).toStringAsFixed(5);
      }else if(operand == '-'){
        output = (number1 - number2).toStringAsFixed(5);
      }else if(operand == '*'){
        output = (number1 * number2).toStringAsFixed(5);
      }else if(operand == '/'){
        output = (number1 / number2).toStringAsFixed(5);
      }

      if(output.length > 18){
        setState(() {
          output = 'To lengthy output';
        });
      }else{
        setState(() {
          output = output;
          int i = output.length-1;
          while(output[i] == '0'){
            i-=1;
          }
          i+=1;
          output = output.substring(0, i);
        });
      }
    }else if(button == '<-'){
      setState(() {
        if(isnum1 && num1.length > 0){
          if(num1[num1.length - 1] == '.'){
            iswedivide = false;
          }
          if(num1[num1.length-1] == '-'){
            isnegative = false;
          }
          num1 = num1.substring(0, num1.length - 1);
          output = '';
        }else if(isoperand){
          operand = '';
          isnum1 = true;
          isnum2 = false;
        }else if(num2.length > 0){
          if(num2[num2.length - 1] == '-'){
            isnegative = false;
          }
          if(num2[num2.length - 1] == '.'){
            iswedivide = false;
          }
          num2 = num2.substring(0, num2.length - 1);
          output = '';
          if(num2.length == 0){
            isnum2 = true;
            isnum1 = false;
            isoperand = true;
          }
        }
      });
    }
  }

  Widget buildbutton(String button){
    return Expanded(
      child: Container(
        color: Colors.blue[100],
        child: OutlineButton(
          borderSide: BorderSide(width: 8.0),
          onPressed: () => whattodo(button),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              '$button',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Simple Calculator',
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Center(
              child: Text(
                '$num1',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Text(
                '$operand',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Text(
                '$num2',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Text(
                '$output',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(
            height: 24.0,
          ),
          Divider(
            color: Colors.black,
            thickness: 10.0,
            height: 15.0,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    buildbutton("7"),
                    buildbutton("8"),
                    buildbutton("9"),
                    buildbutton("/"),
                  ],
                ),
                Row(
                  children:[
                    buildbutton("4"),
                    buildbutton("5"),
                    buildbutton("6"),
                    buildbutton("*"),
                  ],
                ),
                Row(
                  children:[
                    buildbutton("1"),
                    buildbutton("2"),
                    buildbutton("3"),
                    buildbutton("-"),
                  ],
                ),
                Row(
                  children:[
                    buildbutton("."),
                    buildbutton("0"),
                    buildbutton("<-"),
                    buildbutton("+"),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:[
                    buildbutton("clear"),
                    buildbutton("="),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
