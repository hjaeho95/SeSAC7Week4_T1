//
//  UpDownCollectionViewCell.swift
//  SeSAC7Week4_T1
//
//  Created by ez on 7/18/25.
//

import UIKit

class UpDownCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var mainUIView: UIView!
    
    @IBOutlet private var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }

    func configureUI() {
        configureMainLabel()
    }
    
    private func configureMainLabel() {
        
    }
    
    private func initUI() {
        initMainImageView()
        initMainLabel()
    }
    
    private func initMainImageView() {
        mainUIView.backgroundColor = .white
        
        mainUIView.clipsToBounds = true
        DispatchQueue.main.async {
            self.mainUIView.layer.cornerRadius = self.mainUIView.frame.width / 2
        }
    }
    
    private func initMainLabel() {
        mainLabel.font = .systemFont(ofSize: 12)
    }
}
