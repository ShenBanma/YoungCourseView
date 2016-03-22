//作者 年轻 :  欢迎大家使用

import UIKit

extension UIColor {
    static func getRandomColor() -> UIColor {
        let random = arc4random_uniform(10)
        switch random {
        case 0: return UIColor(red: 248 / 255, green: 145 / 255, blue: 121 / 255, alpha: 1)
        case 1: return UIColor(red: 248 / 255, green: 197 / 255, blue: 121 / 255, alpha: 1)
        case 2: return UIColor(red: 188 / 255, green: 243 / 255, blue: 145 / 255, alpha: 1)
        case 3: return UIColor(red: 145 / 255, green: 243 / 255, blue: 213 / 255, alpha: 1)
        case 4: return UIColor(red: 159 / 255, green: 133 / 255, blue: 241 / 255, alpha: 1)
        case 5: return UIColor(red: 213 / 255, green: 133 / 255, blue: 241 / 255, alpha: 1)
        case 6: return UIColor(red: 242 / 255, green: 153 / 255, blue: 228 / 255, alpha: 1)
        case 7: return UIColor(red: 242 / 255, green: 153 / 255, blue: 159 / 255, alpha: 1)
        case 8: return UIColor(red: 194 / 255, green: 190 / 255, blue: 190 / 255, alpha: 1)
        case 9: return UIColor(red: 153 / 255, green: 82 / 255, blue: 82 / 255, alpha: 1)
        default: return UIColor.whiteColor()
        }
    }
}

class YoungCourseView: UIScrollView {
    
    
    private var courses = [Course]() {
        didSet {
            self.addCourse()
        }
    }
    
    private var weekIndex = 1 {
        didSet {
            if weekIndex > 16 {
                weekIndex = 1
            }
            self.updateCourses()
        }
    }
    
    private let dayArrays: [String] = ["一", "二", "三", "四", "五", "六", "日"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentSize = CGSize(width: 7 * 100 + 2 * 30, height: 60 * 12 + 30)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.setupBasicViews()
    }
    
    //对外部的接口
    internal func setCourses(courses: [Course]) {
        self.courses = courses
    }
    
    private func updateCourses() {
        for subView in self.subviews {
            if subView.tag == 10200 {
                subView.removeFromSuperview()
            }
        }
        self.addCourse()
    }
    
    private func addCourse() {
        if self.courses.count != 0 {
            for course in courses {
                if course.weekRange.contains(weekIndex) {
                    let courseView = UIView(frame: CGRect(x: 60 + (course.day - 1) * 100, y: 30 + (course.courseTimeStart - 1) * 60, width: 100, height: course.courseCount * 60))
                    courseView.tag = 10200
                    let courseInformationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 500))
                    var fontSizeInt = 15
                    courseInformationLabel.font = UIFont.systemFontOfSize(CGFloat(fontSizeInt))
                    courseInformationLabel.lineBreakMode = .ByWordWrapping
                    courseInformationLabel.numberOfLines = 0
                    courseInformationLabel.text = course.courseInformation
                    courseInformationLabel.textAlignment = .Center
                    courseInformationLabel.sizeToFit()
                    while courseInformationLabel.bounds.height > courseView.bounds.height - 10 {
                        fontSizeInt -= 1
                        courseInformationLabel.font = UIFont.systemFontOfSize(CGFloat(fontSizeInt))
                        courseInformationLabel.sizeToFit()
                    }
                    courseInformationLabel.center = CGPoint(x: courseView.bounds.width / 2, y: courseView.bounds.height / 2)
                    courseView.addSubview(courseInformationLabel)
                    courseView.backgroundColor = UIColor.getRandomColor()
                    courseView.layer.cornerRadius = 5
                    courseView.layer.borderColor = UIColor.whiteColor().CGColor
                    courseView.layer.borderWidth = 0.5
                    self.addSubview(courseView)
                }
            }
        }
    }
    
    private func setupBasicViews() {
        let weekButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        weekButton.backgroundColor = UIColor(red: 255 / 255, green: 175 / 255, blue: 175 / 255, alpha: 1)
        weekButton.setTitle("第\(weekIndex)周", forState: .Normal)
        weekButton.titleLabel?.font = UIFont.systemFontOfSize(17)
        weekButton.contentHorizontalAlignment = .Center
        weekButton.layer.borderColor = UIColor.whiteColor().CGColor
        weekButton.layer.borderWidth = 0.5
        weekButton.layer.cornerRadius = 5
        weekButton.addTarget(self, action: #selector(YoungCourseView.addWeek(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(weekButton)
        
        for (index, text) in self.dayArrays.enumerate() {
            let dayView = UIView(frame: CGRect(x: 60 + index * 100, y: 0, width: 100, height: 30))
            let showTextLabel = UILabel()
            showTextLabel.font = UIFont.systemFontOfSize(17)
            showTextLabel.text = "星期" + text
            showTextLabel.sizeToFit()
            showTextLabel.center = CGPoint(x: dayView.bounds.width / 2, y: dayView.bounds.height / 2)
            dayView.addSubview(showTextLabel)
            let color = UIColor(red: 180 / 255, green: 235 / 255, blue: 255 / 255, alpha: 1)
            dayView.backgroundColor = color
            dayView.layer.cornerRadius = 5
            dayView.layer.borderColor = UIColor.whiteColor().CGColor
            dayView.layer.borderWidth = 0.5
            self.addSubview(dayView)
        }
        
        for i in 0 ..< 12 {
            let indexView = UIView(frame: CGRect(x: 30, y: 30 + i * 60, width: 30, height: 60))
            let showTextLabel = UILabel()
            showTextLabel.frame = CGRect(x: 0, y: 0, width: 20, height: 100)
            showTextLabel.font = UIFont.systemFontOfSize(14)
            showTextLabel.numberOfLines = 0
            showTextLabel.lineBreakMode = .ByWordWrapping
            showTextLabel.textAlignment = .Center
            showTextLabel.text = "第\(i + 1)节"
            showTextLabel.sizeToFit()
            showTextLabel.center = CGPoint(x: indexView.bounds.width / 2, y: indexView.bounds.height / 2)
            indexView.addSubview(showTextLabel)
            indexView.backgroundColor = UIColor(red: 180 / 255, green: 235 / 255, blue: 255 / 255, alpha: 1)
            indexView.layer.cornerRadius = 5
            indexView.layer.borderColor = UIColor.whiteColor().CGColor
            indexView.layer.borderWidth = 0.5
            
            self.addSubview(indexView)
        }
        
        for i in 0 ..< 3 {
            var y = 0
            var height = 0
            switch i {
            case 0: y = 30; height = 5 * 60
            case 1: y = 30 + 5 * 60; height = 4 * 60
            case 2: y = 30 + 9 * 60; height = 3 * 60
            default: break
            }
            let indexView = UIView(frame: CGRect(x: 0, y: y, width: 30, height: height))
            let showTextLabel = UILabel()
            showTextLabel.frame = CGRect(x: 0, y: 0, width: 20, height: 100)
            showTextLabel.font = UIFont.systemFontOfSize(14)
            showTextLabel.numberOfLines = 0
            showTextLabel.lineBreakMode = .ByWordWrapping
            showTextLabel.textAlignment = .Center
            switch i {
            case 0: showTextLabel.text = "上午"
            case 1: showTextLabel.text = "下午"
            case 2: showTextLabel.text = "晚上"
            default: break
            }
            showTextLabel.sizeToFit()
            showTextLabel.center = CGPoint(x: indexView.bounds.width / 2, y: indexView.bounds.height / 2)
            indexView.addSubview(showTextLabel)
            indexView.backgroundColor = UIColor(red: 180 / 255, green: 235 / 255, blue: 255 / 255, alpha: 1)
            indexView.layer.cornerRadius = 5
            indexView.layer.borderColor = UIColor.whiteColor().CGColor
            indexView.layer.borderWidth = 0.5
            
            self.addSubview(indexView)
        }
        
    }
    
    //button相应事件
    func addWeek(button: UIButton) {
        self.weekIndex += 1
        button.setTitle("第\(self.weekIndex)周", forState: UIControlState.Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Course {
    var weekRange: Range<Int>
    var day: Int
    var courseTimeStart: Int
    var courseCount: Int
    var courseInformation: String
    
    init(weekRange: Range<Int>, day: Int, courseTimeStart: Int, courseCount: Int, courseInformation: String) {
        self.weekRange = weekRange
        self.courseTimeStart = courseTimeStart
        self.courseCount = courseCount
        self.courseInformation = courseInformation
        self.day = day
    }
}