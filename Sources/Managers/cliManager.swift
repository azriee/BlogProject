import Foundation

class CliManager {
  var userInput: String = ""
  var blogs = [Blog]()
  var newBlog: Blog = Blog()
  let fileURL = URL(fileURLWithPath: "Sources/blog.json")
  
  // Constructor
  init() {

    blogs.append(Blog(title: "asdhfasod", content: "adljkfhas"))

    // Read the JSON data from the file and decode it back to the array of Blogs
    let jsonDecoder = JSONDecoder()
    do {
      let data = try Data(contentsOf: fileURL)
      let decodedObjects = try jsonDecoder.decode([Blog].self, from: data)
      blogs = decodedObjects
    } catch {
      print("Error reading data from file: \(error)")
    }

    Views.displayHomeMenu()
    // Loop to keep the program running until exit is selected.
    while true {
      getUserInput()
      switch userInput {
      case "view":
        viewBlogs()
      case "add":
        addBlog()
      case "exit":
        quit()
      case "":
        break
      default:
        Views.displayHomeMenu()
        print(userInput + " is not a valid input")
      }
    }

  }
  // Reads the user input and assigns it to UserInput.
  func getUserInput() {
    userInput = readLine() ?? ""
  }
  // Prints out all the blog titles.
  func showBlogs() {
    if blogs.count == 0 {
      print("There are no blogs, please add some.")
      return
    }

    print("Blog List:")
    for (index, blog) in blogs.enumerated() {
      print("   Blog # \(index + 1): \(blog.getTitle())")
    }
    print("End of List")
  }
  // This will show the content of the blog selected.
  func viewBlogs() {
    showBlogs()
    if blogs.count == 0 {
      return
    }

    print("Enter Blog # to view: ", terminator: "")
    getUserInput()

    if let BlogNumber: Int = Int(userInput) {
      let blogsRange = 0...blogs.count
      if blogsRange.contains(BlogNumber) {
        print("Title: \(blogs[BlogNumber-1].getTitle())")
        print("Content: \(blogs[BlogNumber-1].getContent())")
        editBlog(blog: blogs[BlogNumber - 1], index: BlogNumber - 1)
      }
    } else {
      print("Invalid Blog #")
    }
  }
  // This prompts the user to edit the blog selected.
  func editBlog(blog: Blog, index: Int) {
    print(".")
    print("edit or delete. input anything to do nothing")
    getUserInput()
    switch userInput {
    case "edit":
      print("Enter Title: ", terminator: "")
      getUserInput()
      blog.setTitle(title: userInput)
      print("Enter Content: ", terminator: "")
      getUserInput()
      blog.setContent(content: userInput)
      print("Blog \(index + 1) Edited")
    case "delete":
      blogs.remove(at: index)
      print("Blog \(index + 1) Deleted")
    default:
      return
    }
  }
  //this creates a new blog prompting the user for the title and content.
  func addBlog() {
    newBlog = Blog()
    print("Enter Title: ", terminator: "")
    getUserInput()
    newBlog.setTitle(title: userInput)
    print("Enter Content: ", terminator: "")
    getUserInput()
    newBlog.setContent(content: userInput)
    blogs.append(newBlog)
    print("Blog successfully added.")

  }
  // Saves the blogs to blog.json then exits the program
  func quit() {
    // Convert the array of objects to JSON data
    let jsonEncoder = JSONEncoder()
    guard let jsonData = try? jsonEncoder.encode(blogs) else {
      print("Error encoding data")
      return
    }
    // Write the JSON data to a file
    do {
      try jsonData.write(to: fileURL)
    } catch {
      print("Error writing data to file: \(error)")
    }
    exit(0)
  }
}
