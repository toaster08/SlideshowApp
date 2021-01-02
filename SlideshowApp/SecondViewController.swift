//
//  SecondViewController.swift
//  SlideshowApp
//
//  Created by 山田　天星 on 2020/12/14.
//  Copyright © 2020 山田　天星. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIScrollViewDelegate{

    var selectedImg: UIImage!
    var imageView:UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // デリゲートを設定
       scrollView.delegate = self
       // 最大・最小の大きさを決める
       scrollView.maximumZoomScale = 4.0
       scrollView.minimumZoomScale = 1.0

       // imageViewを生成
       imageView = UIImageView()
       imageView.frame = CGRect(x:0,y:0,width:view.frame.width,height:view.frame.height)
       scrollView.addSubview(imageView)
        
       // imageViewにセグエで飛ばされてきた画像を設定
       imageView.image = selectedImg
       imageView.contentMode = UIView.ContentMode.scaleAspectFit

       // ダブルタップ対応
       let doubleTap = UITapGestureRecognizer(target:self,action:#selector(SecondViewController.doubleTap(gesture:)))
       doubleTap.numberOfTapsRequired = 2
       imageView.isUserInteractionEnabled = true
       imageView.addGestureRecognizer(doubleTap)
        // Do any additional setup after loading the view.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("end zoom")
    }

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        print("start zoom")
    }

    @objc func doubleTap(gesture:UITapGestureRecognizer) -> Void {
        if(self.scrollView.zoomScale < 3){
            let newScale:CGFloat = self.scrollView.zoomScale*3
            let zoomRect:CGRect = self.zoomForScale(scale:newScale, center:gesture.location(in:gesture.view))
            self.scrollView.zoom(to:zoomRect, animated: true)
        } else {
            self.scrollView.setZoomScale(1.0, animated: true)
        }
    }
    
    func zoomForScale(scale:CGFloat, center: CGPoint) -> CGRect{
        var zoomRect: CGRect = CGRect()
        zoomRect.size.height = self.scrollView.frame.size.height / scale
        zoomRect.size.width = self.scrollView.frame.size.width  / scale
        zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
        zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
        return zoomRect
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
