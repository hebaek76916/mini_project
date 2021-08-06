//
//  Sparkle.swift
//  presento
//
//  Created by 현은백 on 2021/08/05.
//
/*Tested in swift 5.1*/

import UIKit



enum Images {
    static let box = UIImage(systemName: "star.fill")!
    static let triangle = UIImage(systemName: "heart.fill")?.withTintColor(.systemPink)
    static let circle = UIImage(systemName: "person.fill")!
    static let swirl = UIImage(systemName: "circle.fill")!
}

class ActivationRequiredViewController: UIViewController {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hj")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        imageView.alpha = 1

        return imageView
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "NotoSansCJKkr-Medium", size: 18) ?? .systemFont(ofSize: 18)//.systemFont(ofSize: 18)
        textView.textAlignment = .left
        textView.text = "ㅎㅎ"
        return textView
    }()
    
    var emitter = CAEmitterLayer()
    
    var colors:[UIColor] = [

        .red,
        .blue,
        .green,
        .yellow
    ]
    
    var images:[UIImage] = [
        Images.box,
        Images.triangle!,
        Images.circle,
        Images.swirl
    ]
    
    var velocities:[Int] = [
        100,
        90,
        150,
        200
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.addSubview(textView)
        view.addSubview(imageView)
        
        self.startSparkle()
        
        view.bringSubviewToFront(textView)
        view.bringSubviewToFront(imageView)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    
    func configure(letter: String, image: String) {
        textView.text = letter
        imageView.image = UIImage(named: image)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = CGRect(x: 18,
                                y: (view.frame.height / 2) ,
                                width: view.frame.width - 36,
                                height: view.frame.height / 3)
        
        imageView.frame = CGRect(x: 18,
                                 y: view.safeAreaInsets.top + 20,
                                width: view.frame.width - 36,
                                height: view.frame.height / 5)
    }
    func startSparkle() {
        emitter.emitterPosition = CGPoint(x: self.view.frame.size.width / 2, y:   -10)
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterSize = CGSize(width: self.view.frame.size.width, height: 2.0)
        emitter.emitterCells = generateEmitterCells()
        self.view.layer.addSublayer(emitter)
    }
    
    private func generateEmitterCells() -> [CAEmitterCell] {
        var cells:[CAEmitterCell] = [CAEmitterCell]()
        for index in 0..<30 {
            
            let cell = CAEmitterCell()
            
            cell.birthRate = 4.0
            cell.lifetime = 14.0
            cell.lifetimeRange = 0
            cell.velocity = CGFloat(getRandomVelocity())
            cell.velocityRange = 0
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 0
            cell.color = getNextColor(i: index)
            cell.contents = getNextImage(i: index)
            cell.scaleRange = 0.25
            cell.scale = 0.1
            
            cells.append(cell)
        }
        return cells
    }
    
    private func getRandomVelocity() -> Int {
        return velocities[getRandomNumber()]
    }
    
    private func getRandomNumber() -> Int {
        return Int(arc4random_uniform(4))
    }
    
    private func getNextColor(i:Int) -> CGColor {
        if i <= 4 {
            return colors[0].cgColor
        } else if i <= 8 {
            return colors[1].cgColor
        } else if i <= 12 {
            return colors[2].cgColor
        } else {
            return colors[3].cgColor
        }
    }
    
    private func getNextImage(i:Int) -> CGImage {
        return images[i % 4].cgImage!
    }
    
}
