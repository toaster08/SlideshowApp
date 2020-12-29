//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 山田　天星 on 2020/12/14.
//  Copyright © 2020 山田　天星. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var i:Int = 0
    
//  画像が載るためのがView
    @IBOutlet weak var ansImage: UIImageView!
    
    
    @IBAction func btnAuto(_ sender: Any) {
        
    }
    
//  次の画像を表示するbotton
    @IBAction func btnNext(_ sender: Any) {
        if i == 2{ //配列の最後を指定することで自動的に最終を選択
            i = 0
            ansImage.image = UIImage(named:"\(i)")
        }else {
            i += 1
            ansImage.image = UIImage(named:"\(i)")
        
        }
    }
    
//    前の画像に戻るためのbutton
    @IBAction func btnPreview(_ sender: Any) {
        if i == 0{
            i = 2
            ansImage.image = UIImage(named:"\(i)")
        }else {
            i -= 1
            ansImage.image = UIImage(named:"\(i)")
        
        }
    }
}

