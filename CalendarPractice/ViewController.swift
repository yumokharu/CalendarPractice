//
//  ViewController.swift
//  CalendarPractice
//
//  Created by 차유민 on 2023/03/18.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var previousButton = UIButton()
    private lazy var nextButton = UIButton()
    private lazy var todayButton = UIButton()
    private lazy var weekStackView = UIStackView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var circleView = UIImageView()
    
    private let calendar = Calendar.current
    private let dateFomatter = DateFormatter()
    private var calendarDate = Date()
    private var days = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.configure()
    }
    
    
    private func configure() {
        self.configureScrollview()
        self.configureContentView()
        self.configureTitleLabel()
        self.configurePreviousButton()
        self.configureNextButton()
        self.configureTodayButton()
        self.configureWeekStackView()
        self.configureWeekLabel()
        self.configureCollectionView()
        self.configureCalendar()
        
    }
    
    private func configureScrollview() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureContentView() {
        self.view.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
    
    private func configureTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.text = "2000년 01월"
        self.titleLabel.font = .monospacedSystemFont(ofSize: 18, weight: .bold)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    private func configurePreviousButton() {
        self.contentView.addSubview(self.previousButton)
        self.previousButton.tintColor = .label
        self.previousButton.setImage(UIImage(systemName: "backward.frame.fill"), for: .normal)
        self.previousButton.addTarget(self, action: #selector(self.didPreviousButtonTapped), for: .touchUpInside)
        self.previousButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.previousButton.widthAnchor.constraint(equalToConstant: 44),
            self.previousButton.heightAnchor.constraint(equalToConstant: 44),
            self.previousButton.trailingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor, constant: -5),
            self.previousButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ])
       
    }
    
    private func configureNextButton() {
        self.contentView.addSubview(self.nextButton)
        self.nextButton.tintColor = .label
        self.nextButton.setImage(UIImage(systemName: "forward.frame.fill"), for: .normal)
        self.nextButton.addTarget(self, action: #selector(self.didNextButtonTapped), for: .touchUpInside)
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nextButton.widthAnchor.constraint(equalToConstant: 44),
            self.nextButton.heightAnchor.constraint(equalToConstant: 44),
            self.nextButton.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 5),
            self.nextButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ])
        
    }
    
    private func configureTodayButton() {
        self.contentView.addSubview(todayButton)
        self.todayButton.setTitle("Today", for: .normal)
        self.todayButton.setTitleColor(.systemBackground, for: .normal)
        self.todayButton.backgroundColor = .label
        self.todayButton.layer.cornerRadius = 5
        self.todayButton.addTarget(self, action: #selector(self.didTodayButtonTapped), for: .touchUpInside)
        self.todayButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.todayButton.widthAnchor.constraint(equalToConstant: 60),
            self.todayButton.heightAnchor.constraint(equalToConstant: 30),
            self.todayButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.todayButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ])
    }
    
    private func configureWeekStackView() {
        self.contentView.addSubview(self.weekStackView)
        self.weekStackView.distribution = .fillEqually
        self.weekStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.weekStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 40),
            self.weekStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.weekStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5)
        ])
    }
    
    private func configureWeekLabel() {
        let dayOfTheWeek = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let label = UILabel()
            label.text = dayOfTheWeek[i]
            label.textAlignment = .center
            self.weekStackView.addArrangedSubview(label)
            
            if i == 0 {
                label.textColor = .systemRed
                
            } else if i == 6 {
                label.textColor = .systemBlue
            }
        }
    }
    
        private func configureCollectionView() {
            self.contentView.addSubview(self.collectionView)
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
            self.collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.collectionView.topAnchor.constraint(equalTo: self.weekStackView.bottomAnchor, constant: 10),
                self.collectionView.leadingAnchor.constraint(equalTo: self.weekStackView.leadingAnchor),
                self.collectionView.trailingAnchor.constraint(equalTo: self.weekStackView.trailingAnchor),
                self.collectionView.heightAnchor.constraint(equalTo: self.collectionView.widthAnchor, multiplier: 1.5),
                self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
        }

        
        
        
    }
    
    
    
    extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.days.count
            
        }
    
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell()
            }
            
            // 경계선 스타일 설정
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.update(day: self.days[indexPath.item])
            return cell
        }
    
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = self.weekStackView.frame.width / 7
            return CGSize(width: width, height: width * 1.2)
        }
    
        // 옆간격 설정해주는 코드 
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return .zero
        }
      
        
    }

extension ViewController {
    
    private func configureCalendar() {
        self.dateFomatter.dateFormat = "yyyy년 MM월"
        self.today()
    }
    
    private func startDayOfWeek() -> Int {
        return self.calendar.component(.weekday, from: self.calendarDate) - 1
    }
    
    private func endDate() -> Int {
        return self.calendar.range(of: .day, in: .month, for: self.calendarDate)?.count ?? Int()
    }
    
    
    private func updateCalendar() {
        self.updateTitle()
        self.updateDate()
    }
    
    private func updateTitle() {
        let date = self.dateFomatter.string(from: self.calendarDate)
        self.titleLabel.text = date
    }
    
    private func updateDate() {
        self.days.removeAll()
        let startDayOfTheWeek = self.startDayOfWeek()
        let totalDays = startDayOfTheWeek + self.endDate()
        
        for day in Int()..<totalDays {
            if day < startDayOfTheWeek {
                self.days.append("")
                continue
            }
            self.days.append("\(day - startDayOfTheWeek + 1)")
        }
        
        self.collectionView.reloadData()
        }
    
    private func minuMonth() {
        self.calendarDate = self.calendar.date(byAdding: DateComponents(month: -1), to: self.calendarDate) ?? Date()
        self.updateCalendar()
    }
    
    private func plusMonth() {
        self.calendarDate = self.calendar.date(byAdding: DateComponents(month: 1), to: self.calendarDate) ?? Date()
        self.updateCalendar()
    }
    
    private func today() {
        self.collectionView.addSubview(circleView)
        let components = self.calendar.dateComponents([.year, .month], from: Date())
        self.calendarDate = self.calendar.date(from: components) ?? Date()
        self.updateCalendar()
    }
    
    }

extension ViewController {
    @objc private func didPreviousButtonTapped(_ sender: UIButton) {
        self.minuMonth()
    }
    
    @objc private func didNextButtonTapped(_ sender: UIButton) {
        self.plusMonth()
    }
    
    @objc private func didTodayButtonTapped(_ sender: UIButton) {
        self.today()
    }
    
    
        
}

