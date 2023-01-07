class SuccessfulStatus {
  int issueCounter;
  SuccessfulStatus(this.issueCounter);

  void showSuccessfulMessage() {
    if (issueCounter == 1) {
      print("🎉 A issue was created successfully 🎉");
    } else {
      print("🎉 $issueCounter issues were created successfully 🎉");
    }
  }
}
