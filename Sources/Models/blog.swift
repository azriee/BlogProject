class Blog: Codable {
  private var title: String
  private var content: String

  init(title: String, content: String) {
    self.title = title
    self.content = content
  }
  convenience init(){
    self.init(title: "",content: "")
  }
  func getTitle() -> String {
    return title
  }
  func setTitle(title: String) {
    self.title = title
  }

  func getContent() -> String {
    return content
  }
  func setContent(content: String) {
    self.content = content
  }
}
