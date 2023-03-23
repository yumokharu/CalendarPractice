//
//  CalendarCollectionViewCell.swift
//  CalendarPractice
//
//  Created by 차유민 on 2023/03/20.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    private lazy var dayLabel = UILabel()
   
    
    
   
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.dayLabelconfigure()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.dayLabelconfigure()
        
      
        
    }
    
    
    
    
    
    
    private func dayLabelconfigure() {
        self.addSubview(self.dayLabel)
        self.dayLabel.font = .boldSystemFont(ofSize: 12)
        self.dayLabel.textAlignment = .right
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
        ])
    }
    

  
    
    
    // day로 들어오는 문자열로 dayLabel 설정해주는 코드 
    func update(day: String) {
        self.dayLabel.text = day
    }
    
}
