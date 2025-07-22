//
//  UpDownCodebaseViewController.swift
//  SeSAC7Week4_T1
//
//  Created by ez on 7/22/25.
//

import UIKit
import SnapKit
import Toast

class UpDownCodebaseViewController: UIViewController {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UP DOWN"
        label.font = .systemFont(ofSize: 40, weight: .black)
        label.textAlignment = .center
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "GAME"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    private var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .emotion1
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "2~999 숫자를 입력해주세요."
        textField.font = .systemFont(ofSize: 20, weight: .heavy)
        textField.textAlignment = .center
        
        textField.borderStyle = .none
        
        textField.backgroundColor = UIColor(named: "MainColor")
        
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private var startButton: UIButton = {
        let button = UIButton()
        let attrString = NSMutableAttributedString(string: "시작하기", attributes: [
            .foregroundColor: UIColor.white.cgColor,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        button.setAttributedTitle(attrString, for: .normal)
        
        button.backgroundColor = .black
        
        button.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        configureUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func initUI() {
        navigationItem.backButtonTitle = "포기하기"
        view.backgroundColor = UIColor(named: "MainColor")
    }
    
    private func configureUI() {
        [titleLabel, subtitleLabel, mainImageView, textField, startButton].forEach { control in
            view.addSubview(control)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(titleLabel)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(60)
        }
        
        textField.snp.makeConstraints {
            $0.bottom.equalTo(startButton.snp.top).offset(-30)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.height.equalTo(60)
        }
        
        mainImageView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(250)
        }
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
        
        let storyboard = UIStoryboard(name: "UpDown", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: UpDownPlayViewController.identifier) as! UpDownPlayViewController
        viewController.maxValue = maxValue
        navigationController?.pushViewController(viewController, animated: true)
        textField.text = ""
    }
    
}
