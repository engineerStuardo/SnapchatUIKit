//
//  UploadVC.swift
//  SnapchatUIKit
//
//  Created by Italo Stuardo on 30/4/23.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        uploadImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        uploadImageView.addGestureRecognizer(gesture)
    }
    
    @objc func choosePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }

    @IBAction func uploadSnap(_ sender: Any) {
        let fs = Firestore.firestore()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("media")
        let userInfo = UserSingleton.sharedInstance
        
        if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    imageRef.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            fs.collection("Snaps").whereField("snapOwner", isEqualTo: userInfo.username).getDocuments { snapshot, error in
                                if error != nil {
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                } else {
                                    if snapshot?.isEmpty == false && snapshot != nil {
                                        for document in snapshot!.documents {
                                            let documentId = document.documentID

                                            if var imageUrlArray = document.get("imageUrlArray") as? [String] {
                                                imageUrlArray.append(imageUrl!)
                                                let additionalDictionary = ["imageUrlArray": imageUrlArray] as [String: Any]
                                                fs.collection("Snaps").document(documentId).setData(additionalDictionary, merge: true) { error in
                                                    if error == nil {
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.uploadImageView.image = UIImage(named: "selectimage.png")
                                                    }
                                                }
                                            }
                                        }
                                    } else {
                                        let snapDictionary = ["imageUrlArray": [imageUrl!], "snapOwner": userInfo.username, "date": FieldValue.serverTimestamp()] as [String: Any]
                                        fs.collection("Snaps").addDocument(data: snapDictionary) { error in
                                            if error != nil {
                                                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                            } else {
                                                self.tabBarController?.selectedIndex = 0
                                                self.uploadImageView.image = UIImage(named: "selectimage.png")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
