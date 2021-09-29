//
//  ViewController.swift
//  CustomSegmentedControl
//
//  Created by Marcelo Sampaio on 28/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outllets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var customSegmentedControl: MSSegmentedControl!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - UI Actions
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        let segmentControl = sender as! MSSegmentedControl
        print("🥋 selected segment: \(segmentControl.selectedSegmentIndex)")
        print("🥋 total of segments: \(segmentControl.segmentsCount)")
        
    }
    

}

