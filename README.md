
# <img src="https://cloudfront-ap-northeast-1.images.arcpublishing.com/chosun/ZL3HPFZD7POHF5YHUBUZZUCVJY.jpg" width="40"> 5조 The Oscars  iOS 영화 앱 프로젝트

</br>

## 🍀 소개
이 프로젝트는 iOS 팀 협업을 통해 진행된 영화 예매 애플리케이션 UI 개발 프로젝트입니다. 사용자 친화적인 영화 예매 환경을 제공하기 위해, CGV, 메가박스와 같은 실제 영화 예매 앱과 넷플릭스 앱을 벤치마킹하여 UI와 기능을 설계하고 구현했습니다.

프로젝트의 목표는 사용자가 원하는 작업(영화 탐색, 예매 등)을 빠르고 정확하게 처리할 수 있는 구조를 만드는 것으로, 기술과 UX가 조화를 이루는 영화 예매 애플리케이션앱을 만드는 데 중점을 두었습니다.

팀 프로젝트는 필수 기능의 완성도를 높이는 데 초점을 맞췄습니다. 복잡한 설계보다는 앱이 실제로 동작하는 결과물을 만드는 과정에 의미를 두었으며, 도전과 협업을 통해 각자의 역량을 끌어올리는 데 중점을 두었습니다.

</br>

## 👨‍💻 팀원
* 박유빈: 리더, 프로젝트 세팅, 회원가입, UserDefaultsManager, NetworkManager
* 서지민: 영화 검색, 영화 세부
* 서현욱: 로그인, 마이페이지
* 양정무: 런치스크린, 탭바, 영화 리스트
* 오푸른솔: 영화 예매, BookManager

</br>


## ⏱️ 개발기간

12/13, 12/16 ~ 12/20

</br>


## ✨ 주요 기능
  
### 📝 **로그인**

- **구현 요소**:
    - 사용자 입력 필드: 아이디, 비밀번호
    - '로그인' 및 '회원가입' 버튼
- **설명**: 로그인 페이지는 사용자가 계정 정보를 입력하고 앱에 접근할 수 있는 진입점. 간단하고 직관적인 레이아웃으로 사용자 편의성을 제공함.


### 🧾 **회원가입**

- **구현 요소**:
    - 입력 필드: 아이디, 비밀번호, 비밀번호 확인, 이메일, 핸드폰 번호
    - '아이디 중복확인' 버튼
    - '로그인 화면으로 돌아가기' 버튼
- **설명**: 회원가입 페이지는 사용자가 새로운 계정을 생성할 수 있도록 구성. 입력 검증과 유효성 검사(중복 확인, 비밀번호 일치 확인)를 포함하여 사용자 경험을 강화.


### 🎬 **탭 바**

- **구현 요소**:
    - 영화 리스트, 검색, 마이페이지 버튼 제공
    - 각 버튼은 명확한 아이콘과 텍스트로 구성
- **설명**: 사용자 친화적인 탭 바를 통해 주요 기능으로 빠르게 이동할 수 있도록 설계됨. 각 섹션 간의 네비게이션이 원활하게 작동.


### 🎥 **영화 리스트**

- **구현 요소**:
    - 영화 목록을 표시하는 **UICollectionView**
    - 영화 포스터와 간략 정보 (제목, 누적관객 수, 평점 등)
    - '바로 예매' 버튼 제공
- **설명**: 영화 리스트는 사용자가 현재 상영 중인 영화를 탐색할 수 있는 공간. 컬렉션 뷰를 사용해 스크롤을 통해 영화를 탐색할 수 있도록 구현함.


### 🔍 **영화 검색**

- **구현 요소**:
    - 상단에 **UISearchBar**를 사용하여 검색 기능 제공
    - 검색 결과를 표시하는 **UICollectionView**
    - 검색된 영화의 포스터와 간략 정보를 표시
- **설명**: 검색 페이지는 사용자가 원하는 영화를 빠르게 탐색할 수 있도록 설계됨. 직관적인 검색 바와 결과를 스크롤로 확인할 수 있는 구조로 구현.


### 📜 **영화 세부**

- **구현 요소**:
    - 영화 포스터 이미지, 제목, 평점, 누적 관객 수, 개봉일
    - 영화 줄거리를 포함한 세부 정보를 **UIScrollView**에 배치
    - '예매하기' 버튼
- **설명**: 세부 페이지는 선택한 영화의 정보를 한눈에 확인할 수 있는 공간. 스크롤 뷰를 통해 많은 정보를 깔끔하게 정리해 제공.


### 🎟️ **영화 예매**

- **구현 요소**:
    - 날짜 및 시간 선택 **UIStackView**로 구성
    - 인원 수 조정 버튼과 실시간 금액 변경 표시
    - '결제하기' 또는 '예매 완료' 버튼
- **설명**: 예매 페이지는 영화 예매를 진행하는 공간. 스택 뷰를 활용해 날짜, 시간, 인원 선택 등의 요소를 정렬하여 간단하고 직관적인 UI를 제공.


### 👤 **마이 페이지**

- **구현 요소**:
    - 사용자의 정보(이름, 이메일, 핸드폰 번호 등)를 표시하는 **UIStackView**
    - 예매 내역을 테이블로 표시 (영화 제목, 날짜, 시간, 인원, 포스터 이미지)
    - 보유 포인트 및 기타 정보
    - '로그아웃' 버튼
- **설명**: 마이 페이지는 사용자가 자신의 계정 정보를 확인하고 관리할 수 있는 공간. 스택 뷰로 UI 요소를 구성하여 정보를 깔끔하게 정리.

    
</br>

## 🛠 개발 도구 및 라이브러리, 전략

- **Swift** & **UIKit**
    - iOS 네이티브 앱 개발을 위한 프로그래밍 언어 및 UI 프레임워크.
- **SnapKit**
    - 오토레이아웃 제약을 코드로 효율적으로 설정하기 위한 라이브러리.
- **Alamofire**
    - 네트워크 요청과 JSON 데이터를 처리하기 위해 사용한 HTTP 네트워킹 라이브러리.
- **UserDefaults**
    - 간단한 사용자 데이터 및 설정을 저장하기 위해 사용한 iOS 기본 저장소.
- **Git Flow**
    - 협업 시 역할별 브랜치 관리 및 개발 프로세스 효율화를 위한 Git 전략.

</br>

## 🔧 요구사항

- **Xcode 버전**: Xcode 16.1 이상

- **iOS 지원 버전**: iOS 16.0 이상

- **Swift 버전**: Swift 5 이상


</br>

## 🚀 실행 방법

1. **프로젝트 클론**: GitHub에서 프로젝트를 클론합니다.

  ```
    git clone https://github.com/daydreamplace/The_Oscars.git
  ```
</br>

2. **Xcode에서 열기**: Xcode를 열고, 클론한 프로젝트 폴더를 엽니다.
</br>

3. **시뮬레이터 실행**: Xcode에서 빌드 타겟을 선택하고, iOS 시뮬레이터에서 실행합니다.
</br>
</br>

##  👀 프로젝트 구조
###  ℹ️ File Tree

```
🏆 The_Oscars
├── 📂 The_Oscars
│   ├── 📂 Extensions
│   │   └── UIView+AddSubviews.swift
│   ├── 📂 Features
│   │   ├── 📂 Auth
│   │   │   ├── 📂 Login
│   │   │   │   ├── LoginView.swift
│   │   │   │   └── LoginViewController.swift
│   │   │   ├── 📂 Signup
│   │   │   │   ├── SignupView.swift
│   │   │   │   └── SignupViewController.swift
│   │   │   └── CustomTextField.swift
│   │   ├── 📂 Movies
│   │   │   ├── 📂 Booking
│   │   │   │   ├── BookingViewController.swift
│   │   │   │   └── MovieBookingView.swift
│   │   │   ├── 📂 MovieDetail
│   │   │   │   └── MovieDetailController.swift
│   │   │   ├── 📂 MovieList
│   │   │   │   ├── MovieCell.swift
│   │   │   │   └── MovieListViewController.swift
│   │   │   ├── 📂 TabBar
│   │   │   │   └── TabBarViewController.swift
│   │   │   ├── 📂 MyPage
│   │   │   │   ├── MyPageView.swift
│   │   │   │   └── MyPageViewController.swift
│   │   │   └── 📂 Search
│   │   │       ├── SearchMovieCell.swift
│   │   │       └── SearchViewController.swift
│   ├── 📂 Managers
│   │   ├── 🛠️ NetworkManager.swift
│   │   └── 🛠️ UserDefaultsManager.swift
│   ├── 📂 Models
│   │   ├── BookingModel.swift
│   │   ├── DatesModel.swift
│   │   ├── MovieCategory.swift
│   │   ├── MovieModel.swift
│   │   ├── MovieResponseModel.swift
│   │   └── UserModel.swift
│   ├── 📂 Resources
│   │   └── Assets.xcassets
│   ├── 📂 Utils
│   │   ├──  Validator.swift
│   ├── AppDelegate.swift
│   ├── Info.plist
│   └── LaunchScreen.storyboard

```

</br>

## 💻 실행 화면
[![The Oscars](https://img.youtube.com/vi/J9cKnEbyBxA/0.jpg)](https://www.youtube.com/watch?v=J9cKnEbyBxA)


<br>

## 📚 프로젝트를 통해 배운 것
**협업 과정에서의 배움**

- 팀원들과 Git Flow를 사용하며 협업하는 방법을 처음 경험했습니다. 브랜치 관리가 처음엔 어려웠지만, 익숙해질수록 실수도 줄어들고 더 깔끔한 작업이 가능했습니다.

**iOS UI 개발 경험**

- **UIKit**을 사용해서 UI를 직접 코드로 작성하는 과정을 통해, 오토레이아웃의 작동 방식과 스택 뷰, 컬렉션 뷰 같은 컴포넌트를 실제로 사용해 볼 수 있었습니다.

**사용자 관점에서 생각하기**

- 영화 예매 앱을 만들면서 **사용자가 어떤 흐름으로 앱을 사용할지**를 고민하게 되었습니다.
- 유효성 검사나 검색 기능 같은 부분에서, 단순히 기능을 구현하는 것만이 아니라 **어떻게 하면 더 편리할지**를 생각하며 개선해 나갔습니다.

**완벽보다는 도전**
- 처음부터 완벽하게 하려고 하면 아무것도 못 한다는 걸 느꼈습니다.
- 부족하더라도 일단 도전해 보고, 피드백을 받아 개선해 나가는 과정에서 더 많이 배웠습니다.

<br>

## 📖 레퍼런스 및 학습 자료
과제 발제 자료, 넷플릭스, 메가박스, CGV, 롯데시네마 앱

<br>

## 👥 팀 프로젝트 링크

- [노션](https://teamsparta.notion.site/The-5scars-5c797b1b25f4417997c54d99104c789d)
- [피그마](https://www.figma.com/proto/MBY3mkgHjG6p6UEm6SzzGG/%EC%98%81%ED%99%94%EB%A5%BC-%EC%98%88%EB%A7%A4%ED%95%98%EC%9E%90~?node-id=0-1&t=qBHXJBATBGT3cPW6-1)
