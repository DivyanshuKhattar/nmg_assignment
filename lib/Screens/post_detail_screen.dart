import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nmg_assignment/ModelClasses/ProductModel/post_content_model.dart';
import 'package:nmg_assignment/Resources/api_call.dart';
import 'package:nmg_assignment/Resources/color_picker.dart';
import 'package:nmg_assignment/Resources/controllers.dart';
import 'package:nmg_assignment/Resources/custom_style.dart';
import 'package:nmg_assignment/Resources/string_constant.dart';

class PostDetailScreen extends StatefulWidget {
  final int index;
  final int postId;
  final String authorName;
  const PostDetailScreen({Key? key, required this.postId, required this.authorName, required this.index}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;
  ProductContentModel? postData;
  bool dataFetched = false;
  TextEditingController commentController = TextEditingController();
  final ControllerOfGetx getController = Get.put(ControllerOfGetx());

  @override
  void initState() {
    fetchPostContent();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// function to FETCH POST CONTENT
  Future fetchPostContent() async{
    setState(() {
      postData = null;
    });
    try{
      final response = await Util.getPostDetail(widget.postId);
      final postResponse = productContentModelFromJson(response);
      if(postResponse.id != 0){
        setState(() {
          postData = postResponse;
        });
      }
      setState(() {
        dataFetched = true;
      });
    }
    catch(e){
      dataFetched = true;
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants().productDetailPage),
      ),
      body: dataFetched == true
      ? postData != null
        ? GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.05, vertical: deviceHeight*0.03,),
            child: Column(
              children: [
                /// body
                postCommentWidget(),
                SizedBox(height: deviceHeight*0.02,),
                /// footer
                sendCommentWidget(),
              ],
            ),
          ),
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

  /// widget to show the POST AND COMMENTS
  Widget postCommentWidget(){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              postData!.title!,
              style: CustomStyle.fourteenSemiBoldBlackText,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, deviceHeight*0.015, 0, deviceHeight*0.02),
              child: Text(
                postData!.body!,
                style: CustomStyle.twelveNormalBlackText,
              ),
            ),
            Container(
              width: deviceWidth,
              padding: EdgeInsets.fromLTRB(0, deviceHeight*0.015, 0, deviceHeight*0.02),
              child: Text(
                "~ ${widget.authorName}",
                style: CustomStyle.twelveNormalBlackText,
                textAlign: TextAlign.end,
              ),
            ),
            Divider(
              color: lightGreyColor.withOpacity(0.4),
              thickness: 2,
              endIndent: 20,
              indent: 20,
            ),
            /// comments
            ListView.builder(
              padding: EdgeInsets.only(top: deviceHeight*0.02),
              shrinkWrap: true,
              primary: false,
              itemCount: getController.dataList[widget.index].length,
              itemBuilder: (BuildContext context, int index){
                var data = getController.dataList[widget.index][index];
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: lightGreyColor.withOpacity(0.4),
                    ),
                    child: Text(
                      data,
                      style: CustomStyle.twelveNormalBlackText,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// widget to show the SEND COMMENT
  Widget sendCommentWidget(){
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: commentController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withOpacity(0.2),
              contentPadding: const EdgeInsets.fromLTRB(15, 11, 15, 11),
              hintText: "Enter Comment...",
              border: InputBorder.none,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: (){
            if(commentController.text.isNotEmpty){
              sendComment();
            }
          },
        )
      ],
    );
  }

  /// function to SEND COMMENT AND UPDATE THE COMMENT LIST
  Future sendComment() async{
    FocusManager.instance.primaryFocus?.unfocus();
    List commentList = getController.dataList[widget.index];
    setState(() {
      commentList.add(commentController.text.trim());
      commentController.clear();
    });
    getController.dataList[widget.index] = commentList;
  }
}
