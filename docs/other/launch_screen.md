# 🚀 iOS에서 Launch Screen 구성하기 (SwiftUI 기반)

> Flutter 개발자인 나는 런치스크린을 만들 때 [`flutter_native_splash`](https://pub.dev/packages/flutter_native_splash) 패키지를 사용해 native 런치 스크린을 등록하곤 했는데, SwiftUI에서는 어떤 방식으로 런치 스크린을 설정할까?
  
이 문서는 **SwiftUI 앱에서 시스템 Launch Screen을 구성하는 가장 표준적인 방법**인 `LaunchScreen.storyboard` 기반 구성을 설명합니다.

## 🧠 먼저 알아야 할 것: iOS에서의 런치 스크린은 "코드 불가"!

- **Launch Screen은 앱 실행 전, 시스템이 사용자에게 보여주는 '가짜 첫 화면'입니다.**  
- ⚠️ Apple은 이 화면이 **빠르게 전환되어야 한다는 UX 철학**에 따라 아래를 제한합니다:

| 제한 사항        | 설명                                         |
| ------------ | ------------------------------------------ |
| ❌ 코드 실행      | SwiftUI View, UIKit ViewController 등 사용 불가 |     |
| ❌ 애니메이션      | 불가능                                        |     |
| ❌ 사용자와의 상호작용 | 버튼, 제스처 등 불가                               |     |
| ⛔ 텍스트        | 지역화가 어렵기 때문에 가급적 피할 것                      |     |

## ✅ iOS에서의 표준 런치 스크린 구성법

### 1. `LaunchScreen.storyboard` 확인 또는 생성

대부분의 SwiftUI 프로젝트에는 `LaunchScreen.storyboard`가 기본 포함되어 있습니다.    
만약 없다면 다음과 같이 생성하세요:

`File > New > File > User Interface > Storyboard > LaunchScreen.storyboard`

### 2. Xcode 설정에서 연결

`LaunchScreen.storyboard`를 프로젝트에 추가한 후, 다음 경로로 이동해 연결합니다.

> **Xcode > Targets > [Your App] > General > Launch Screen File**

- `Launch Screen File` 항목에 `LaunchScreen`이라고 입력 (확장자 `.storyboard`는 생략)

### 3. 간단한 디자인 구성

- `LaunchScreen.storyboard` 열기  
- 기본 View에 **Image View**를 추가  
- **App 로고** 또는 간단한 심볼을 넣고 **가운데 정렬**  
- **Auto Layout 설정**: Center X/Y, 고정된 Width/Height

```plaintext  
LaunchScreen.storyboard  
└── View  
    └── UIImageView  
        └── Image: LaunchLogo  
        └── Content Mode: Aspect Fit  
        └── Constraints: Center X + Y, Width = 200, Height = 200
```
### 🔍 SwiftUI에서 Splash 화면은 별도로 구현해야 함

```swift
NavigationStack {  
    SplashView() // 앱 내부에서 보여지는 Splash 화면  
}
```

`LaunchScreen.storyboard`는 시스템이 앱을 시작할 때만 보여주는 화면이므로,

**애니메이션, 로딩 로직, 로그인 여부 판단 등**이 필요한 경우에는

별도의 SplashView.swift를 앱 내부에 만들어 사용해야 합니다.

### 📌 정리

| **Flutter에서**                   | **SwiftUI에서**                   |
| ---------------------------- | --------------------------- |
| flutter_native_splash 패키지 사용 | LaunchScreen.storyboard로 구성 |
| 코드로 제어 가능                    | 시스템 제어 (자동 표시)              |
| Splash Widget 구성 가능          | 내부 SplashView로 별도 구현 필요     |


### 📎 참고 문서

- [Apple 공식 문서 — Specifying your app’s launch screen](https://developer.apple.com/documentation/Xcode/specifying-your-apps-launch-screen)
- [HIG — Launching](https://developer.apple.com/design/human-interface-guidelines/launching)