import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_proj/constants/enums.dart';
import 'package:flutter_bloc_proj/cubits/counter_cubit.dart';
import 'package:flutter_bloc_proj/cubits/internet_cubit.dart';
import 'package:flutter_bloc_proj/cubits/printer_cubit.dart';

class DifferentScreen extends StatefulWidget {
  DifferentScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _DifferentScreenState createState() => _DifferentScreenState();
}

class _DifferentScreenState extends State<DifferentScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(builder: (context, state) {
                if (state is InternetConnected && state.connectionType == ConnectionType.Wifi)
                  return Text('Connected to WIFI', style: TextStyle(
                      color: Colors.pink,
                      fontSize: 30
                  ),);
                else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile)
                  return Text('Connected to MOBILE DATA', style: TextStyle(
                      color: Colors.pink,
                      fontSize: 30
                  ),);
                else if (state is InternetDisconnected)
                  return Text('Disconnected', style: TextStyle(
                      color: Colors.pink,
                      fontSize: 30
                  ),);
                return CircularProgressIndicator();
              }),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Incremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } else if (state.wasIncremented == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Decremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.counterValue < 0) {
                    return Text(
                      'BRR, NEGATIVE ' + state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue % 2 == 0) {
                    return Text(
                      'YAAAY ' + state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else if (state.counterValue == 5) {
                    return Text(
                      'HMM, NUMBER 5',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  } else
                    return Text(
                      state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    );
                },
              ),
              SizedBox(
                height: 24,
              ),
              BlocBuilder<PrinterCubit, PrinterState>(
                builder: (context, state) {
                  return Text('The TEXT is: ' + state.text);
                },
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: Text('${widget.title}'),
                    backgroundColor: widget.color,
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                      // context.bloc<CounterCubit>().decrement();
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    backgroundColor: widget.color,
                    heroTag: Text('${widget.title} #2'),
                    onPressed: () {
                      // BlocProvider.of<CounterCubit>(context).increment();
                      context.bloc<CounterCubit>().increment();
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                onPressed: () {
                  BlocProvider.of<PrinterCubit>(context).addWord();
                },
                child: Text('Submit'),
                color: widget.color,
              ),
            ],
          ),
        ),
      );
  }
}
