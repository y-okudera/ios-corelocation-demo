# Core Location Framework

## 概要
Core Locationは、デバイスの現在の緯度・経度を決定し、位置情報を利用するためのフレームワークです。

## クラス
[CLLocation Class](https://github.com/stv-yokudera/ios-corelocation-demo#cllocation)<br>
[CLLocationManager Class](https://github.com/stv-yokudera/ios-corelocation-demo#cllocationmanager)<br>
[CLGeocoder Class](https://github.com/stv-yokudera/ios-corelocation-demo#clgeocoder)

## プライバシー設定
iOS8以降でデバイスの位置情報を使用する場合は、Info.plistに位置情報を使用する目的を記述しなければなりません。
- 常に位置情報を使用する場合
<br>“Privacy - Location Always Usage Description”に使用目的を記述する
- アプリがフォアグラウンドにある間のみ位置情報を使用する場合
<br>“Privacy - Location When In Use Usage Description”に使用目的を記述する

ここで記述した使用目的は、ユーザーに位置情報を使用する許可を求めるアラートに表示されます。

![info.plistのイメージ](https://github.com/stv-yokudera//ios-corelocation-demo/wiki/images/info-plist.png)

![requestAlwaysAuthorizationのイメージ](https://github.com/stv-yokudera//ios-corelocation-demo/wiki/images/requestAlwaysAuthorization.jpg)

![requestWhenInUseAuthorizationのイメージ](https://github.com/stv-yokudera//ios-corelocation-demo/wiki/images/requestWhenInUseAuthorization.jpg)

## バックグラウンドの位置情報取得設定
バックグラウンドでも位置情報を取得する場合は、プロジェクトファイルを選択し、<br>Capabilitiesタブ->Background ModesのLocation updatesにチェックを入れます。

![バックグラウンドモードのイメージ](https://github.com/stv-yokudera//ios-corelocation-demo/wiki/images/backgroundmodes.png)

## 開発環境

| Category | Version |
|:-----------:|:------------:|
| Swift | 3.0.2 |
| Xcode | 8.2.1 |
| iOS | 10.0~ |
## 参考
https://developer.apple.com/reference/corelocation

<hr>

# CLLocation

## 概要
CLLocationは、デバイスの位置データを表すためのクラスです。<br>
デバイスの位置の地理的座標、高度、測定が行われた時刻などを取得することができます。

## 関連クラス
NSObject、CLLocationManager

## イニシャライザ

| イニシャライザ | 説明 | サンプル |
|:-----------|:------------|:------------|
| init(latitude:longitude:) | 緯度と経度を指定してCLLocationオブジェクトを生成する | let location = CLLocation(latitude: lat, longitude: lon) |

## 主要プロパティ

| プロパティ名 | 説明 | サンプル |
|:-----------|:------------|:------------|
| coordinate | 座標情報 | location.coordinate.latitude<br>location.coordinate.longitude |
| altitude | メートル単位の標高 | location.altitude |
| timestamp | 位置の測定が行われた時刻 | locationManager.delegate = self |

## 主要メソッド

| メソッド名 | 説明 | サンプル |
|:-----------|:------------|:------------|
| distance(from:) | 2点間の距離をメートル単位で測定する | location.distance(from: otherLocation) |

## 参考
https://developer.apple.com/reference/corelocation/cllocation

<hr>

# CLLocationManager

## 概要
CLLocationManagerは、アプリケーションに位置情報に関連するイベントの設定をするためクラスです。<br>位置情報を取得する間隔や位置情報の精度を設定することができます。

## 関連クラス
NSObject、CLLocation

## 主要プロパティ

| プロパティ名 | 説明 | サンプル |
|:-----------|:------------|:------------|
| desiredAccuracy | 位置データの精度を設定する | locationManager.desiredAccuracy = kCLLocationAccuracyBest |
| distanceFilter | 位置情報を取得する最小間隔をメートル単位で設定する | locationManager.distanceFilter = 100.0 |
| delegate | CLLocationManagerDelegateの更新イベントを受け取るためのデリゲートオブジェクト | locationManager.delegate = self |

## 主要メソッド

| メソッド名 | 説明 | サンプル |
|:-----------|:------------|:------------|
| requestWhenInUseAuthorization() | アプリがフォアグラウンドにある間、位置情報サービスの使用を許可することの確認をする | locationManager.requestWhenInUseAuthorization() |
| requestAlwaysAuthorization() | 常に位置情報サービスの使用を許可することの確認をする | locationManager.requestAlwaysAuthorization() |
| startUpdatingLocation() | デバイスの位置情報の取得を開始する | locationManager.startUpdatingLocation() |

### CLLocationManagerDelegateプロトコルのメソッド

|メソッド名|説明|必須|
|---|---|---|
|locationManager(_:didChangeAuthorization:) | 位置情報の許可状態が変更された時の処理 | - |
|locationManager(_:didUpdateLocations:) | 位置情報が更新された時の処理 | - |
|locationManager(_:didFailWithError:) | 位置情報の取得に失敗した時の処理 | - |

## 参考
https://developer.apple.com/reference/corelocation/cllocationmanager

<hr>

# CLGeocoder

## 概要
CLGeocoderは、座標とその座標の情報(街路、都市、州および国など)を変換するためのクラスです。

## 関連クラス
NSObject、CLLocation

## 主要メソッド

| メソッド名 | 説明 | サンプル |
|:-----------|:------------|:------------|
| reverseGeocodeLocation(_:completionHandler:) | 指定した位置の逆ジオコーディング要求を送信する | geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in<br>    placemarks?.forEach{ print("\($0)") }<br>}) |

## 参考
https://developer.apple.com/reference/corelocation/clgeocoder
