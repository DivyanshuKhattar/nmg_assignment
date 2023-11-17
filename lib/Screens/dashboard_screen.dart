import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nmg_assignment/CommonClasses/common_functions.dart';
import 'package:nmg_assignment/ModelClasses/ProductModel/author_details_list.dart';
import 'package:nmg_assignment/ModelClasses/ProductModel/post_list_model.dart';
import 'package:nmg_assignment/Resources/api_call.dart';
import 'package:nmg_assignment/Resources/color_picker.dart';
import 'package:nmg_assignment/Resources/controllers.dart';
import 'package:nmg_assignment/Resources/custom_style.dart';
import 'package:nmg_assignment/Resources/string_constant.dart';
import 'package:nmg_assignment/Screens/post_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;
  List<AuthorDetailModel> authorList = [];
  List<PostListModel> postList = [];
  List authorNames = [];
  bool dataFetched = false;
  final ControllerOfGetx getController = Get.put(ControllerOfGetx());

  @override
  void initState() {
    CommonFunction.darkStatusBarColor(greenColor);
    fetchPostList().then((value) {
      fetchAuthorList();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// function to FETCH POST LIST
  Future fetchPostList() async{
    setState(() {
      dataFetched = false;
      postList.clear();
    });
    try{
      final response = await Util.getPostListData();
      final postResponse = postListModelFromJson(response);
      if(postResponse.isNotEmpty){
        setState(() {
          postList = postResponse;
        });
      }
    }
    catch(e){
      dataFetched = true;
      debugPrint(e.toString());
    }
  }

  /// function to FETCH AUTHOR LIST
  Future fetchAuthorList() async{
    setState(() {
      authorList.clear();
    });
    try{
      final response = await Util.getAuthorList();
      final authorResponse = authorDetailModelFromJson(response);
      if(authorResponse.isNotEmpty){
        setState(() {
          authorList = authorResponse;
        });
      }
      filterAuthor();
      setState(() {
        dataFetched = true;
      });
    }
    catch(e){
      dataFetched = true;
      debugPrint(e.toString());
    }
  }

  /// function to FILTER AUTHOR NAME
  void filterAuthor(){
    for(int i=0; i<postList.length; i++){
      for(int j=0; j<authorList.length; j++){
        if(postList[i].userId == authorList[j].id){
          authorNames.add(authorList[j].name);
          break;
        }
      }
      getController.dataList.add([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants().productList),
      ),
      body: dataFetched == true
      ? postList.isNotEmpty && authorNames.isNotEmpty
        ? ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: postList.length,
          itemBuilder: (BuildContext context, int index){
            var postData = postList[index];
            return displayCardWidget(postData, index);
          },
        )
        : Center(
          child: Text(
            StringConstants().noDataFound,
            style: CustomStyle.twelveNormalBlackText,
          ),
        )
      : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// widget to DISPLAY THE CARD
  Widget displayCardWidget(PostListModel? postData, int index){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailScreen(
              postId: postData.id!,
              authorName: authorNames[index],
              index: index,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: lightGreenColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: deviceWidth*0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: deviceWidth*0.8,
                    child: Text(
                      postData!.title!,
                      style: CustomStyle.fourteenSemiBoldBlackText,
                    ),
                  ),
                  SizedBox(height: deviceHeight*0.01,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.face,
                        color: greenColor,
                        size: deviceHeight*0.024,
                      ),
                      SizedBox(width: deviceWidth*0.02,),
                      SizedBox(
                        width: deviceWidth*0.5,
                        child: Text(
                          authorNames[index],
                          style: CustomStyle.twelveNormalBlackText,
                        ),
                      ),

                      const Spacer(),
                      Icon(
                        Icons.comment,
                        color: greenColor,
                        size: deviceHeight*0.024,
                      ),
                      SizedBox(width: deviceWidth*0.02,),
                      Obx(() => Text(
                        "${getController.dataList[index].length}",
                        style: CustomStyle.twelveNormalBlackText,
                      )),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: greenColor,
              size: deviceHeight*0.024,
            ),
          ],
        ),
      ),
    );
  }
}
