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
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memetableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        
        return memes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell")
        let ameme = memes[indexPath.row]
       
        cell!.imageView!.image = ameme.afterImage
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VC = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        let meme = memes[indexPath.row]
        VC.meme = meme
        navigationController!.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func addMeme(_ sender: AnyObject) {
        
        let VC = storyboard!.instantiateViewController(withIdentifier: "EditMemeViewController") as! EditMemeViewController
        present(VC, animated: true, completion: nil)

        
    }

}

