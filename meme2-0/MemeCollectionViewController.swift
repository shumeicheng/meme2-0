//
//  MemeCollectionViewController.swift
//  meme2.0
//
//  Created by Shu-Mei Cheng on 3/31/16.
//  Copyright © 2016 Shu-Mei Cheng. All rights reserved.
//

import Foundation
import UIKit
class MemeCollectionViewController: UICollectionViewController {
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    @IBOutlet var memecollectionView: UICollectionView!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let controller = segue.destinationViewController as! EditMemeViewController

        controller.memecollectionView = memecollectionView
    }
    // shared data model
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowlayout.minimumInteritemSpacing = space
        flowlayout.itemSize = CGSizeMake(dimension, dimension)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        cell.memeImage.image = self.memes[indexPath.row].afterImage
        return cell
    }
    @IBAction func addMeme(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("EditMemeViewController") as! EditMemeViewController
        self.presentViewController(vc, animated: true, completion: nil)
        

    }
    @IBAction func editMeme(sender: AnyObject) {
    }
}
