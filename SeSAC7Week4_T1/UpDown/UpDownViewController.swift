//
//  UpDownViewController.swift
//  SeSAC7Week4_T1
//
//  Created by ez on 7/18/25.
//

import UIKit
import Toast

class UpDownViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    
    @IBOutlet private var subtitleLabel: UILabel!
    
    @IBOutlet private var mainImageView: UIImageView!
    
    @IBOutlet private var textField: UITextField!
    
    @IBOutlet private var startButton: UIButton!
    
    let mainColor = UIColor(named: "MainColor")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func initUI() {
        navigationItem.backButtonTitle = "포기하기"
        view.backgroundColor = mainColor
        
        initTitleLable()
        initSubtitleLabel()
        initMainImageView()
        initTextField()
        initStartButton()
    }
    
    private func initTitleLable() {
        titleLabel.text = "UP DOWN"
        titleLabel.font = .systemFont(ofSize: 40, weight: .black)
        titleLabel.textAlignment = .center
    }
    
    private func initSubtitleLabel() {
        subtitleLabel.text = "GAME"
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .light)
        subtitleLabel.textAlignment = .center
    }
    
    private func initMainImageView() {
        mainImageView.image = .emotion1
        mainImageView.contentMode = .scaleAspectFill
    }
    
    private func initTextField() {
        textField.placeholder = "2~999 숫자를 입력해주세요."
        textField.font = .systemFont(ofSize: 20, weight: .heavy)
        textField.textAlignment = .center
        
        textField.borderStyle = .none
        
        textField.backgroundColor = mainColor
        
        textField.keyboardType = .numberPad
    }
    
    private func initStartButton() {
        let attrString = NSMutableAttributedString(string: "시작하기", attributes: [
            .foregroundColor: UIColor.white.cgColor,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        startButton.setAttributedTitle(attrString, for: .normal)
        
        startButton.backgroundColor = .black
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        
        let toast = {
            self.view.makeToast("2~999 숫자를 입력해주세요.", position: .center)
        }
        
        guard let maxValue = Int(textField.text ?? "0") else {
            toast()
            return
        }
        
        if maxValue < 2 || maxValue > 999 {
            toast()
            return
        }
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: UpDownPlayViewController.identifier) as? UpDownPlayViewController {
            vc.maxValue = maxValue
            navigationController?.pushViewController(vc, animated: true)
            textField.text = ""
        }
    }
    
    
}
