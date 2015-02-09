//
//  DVDMoviesViewController.swift
//  RottenTomatoes
//
//  Created by Olga Azarova on 2/9/15.
//  Copyright (c) 2015 Olga Azarova. All rights reserved.
//


import UIKit

class DVDMoviesViewController: UIViewController, UITableViewDataSource{
    
    var moviesArray : [NSDictionary]!
    var selectedIndex = 0
    var refreshMoviesControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Style navigation bar controller
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        self.navigationItem.title = "DVD's"
        
        refreshMoviesControl = UIRefreshControl()
        refreshMoviesControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refreshMoviesControl, atIndex: 0)
        
        self.pullData()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = moviesArray {
            return array.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movie = self.moviesArray![indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("olgaa.myMovieCell") as BoxOfficeTableViewCell
        cell.movieTitleLabel.text = movie["title"] as NSString
        
        // Get url's for movie posters
        var posters = movie["posters"] as NSDictionary
        var posterURL = posters["thumbnail"] as String
        
        let url = NSURL(string: posterURL)
        let data = NSData(contentsOfURL: url!)
        cell.movieThumbnail.image = UIImage(data: data!)
        
        // Make poster images fade in
        UIView.animateWithDuration(1.0,
            delay: 0.0,
            options: nil,
            animations: {
                cell.movieThumbnail.alpha = 1.0
            },
            completion: {
                finished in
        })
        
        cell.movieSynopsisLabel.text = movie["synopsis"] as NSString
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "testSegue"){
            let selectedIndex = self.tableView.indexPathForCell(sender as UITableViewCell)!
            
            // Pass movie details to the movieDetailsViewController
            var movieDetailsViewController: MovieDetailsViewController = segue.destinationViewController as MovieDetailsViewController
            movieDetailsViewController.movieDictionary = moviesArray
            movieDetailsViewController.movieIndex = selectedIndex.row
            
        }
        
    }
    
    
    func onRefresh() {
        pullData()
    }
    
    
    func pullData(){
        let YourApiKey = "2wmv5yg4c637seevpmybgwtk"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
        SVProgressHUD.show()
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            
            if error != nil {
                NSLog("the error is \(error)")
                self.showNetworkError()
            } else {
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
                self.moviesArray = dictionary["movies"] as? [NSDictionary]
                self.tableView.reloadData()
                self.refreshMoviesControl.endRefreshing()
                SVProgressHUD.dismiss()
            }
        })
        
    }
    
    func showNetworkError() {
        var errorView: UIView = UIView(frame: CGRectMake(0, 50, 320, 65))
        errorView.backgroundColor = UIColor.grayColor()
        var errorLabel: UILabel = UILabel(frame: CGRectMake(110, 20, 260, 40))
        errorLabel.text = "Network error!"
        errorLabel.textColor = UIColor.whiteColor()
        errorView.addSubview(errorLabel)
        self.view.addSubview(errorView)
    }
    
}

// UITabBarDelegate
extension DVDMoviesViewController: UITabBarDelegate {
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        pullData()
    }
}


