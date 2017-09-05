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
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }

    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowlayout.minimumInteritemSpacing = space
        flowlayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memecollectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        cell.memeImage.image = memes[indexPath.row].afterImage
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        
        let VC = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        let meme = memes[indexPath.row]
        VC.meme = meme
        navigationController!.pushViewController(VC, animated: true)
    }

    @IBAction func addMeme(_ sender: AnyObject) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditMemeViewController") as! EditMemeViewController
       present(vc, animated: true, completion: nil)
        

    }
}
