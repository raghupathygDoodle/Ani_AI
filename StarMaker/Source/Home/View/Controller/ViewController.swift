//
//  ViewController.swift
//  APIBase
//
//  Created by Raghu on 29/05/23.
//

import UIKit
import JJFloatingActionButton
import AVFoundation
import AVKit
import GSPlayer

class ViewController: BaseVC,UIApplicationDelegate {

    @IBOutlet weak var jjFloatingActionButton: JJFloatingActionButton!
    
    var valueee = [String]()

    var closurr: (()->())?
    var indexValue = 0
    var selectedInd: Int?
    var indexItem = 0
    var ur = [String]()
    var viURL = URL(string: "")
    var subCatIndex = 0
//    var lists = ["https://scontent-bom1-1.cdninstagram.com/v/t66.30100-16/43505586_272194585364333_1429424540395265832_n.mp4?_nc_ht=scontent-bom1-1.cdninstagram.com&_nc_cat=105&_nc_ohc=MaTWNebGtnYAX-MMlXJ&edm=AP_V10EBAAAA&ccb=7-5&oh=00_AfBYKpi_zTI6jx-KKjyx0shiqKb924tRRxc6SGKDhjUCQQ&oe=649ACC8E&_nc_sid=8721cf","https://scontent-bom1-1.cdninstagram.com/o1/v/t16/f1/m82/1443341836F6A6790FD137578312EFBF_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLmNsaXBzLmJhc2VsaW5lIn0&_nc_ht=scontent-bom1-1.cdninstagram.com&_nc_cat=102&vs=741577030863329_1315474820&_nc_vs=HBksFQIYT2lnX3hwdl9yZWVsc19wZXJtYW5lbnRfcHJvZC8xNDQzMzQxODM2RjZBNjc5MEZEMTM3NTc4MzEyRUZCRl92aWRlb19kYXNoaW5pdC5tcDQVAALIAQAVABgkR080V2l4TjlBekJzNkFzREFQY2tvY19ieEVjOGJxX0VBQUFGFQICyAEAKAAYABsAFQAAJvTC3%2BOD%2BtRAFQIoAkMzLBdAOKp%2B%2Bdsi0RgSZGFzaF9iYXNlbGluZV8xX3YxEQB1%2FgcA&_nc_rid=e21df130b6&ccb=9-4&oh=00_AfDMds_G7ultLJrJSmG_dgxRUowWBv4b7lpB9sf1ipaz3g&oe=649B275B&_nc_sid=8721cf","https://scontent-bom1-1.cdninstagram.com/o1/v/t16/f1/m82/E2452CEAC9C06B476CE75E81B7D0159E_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLmNsaXBzLmJhc2VsaW5lIn0&_nc_ht=scontent-bom1-1.cdninstagram.com&_nc_cat=102&vs=1055287069197277_2519882185&_nc_vs=HBksFQIYT2lnX3hwdl9yZWVsc19wZXJtYW5lbnRfcHJvZC9FMjQ1MkNFQUM5QzA2QjQ3NkNFNzVFODFCN0QwMTU5RV92aWRlb19kYXNoaW5pdC5tcDQVAALIAQAVABgkR0pPS25CTjh4dGJtSm9jQUFCYmRVUmhveUNrOGJxX0VBQUFGFQICyAEAKAAYABsAFQAAJp7pifXzlvk%2FFQIoAkMzLBdAQEAAAAAAABgSZGFzaF9iYXNlbGluZV8xX3YxEQB1%2FgcA&_nc_rid=5b74a9f120&ccb=9-4&oh=00_AfA4Wbnk8Lnt4ExwY1E6hCgY2vUXtVzvv4oHxsVBA8SvAA&oe=649AED53&_nc_sid=8721cf","https://scontent-bom1-1.cdninstagram.com/o1/v/t16/f1/m82/0C45AC2EE25D5DE10E3895B9DD1E0FA6_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLmNsaXBzLmJhc2VsaW5lIn0&_nc_ht=scontent-bom1-1.cdninstagram.com&_nc_cat=101&vs=169637839184694_630337152&_nc_vs=HBksFQIYT2lnX3hwdl9yZWVsc19wZXJtYW5lbnRfcHJvZC8wQzQ1QUMyRUUyNUQ1REUxMEUzODk1QjlERDFFMEZBNl92aWRlb19kYXNoaW5pdC5tcDQVAALIAQAVABgkR01wRTZ4UEpGRlZ2VENZVkFLSHBwTWNySENZemJxX0VBQUFGFQICyAEAKAAYABsAFQAAJsr1iYyduOw%2FFQIoAkMzLBdAMG7ZFocrAhgSZGFzaF9iYXNlbGluZV8xX3YxEQB1%2FgcA&_nc_rid=5ffc98f4c5&ccb=9-4&oh=00_AfDPJzunMYQJv861c2Apk3u9VVl6rhUcJI-IuSBrM-W4iA&oe=649B1406&_nc_sid=8721cf","https://scontent-bom1-2.cdninstagram.com/v/t50.2886-16/10000000_463966558721711_3596831325835874918_n.mp4?efg=eyJ2ZW5jb2RlX3RhZyI6InZ0c192b2RfdXJsZ2VuLjcyMC5jbGlwcy5iYXNlbGluZSIsInFlX2dyb3VwcyI6IltcImlnX3dlYl9kZWxpdmVyeV92dHNfb3RmXCJdIn0&_nc_ht=scontent-bom1-2.cdninstagram.com&_nc_cat=111&_nc_ohc=gWAeGNbpdbcAX9P89m0&edm=AP_V10EBAAAA&vs=1177795699748622_1775287726&_nc_vs=HBksFQAYJEdJQ1dtQUN2bHV1aF9hVUJBR2JTY2JVSWdfb3hicV9FQUFBRhUAAsgBABUAGCRHTzkxNFJHY1l4ZFFnQWdMQUxUejFKOGJhRU1DYnFfRUFBQUYVAgLIAQAoABgAGwAVAAAmxtjIvu%2F4h0EVAigCQzMsF0A%2BTMzMzMzNGBJkYXNoX2Jhc2VsaW5lXzFfdjERAHX%2BBwA%3D&_nc_rid=9c3c4e11fe&ccb=7-5&oh=00_AfAagCfU_6I5dJNz1ihyz0PoP5SmpZesTpex5_WdTHoEpw&oe=649B28F4&_nc_sid=8721cf","https://scontent-bom1-1.cdninstagram.com/v/t50.2886-16/283463121_425792365765345_8254882158951697967_n.mp4?efg=eyJ2ZW5jb2RlX3RhZyI6InZ0c192b2RfdXJsZ2VuLjcyMC5jbGlwcy5iYXNlbGluZSIsInFlX2dyb3VwcyI6IltcImlnX3dlYl9kZWxpdmVyeV92dHNfb3RmXCJdIn0&_nc_ht=scontent-bom1-1.cdninstagram.com&_nc_cat=101&_nc_ohc=8fCvhqMTGU8AX_G69eK&edm=AP_V10EBAAAA&vs=738938053907169_472412488&_nc_vs=HBksFQAYJEdORk41UkRob3JXQ1FZTUJBQ19PQmx1V080OXlicV9FQUFBRhUAAsgBABUAGCRHSEZiQ0JFai1zT0Qyb29CQUhhVHJzTk1oT0plYnFfRUFBQUYVAgLIAQAoABgAGwAVAAAmppW3oY6c5D8VAigCQzMsF0AfMzMzMzMzGBJkYXNoX2Jhc2VsaW5lXzFfdjERAHX%2BBwA%3D&_nc_rid=13304391f9&ccb=7-5&oh=00_AfACRmLVm6iDJAF7bCbcEwCBYQYuprS7RRThxYBKQhu_Qw&oe=649B4545&_nc_sid=8721cf","https://scontent-bom1-1.cdninstagram.com/o1/v/t16/f1/m82/664D8C74FB16EAA74BC42BD2B3CFB081_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLmNsaXBzLmJhc2VsaW5lIn0&_nc_ht=scontent-bom1-1.cdninstagram.com&_nc_cat=103&vs=590588946459992_3243512422&_nc_vs=HBksFQIYT2lnX3hwdl9yZWVsc19wZXJtYW5lbnRfcHJvZC82NjREOEM3NEZCMTZFQUE3NEJDNDJCRDJCM0NGQjA4MV92aWRlb19kYXNoaW5pdC5tcDQVAALIAQAVABgkR0VJTUdoVHR4YjRySG5jREFEeUVYbEFrSDVGcWJxX0VBQUFGFQICyAEAKAAYABsAFQAAJv7li5uU95ZBFQIoAkMzLBdAQCZFocrAgxgSZGFzaF9iYXNlbGluZV8xX3YxEQB1%2FgcA&_nc_rid=ffc7f11e17&ccb=9-4&oh=00_AfDAkVjS5PqQD80kjNFZUnhc2_Uad6jaoMlWzDNmiTJzvg&oe=649AFF6D&_nc_sid=8721cf","https://scontent-bom1-1.cdninstagram.com/v/t66.30100-16/43505586_272194585364333_1429424540395265832_n.mp4?_nc_ht=scontent-bom1-1.cdninstagram.com&_nc_cat=105&_nc_ohc=MaTWNebGtnYAX-MMlXJ&edm=AP_V10EBAAAA&ccb=7-5&oh=00_AfBYKpi_zTI6jx-KKjyx0shiqKb924tRRxc6SGKDhjUCQQ&oe=649ACC8E&_nc_sid=8721cf","https://scontent-bom1-1.cdninstagram.com/o1/v/t16/f1/m82/1443341836F6A6790FD137578312EFBF_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLmNsaXBzLmJhc2VsaW5lIn0&_nc_ht=scontent-bom1-1.cdninstagram.com&_nc_cat=102&vs=741577030863329_1315474820&_nc_vs=HBksFQIYT2lnX3hwdl9yZWVsc19wZXJtYW5lbnRfcHJvZC8xNDQzMzQxODM2RjZBNjc5MEZEMTM3NTc4MzEyRUZCRl92aWRlb19kYXNoaW5pdC5tcDQVAALIAQAVABgkR080V2l4TjlBekJzNkFzREFQY2tvY19ieEVjOGJxX0VBQUFGFQICyAEAKAAYABsAFQAAJvTC3%2BOD%2BtRAFQIoAkMzLBdAOKp%2B%2Bdsi0RgSZGFzaF9iYXNlbGluZV8xX3YxEQB1%2FgcA&_nc_rid=e21df130b6&ccb=9-4&oh=00_AfDMds_G7ultLJrJSmG_dgxRUowWBv4b7lpB9sf1ipaz3g&oe=649B275B&_nc_sid=8721cf","https://scontent-bom1-1.cdninstagram.com/o1/v/t16/f1/m82/E2452CEAC9C06B476CE75E81B7D0159E_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLmNsaXBzLmJhc2VsaW5lIn0&_nc_ht=scontent-bom1-1.cdninstagram.com&_nc_cat=102&vs=1055287069197277_2519882185&_nc_vs=HBksFQIYT2lnX3hwdl9yZWVsc19wZXJtYW5lbnRfcHJvZC9FMjQ1MkNFQUM5QzA2QjQ3NkNFNzVFODFCN0QwMTU5RV92aWRlb19kYXNoaW5pdC5tcDQVAALIAQAVABgkR0pPS25CTjh4dGJtSm9jQUFCYmRVUmhveUNrOGJxX0VBQUFGFQICyAEAKAAYABsAFQAAJp7pifXzlvk%2FFQIoAkMzLBdAQEAAAAAAABgSZGFzaF9iYXNlbGluZV8xX3YxEQB1%2FgcA&_nc_rid=5b74a9f120&ccb=9-4&oh=00_AfA4Wbnk8Lnt4ExwY1E6hCgY2vUXtVzvv4oHxsVBA8SvAA&oe=649AED53&_nc_sid=8721cf","https://scontent-bom1-1.cdninstagram.com/o1/v/t16/f1/m82/0C45AC2EE25D5DE10E3895B9DD1E0FA6_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLmNsaXBzLmJhc2VsaW5lIn0&_nc_ht=scontent-bom1-1.cdninstagram.com&_nc_cat=101&vs=169637839184694_630337152&_nc_vs=HBksFQIYT2lnX3hwdl9yZWVsc19wZXJtYW5lbnRfcHJvZC8wQzQ1QUMyRUUyNUQ1REUxMEUzODk1QjlERDFFMEZBNl92aWRlb19kYXNoaW5pdC5tcDQVAALIAQAVABgkR01wRTZ4UEpGRlZ2VENZVkFLSHBwTWNySENZemJxX0VBQUFGFQICyAEAKAAYABsAFQAAJsr1iYyduOw%2FFQIoAkMzLBdAMG7ZFocrAhgSZGFzaF9iYXNlbGluZV8xX3YxEQB1%2FgcA&_nc_rid=5ffc98f4c5&ccb=9-4&oh=00_AfDPJzunMYQJv861c2Apk3u9VVl6rhUcJI-IuSBrM-W4iA&oe=649B1406&_nc_sid=8721cf","https://scontent-bom1-2.cdninstagram.com/v/t50.2886-16/10000000_463966558721711_3596831325835874918_n.mp4?efg=eyJ2ZW5jb2RlX3RhZyI6InZ0c192b2RfdXJsZ2VuLjcyMC5jbGlwcy5iYXNlbGluZSIsInFlX2dyb3VwcyI6IltcImlnX3dlYl9kZWxpdmVyeV92dHNfb3RmXCJdIn0&_nc_ht=scontent-bom1-2.cdninstagram.com&_nc_cat=111&_nc_ohc=gWAeGNbpdbcAX9P89m0&edm=AP_V10EBAAAA&vs=1177795699748622_1775287726&_nc_vs=HBksFQAYJEdJQ1dtQUN2bHV1aF9hVUJBR2JTY2JVSWdfb3hicV9FQUFBRhUAAsgBABUAGCRHTzkxNFJHY1l4ZFFnQWdMQUxUejFKOGJhRU1DYnFfRUFBQUYVAgLIAQAoABgAGwAVAAAmxtjIvu%2F4h0EVAigCQzMsF0A%2BTMzMzMzNGBJkYXNoX2Jhc2VsaW5lXzFfdjERAHX%2BBwA%3D&_nc_rid=9c3c4e11fe&ccb=7-5&oh=00_AfAagCfU_6I5dJNz1ihyz0PoP5SmpZesTpex5_WdTHoEpw&oe=649B28F4&_nc_sid=8721cf","https://scontent-bom1-1.cdninstagram.com/v/t50.2886-16/283463121_425792365765345_8254882158951697967_n.mp4?efg=eyJ2ZW5jb2RlX3RhZyI6InZ0c192b2RfdXJsZ2VuLjcyMC5jbGlwcy5iYXNlbGluZSIsInFlX2dyb3VwcyI6IltcImlnX3dlYl9kZWxpdmVyeV92dHNfb3RmXCJdIn0&_nc_ht=scontent-bom1-1.cdninstagram.com&_nc_cat=101&_nc_ohc=8fCvhqMTGU8AX_G69eK&edm=AP_V10EBAAAA&vs=738938053907169_472412488&_nc_vs=HBksFQAYJEdORk41UkRob3JXQ1FZTUJBQ19PQmx1V080OXlicV9FQUFBRhUAAsgBABUAGCRHSEZiQ0JFai1zT0Qyb29CQUhhVHJzTk1oT0plYnFfRUFBQUYVAgLIAQAoABgAGwAVAAAmppW3oY6c5D8VAigCQzMsF0AfMzMzMzMzGBJkYXNoX2Jhc2VsaW5lXzFfdjERAHX%2BBwA%3D&_nc_rid=13304391f9&ccb=7-5&oh=00_AfACRmLVm6iDJAF7bCbcEwCBYQYuprS7RRThxYBKQhu_Qw&oe=649B4545&_nc_sid=8721cf","https://scontent-bom1-1.cdninstagram.com/o1/v/t16/f1/m82/664D8C74FB16EAA74BC42BD2B3CFB081_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLmNsaXBzLmJhc2VsaW5lIn0&_nc_ht=scontent-bom1-1.cdninstagram.com&_nc_cat=103&vs=590588946459992_3243512422&_nc_vs=HBksFQIYT2lnX3hwdl9yZWVsc19wZXJtYW5lbnRfcHJvZC82NjREOEM3NEZCMTZFQUE3NEJDNDJCRDJCM0NGQjA4MV92aWRlb19kYXNoaW5pdC5tcDQVAALIAQAVABgkR0VJTUdoVHR4YjRySG5jREFEeUVYbEFrSDVGcWJxX0VBQUFGFQICyAEAKAAYABsAFQAAJv7li5uU95ZBFQIoAkMzLBdAQCZFocrAgxgSZGFzaF9iYXNlbGluZV8xX3YxEQB1%2FgcA&_nc_rid=ffc7f11e17&ccb=9-4&oh=00_AfDAkVjS5PqQD80kjNFZUnhc2_Uad6jaoMlWzDNmiTJzvg&oe=649AFF6D&_nc_sid=8721cf"]
    var lists = ["https://user-images.githubusercontent.com/90382113/170887700-e405c71e-fe31-458d-8572-aea2e801eecc.mp4","https://user-images.githubusercontent.com/90382113/170885742-d82e3b59-e45a-4fcf-a851-fed58ff5a690.mp4","https://user-images.githubusercontent.com/90382113/170888784-5d9a7623-10c8-4ca2-8585-fdb29b2ed037.mp4","https://user-images.githubusercontent.com/90382113/170889265-7ed9a56c-dd5f-4d78-b453-18b011644da0.mp4","https://user-images.githubusercontent.com/90382113/170890384-43214cc8-79c6-4815-bcb7-e22f6f7fe1bc.mp4","https://user-images.githubusercontent.com/90382113/170887700-e405c71e-fe31-458d-8572-aea2e801eecc.mp4","https://user-images.githubusercontent.com/90382113/170885742-d82e3b59-e45a-4fcf-a851-fed58ff5a690.mp4","https://user-images.githubusercontent.com/90382113/170888784-5d9a7623-10c8-4ca2-8585-fdb29b2ed037.mp4","https://user-images.githubusercontent.com/90382113/170889265-7ed9a56c-dd5f-4d78-b453-18b011644da0.mp4","https://user-images.githubusercontent.com/90382113/170890384-43214cc8-79c6-4815-bcb7-e22f6f7fe1bc.mp4"]
    var listss = ["fyQblmSwP5o","2Yavgd1buUU","3iIdsmrAi8k","i4p5w_yEe-c","aPfxC4NmNXY"]
    var categories = ["Beauty","Nails","HairCare","SkinCare","Entertainment","Face","Dance"]
    @IBOutlet weak var videoPlayingCollectionView: UICollectionView!

    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    @IBOutlet weak var subCategoryView: UIView!
    @IBOutlet weak var labelSubCategoryTitle: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var videoURLCategory = false
    var categoriesModel: Categories?
    var categoriesList: [CategoryList]?
    var subCategories = [Subcategory]()
    var totalCollection = [String]()
    var collectionString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        
        
        
        
        
        
        
        
        
        
        
       
        videoPlayingCollectionView.delegate = self
        videoPlayingCollectionView.dataSource = self
       
        videoPlayingCollectionView.register(UINib(nibName: "VideosListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideosListCollectionViewCell")
        

        categoryCollectionView.isHidden = false
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: "CategoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryListCollectionViewCell")


        subCategoryView.isHidden = true
        subCategoryCollectionView.isHidden = true
        subCategoryCollectionView.delegate = self
        subCategoryCollectionView.dataSource = self
        subCategoryCollectionView.register(UINib(nibName: "SubCategoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubCategoryListCollectionViewCell")
        
       jjFloatingActionButton.addItem(title: "", image: UIImage(named: "User")?.withRenderingMode(.alwaysOriginal)) { item in
          // do something
            print("User")
        }
        
        jjFloatingActionButton.addItem(title: "", image: UIImage(named: "Edit")?.withRenderingMode(.alwaysOriginal)) { item in
          // do something
            print("Edit")
            if let action = self.closurr{
                action()
            }
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "DescriptionPresentViewController") as? DescriptionPresentViewController
           
            vc?.modalPresentationStyle = .overCurrentContext
            self.present(vc!, animated: true)
        }
        jjFloatingActionButton.addItem(title: "", image: UIImage(named: "Hint")?.withRenderingMode(.alwaysOriginal)) { item in
          // do something
            print("Hint")

        }
        jjFloatingActionButton.addItem(title: "", image: UIImage(named: "Save")?.withRenderingMode(.alwaysOriginal)) { item in
          // do something
            print("save")

        }
        jjFloatingActionButton.itemAnimationConfiguration = .circularPopUp()
        jjFloatingActionButton.buttonColor = .black
        jjFloatingActionButton.itemSizeRatio = 1
        // Do any additional setup after loading the view.
 
//        apiCall()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        check()
        apiCall()
//        self.showTabBar()
    }

   
    @IBAction func buttonSubCategory(_ sender: UIButton) {
        self.subCategoryView.isHidden = true
        self.categoryCollectionView.isHidden = false
        self.videoURLCategory = false
        self.videoPlayingCollectionView.reloadData()
    }
    func apiCall(){
        if let path = Bundle.main.path(forResource: "categories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                self.categoriesModel = try decoder.decode(Categories.self, from: data)
                self.categoriesList = self.categoriesModel?.categoryList
                for i in categoriesList ?? []{
                    self.collectionString = i.category
                    self.totalCollection.append(self.collectionString ?? "")
                }
                print("toaaaaa ======\(self.totalCollection)")
                for i in self.categoriesModel?.categoryList ?? []{
                    self.subCategories.append(contentsOf: i.subcategory ?? [Subcategory]())
                    for j in i.subcategory ?? []{
                        self.ur.append(contentsOf: j.url ?? [])
                    }
                }
                print("url array ==== \(self.ur)")
                print("dataaaa   ==========  \(self.categoriesModel)")
            } catch {
                print("Error loading JSON: \(error)")
            }
        }
    }
//        var parameter = [String : Any]()
//         ApiService.sharedInstance.apiRequest(baseUrl: "https://crudcrud.com/api/", url: "06f4ee44808d4ed6bfdfafdaf4e61086", parameter: parameter, method: .get) { (status: Result<[String]>) in
//             switch status{
//             case .success(data: let data):
//                 self.valueee = data
//                 print("dddd \(self.valueee)")
//             case .failure(message: let message):
//                 print("itemss")
//             case .error(message: let message):
//                 print("valueee")
//             }
//         }
//    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
 
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case videoPlayingCollectionView:
            if videoURLCategory == true{
                return categoriesList?[indexItem].subcategory?[subCatIndex].url?.count ?? 0
            }else{
                return listss.count
            }
           
        case categoryCollectionView:
            return self.categoriesModel?.categoryList?.count ?? 0
        case subCategoryCollectionView:
            return categoriesList?[indexItem].subcategory?.count ?? 0
        default:
            return 0
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        switch collectionView {
        case videoPlayingCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosListCollectionViewCell", for: indexPath) as? VideosListCollectionViewCell else{return UICollectionViewCell()}
            cell.layoutIfNeeded()
            self.indexValue = indexPath.item
            if videoURLCategory == true{
                let urs = URL(string: categoriesList?[indexItem].subcategory?[subCatIndex].url?[indexPath.item] ?? "")
                viURL = urs
            }else{
                
//                let videoURL = URL(string: lists[indexPath.row])!
//                viURL = videoURL
            }
            
            let urs = listss[indexPath.item]
            
            cell.url = viURL
                DispatchQueue.main.async {

//                    cell.configure(with: self.viURL!)
                    cell.ytConfig(urs)
                }


            cell.closureDescription = {
                cell.pause()
//                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "DescriptionPresentViewController") as? DescriptionPresentViewController
//                vc?.modalPresentationStyle = .overCurrentContext
//                vc?.closureDismiss = {
//                    cell.play()
//                    self.dismiss(animated: true)
//                }
//                print("HIiiii pressed")
//                self.present(vc!, animated: true)
            }
            return cell
        case categoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryListCollectionViewCell", for: indexPath) as? CategoryListCollectionViewCell else{
                return UICollectionViewCell()
            }
            cell.selectCategoryButton.tag = indexPath.item
            cell.closureSelectCategory = { [unowned self] index in
                self.indexItem = index
                self.categoryCollectionView.isHidden = true
                self.subCategoryView.isHidden = false
                
                self.labelSubCategoryTitle.text = self.categoriesModel?.categoryList?[index].category
                self.subCategoryCollectionView.reloadData()
                self.videoPlayingCollectionView.reloadData()
                self.subCategoryCollectionView.isHidden = false
            }
            cell.labelCategoryName.text = self.categoriesModel?.categoryList?[indexPath.item].category
            return cell
        case subCategoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryListCollectionViewCell", for: indexPath) as? SubCategoryListCollectionViewCell else {return UICollectionViewCell()}
            cell.selectCategoryButton.tag = indexPath.item
            cell.labelDetailSubCategory.text = categoriesList?[indexItem].subcategory?[indexPath.item].title
            cell.closureSelectCategory = { [unowned self] index in
                self.subCatIndex = index
                self.videoURLCategory = true
                self.videoPlayingCollectionView.reloadData()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
           
       
       
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? VideosListCollectionViewCell{
            cell.play()

        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView{
            self.indexItem = indexPath.item
            categoryCollectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? VideosListCollectionViewCell{

            self.closurr = {
                cell.pause()
            }
            cell.pause()

        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case videoPlayingCollectionView:
            return collectionView.bounds.size
        case categoryCollectionView:
            return CGSize(width: (categoriesModel?.categoryList?[indexPath.item].category?.size(withAttributes: nil).width ?? 0 ) + 50, height: 40)
        case subCategoryCollectionView:
            return CGSize(width: (self.subCategories[selectedInd ?? 0].title?.size(withAttributes: nil).width ?? 0 ) + 50, height: 40)
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{check()}
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        check()
    }
    
    func check() {
        DispatchQueue.main.async {
            self.checkPreload()
            self.checkPlay()
        }
       
    }
    
    func checkPreload() {
        guard let lastRow = videoPlayingCollectionView.indexPathsForVisibleItems.last?.row else { return }
        let arrayUrl = [URL(string: lists[indexValue])!]
        let urls = arrayUrl
            .suffix(from: min(lastRow + 1, arrayUrl.count))
            .prefix(2)

        VideoPreloadManager.shared.set(waiting: Array(urls))
    }
    
    func checkPlay() {
        let visibleCells = videoPlayingCollectionView.visibleCells.compactMap { $0 as? VideosListCollectionViewCell }

        guard visibleCells.count > 0 else { return }

        let visibleFrame = CGRect(x: 0, y: videoPlayingCollectionView.contentOffset.y, width: videoPlayingCollectionView.bounds.width, height: videoPlayingCollectionView.bounds.height)

        let visibleCell = visibleCells
            .filter { visibleFrame.intersection($0.frame).height >= $0.frame.height / 2 }
            .first

        visibleCell?.play()
    }
}

