//
//  SnapVC.swift
//  SnapchatUIKit
//
//  Created by Italo Stuardo on 30/4/23.
//

import UIKit
import ImageSlideshow

class SnapVC: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedSnap: Snap?
    var inputArray = [AlamofireSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let snap = selectedSnap {
            timeLabel.text = "Time left \(snap.timeDifference)"
            for imageUrl in snap.imageUrlArray {
                inputArray.append(AlamofireSource(urlString: imageUrl)!)
            }
            
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = .lightGray
            pageIndicator.pageIndicatorTintColor = .black

            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.9))
            imageSlideShow.backgroundColor = .white
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            imageSlideShow.pageIndicator = LabelPageIndicator()

            
            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeLabel)
        }
        
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
