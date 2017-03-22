//
//  ViewController.swift
//  DrawingApp
//
//  Created by RoYzH on 2/10/17.
//  Copyright © 2017 RoYzH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var eraseOrpaint: UIButton!
    var isErasing = true
    
    var Points = [CGPoint]()
    
    var drawLines: drawLine?
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    var thickness: CGFloat = 0.5
    var opacity: CGFloat = 1.0
    
    var image: UIImage!
    
    @IBOutlet weak var opacityValue: UISlider!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var toolImage: UIImageView!
    
    @IBAction func clearButton(_ sender: Any) {
        for v in imageView.subviews {
            v.removeFromSuperview()
        }
    }
    
    @IBAction func undoButton(_ sender: Any) {
        let totalNumber = imageView.subviews.count
        var number = Int(0)
        for v in imageView.subviews {
            number += 1;
            if(number == totalNumber) {
                v.removeFromSuperview()
            }
        }
    }
    
    @IBAction func eraseButton(_ sender: Any) {
        if(isErasing) {
            (red, green, blue) = (1, 1, 1)
            opacity = 1.0
            opacityValue.value = 1.0
            toolImage.image = #imageLiteral(resourceName: "EraserIcon")
            eraseOrpaint.setImage(#imageLiteral(resourceName: "paintBrush"), for: .normal)
        }
        else {
            (red, green, blue) = (0, 0, 0)
            toolImage.image = #imageLiteral(resourceName: "paintBrush")
            eraseOrpaint.setImage(#imageLiteral(resourceName: "EraserIcon"), for: .normal)
        }
        isErasing = !isErasing
    }
    
    @IBAction func thicknessSlider(_ sender: Any) {
        let slider = sender as! UISlider
        thickness = CGFloat(slider.value)
    }
    
    @IBAction func opacitySlider(_ sender: Any) {
        let slider = sender as! UISlider
        opacity = CGFloat(slider.value)
    }
    
    @IBAction func colorSet(_ sender: UIButton) {
        if (sender.tag == 1) {
            //red
            (red, green, blue) = (1, 0, 0)
        }
        else if (sender.tag == 2) {
            //yellow
            (red, green, blue) = (1, 1, 0)
        }
        else if (sender.tag == 3) {
            //blue
            (red, green, blue) = (0, 0, 1)
        }
        else if (sender.tag == 4) {
            //green
            (red, green, blue) = (0, 1, 0)
        }
        else if (sender.tag == 5) {
            //teal
            (red, green, blue) = (0, 1, 1)
        }
        else if (sender.tag == 6) {
            //pink
            (red, green, blue) = (1, 0, 1)
            
        }
        else if (sender.tag == 7) {
            //white
            (red, green, blue) = (1, 1, 1)
        }
        else {
            //black
            (red, green, blue) = (0, 0, 0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: imageView) as CGPoint
        Points.append(touchPoint)
        let frame = CGRect(x:0, y:0, width:imageView.frame.width, height:imageView.frame.height)
        drawLines = drawLine(frame: frame)
        drawLines?.draws = Draw(points: Points, red: red, green: green, blue: blue, thick: thickness, opacity: opacity, tool:toolImage, toolCenterShift: imageView.frame.origin.y)
        imageView.addSubview(drawLines!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: imageView) as CGPoint
        drawLines?.draws?.points.append(touchPoint)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        Points.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        toolImage = UIImageView()
        toolImage.frame = CGRect(x: self.view.bounds.size.width, y: self.view.bounds.size.width, width: 30, height: 30)
        toolImage.image = #imageLiteral(resourceName: "paintBrush")
        self.view.addSubview(toolImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

