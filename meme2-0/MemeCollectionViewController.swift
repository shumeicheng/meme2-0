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
        memecollectionView.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        cell.memeImage.image = memes[indexPath.row].afterImage
        return cell
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let VC = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        let meme = memes[indexPath.row]
        VC.meme = meme
        navigationController!.pushViewController(VC, animated: true)
    }

    @IBAction func addMeme(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("EditMemeViewController") as! EditMemeViewController
       presentViewController(vc, animated: true, completion: nil)
        

    }
}
