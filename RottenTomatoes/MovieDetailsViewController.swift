//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Olga Azarova on 2/6/15.
//  Copyright (c) 2015 Olga Azarova. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movieDictionary: [NSDictionary]! = []
    var movieIndex: Int = 0
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieSummary: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let movie = movieDictionary[movieIndex]
        
        var title : String = movie["title"] as String
        var year : Int = movie["year"] as Int
        var ratings : NSDictionary = movie["ratings"] as NSDictionary
        var criticsScore : Int = ratings["critics_score"] as Int
        var audienceScore : Int = ratings["audience_score"] as Int
        var rating : String = movie["mpaa_rating"] as String
        var synopsis :String = movie["synopsis"] as String
        
        self.navigationItem.title = movie["title"] as? String

        self.movieTitle.text = title+" ("+String(year)+")"
        self.movieScore.text = "Critics Score: \(String(criticsScore)), Audience Score: \(String(audienceScore))"
        self.movieRating.text = rating
        self.movieSummary.text = synopsis
        
        // Get url's for movie posters
        var posters = movie["posters"] as NSDictionary
        var posterURL = posters["thumbnail"] as String
        let originalImage = posterURL.stringByReplacingOccurrencesOfString("tmb", withString: "ori", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        //load thumbnail image first
        moviePoster.setImageWithURL(NSURL(string: posterURL), placeholderImage: UIImage(named: "flixster"))
        
        if var url = NSURL(string: originalImage) {
            // fade in
            UIView.animateWithDuration(1.0,
                delay: 0.0,
                options: nil,
                animations: {
                    self.moviePoster.alpha = 0.5
                },
                completion: {
                    finished in
            })
   
            //load detailed image now
            moviePoster.setImageWithURL(url, placeholderImage: UIImage(named: "flixster"))
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    override func loadView() {
        let myView = UIView(frame: CGRectZero)
        myView.backgroundColor = UIColor.greenColor()
        self.view = myView
    }
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
