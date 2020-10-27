import UIKit
import AudioToolbox

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var fontColor: UIColor = UIColor.white {
        didSet {
            self.tintColor = fontColor
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
        
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), for: .touchDown)
        self.addTarget(self, action: #selector(CustomButton.scaleDefault), for: .touchCancel)
        self.addTarget(self, action: #selector(CustomButton.scaleDefault), for: .touchDragExit)
        self.addTarget(self, action: #selector(CustomButton.scaleDefault), for: .touchDragOutside)
        self.addTarget(self, action: #selector(CustomButton.scaleDefault), for: .touchUpOutside)
        self.addTarget(self, action: #selector(CustomButton.scaleDefault), for: .touchUpInside)
        self.addTarget(self, action: #selector(CustomButton.generateFeedback), for: .touchUpInside)
    }
    
    @objc func scaleToSmall() {
        self.zoomOut()
    }
    
    @objc func scaleDefault() {
        self.zoomIn()
    }
    
    @objc func generateFeedback() {
        let peek = SystemSoundID(1519)
        AudioServicesPlaySystemSound(peek)
    }
}
