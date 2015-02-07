//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Olga Azarova on 2/6/15.
//  Copyright (c) 2015 Olga Azarova. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    
    var moviesArray : NSArray?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let YourApiKey = "2wmv5yg4c637seevpmybgwtk"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            self.moviesArray = dictionary["movies"] as? NSArray
            self.tableView.reloadData()
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = moviesArray {
            return array.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movie = self.moviesArray![indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("olgaa.mycell") as MovieTableViewCell
        cell.movieTitleLabel.text = movie["title"] as NSString

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let details = MovieDetailsViewController()
        let movie = self.moviesArray![indexPath.row] as NSDictionary
        details.movieDictionary = movie
        self.navigationController?.pushViewController(details, animated: true)
    }
}

