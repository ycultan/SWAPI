//
//  FilmTableViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Lucy Tan on 9/19/17.
//  Copyright © 2017 Lucy Tan. All rights reserved.
//

import UIKit

class FilmTableViewController: UITableViewController {

    var films = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://swapi.co/api/films/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                    print(jsonResult)
                    if let results = jsonResult["results"] {
                        let resultsArray = results as! NSArray
                        let filmArray = resultsArray.value(forKey: "title") as! NSArray
                        print(filmArray)
                        for i in 0..<filmArray.count {
                            self.films.append(filmArray[i] as! String)
                        }
                    }
                    self.tableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        })
        task.resume()
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return films.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = films[indexPath.row]
        return cell
    }
}
