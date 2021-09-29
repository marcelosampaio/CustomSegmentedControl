//
//  MSSegmentedControl.swift
//  CustomSegmentedControl
//
//  Created by Marcelo Sampaio on 28/09/21.
//
//  https://www.youtube.com/watch?v=xGdRCUrSu94

import UIKit

@IBDesignable

class MSSegmentedControl: UIControl {
    
    // MARK: - Properties
    var buttons = [UIButton]()
    var selector : UIView!
    var selectedSegmentIndex = 0
    var segmentsCount = 0
    
    // MARK: - IBDesignable
    @IBInspectable
    var borderWidth : CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable
    var borderColor : UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var textColor : UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor : UIColor = UIColor.darkGray {
        didSet {
            updateView()
        }
    }

    @IBInspectable
    var selectorTextColor : UIColor = UIColor.darkGray {
        didSet {
            updateView()
        }
    }
    
    
    @IBInspectable
    var commaSeparatedButtonTitle : String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var fontSize : Int = 15 {
        didSet {
            updateView()
        }
    }
    
    
    
    
    // MARK: - Draw
    override func draw(_ rect: CGRect) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }


    
    // MARK: - Helpers
    func updateView() {
        
        buttons.removeAll()
        subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        let buttonTitles = commaSeparatedButtonTitle.components(separatedBy: ",")
        
        for title in buttonTitles {
            
            let button = UIButton(type: .system)
            
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
            button.setTitle(title, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        // selector view
        let selectorWidth = frame.width / CGFloat(buttons.count)
        let selectorHeight = frame.height
        
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: selectorHeight))
        selector.layer.cornerRadius = frame.height / 2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        // stack view
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        // stack view constraints
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    
    @objc func buttonTapped(button: UIButton) {
        for (index, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == button {
                selectedSegmentIndex = index
                segmentsCount = buttons.count
                
                UIView.animate(withDuration: 0.38) {
                    // completion
                    self.selector.center = button.center
                }
                    
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        
        sendActions(for: .valueChanged)
    }
    
}
