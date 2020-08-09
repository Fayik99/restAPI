//
//  CreatePostViewController.swift
//  restAPI
//
//  Created by Fayik Muzammil on 8/3/20.
//  Copyright © 2020 Fayik Muzammil. All rights reserved.
//

import UIKit

protocol updateDataDelegate {
    func update(post: Post)
}

class CreatePostViewController: UIViewController {
    
    var delegate: updateDataDelegate?
    
    @IBOutlet weak var txtUserId: UITextField!
    @IBOutlet weak var txtPostTitle: UITextField!
    @IBOutlet weak var txtPostBody: UITextField!
    
    var postData: Post?

    override func viewDidLoad() {
        super.viewDidLoad()

        if(postData != nil) {
            txtUserId.text = "\(postData?.userId ?? 0)"
            txtPostBody.text = postData?.body
            txtPostTitle.text = postData?.title
            
        }
    }
    
    func savePost() {
         
        // post api call
        // navigate back to home page
        let jsonUrlString = "https://jsonplaceholder.typicode.com/posts"
        
        
        var paramsDictionary = [String:Any]()
        
        paramsDictionary["userId"] = 1
        paramsDictionary["title"]    = txtPostTitle.text
        paramsDictionary["body"]    = txtPostBody.text
        
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
        
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc: PostTableViewController = mainStoryboard.instantiateViewController(withIdentifier: "home") as! PostTableViewController
        
          self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func updatePost() {
        
        
        guard let title = txtPostTitle.text, txtPostTitle.hasText else { print("title not found")
            return
        }
        guard let body = txtPostBody.text, txtPostBody.hasText else { print("body not found")
            return
        }
        
        let post = Post(title: title, body: body)

        print(post.title as Any)
        print(post.body as Any)
        
        delegate?.update(post: post)
        
        self.navigationController?.popViewController(animated: true)
    }
  
    @IBAction func submitPostData(_ sender: Any) {
        // if isEdit
       // updatePost()
        
        //else
        savePost()
    }
    
}
