//
//  RestViewController.swift
//  restAPI
//
//  Created by Fayik Muzammil on 7/28/20.
//  Copyright © 2020 Fayik Muzammil. All rights reserved.
//

import UIKit

struct Course: Decodable {
   var id: Int?
   var name: String?
   var link: String?
   var imageUrl: String?
 

//init(json: [String: Any]) {
//        id = json["id"] as? Int ?? -1
//        name = json["name"] as? String ?? ""
//        link = json["link"] as? String ?? ""
//        imageUrl = json["imageUrl"] as? String ?? ""
//  }
}

// POST //struct Post: Decodable {
//var id: Int?
//var userId: Int?
//var title: String?
//var body: String?
//
//}

struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course]
}

class RestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let course = Course(id: 1, name: "Fayik99", link: "ABCD", imageUrl: "FEGHY")
//        print(course)
         
           // 1
        // let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/course"
          // 2 method array
       //  let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
       //  let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
       //  let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
        
        
       // guard let url = URL(string: jsonUrlString) else { return }
         
    
   // GET //   let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/course"
        
        let jsonUrlString = "https://jsonplaceholder.typicode.com/posts"
            
        
        var paramsDictionary = [String:Any]()

        paramsDictionary["userId"] = 12312
        paramsDictionary["id"]    = 21412
        paramsDictionary["title"]    = "titie 1"
        paramsDictionary["body"]    = "body 1"
        
HttpClientApi.instance().makeAPICall(url: jsonUrlString, params: paramsDictionary, method: .POST, success: { (data, response, error) in
        print("data loaded")
        
          guard let data = data else { return }
    
                       do {
                           let post = try JSONDecoder().decode(Post.self, from: data)
    
                           print(post)
    
                       } catch let jsonError {
                           print("Decode Error ", jsonError)
                       }
                   }) { (data, response, error) in
                       print("wrong api call", error)
                   }
        
        
        
        
        
        
        
        
// GET //        HttpClientApi.instance().makeAPICall(url: jsonUrlString, params: nil, method: .GET, success: { (data, response, error) in
//                   print("data loaded")
//
//                   guard let data = data else { return }
//
//                   do {
//                       let course = try JSONDecoder().decode(Course.self, from: data)
//
//                       print(course)
//
//                   } catch let jsonError {
//                       print("Decode Error ", jsonError)
//                   }
//               }) { (data, response, error) in
//                   print("wrong api call", error)
//               }
// GET
            
        
        
        
        
         //  URLSession.shared.dataTask(with: url) { ( data, response, error) in
          //  guard let data =  data else { return }
//            let dataString = String(data: data, encoding: .utf8)
            
        //    do {
                //swift 4 and above
                //let courses = try JSONDecoder().decode(Course.self, from: data)
               // print(courses)
               // print(courses.name)
            
                //All the courses [array]
//                let courses = try JSONDecoder().decode([Course].self, from: data)
//                print(courses[2].name)
               
//            let courses = try JSONDecoder().decode(WebsiteDescription.self, from: data)
//              //  print(courses.courses)
//                print(courses.courses[0].name)
//
//            let courses = try JSONDecoder().decode([Course].self, from: data)
//                print(courses)
//
//             } catch let jsonErr {
//                print("Decode Error", jsonErr)
//                }
//
//        }.resume()
        
    }
    
}

