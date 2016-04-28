import UIKit
import Firebase

class MyCustomCell: UITableViewCell {
    
    
    var ref = Firebase(url:"https://incandescent-heat-1881.firebaseio.com")
    var clientRef = Firebase(url:"https://incandescent-heat-1881.firebaseio.com/users")
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    var cellWidth: CGFloat?
    var cellHeight: CGFloat?
    var currFlake: Flake?
    
    let flakerLabel = UILabel()
    let separatorLabel = UILabel()
    let timeStampLabel = UILabel()
    let reasonLabel = UILabel()
    
    var user_icon: UIImageView = UIImageView()
    
    let likeButton = UIButton()
    let commentButton = UIButton()
    
    var numLikes: Int?

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
        
        DataService.dataService.FLAKE_REF.observeEventType(.Value, withBlock: { snapshot in
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        if (postDictionary["flaker"] as! String == self.currFlake!.flakeFlaker) {
                            print(snapshot.value)
                        }
                     }
                }
            }
        })
    }

    
    func commentAction() {
        print("commented")
//        self.presentViewController(CommentsV, animated: true, completion: nil)
    }
    
    
    func addLabels() {
        var options: [String] = [" flaked on ", " wussed out on ", " ditched ", " abandoned ", " forgot about "]
//        print(arc4random_uniform(UInt32(options.count)))
        var randIndex: Int = Int(arc4random_uniform(UInt32(options.count)))
        
        flakerLabel.text = currFlake!.flakeFlaker + options[randIndex] + currFlake!.flakeFlakee
        flakerLabel.frame = CGRect(x: cellHeight!, y: 0, width: cellWidth! * 0.7, height: cellHeight! / 2)
        
        separatorLabel.frame = CGRect(x: cellWidth! * 0.1, y: cellHeight!, width: cellWidth! * 0.8, height: 1.3)
        separatorLabel.backgroundColor = UIColor.cyanColor()
        
        reasonLabel.text =  "\"" + currFlake!.flakeReason + "\""
        reasonLabel.frame = CGRect(x: cellHeight!, y: cellHeight! * 0.25, width: cellWidth! * 0.7, height: cellHeight! / 2)
        
        self.contentView.addSubview(reasonLabel)
        self.contentView.addSubview(separatorLabel)
        self.contentView.addSubview(flakerLabel)
        
    }
    func addImages() {
        clientRef.observeEventType(.Value, withBlock: {
            snapshot in
            if let password1 = snapshot.value[self.currFlake!.flakeFlaker] {
                if let person = snapshot.value[self.currFlake!.flakeFlaker]! {
                    var photostr = person["default_photo"] as! String
                    self.addImages_helper(true, photo: photostr)
                } else {
                    self.addImages_helper(false, photo: "")
                }
            } else {
                self.addImages_helper(false, photo: "")
            }
        })
    }
    
    
    
    func addImages_helper(flag:Bool, photo: String) {
        var image = UIImage()
        if (flag) {
            image = decodeStringToImage(photo)
        } else {
            image = UIImage(named: "profile")!
        }
        
//        var quoteString = ["string": encodeImageToString(image)]
//        var usersRef = ref.childByAppendingPath("images")
//        
//        var users = ["image":quoteString]
//        
//        usersRef.setValue(users)
        
        user_icon = UIImageView(image: image)
//        user_icon = UIImageView(image: decodeStringToImage(encodeImageToString(image)))
        
//        user_icon.contentMode = UIViewContentMode.ScaleAspectFit
        user_icon.frame = CGRect(x: cellHeight! * 0.2, y: cellHeight! * 0.2, width: cellHeight! * 0.6, height: cellHeight! * 0.6)
        user_icon.layer.cornerRadius = user_icon.frame.size.height / 2
        user_icon.layer.masksToBounds = true
        user_icon.layer.borderWidth = 0;
        self.contentView.addSubview(user_icon)
    }
    
    func encodeImageToString(image: UIImage)->String {
        //Use image name from bundle to create NSData
        //Now use image to create into NSData format
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        return base64String
    }
    
    func decodeStringToImage(something: String)->UIImage {
        let decodedData = NSData(base64EncodedString: something, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let newImage: UIImage = UIImage(data: decodedData!)!
        return newImage
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//    }
}