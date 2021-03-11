import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/providers/provider_widget.dart';
import 'package:campus_benefit_app/providers/view_state_widget.dart';
import 'package:campus_benefit_app/ui/widgets/search_bar.dart';
import 'package:campus_benefit_app/view_models/course/course_page_model.dart';
import 'package:flutter/material.dart';

class CourseRG1OrderPage extends StatefulWidget {
  @override
  _CourseRG1OrderPageState createState() => _CourseRG1OrderPageState();
}

class _CourseRG1OrderPageState extends State<CourseRG1OrderPage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProviderWidget<RG1OrderDataListModel>(
            builder: (BuildContext context, RG1OrderDataListModel model,
                Widget child) {
              if (model.busy) {
                return ViewStateBusyWidget();
              }
              return CustomScrollView(slivers: <Widget>[
                SliverAppBar(
                  title: Text("订单详情"),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 12,
                      bottom: 12,
                      right: 12,
                      top: 10,
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: SearchBar(
                          searchBarWidth:
                              MediaQuery.of(context).size.width * 0.85,
                          hintText: "账号搜索",
                          controller: textEditingController,
                          onSearchTextChanged: (value) {
                            model.search = value;
                            model.searchRefresh();
                          },
                        )),
                        // GestureDetector(
                        //   child: new Container(
                        //     alignment: Alignment(0, 0),
                        //     margin: EdgeInsets.only(left: 12),
                        //     height: 32,
                        //     child: Text("搜索",
                        //         style: TextStyle(
                        //             color: Colors.black, fontSize: 14)),
                        //   ),
                        //   onTap: () {
                        //     model.search = textEditingController.text;
                        //     textEditingController.clear();
                        //     model.refresh();
                        //     FocusScope.of(context).requestFocus(FocusNode());
                        //   },
                        // )
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 5,
                        columns: [
                          DataColumn(
                            label: Text("操作"),
                          ),
                          DataColumn(label: Text("平台名")),
                          DataColumn(label: Text("学校名")),
                          DataColumn(label: Text("账号")),
                          DataColumn(label: Text("密码")),
                          DataColumn(label: Text("添加时间")),
                        ],
                        rows: List<DataRow>.generate(
                            model.list.length,
                            (index) => DataRow(cells: [
                                  DataCell(Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteName.courseRG1OrderCourse,
                                              arguments:
                                                  model.list[index].account);
                                        },
                                        child: Container(
                                          width: 70,
                                          height: 20,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '查看课程',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(2.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                                  DataCell(
                                      Text("${model.list[index].platform}")),
                                  DataCell(Text("${model.list[index].school}")),
                                  DataCell(
                                      Text("${model.list[index].account}")),
                                  DataCell(
                                      Text("${model.list[index].password}")),
                                  DataCell(Text("${model.list[index].date}")),
                                ])),
                      )),
                ),
              ]);
            },
            model: RG1OrderDataListModel(),
            onModelReady: (model) => model.initData()));
  }
}

class CourseRG1OrderCoursePage extends StatefulWidget {
  final String account;
  const CourseRG1OrderCoursePage({Key key, this.account}) : super(key: key);
  @override
  _CourseRG1OrderCoursePageState createState() =>
      _CourseRG1OrderCoursePageState();
}

class _CourseRG1OrderCoursePageState extends State<CourseRG1OrderCoursePage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProviderWidget<RG1OrderCourseDataListModel>(
            builder: (BuildContext context, RG1OrderCourseDataListModel model,
                Widget child) {
              if (model.busy) {
                return ViewStateBusyWidget();
              }
              return CustomScrollView(slivers: <Widget>[
                SliverAppBar(
                  title: Text("课程详情"),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 12,
                      bottom: 12,
                      right: 12,
                      top: 10,
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: SearchBar(
                          searchBarWidth:
                              MediaQuery.of(context).size.width * 0.85,
                          hintText: "账号搜索",
                          controller: textEditingController,
                          onSearchTextChanged: (value) {
                            model.search = value;
                            model.searchRefresh();
                          },
                        )),
                        // GestureDetector(
                        //   child: new Container(
                        //     alignment: Alignment(0, 0),
                        //     margin: EdgeInsets.only(left: 12),
                        //     height: 32,
                        //     child: Text("搜索",
                        //         style: TextStyle(
                        //             color: Colors.black, fontSize: 14)),
                        //   ),
                        //   onTap: () {
                        //     model.search = textEditingController.text;
                        //     textEditingController.clear();
                        //     model.refresh();
                        //     FocusScope.of(context).requestFocus(FocusNode());
                        //   },
                        // )
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 5,
                        columns: [
                          DataColumn(
                            label: Text("操作"),
                          ),
                          DataColumn(label: Text("状态")),
                          DataColumn(label: Text("课程名")),
                          DataColumn(label: Text("平台名")),
                          DataColumn(label: Text("账号")),
                          DataColumn(label: Text("时间")),
                        ],
                        rows: List<DataRow>.generate(
                            model.list.length,
                            (index) => DataRow(cells: [
                                  DataCell(Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          model
                                              .extraBrush(model.list[index].id);
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 20,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '补刷',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(2.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                                  DataCell(Text("${model.list[index].status}")),
                                  DataCell(
                                      Text("${model.list[index].courseName}")),
                                  DataCell(Text(
                                      "${model.list[index].platformName}")),
                                  DataCell(
                                      Text("${model.list[index].username}")),
                                  DataCell(
                                      Text("${model.list[index].createDate}")),
                                ])),
                      )),
                ),
              ]);
            },
            model: RG1OrderCourseDataListModel(widget.account),
            onModelReady: (model) => model.initData()));
  }
}
