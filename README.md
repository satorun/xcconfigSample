# xcconfigSample

Xcodeのxcconfigファイルを使った環境切り替えのサンプルプロジェクトです。

## xcconfig構成

```
Config/
├── Common.xcconfig          # 共通設定
├── DebugBase.xcconfig       # Debug共通設定
├── ReleaseBase.xcconfig     # Release共通設定
├── ApiLocal.xcconfig        # Local環境API
├── ApiStg.xcconfig          # Staging環境API
├── ApiProd.xcconfig         # Production環境API
├── DebugLocal.xcconfig      # Debug + Local
├── DebugStg.xcconfig        # Debug + Staging
├── DebugProd.xcconfig       # Debug + Production
├── ReleaseLocal.xcconfig    # Release + Local
├── ReleaseStg.xcconfig      # Release + Staging
└── ReleaseProd.xcconfig     # Release + Production
```

## デフォルト設定

| Build Configuration | xcconfig |
|---------------------|----------|
| Debug | DebugStg.xcconfig |
| Release | ReleaseProd.xcconfig |

## コマンドラインでxcconfigを切り替える

`-xcconfig`オプションを使うことで、Build Configurationを変更せずにxcconfigを切り替えられます。

```bash
# Debug ConfigurationでProduction環境を使用
xcodebuild -scheme xcconfigSample -configuration Debug \
  -xcconfig xcconfigSample/Config/DebugProd.xcconfig \
  -destination 'generic/platform=iOS Simulator' \
  build
```

```bash
# Debug ConfigurationでLocal環境を使用
xcodebuild -scheme xcconfigSample -configuration Debug \
  -xcconfig xcconfigSample/Config/DebugLocal.xcconfig \
  -destination 'generic/platform=iOS Simulator' \
  build
```

## xcconfig変数の使い方

### 1. Info.plistで変数を参照

```xml
<key>ApiHost</key>
<string>$(ApiHost)</string>
```

### 2. Swiftコードで読み込み

```swift
enum Const {
    static let apiHost: String = {
        guard let host = Bundle.main.object(forInfoDictionaryKey: "ApiHost") as? String else {
            fatalError("ApiHost is not set in Info.plist")
        }
        return host
    }()
}
```

## 定義されている変数

| 変数名 | 説明 | 例 |
|--------|------|-----|
| `ApiHost` | API接続先ホスト | `local.host`, `stg.host`, `prod.host` |
| `CommonString` | 共通文字列 | `Common String` |
| `DisplayName` | アプリ表示名 | `Debug App`, `Release App` |
| `BundleIdentifier` | Bundle ID | `org.satorun.sample.debug`, `org.satorun.sample` |
| `AppIconName` | アプリアイコン名 | `AppIconDebug`, `AppIcon` |

## 注意事項

- Build Configurationの追加（Debug/Release以外）は、CocoaPodsやSPMとの互換性問題を引き起こす可能性があるため推奨されません
- 環境の切り替えは`-xcconfig`オプションまたはスキームのPre-actionスクリプトで対応することを推奨します
