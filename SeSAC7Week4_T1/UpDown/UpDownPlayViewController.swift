//
//  UpDownPlayViewController.swift
//  SeSAC7Week4_T1
//
//  Created by ez on 7/18/25.
//

import UIKit

class UpDownPlayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    static let identifier = "UpDownPlayViewController"
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var subtitleLabel: UILabel!
    
    
    @IBOutlet var checkButton: UIButton!
    
    var values = [Int]()
    
    var maxValue = 0
    var randomValue = 0
    var count = 0
    var selectedButton: UIButton? {
        willSet {
            selectedButton?.isSelected = false
            selectedButton?.backgroundColor = .white
            newValue?.isSelected = true
            newValue?.backgroundColor = .black
            
            checkButton.isEnabled = true
        }
    }
    
    let mainColor = UIColor(named: "MainColor")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        randomValue = Int.random(in: 1...maxValue)
        values = Array(1...maxValue)
    }
    
    private func collectionViewLayout(_ layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), rowCount: CGFloat, columnCount: CGFloat, padding: CGFloat = 16, spacing: CGFloat = 16, direction: UICollectionView.ScrollDirection = .vertical) -> UICollectionViewFlowLayout {
        
        let deviceWidth = UIScreen.main.bounds.width
        let deviceHeight = UIScreen.main.bounds.height
        
        let itemWidth = deviceWidth - (padding * 2) - (spacing * (rowCount - 1))
        let itemHeight = deviceHeight - (padding * 2) - (spacing * (columnCount - 1))
        
        layout.itemSize = CGSize(width: itemWidth / rowCount, height: itemWidth / rowCount)
        layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = direction
        
        return layout
    }
    
    private func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: UpDownCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: UpDownCollectionViewCell.identifier)
        
        initUI()
        
        collectionView.collectionViewLayout = collectionViewLayout(rowCount: 6, columnCount: 0, padding: 8, spacing: 8, direction: .horizontal)
    }
    
    private func initUI() {
        
        view.backgroundColor = mainColor
        collectionView.backgroundColor = .clear
        
        initTitleLable()
        initSubtitleLabel()
        initCheckButton()
    }
    
    private func initTitleLable() {
        titleLabel.text = "UP DOWN"
        titleLabel.font = .systemFont(ofSize: 40, weight: .black)
        titleLabel.textAlignment = .center
    }
    
    private func initSubtitleLabel() {
        subtitleLabel.text = "시도 횟수: \(count)"
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .light)
        subtitleLabel.textAlignment = .center
    }
    
    private func initCheckButton() {
        let attrString = NSMutableAttributedString(string: "결과 확인하기", attributes: [
            .foregroundColor: UIColor.white.cgColor,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        checkButton.setAttributedTitle(attrString, for: .normal)
        
        checkButton.backgroundColor = .black
        
        checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        
        checkButton.isEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpDownCollectionViewCell.identifier, for: indexPath) as! UpDownCollectionViewCell
        
        cell.cellButton.setTitle("\(values[indexPath.row])", for: .normal)
        cell.cellButton.addTarget(self, action: #selector(cellButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    
    
    @objc private func checkButtonClicked() {
        print(#function)
        
        guard let value = Int(selectedButton?.titleLabel?.text ?? "") else { return }
        
        count += 1
        subtitleLabel.text = "시도 횟수: \(count)"
        
        var title = "GOOD!"
        
        if value == randomValue {
            let alert = UIAlertController(title: "정답입니다.", message: "시도 횟수: \(count), 정답: \(value)", preferredStyle: .alert)
            let action = UIAlertAction(title: "처음으로 돌아가기", style: .default) {_ in 
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(action)
            
            titleLabel.text = title
            
            present(alert, animated: true)
            
            return
        }
        
        if value > randomValue {
            values = values.filter { $0 < value }
            title = "Down"
            titleLabel.text = title
        } else if value < randomValue {
            values = values.filter { $0 > value }
            title = "Up"
            titleLabel.text = title
        }
        
        selectedButton = nil
        collectionView.reloadData()
    }
    
    @objc private func cellButtonTapped(sender: UIButton) {
        selectedButton = sender
    }
}
