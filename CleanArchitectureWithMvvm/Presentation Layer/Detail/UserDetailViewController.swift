//
//  UserDetailViewController.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 12/02/2025.
//

import UIKit
import Combine
import SDWebImage
import SwiftUI
import MMPopup // Custom Framework
import CoreML
import Vision
import WatchConnectivity
import SoundAnalysis
import CryptoKit
import Security






class UserDetailViewController: UIViewController {

    private var viewModel: UserDetailViewModel!
    private var cancellables = Set<AnyCancellable>()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    private let movieId: Int
   
    
    // UI Components
      private let imageView = UIImageView()
      private let titleLabel = UILabel()
      private let releaseDate = UILabel()
      private let descriptionLabel = UILabel()
    

    init(viewModel: UserDetailViewModel, userId: Int) {
        self.viewModel = viewModel
        self.movieId = userId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        fetchUserDetail()
      //  setupActivityIndicator()
        view.backgroundColor = .white
      //  swiftUISetup()
        
        animationView()
        
//        //CryptoKit
//        let data = "Hello, CryptoKit!".data(using: .utf8)!
//        let hash = SHA256.hash(data: data)
//        print("SHA-256 Hash: \(hash)")

//        // Generate a symmetric key
//        let key = SymmetricKey(size: .bits256)
//
//        // Encrypt data
//        let data = "Sensitive Data mahesh".data(using: .utf8)!
//        let sealedBox = try! AES.GCM.seal(data, using: key)
//        print("SHA-256 Hash: \(sealedBox)")
//        
//        // Decrypt data
//        let decryptedData = try! AES.GCM.open(sealedBox, using: key)
//        let decryptedString = String(data: decryptedData, encoding: .utf8)!
//        print("Decrypted: \(decryptedString)")
        
        
        
        let data = "Sensitive Data3333".data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userAccount",
            kSecValueData as String: data
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("Data saved to Keychain")
        } else {
            print("Failed to save data: \(status)")
        }
        

        // Retrieve the key from the Keychain
        let retrieveQuery: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: "userAccount",
            kSecReturnData as String: true
        ]
        var item: CFTypeRef?
        SecItemCopyMatching(retrieveQuery as CFDictionary, &item)
        if let retrievedData = item as? Data {
            let retrievedKey = SymmetricKey(data: retrievedData)
            print("Retrieved Key: \(retrievedKey)")
        }
        
        
        
    }
    
    private func animationView() {
        
        
     //   DLBS 3 kitta  needed any can sell me
        
        
//        UIView.animate(withDuration: 1) {
//            self.imageView.layer.cornerRadius = 20
//            self.imageView.layer.shadowOpacity = 0.5
//        }
        
     
      
        
//        let animation = CABasicAnimation(keyPath: "position.y")
//        animation.fromValue = 50
//        animation.toValue = 300
//        animation.duration = 2
//        animation.repeatCount = .infinity
//        animation.autoreverses = true
//
//        imageView.layer.add(animation, forKey: "positionAnimation")
        
        
//        let animation = CAKeyframeAnimation(keyPath: "position")
//        animation.values = [
//            CGPoint(x: 50, y: 50),
//            CGPoint(x: 200, y: 50),
//            CGPoint(x: 200, y: 200),
//            CGPoint(x: 50, y: 200)
//        ]
//        animation.keyTimes = [0, 0.3, 0.7, 1]
//        animation.duration = 4
//        animation.repeatCount = .infinity
//
//        imageView.layer.add(animation, forKey: "keyframeAnimation")
        
//        let animation = CASpringAnimation(keyPath: "transform.scale")
//        animation.fromValue = 1
//        animation.toValue = 2
//        animation.damping = 5
//        animation.initialVelocity = 10
//        animation.duration = 1
//
//        imageView.layer.add(animation, forKey: "springAnimation")
        
//        let transition = CATransition()
//        transition.type = .fade
//        transition.duration = 1
//        imageView.layer.add(transition, forKey: nil)
        
        //        let positionAnimation = CABasicAnimation(keyPath: "position.x")
        //        positionAnimation.fromValue = 50
        //        positionAnimation.toValue = 300
        //
        //        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        //        scaleAnimation.fromValue = 1
        //        scaleAnimation.toValue = 2
        //
        //        let group = CAAnimationGroup()
        //        group.animations = [positionAnimation, scaleAnimation]
        //        group.duration = 2
        //
        //        imageView.layer.add(group, forKey: "groupAnimation")
                
        //        //animation
        //        let animation = CABasicAnimation(keyPath: "opacity")
        //        animation.fromValue = 1
        //        animation.toValue = 0
        //        animation.duration = 2
        //        animation.beginTime = CACurrentMediaTime() + 1 // Delay
        //        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        //
        //        imageView.layer.add(animation, forKey: "opacityAnimation")
        
    }
    
    
    
    
    private func setupActivityIndicator() {
          activityIndicator.center = view.center
        activityIndicator.color = .blue
        activityIndicator.hidesWhenStopped = true
          view.addSubview(activityIndicator)
     }
    
//    struct MySwiftUIView: View {
//        var body: some View {
//            Text("Release Date == !!!")
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//        }
//        
//    }
    
    struct UserProfileView: View {
        var body: some View {
            VStack {
                ProfileHeader()
                ProfileDetails()
                    
            }
            .background(.blue)
        }
    }

    struct ProfileHeader: View {
        var body: some View {
            Image("123333")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
        }
    }

    struct ProfileDetails: View {
        var body: some View {
            Text("John Doe")
                .font(.title)
                .foregroundStyle(.white)
            Text("iOS Developer")
                .font(.subheadline)
                .foregroundStyle(.white)
        }
    }
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
         print("didReceiveMemoryWarning")
     }
  
    func swiftUISetup(){
        
        let swiftUIView = UserProfileView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // Add the SwiftUI view to the UIKit view hierarchy
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hostingController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        hostingController.didMove(toParent: self)
        
        
    }

    // MARK: - Setup UI
       private func setupUI() {
           view.backgroundColor = .white

           // ImageView
           imageView.contentMode = .scaleAspectFit
           imageView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(imageView)

           // Title Label
           titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
           titleLabel.textAlignment = .center
           titleLabel.numberOfLines = 0
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(titleLabel)
           
           // releaseDate Label
           releaseDate.font = UIFont.boldSystemFont(ofSize: 16)
           releaseDate.textAlignment = .center
           releaseDate.numberOfLines = 0
           releaseDate.textColor = .blue
          // releaseDate.backgroundColor = .red
           releaseDate.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(releaseDate)

           // Description Label
           descriptionLabel.font = UIFont.systemFont(ofSize: 16)
           descriptionLabel.textAlignment = .center
           descriptionLabel.numberOfLines = 0
           descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(descriptionLabel)

           // Constraints
           NSLayoutConstraint.activate([
               // ImageView
               imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
               imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

               // Title Label
               titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
               titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               
               // ReleaseDate Label
               releaseDate.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
               releaseDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               releaseDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

               // Description Label
               descriptionLabel.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 20),
               descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
               
           ])
       }
  
    private func bindViewModel() {
        
        // Bind ViewModel to View
        viewModel.updateLoadingStatus = { [weak self] isLoading in
            print("isLoading Detail == \(isLoading)")
            DispatchQueue.main.async {
                isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.$userDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userDetail in
                
                print("userDetail \(String(describing: userDetail.debugDescription))")
                if let userDetail = userDetail {
                   
                    self?.titleLabel.text = "\(userDetail.originalTitle)"
                    self?.descriptionLabel.text = "\(userDetail.overview)"
                    self?.releaseDate.text = "Release Date = \(userDetail.releaseDate)"
                    let imageURL = "https://image.tmdb.org/t/p/w500\(userDetail.backdropPath)"
                    self?.imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
                }
            }
            .store(in: &cancellables)

        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    print("error \(error.description)")
                    self?.showError(error)
                }
            }
            .store(in: &cancellables)
    }

    private func fetchUserDetail() {
        viewModel.fetchUserDetail(userId: movieId)
    }
    
    
    
//    private func visionCL(imgeUrl:URL){
//        
//        // Load the Core ML model
//        guard let model = try? VNCoreMLModel(for: MobileNetV2().model) else{
//             fatalError("Erro acessando modelo")
//        }
//
//        // Create a request
//        let request = VNCoreMLRequest(model: model) { request, error in
//            guard let results = request.results as? [VNClassificationObservation] else { return }
//            for result in results {
//                print("\(result.identifier): \(result.confidence)")
//            }
//        }
//
//        // Perform the request
//        let handler = VNImageRequestHandler(url: imgeUrl)
//        try! handler.perform([request])
//        
//    }
    
    
    

    private func showError(_ message: String) {
        
        
       // let customAlert = MMPopupVC.instantiate() 
//        customAlert.titleLabel.text = "Alert Title"
//        customAlert.messageLabel.text = "This is a custom alert message."
//        
//        customAlert.okAction = {
//            print("OK button tapped")
//        }
//        
//        customAlert.cancelAction = {
//            print("Cancel button tapped")
//        }
//        
//        present(customAlert, animated: true, completion: nil)
    
        
        
        
        

        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true)
        
        
        
//        let custompopup = MMPopupVC(nibName: "MMPopupVC", bundle: nil)
//        custompopup.modalPresentationStyle = .custom
//        custompopup.modalTransitionStyle = .crossDissolve
//        self.present(custompopup, animated: true, completion: nil)
        
        
        
    }
}
