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
    
    var i:Int = 1
    // タイマー
    var timer: Timer!
    // タイマー用の時間のための変数
    var timer_sec: Float = 0
    
    //  画像が載るためのがView
    @IBOutlet weak var ansImage: UIImageView!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var btnPreview: UIButton!
    
    //  次の画像を表示するbotton
    @IBAction func btnNext(_ sender: Any) {
        if i == 17{ //配列の最後を指定することで自動的に最終を選択
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
            i = 17
            ansImage.image = UIImage(named:"\(i)")
        }else {
            i -= 1
            ansImage.image = UIImage(named:"\(i)")
        }
    }

    // selector: #selector(updatetimer(_:)) で指定された関数
    // timeInterval: 0.1, repeats: true で指定された通り、0.1秒毎に呼び出され続ける
    @objc func updateTimer(_ timer: Timer) {
        self.timer_sec += 2.0
        if self.timer_sec.truncatingRemainder(dividingBy: 2.0) == 0{
         self.btnNext(btnNext as Any)
        }
    }
    
    @IBOutlet weak var btnAuto: UIButton!
    //自動送り用のbutton
    @IBAction func btnAuto(_ sender: Any) {
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            btnAuto.setTitle("一時停止", for:UIControl.State.normal)
            btnNext.isEnabled = false
            btnPreview.isEnabled = false

        }else{
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil          // startTimer() の self.timer == nil で判断するために、 self.timer = nil としておく
            btnAuto.setTitle("再生", for:UIControl.State.normal)
            btnNext.isEnabled = true
            btnPreview.isEnabled = true
        }
    }
    
//  画像タップでの遷移
    @IBAction func tapAction(_ sender: UIStoryboardSegue) {
        self.performSegue(withIdentifier: "toSecond", sender: nil)
    }
    
//  遷移の際に画像を送る
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // segueから遷移先のSecondViewControllerを取得する
           let secondViewController:SecondViewController = segue.destination as! SecondViewController
           // 遷移先のSecondViewControllerで宣言しているx, selectedImgに値を代入して渡す
           secondViewController.selectedImg = UIImage(named:"\(i)")
    }
}
