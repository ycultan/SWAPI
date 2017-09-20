//
//  ViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Lucy Tan on 9/19/17.
//  Copyright © 2017 Lucy Tan. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController{
    // Hardcoded data for now
    var people = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // specify the url that we will be sending the GET Request to
        let url = URL(string: "http://swapi.co/api/people/")
        // create a URLSession to handle the request tasks
        let session = URLSession.shared
        // create a "data task" to make the request and run the completion handler
        let task = session.dataTask(with: url!, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
//            print("in here")
            // see: Swift nil coalescing operator (double questionmark)
//            print(data ?? "no data") // the "no data" is a default value to use if data is nil
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                    print(jsonResult)
                    if let results = jsonResult["results"] {
//                        print(results)
                        let resultsArray = results as! NSArray
                        let name = resultsArray.value(forKey: "name") as! NSArray
//                        print(name)
                        for i in 0..<name.count {
//                            print(name[i])
                            self.people.append(name[i] as! String)
                        }
//                        print(self.people)
//                        print(resultsArray.value(forKey: "name"))
                        
//                        print("array", resultsArray)
//                        print("resultsArray[0] = ", resultsArray[0])
//                        print("first object", resultsArray.firstObject)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
                } catch {
                    print(error)
                }
            
        })
        // execute the task and wait for the response before
        // running the completion handler. This is async!
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // if we return - sections we won't have any sections to put our rows in
//        return 1
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
//        let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = people[indexPath.row]
        // return the cell so that it can be rendered
        return cell
    }
}





//solutions
//
//
//
//
//
//
//
//
//
//
//import UIKit
//
//class PeopleViewController: UITableViewController {
//    
//    // data array used for tableView -- see cellForRowAt function
//    var people = [String]()
//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        
//        // prepare request information and session
//        let url = NSURL(string: "http://swapi.co/api/people/")
//        let session = URLSession.shared
//        
//        // retrieve data from url and handle with 'completionHandler' function enclosure
//        let task = session.dataTask(with: url! as URL, completionHandler: {
//            // swift anonymous function definition
//            data, response, error in
//            do {
//                // is there a result? Continue if we can cast response to dictionary type
//                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                    
//                    // cast results key to array for iteration
//                    if let results = jsonResult["results"] as? NSArray {
//                        for person in results {
//                            // cast to dictionary for data extraction
//                            let personDict = person as! NSDictionary
//                            self.people.append(personDict["name"]! as! String)
//                        }
//                    }
//                }
//                // async -- if we loaded the data outside of the do-catch statement
//                // it would attempt to load before we had populated the 'people' array
//                self.tableView.reloadData()
//            } catch {
//                print(error)
//            }
//        })
//        // task.resume() will begin a task and wait for the response to handle
//        // with completionHandler. Code we put below here will likely happen before the response
//        task.resume()
//        print("I happen before the response!")
//    }
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    // MARK: - Table view data source: people
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return people.count
//    }
//    
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
//        cell.textLabel?.text = people[indexPath.row]
//        return cell
//    }
//    
//}
//
