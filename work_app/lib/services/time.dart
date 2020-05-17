class Time {

  int studyTime;
  int breakTime;

  // CONSTRUCTOR FOR THIS Time class
  // WE ARE EXPECTING TO RECEIVE ALL OF THESE PARAMETERS WHEN WE CREATE A INSTANCE OF THIS Time Class.
  Time({this.studyTime, this.breakTime});

  Future<void> getTime() async {

    try{
      studyTime = studyTime + 0;
      breakTime = breakTime + 0;
    }
    catch(e) {
      print('HEY MARK THE ERROR IS $e');
    }
  }
}
