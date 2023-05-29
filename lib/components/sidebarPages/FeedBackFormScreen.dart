import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rating_dialog/rating_dialog.dart';

class FeedBackFormScreen extends StatefulWidget {
  @override
  _FeedBackFormScreenState createState() => _FeedBackFormScreenState();
}

class _FeedBackFormScreenState extends State<FeedBackFormScreen> {
  final userfieldText = TextEditingController();
  final firstfieldText = TextEditingController();
  final lastfieldText = TextEditingController();
  final mobilefieldText = TextEditingController();
  final emailfieldText = TextEditingController();
  clearText() =>
      {
        userfieldText.clear(),
        firstfieldText.clear(),
        lastfieldText.clear(),
        mobilefieldText.clear(),
        emailfieldText.clear(),

      };
  String userName = '',
      firstName = '',
      lastName = '',
      mobileNumber = '',
      emailId = '';
  bool userNameError = false,
      nameError = false,
      mobileNumberError = false,
      emailIdError = false;
  var isExpandedValues = [false, false];
  var selected;
  var categorylist = ['KCR', 'KTR', 'MLA', 'MP'];

  Widget feedbackFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.text,
          onChanged: (value) => userName = value,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.blue, width: 1),
            ),
            labelText: 'User Name',
          ),
          controller: userfieldText,
        ),
        (userNameError
            ? Text('Please enter valid user name',
            style: TextStyle(color: Colors.red))
            : Container(height: 0)),
        Container(height: 20),
        TextFormField(
          keyboardType: TextInputType.phone,
          onChanged: (value) => mobileNumber = value,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.blue, width: 1),
            ),
            labelText: 'Mobile Number',
          ),
          controller: mobilefieldText,
        ),
        (mobileNumberError
            ? Text('enter only numbers', style: TextStyle(color: Colors.red))
            : Container(height: 0)),
        SizedBox(height: 20),
        /*Text.rich(
          TextSpan(
              text: 'Email Id',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                )
              ]
          ),
        ),
        SizedBox(height: 10),*/
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => emailId = value,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.blue, width: 1),
            ),
            labelText: 'Email ID',
          ),
          controller: emailfieldText,
        ),
        (emailIdError
            ? Text(
          'Please enter valid email address',
          style: TextStyle(color: Colors.red),
        )
            : Container(height: 0)),
        //SizedBox(height: 20),
       /* Text(
          'Category',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        DropdownButton<String>(
          isExpanded: true,
          hint: Text("Select Category"),
          value: selected,
          onChanged: (String? value) {
            setState(
                  () {
                selected = value;
              },
            );
          },
          items: categorylist.map(
                (String category) {
              return DropdownMenuItem<String>(
                value: category,
                child:
                Text(category),
              );
            },
          ).toList(),
        ),*/
        SizedBox(height: 20),
        /*Text.rich(
          TextSpan(
              text: 'What is the primary purpose of using this App',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                )
              ]
          ),
        ),
        SizedBox(height: 10),*/
        TextField(
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.blue, width: 1),
            ),
            labelText: 'What is the primary purpose of using this App',
          ),
        ),
        SizedBox(height: 10),
        /*Text(
          'What improvements you would like to suggest',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),*/
        TextField(
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.blue, width: 1),
            ),
            labelText: 'What improvements you would like to suggest',
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Please Rate The App',
          style: TextStyle(
              color: Colors.pinkAccent, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Container(
          child: Center(
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              color: Colors.pinkAccent,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'Show Some Love',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: _showRatingAppDialog,
            ),
          ),
        ),
      ],
    );
  }

  Widget feedbackOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        OutlinedButton.icon(
          onPressed: () {
            setState(() {
              /// validate userName
              userNameError = userName.length == 0;

              /// validate name
              nameError = !RegExp(r'^[a-zA-Z\s]*$').hasMatch(firstName) ||
                  !RegExp(r'^[a-zA-Z\s]*$').hasMatch(lastName);

              /// validate mobileNumber
              mobileNumberError = mobileNumber.length == 0;

              /// validate emailId
              emailIdError = !RegExp(
                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
                  .hasMatch(emailId);
            });
          },
          icon: Icon(Icons.check),
          label: Text("Submit"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue, side: BorderSide(color: Colors.blue),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {
            clearText();
            userName = '';
            firstName = '';
            lastName = '';
            mobileNumber = '';
            emailId = '';
          },
          icon: Icon(Icons.refresh),
          label: Text("Reset"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue, side: BorderSide(color: Colors.blue),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(""),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Rating & Reviews',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 50),
                        feedbackFields(),
                        Container(height: 20),
                        feedbackOptions()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      starSize: 30,
      //ratingColor: Colors.amber,
      title: Text('Rating Dialog'),
      message: Text('Rating this app and tell others what you think.'
          ' Add more description here if you want.', style: TextStyle(fontSize: 16),),
      /*image: Image.asset(
        "assets/PiLog_Logos-01.png",
        height: 100,
      ),*/
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating},'
            'comment: ${response.comment}');

        if (response.rating < 3.0) {
          print('response.rating: ${response.rating}');
        } else {
          Container();
        }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}
