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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let movie = movieDictionary[movieIndex]

        // Get url's for movie posters
        var posters = movie["posters"] as NSDictionary
        var posterURL = posters["detailed"] as String
        let originalImage = posterURL.stringByReplacingOccurrencesOfString("tmb", withString: "ori", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        let url = NSURL(string: originalImage)
        //let data = NSData(contentsOfURL: url!)
        moviePoster.setImageWithURL(url)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        let myView = UIView(frame: CGRectZero)
        myView.backgroundColor = UIColor.greenColor()
        self.view = myView
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
