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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       let controller = segue.destinationViewController as! EditMemeViewController
        controller.tableView = memetableView
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell")
        let ameme = self.memes[indexPath.row]
       
        cell!.imageView!.image = ameme.originalImage
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let VC = self.storyboard!.instantiateViewControllerWithIdentifier("EditMemeViewController") as! EditMemeViewController
        let meme = self.memes[indexPath.row]
        VC.aMeme = meme
        self.navigationController!.pushViewController(VC, animated: true)
        
    }
    
    
    @IBAction func EditMeme(sender: AnyObject) {
    }

}

