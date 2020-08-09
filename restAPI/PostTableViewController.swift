//
//  PostTableViewController.swift
//  restAPI
//
//  Created by Fayik Muzammil on 8/3/20.
//  Copyright © 2020 Fayik Muzammil. All rights reserved.
//

import UIKit

struct Post: Decodable {
var id: Int?
var userId: Int?
var title: String?
var body: String?

}

class PostTableViewController: UITableViewController {

    var selectedIndexPath: IndexPath?
    
    var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let newXib = UINib(nibName: "PostTableViewCellTableViewCell", bundle: nil)
        
        tableView.register(newXib, forCellReuseIdentifier: "postcell")
        
        getPosts()

    }
    
    func getPosts() {
        
        let jsonUrlString = "https://jsonplaceholder.typicode.com/posts"
        
        HttpClientApi.instance().makeAPICall(url: jsonUrlString, params: nil, method: .GET, success: { (data, response, error) in
            print("data loaded")
            
            guard let data = data else { return }
            
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: data)
                
             //   print(posts)
                //   self.tableView.reloadData()
                
                
            } catch let jsonError {
                print("Decode Error ", jsonError)
            }
        }) { (data, response, error) in
            print("wrong api call", error)
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postcell", for: indexPath) as! PostTableViewCellTableViewCell
        
        cell.lblTitle.text = posts[indexPath.row].title
        cell.lblBody.text = posts[indexPath.row].body
        cell.userName.tag = posts[indexPath.row].userId ?? 0
        cell.userName.addTarget(self, action: #selector(navigateToUserPosts), for: .touchUpInside)

        let controller = CreatePostViewController()
        controller.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    @objc func navigateToUserPosts (sender: UIButton!) {
        print("Click \(sender.tag)")
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc: UserPostsTableViewController = mainStoryboard.instantiateViewController(withIdentifier: "userpostdata") as! UserPostsTableViewController
        vc.userId = sender.tag
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc: CreatePostViewController = mainStoryboard.instantiateViewController(withIdentifier: "createpost") as! CreatePostViewController
            
            vc.postData = self.posts[indexPath.row]
            
            vc.delegate = self
            self.selectedIndexPath = indexPath
            tableView.deselectRow(at: indexPath, animated: true)
        
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        edit.backgroundColor = UIColor.green
        
        return [edit]
    }
}


extension PostTableViewController: updateDataDelegate
  {
     func update(post: Post) {
    if let indexPath = selectedIndexPath {
        posts[indexPath.row] = post
        tableView.reloadRows(at: [indexPath], with: .automatic)
        selectedIndexPath = nil
    }
      
  }
}
  
  


   /*
 
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


