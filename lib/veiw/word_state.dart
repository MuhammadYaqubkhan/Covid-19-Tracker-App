import 'package:covid_19_app/Model/world_states_model.dart';
import 'package:covid_19_app/services/states_services.dart';
import 'package:covid_19_app/veiw/country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WordStateScreen extends StatefulWidget {
  const WordStateScreen({Key? key}) : super(key: key);
  @override
  State<WordStateScreen> createState() => _WordStateScreenState();
}
class _WordStateScreenState extends State<WordStateScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorList = <Color> [
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
    ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01,),
              FutureBuilder(
                future: statesServices.fechWorldStatesRecords(),
                  builder: (context ,AsyncSnapshot<WorldStatesModel> snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    flex: 1,
                      child: SpinKitFadingCircle(
                        color : Colors.white,
                        size : 50.0,
                        controller: _controller
                      )
                  );
                }else{
                  return Column(
                    children: [
                      PieChart(
                        dataMap:{
                          //'total': 20,
                          "Total": double.parse(snapshot.data!.cases!.toString()),
                          "Recovered":double.parse(snapshot.data!.recovered.toString()),
                          "Death": double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions:const ChartValuesOptions(
                          showChartValuesInPercentage: true
                        ),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left
                        ),
                        animationDuration: Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorList,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                        child: Card(
                          child: Column(
                            children: [
                              //ReusbleRow(title: 'total',value: '200',),
                             ReusbleRow(title: 'Total',value: snapshot.data!.cases.toString()),
                             ReusbleRow(title: 'Deaths',value: snapshot.data!.deaths.toString()),
                             ReusbleRow(title: 'Recovered',value: snapshot.data!.recovered.toString()),
                             ReusbleRow(title: 'Active',value: snapshot.data!.active.toString()),
                             ReusbleRow(title: 'Critical',value: snapshot.data!.critical.toString()),
                             ReusbleRow(title: 'Today Deaths',value: snapshot.data!.todayDeaths.toString()),
                             ReusbleRow(title: 'Today Recovered',value: snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen()));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text('Track Countries'),
                          ),
                        ),
                      )
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
class ReusbleRow extends StatelessWidget {
  String title, value;
  ReusbleRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10 ,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
