//
//  ViewController.swift
//  BMI
//
//  Created by 김하람 on 2023/04/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    var bmi: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightTextField.delegate = self
        weightTextField.delegate = self
        makeUI()
    }
    
    func makeUI() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        mainLabel.text = "키와 몸무게를 입력해주세요"
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 5
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        
        heightTextField.placeholder = "cm 단위로 입력해주세요"
        weightTextField.placeholder = "kg 단위로 입력해주세요"
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        // 버튼을 눌렀을 때 결과를 계산해야 함.
        bmi = calculateBMI(height: heightTextField.text!, weight: weightTextField.text!)
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 뭄무게를 입력하지 않으셨습니다"
            mainLabel.textColor = UIColor.red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해주세요"
        mainLabel.textColor = UIColor.black
        return true
    }
    
    // 데이터 전달을 위한 함수 - 계산된 값을 다음 화면으로 넘겨야 함
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController
            
            // 계산한 값 전달하기
            secondVC.bmiNumber = self.bmi
            secondVC.bmiColor = getBackgroundColor()
            secondVC.adviceString = getBMIAdviceString()
            
        }
        
        // 다음 화면으로 가기 전에 텍스트필드 지우기
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    // bmi 계산하는 함수
    func calculateBMI(height: String, weight: String) -> Double{
        guard let h = Double(height), let w = Double(weight) else {return 0.0}
        var bmi = w / (h * h) * 10000
        bmi = round(bmi * 10) / 10
        print("결과: \(bmi)")
        return bmi
    }
    
    // 색을 얻는 함수
    func getBackgroundColor() -> UIColor {
        guard let bmi = bmi else { return UIColor.black }
        switch bmi {
        case ..<18.6:
            return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
    
    // 문자열 얻는 메서드
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "" }
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
    }
    
}




// 두 텍스트필드 모두 적용된다. 둘 다 delegate로 설정했기 때문이다.
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // height인 경우만 하고 싶으면 이렇게 조건문으로 나눠서 할 수 있다.
//        if textField == heightTextField{
//
//        }
        // 숫자만 입력되게 하는 논리
        if Int(string) != nil || string == ""{
            return true
        }
        return false
    }
    
    // 키 입력 마치면 몸무게로 넘어가게 하기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두 필드에 입력을 모두 마치면 키보드 내려가기
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
            
        // 두 번째 텍스트필드로 넘어가게 하기
        } else if heightTextField.text != ""{
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
}

