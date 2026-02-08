import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_evntly/provider/home_page_provider.dart';

import '../../core/firebase_functions.dart';
import '../../models/task_model.dart';
import '../../provider/home_provider.dart';

class HomeTabs2 extends StatelessWidget {
  static const String routeName ="HomeTabs2";
   HomeTabs2({super.key});

  DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>HomePageProvider()..getTasksStream()),

      ],

              builder: (context,child){
        // var provider=Provider.of<HomePageProvider>(context);
        final provider = context.watch<HomePageProvider>();
        return Container(


            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                      height: 50,
                      child:
                      ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(width: 12),
                        itemCount:provider.Categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              provider.changeCategories(index);
                            },
                            child: Chip(label: Text(
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                color: index != provider.selectedCategoriesIndex
                                    ? Theme
                                    .of(context)
                                    .colorScheme
                                    .primary
                                    : Colors.white,
                              ),
                              provider.Categories[index].replaceAll("_", ' ').toUpperCase(),
                            ),
                              backgroundColor: index == provider.selectedCategoriesIndex ?
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .primary
                                  : Colors.white,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),

                            ),
                          );
                        },
                      ),

                  ),


                  Expanded(
                    child:provider.tasks.isEmpty?
                    Center(child: Text("No Tasks Found",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF1C1C1C),
                        fontWeight: FontWeight.w600,
                      ),
                    ))
                        : ListView.separated(
                      itemCount: provider.tasks.length,
                      separatorBuilder: (context,index){
                        return SizedBox(height: 12);
                      },
                      itemBuilder: (context,index){
                        return Container(
                          color: Color(0xFFF0F0F0),
                          height: 193,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.asset("assets/images/${provider.tasks[index].category}.png",
                                  width: double.infinity,
                                  fit: BoxFit.cover,),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      formatter.format(
                                        DateTime.fromMicrosecondsSinceEpoch(
                                            provider.tasks[index].date),
                                      ),

                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).colorScheme.primary),),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF0F0F0),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              provider.tasks[index].title,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF1C1C1C))),
                                          InkWell(
                                            onTap: (){
                                              var task=provider.tasks[index];
                                              task.isFavorite=!task.isFavorite;
                                              provider.updateTask(task);
                                            },
                                            child: Icon(
                                                provider.tasks[index].isFavorite?
                                                Icons.favorite:
                                                Icons.favorite_border),),
                                        ],
                                      )
                                  )
                                ],
                              )

                            ],
                          ),
                        );
                      },

                    ),
                  ),
                ],
              ),

            )


        );
              }

    );


  }
}
