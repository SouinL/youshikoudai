//
//  DataTableViewCell.swift
//  LWY
//
//  Created by ant on 2018/5/24.
//  Copyright © 2018年 com.cornerant. All rights reserved.
//

import UIKit
import Kingfisher

protocol DataTableViewCellDelegate:NSObjectProtocol {

    func typeButtonClick(cell:DataTableViewCell,button:UIButton)
}

class DataTableViewCell: UITableViewCell {
    @IBOutlet weak var dataImageView: UIImageView!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var typeAButton: UIButton!
    @IBOutlet weak var typeBButton: UIButton!
    weak var delegate: DataTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.typeAButton.addTarget(self, action: #selector(DataTableViewCell.typeButtonClick(button:)), for: UIControlEvents.touchUpInside)
        self.typeBButton.addTarget(self, action: #selector(DataTableViewCell.typeButtonClick(button:)), for: UIControlEvents.touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func comfigCell(with dataModel:DataModel){
        
        dataImageView.kf.setImage(with: URL(string: dataModel.image))
        dataLabel.text = dataModel.text
    }
    
    @objc func typeButtonClick(button:UIButton) {
        self.delegate?.typeButtonClick(cell: self, button: button)
    }
}
