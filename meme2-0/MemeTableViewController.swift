//
//  MemeTableViewController.swift
//  meme2-0
//
//  Created by Shu-Mei Cheng on 4/1/16.
//  Copyright © 2016 Shu-Mei Cheng. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate{

    @IBOutlet weak var memetableView: UITableView!
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memetableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        
        return memes.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell")
        let ameme = memes[indexPath.row]
       
        cell!.imageView!.image = ameme.afterImage
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let VC = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        let meme = memes[indexPath.row]
        VC.meme = meme
        navigationController!.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func addMeme(sender: AnyObject) {
        
        let VC = storyboard!.instantiateViewControllerWithIdentifier("EditMemeViewController") as! EditMemeViewController
        presentViewController(VC, animated: true, completion: nil)

        
    }

}

