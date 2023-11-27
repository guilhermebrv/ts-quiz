//
//  SecondScreenVC.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 23/09/2023.
//

import UIKit
import PhotosUI


class SecondScreenVC: UIViewController {
    
    var secondScreenView: SecondsScreenView?
    
    var alertController: SelectPhotoAlertController?
        
    var cameraPicker: UIImagePickerController = UIImagePickerController()
        
    override func loadView() {
        secondScreenView = SecondsScreenView()
        view = secondScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configCameraPicker()
        alertController = SelectPhotoAlertController(controller: self)
        secondScreenView?.delegate(delegate: self)
        secondScreenView?.playerNameTextField.delegate = self
    }
    
    func configCameraPicker() {
        cameraPicker.delegate = self
    }
}

extension SecondScreenVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
    
    func presentPHPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let itemProvider = results.first?.itemProvider else {
                    return
                }
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) {
                [weak self] (image, error) in
                if let selectedImage = image as? UIImage {
                    DispatchQueue.main.async {
                        self?.secondScreenView?.playerChooseImageButton.setBackgroundImage(selectedImage, for: .normal)
                    }
                } else {
                    return
                }
            }
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            if let selectedImage = info[.originalImage] as? UIImage {
                    self.secondScreenView?.playerChooseImageButton.setBackgroundImage(selectedImage, for: .normal)
                    self.secondScreenView?.playerChooseImageButton.imageView?.contentMode = .scaleToFill
                }
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}

extension SecondScreenVC: SecondScreenViewProtocol, UITextFieldDelegate {
    
    func tappedChooseImage() {
        secondScreenView?.playerChooseImageButton.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 174/255, alpha: 0.8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.secondScreenView?.playerChooseImageButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 0.7)
        }
        
        self.alertController?.chooseImage(completion: { option in
            switch option {
            case .camera:
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    self.cameraPicker.sourceType = .camera
                    self.present(self.cameraPicker, animated: true)
                } else {
                    self.presentPHPicker()
                }
            case .library:
                self.presentPHPicker()
            case .cancel:
                break
            }
        })
        }
    
    func tappedChooseFavEraButton() {
        let chooseEra = ChooseEraModalVC()
        chooseEra.modalTransitionStyle = .flipHorizontal
        present(chooseEra, animated: true)
        
        secondScreenView?.chooseFavoriteEraButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.secondScreenView?.chooseFavoriteEraButton.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 174/255, alpha: 0.8)
        }
    }
    
    func tappedNextStepButton() {
        let nextScreen = ChooseDifficultyVC()
            self.navigationController?.pushViewController(nextScreen, animated: true)
        
        secondScreenView?.nextStepButton.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 174/255, alpha: 0.8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.secondScreenView?.nextStepButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 0.7)
        }
        
        TemporaryDataStorage.shared.playerName = secondScreenView?.playerNameTextField.text ?? ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)

        let maxCharacterLimit = 13
        let minCharacterLimit = 5
        
        if updatedText.count > maxCharacterLimit {
            secondScreenView?.animationMaxCharacters()
            return false
        }
        
       if textField.text?.count ?? 0 < minCharacterLimit {
            secondScreenView?.animationMinCharacters()
            return true
       }
        
        secondScreenView?.alertMaxCharactersLabel.alpha = 0.0
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let current = textField.text
        let minCharacterLimit = 5
        
        if let text = textField.text, text.isEmpty {
            secondScreenView?.playerNameLabel.text = "Hello, \nplayer!"
            secondScreenView?.nextStepButton.isEnabled = false
            secondScreenView?.alertMaxCharactersLabel.alpha = 0.0
        } else if let text = textField.text, text.count < minCharacterLimit {
            secondScreenView?.playerNameLabel.text = "Hello, \n\(current ?? "player")!"
            secondScreenView?.animationMinCharacters()
            secondScreenView?.nextStepButton.isEnabled = false
        } else {
            secondScreenView?.playerNameLabel.text = "Hello, \n\(current ?? "player")!"
            secondScreenView?.nextStepButton.isEnabled = true
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        return true
    }
}
