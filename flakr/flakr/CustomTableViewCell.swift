import UIKit
class MyCustomCell: UITableViewCell {
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    var cellWidth: CGFloat?
    var cellHeight: CGFloat?
    var currFlake: FlakeData?
    
    let flakerLabel = UILabel()
    let separatorLabel = UILabel()
    let timeStampLabel = UILabel()
    var bgImage: UIImageView = UIImageView()
    
    let likeButton = UIButton()
    let commentButton = UIButton()

    @IBAction func firstButton(sender: UIButton) {
        sender.titleLabel?.textColor  = UIColor.redColor()
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    

    func addButtons() {
        let likeButton = UIButton()
        likeButton.frame = CGRect(x: cellHeight! * 0.7, y: cellHeight! * 0.5, width: cellHeight!, height: cellHeight! * 0.5)
        likeButton.setTitle("Like", forState: UIControlState.Normal)
        likeButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        likeButton.addTarget(self, action: "likeAction", forControlEvents: UIControlEvents.TouchUpInside)
        likeButton.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Highlighted)
        
        let commentButton = UIButton()
        commentButton.frame = CGRect(x: cellHeight! * 1.8, y: cellHeight! * 0.5, width: cellHeight!, height: cellHeight! * 0.5)
        commentButton.setTitle("Comment", forState: UIControlState.Normal)
        commentButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        commentButton.addTarget(self, action: "commentAction", forControlEvents: UIControlEvents.TouchUpInside)
        commentButton.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Highlighted)
        
        self.contentView.addSubview(commentButton)
        self.contentView.addSubview(likeButton)
    }
    
    func likeAction() {
        print("liked!")
    }
    
    func commentAction() {
        print("commented!")
    }
    
    
    
    func addLabels() {
        var options: [String] = [" flaked on ", " pussied out on ", " ditched "]
        print(arc4random_uniform(UInt32(options.count)))
        var randIndex: Int = Int(arc4random_uniform(UInt32(options.count)))
        flakerLabel.text = currFlake!.flaker + options[randIndex] + currFlake!.flakee
        flakerLabel.frame = CGRect(x: cellHeight!, y: 0, width: cellWidth! * 0.7, height: cellHeight! / 2)
        
        separatorLabel.frame = CGRect(x: cellWidth! * 0.1, y: cellHeight!, width: cellWidth! * 0.8, height: 1.3)
        separatorLabel.backgroundColor = UIColor.cyanColor()
        
        self.contentView.addSubview(separatorLabel)
        self.contentView.addSubview(flakerLabel)
        
        
    }
    
    func addImages() {
        var image: UIImage = UIImage(named: "ajay_logo")!
        bgImage = UIImageView(image: image)
        bgImage.contentMode = UIViewContentMode.ScaleAspectFit
        bgImage.frame = CGRect(x: cellHeight! * 0.2, y: cellHeight! * 0.2, width: cellHeight! * 0.6, height: cellHeight! * 0.6)
        bgImage.layer.cornerRadius = bgImage.frame.size.height / 2
        bgImage.layer.masksToBounds = true
        bgImage.layer.borderWidth = 0;
        self.contentView.addSubview(bgImage)
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//    }
}