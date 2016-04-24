import UIKit
class MyCustomCell: UITableViewCell {
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    var cellWidth: CGFloat?
    var cellHeight: CGFloat?
    
    let myLabel = UILabel()
    let likeButton = UIButton()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
//        let cellWidth = screenSize.width
//        let cellHeight = screenSize.height / 7
        myLabel.frame = CGRect(x: 10, y: 10, width: 140, height: 30)
        myLabel.backgroundColor = UIColor.yellowColor()
        

        
        
        self.contentView.addSubview(myLabel)
    }
    
    func testing() {
        print("hello")
//        print(randomData);
    }
    
    func addButtons() {
        let likeButton = UIButton()
        likeButton.frame = CGRectMake(cellWidth! / 2, cellHeight! / 2, cellWidth! / 8, cellHeight! / 2)
        likeButton.setTitle("Like", forState: UIControlState.Normal)
        likeButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        likeButton.addTarget(self, action: "testing", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(likeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}