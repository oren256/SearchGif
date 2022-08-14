//
//  GigCollectionViewCell.swift
//  GiphySearch
//
//  Created by  DNS on 12.08.2022.
//

import UIKit
import SDWebImage
//Использую бибилиотеку SDWebImage для UIKit

class GifCollectionViewCell: UICollectionViewCell {
    static let identifier = "GifCollectionViewCell"
    
    private var gifView: UIImageView {
        let gifView = UIImageView()
        gifView.clipsToBounds = true
        gifView.contentMode = .scaleAspectFill
        return gifView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(gifView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gifView.frame = contentView.bounds
    }
    
    //каким образом обнулить ячейку??
    override func prepareForReuse() {
        super.prepareForReuse()
        gifView.image = nil
    }
    
    
    //по URL загружаю Gif-ку
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        gifView.sd_setImage(with: url)
    }
    
}
