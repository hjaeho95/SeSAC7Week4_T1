//
//  UpDownCollectionViewCell.swift
//  SeSAC7Week4_T1
//
//  Created by ez on 7/18/25.
//

import UIKit

class UpDownCollectionViewCell: UICollectionViewCell {

    static let identifier = "UpDownCollectionViewCell"
    
    @IBOutlet var cellButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }

    func configureUI(rowData: Int) {
//        configureCellButton(rowData)
    }
    
    
    
    private func configureCellButton(_ rowData: Int) {
        cellButton.setTitle("\(rowData)", for: .normal)
    }
    
    private func initUI() {
        backgroundColor = .clear
        
        initCellButton()
    }
    
    private func initCellButton() {
        cellButton.backgroundColor = .white
        
        cellButton.clipsToBounds = true
        // TODO: draw로 바꾸기
        DispatchQueue.main.async {
            self.cellButton.layer.cornerRadius = self.cellButton.frame.width / 2
        }
        
        cellButton.setTitle("", for: .normal)
        cellButton.setTitleColor(.black, for: .normal)
        cellButton.setTitleColor(.white, for: .selected)
    }
}
