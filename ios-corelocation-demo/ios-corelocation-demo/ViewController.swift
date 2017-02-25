//
//  ViewController.swift
//  ios-corelocation-demo
//
//  Created by OkuderaYuki on 2017/02/23.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    // 緯度ラベル
    @IBOutlet weak var latitudeLabel: UILabel!
    // 経度ラベル
    @IBOutlet weak var longitudeLabel: UILabel!
    fileprivate var locationManager: CLLocationManager?
    fileprivate var latitude: CLLocationDegrees?
    fileprivate var longitude: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLocationManager()
    }
    
    /// LocationManagerで現在地の更新を開始する
    func setupLocationManager() {
        locationManager = CLLocationManager()
        
        // 精度の設定をする
        // 最高レベルの精度を使用する
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        // 位置情報を取得する最小間隔をメートル単位で設定
        locationManager?.distanceFilter = 50.0
        
        // locationManagerのデリゲートにViewControllerのインスタンスをセット
        locationManager?.delegate = self
    }

    /// ボタンタップで現在地の緯度、経度から住所、都市、国などの情報をコンソールに出力する
    @IBAction func tappedReverseGeocoding(_ sender: Any) {
        
        guard let lat = self.latitude, let lon = self.longitude else { return }
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: lon)
        
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            placemarks?.forEach{ print("\($0)") }
        })
    }
    
    /// 緯度ラベル、経度ラベルを更新する
    fileprivate func updateLabels() {
        latitudeLabel.text = String(format: "緯度: %@", self.latitude?.description ?? "-")
        longitudeLabel.text = String(format: "経度: %@", self.longitude?.description ?? "-")
    }
    
    /// 位置情報の許可状態をrestricted or deniedに変更された時の処理
    fileprivate func clearLocationValues() {
        // 許可状態変更前に取得した位置情報を使用しないようにnilをセットする
        self.latitude = nil
        self.longitude = nil
        updateLabels()
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    /// 位置情報の許可状態が変更された時に呼ばれる
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
            /*
             位置情報を使用する許可を得る
             (ステータスがnotDeterminedの場合しかユーザに許可を求めるアラートは表示されない)
             */
        case .notDetermined:
            print("まだ位置情報の利用を許可する確認をしていない")
            
            // アプリ使用中のみ位置情報の利用を許可する確認を行う
            manager.requestWhenInUseAuthorization()
            
            // 常に位置情報の利用を許可する確認を行う
//            manager.requestAlwaysAuthorization()
            break;
            
        case .restricted:
            print("設定/一般/機能制限 で位置情報サービスが制限されている")
            clearLocationValues()
            break;
            
        case .denied:
            print("位置情報の設定が「許可しない」になっている")
            clearLocationValues()
            break;
            
        case .authorizedAlways:
            print("位置情報の設定が「このAppの使用中のみ許可」になっている")
            // 現在地の更新を開始する
            manager.startUpdatingLocation()
            break;
            
        case .authorizedWhenInUse:
            print("位置情報の設定が「常に許可」になっている")
            // 現在地の更新を開始する
            manager.startUpdatingLocation()
            break
        }
    }
    
    /// 位置情報が更新された時の処理
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("\(manager.location)")
        print("緯度:\(manager.location?.coordinate.latitude)")
        print("経度:\(manager.location?.coordinate.longitude)")
        print("標高:\(manager.location?.altitude)")
        print("タイムスタンプ:\(manager.location?.timestamp)")
        
        // 前回取得時の緯度・経度情報があれば、移動距離を測定する
        if let lat = self.latitude, let lon = self.longitude {
            let previousLocation = CLLocation(latitude: lat, longitude: lon)
            print("移動距離:\(manager.location?.distance(from: previousLocation))")
        }
        
        // 緯度ラベル、経度ラベルを更新する
        self.latitude = manager.location?.coordinate.latitude
        self.longitude = manager.location?.coordinate.longitude
        updateLabels()
    }
    
    /// 位置情報の取得に失敗した時の処理
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }
}

