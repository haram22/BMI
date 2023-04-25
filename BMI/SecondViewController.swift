//
//  SecondViewController.swift
//  BMI
//
//  Created by 김하람 on 2023/04/25.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var bmiNumberLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    var bmiNumber: Double?
    var adviceString: String?
    var bmiColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
    }
    
    func makeUI(){
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 5
        
        // Optional 값 벗기기
        guard let bmi = bmiNumber else {return}
        bmiNumberLabel.text = String(bmi)
        
        adviceLabel.text = adviceString
        bmiNumberLabel.backgroundColor = bmiColor
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
