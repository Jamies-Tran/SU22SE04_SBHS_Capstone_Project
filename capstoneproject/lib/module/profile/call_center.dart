import 'package:flutter/material.dart';

class CallCenter extends StatefulWidget {
  @override
  _CallCenterState createState() => _CallCenterState();
}

class _CallCenterState extends State<CallCenter> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  late String _name, _email, _problem;
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController problem = TextEditingController();

  void addData() {
   
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          title: const Text('Call Center',
              style: TextStyle(fontFamily: "Sofia", color: Colors.black)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 15.0),
          child: ListView(
            children: <Widget>[
              const Text(
                'Call Center',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    border: Border.all(width: 1.2, color: const Color(0xFFFFAB40))),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'callCenterDesc',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                        fontFamily: "Sans"),
                  ),
                ),
              ),
              Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      'Name',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15.0),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      // ignore: missing_return
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Please enter name';
                        }
                      },
                      onSaved: (input) => _name = input!,
                      controller: nama,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 16.0,
                          color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.black12.withOpacity(0.01))),
                        contentPadding: const EdgeInsets.all(13.0),
                        hintText: 'Input name',
                        hintStyle:
                            const TextStyle(fontFamily: "Sans", fontSize: 15.0),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text('email',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.0)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      // ignore: missing_return
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'please enter email';
                        }
                      },
                      onSaved: (input) => _email = input!,
                      controller: email,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 16.0,
                          color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.black12.withOpacity(0.01))),
                        contentPadding: const EdgeInsets.all(13.0),
                        hintText: 'Input email',
                        hintStyle:
                            const TextStyle(fontFamily: "Sans", fontSize: 15.0),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text('Detail Problem',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.0)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: TextFormField(
                        // ignore: missing_return
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Please Problem';
                          }
                        },
                        maxLines: 10,
                        onSaved: (input) => _problem = input!,
                        controller: problem,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: const TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.black12.withOpacity(0.01))),
                          contentPadding: const EdgeInsets.all(13.0),
                          hintText:
                              'Input Problem',
                          hintStyle:
                              const TextStyle(fontFamily: "Sans", fontSize: 15.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      onTap: () {
                        final formState = _form.currentState;

                        if (formState!.validate()) {
                          formState.save();
                          setState(() {});

                          addData();
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                      'Error'),
                                  content: const Text('Please enter information'),
                                  actions: <Widget>[
                                    TextButton (
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }
                      },
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color:  Color(0xFF09314F),
                            borderRadius:
                                BorderRadius.all( Radius.circular(40.0))),
                        child: const Center(
                          child: Text(
                            'Input data',
                            style: TextStyle(
                                fontFamily: "Popins",
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
