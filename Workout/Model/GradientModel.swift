import UIKit
import Foundation

class GradientModel {
    
    func setLinearGradient(colorLeft: CGColor, colorRight: CGColor, frame: CGRect) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = frame
    }
    
    func setStandartGradient(colorTop: CGColor, colorBottom: CGColor, frame: CGRect, view: UIView) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.frame = frame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
