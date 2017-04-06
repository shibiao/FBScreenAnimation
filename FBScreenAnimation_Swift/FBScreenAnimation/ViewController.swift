//
//  ViewController.swift
//  FBScreenAnimation
//
//  Created by sycf_ios on 2017/4/6.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //每点击一次屏幕产生一组图片动画
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelTap)))
    }
    func handelTap() {
        //循环10次
        (0...10).forEach { (_) in
            //生成动态视图
            generateAnimationViews()
        }
    }
    fileprivate func generateAnimationViews() {
        //drand48()的作用是产生[0,1]直接均匀分布的随机数
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "thumbsUp") : #imageLiteral(resourceName: "heart")
        let imageView = UIImageView(image: image)
        //产生20到38之间的随机数
        let dimension = 20 + drand48() * 19
        //定义图片frame
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        //添加关键帧动画
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        //把图片关键帧动画路径上
        imageView.layer.add(animation, forKey: nil)
        //添加图片到视图
        view.addSubview(imageView)
    }
}
func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    //起始点
    path.move(to: CGPoint(x: 0, y: 200))
    //终点
    let endPoint  = CGPoint(x: 500, y: 200)
    //随机值
    let randomYShift = 200 + drand48() * 250
    //设置2个控制点
    let cp1 = CGPoint(x: 100, y: 100 - randomYShift)
    let cp2 = CGPoint(x: 200, y: 300 + randomYShift)
    //曲线路径
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}
