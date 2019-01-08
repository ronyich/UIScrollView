//
//  ViewController.swift
//  UIScrollView
//
//  Created by Ron Yi on 2019/1/8.
//  Copyright © 2019 Ron Yi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var mainView: UIView!

    var scrollView = UIScrollView()

    var imageView = UIImageView()

    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.addSubview(scrollView)

        srollViewConfig()
        
        imageViewConfig()

        imageView.image = UIImage(named: "icon_photo")

    }

    @IBAction func pickAnImage(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePickerController.delegate = self
            imagePickerController.sourceType = .savedPhotosAlbum
            imagePickerController.allowsEditing = false
            
            self.present(imagePickerController, animated: true, completion: nil)

        } else {

            print("Pick an Image error.")
            
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            srollViewConfig()
            imageView.image = pickedImage

        } else {

            print("PickedImage as UIImage error.")

        }

        self.dismiss(animated: true)

    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {

        return imageView

    }

    func srollViewConfig() {
        
        scrollView.delegate = self

        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        
        scrollView.contentSize = imageView.bounds.size
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        scrollView.contentOffset = CGPoint(x: mainView.center.x, y: mainView.center.y)

        scrollView.maximumZoomScale = 2.0

//        scrollView.contentSize.width = 2000
//        scrollView.contentSize.height = 2000
        
//        scrollView.minimumZoomScale = 1.0
//        scrollView.zoomScale = 1.0

        setZoomScale()

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true

        scrollView.addSubview(imageView)
        
    }

    func imageViewConfig() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
//        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
//        imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true

        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true

    }

    func setZoomScale() {
        
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = 1.0
        
    }

    override func viewWillLayoutSubviews() {

        setZoomScale()

    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {

        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size

        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0

        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)

    }

}

