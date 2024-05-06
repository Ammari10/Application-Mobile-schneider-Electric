import 'package:flutter/material.dart';

const decorationTextField =  InputDecoration(
                     
                      // To Delete borders
                      enabledBorder: OutlineInputBorder(
                        borderSide:BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      //fill Color : Colors.red,
                      filled: true,
                      contentPadding: EdgeInsets.all(8),
                    );




















