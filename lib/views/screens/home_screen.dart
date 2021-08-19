import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_proj/constants/enums.dart';
import 'package:flutter_bloc_proj/cubits/counter_cubit.dart';
import 'package:flutter_bloc_proj/cubits/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          context.bloc<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          context.bloc<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: widget.color,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Wifi)
                  return Text(
                    'Connected to WIFI',
                    style: TextStyle(color: Colors.pink, fontSize: 30),
                  );
                else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Mobile)
                  return Text(
                    'Connected to MOBILE DATA',
                    style: TextStyle(color: Colors.pink, fontSize: 30),
                  );
                else if (state is InternetDisconnected)
                  return Text(
                    'Disconnected',
                    style: TextStyle(color: Colors.pink, fontSize: 30),
                  );
                return CircularProgressIndicator();
              }),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    backgroundColor: widget.color,
                    heroTag: Text('${widget.title}'),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Decremented!"), duration: Duration(milliseconds: 300),));
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    backgroundColor: widget.color,
                    heroTag: Text('${widget.title} #2'),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incremented!"), duration: Duration(milliseconds: 300),));
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
                  Navigator.pushNamed(context, '/second');
                },
                child: Text("Go to the Second Screen"),
                color: widget.color,
              ),
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/third');
                },
                child: Text("Go to the Third Screen"),
                color: widget.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
