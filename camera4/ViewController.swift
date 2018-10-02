//
//  ViewController.swift
//  camera4
//
//  Created by 菊地雅之 on 2018/09/24.
//  Copyright © 2018年 Masayuki Kikuchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

   
    @IBOutlet weak var cameraView: UIImageView!
    @IBOutlet weak var cameraView2: UIImageView!
    @IBOutlet weak var cameraView3: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    //各UIImageViewに異なる写真を載せる
    var imageViewNumber: Int = 0
    var pickImageViewNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.text = "Tap the [＋] to take a picture"
    }

    
    //カメラの撮影開始①
    @IBAction func startCamera(_ sender: Any) {
        imageViewNumber = 1
        takePicture()
        
    }
    //カメラの撮影開始②
    @IBAction func startCamera2(_ sender: Any) {
        imageViewNumber = 2
        takePicture()
        
    }
    //カメラの撮影開始③
    @IBAction func startCamera3(_ sender: Any) {
        imageViewNumber = 3
        takePicture()
        
    }
    
    
    func takePicture(){
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        //カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
        //インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            label.text = "error"
        
        }
    }
    
   
    
    //撮影が完了した時に呼ばれる 3枚別々のUIImageViewを表示する
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage]
            as? UIImage {
            
            
            
            if imageViewNumber == 1{
                cameraView.contentMode = .scaleAspectFit
                cameraView.image = pickedImage
            }else if imageViewNumber == 2{
                cameraView2.contentMode = .scaleAspectFit
                cameraView2.image = pickedImage
            
            }else if imageViewNumber == 3{
                cameraView3.contentMode = .scaleAspectFit
                cameraView3.image = pickedImage
        
            }
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        label.text = "Tap the[保存] to save a picture"
        
        }
    
    }
        
        
        
    //書き込み完了結果の受け取り
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error.code)
            label.text = "保存 Failed !"
        }
        else{
            label.text = "保存 Succeed !"
        }
    }
    
    
    
    
    //写真を保存
        
    @IBAction func savePicture(_ sender: Any) {
        let image:UIImage! = cameraView.image
        
        if image != nil {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(ViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        else{
            label.text = "image Failed !"
        }
        
    }
    
    
    
    //アルバムを表示
    @IBAction func showAlbum(_ sender: Any) {
       pickImageViewNumber = 1
        showImageList()
    }
    
    @IBAction func showAlbum2(_ sender: Any) {
       pickImageViewNumber = 2
        showImageList()
    }
    
    @IBAction func showAlbum3(_ sender: Any) {
       pickImageViewNumber = 3
        showImageList()
    }
    
        
        
        
    func showImageList(){
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.photoLibrary){
                
                //インスタンスの作成
                let cameraPicker = UIImagePickerController()
                cameraPicker.sourceType = sourceType
                cameraPicker.delegate = self
                self.present(cameraPicker, animated: true, completion: nil)
            
                label.text = "Tap the [保存] to save a picture"
            
            
            if let showedImage = [UIImagePickerController]()
                as? UIImage {
            
            if pickImageViewNumber == 1{
                cameraView.contentMode = .scaleAspectFit
                cameraView.image = showedImage
            }else if pickImageViewNumber == 2{
                cameraView2.contentMode = .scaleAspectFit
                cameraView2.image = showedImage
                
            }else if pickImageViewNumber == 3{
                cameraView3.contentMode = .scaleAspectFit
                cameraView3.image = showedImage
                
            }
            
                
                
            
                }
        else{
            label.text = "error"
            
        }
        
    }
    
    
        func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
}
