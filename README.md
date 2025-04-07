# 🌱 DiverCompass

> 아카데미 여정을 해저 탐험에 비유하여, 러너가 목표를 잊지 않고 지속적으로 리마인드하며 성장 방향을 확인할 수 있도록 돕는 앱입니다.

<!-- ![프로젝트 배너 또는 스크린샷](https://your-image-link-here.com/banner.png) -->

[![Swift](https://img.shields.io/badge/Swift-6.0.3-orange.svg)]()
[![Xcode](https://img.shields.io/badge/Xcode-16.2-blue.svg)]()
[![License](https://img.shields.io/badge/license-MIT-green.svg)]()

## 🗂 목차
- [🌱 DiverCompass](#-divercompass)
  - [🗂 목차](#-목차)
  - [💡 프로젝트 동기](#-프로젝트-동기)
  - [📌 목표](#-목표)
  - [💡 Exploratory Learning Cycle](#-exploratory-learning-cycle)
  - [⚙️ 개발 환경](#️-개발-환경)
  - [🧩 구현 기능](#-구현-기능)
    - [🔹 여정 추적](#-여정-추적)
    - [🔹 목표 설정 및 리마인드](#-목표-설정-및-리마인드)
    - [🔹 진행률 시각화](#-진행률-시각화)
    - [🔹 감성적 인터페이스 (TO BE)](#-감성적-인터페이스-to-be)
    - [🔹 회고 기능 (추후 고려)](#-회고-기능-추후-고려)
  - [🙋🏻‍♀️ 작성자](#️-작성자)
  - [📝 라이선스](#-라이선스)

## 💡 프로젝트 동기

Apple Developer Academy에서는 약 9개월간의 긴 여정을 거칩니다.  
러너들은 자신만의 목표를 설정하지만, 시간이 흐르면서 목표와 다른 방향으로 벗어나거나 의욕을 잃을 수 있습니다.

> DiverCompass는 이 문제에 대한 탐구에서 시작된 프로젝트로,  
러너가 마치 해저를 탐험하는 다이버처럼, 자신의 방향을 잃지 않고 끝까지 여정을 완주할 수 있도록 돕기 위해 기획되었습니다.

## 📌 목표

- 러너의 목표 설정 및 리마인드 문제 해결
- CLI → Swift iOS 앱 전환 실험
- 감성적 디자인(물방울 등)을 통한 UI/UX 도전
- Exploratory Learning Cycle 기반으로 문제-솔루션 간 학습 흐름 정리

## 💡 Exploratory Learning Cycle

이 프로젝트는 Apple Developer Academy의 공식 CBL 커리큘럼을 기반으로 진행됩니다.  
각 사이클마다 문제 정의, 실험, 설계, 피드백을 반복하며 앱을 고도화해 나갑니다.

> 현재 작성 중: **Cycle 1 – 챌린지 학습 목표를 이루는 것을 도와주는 App Statement 만들기**

👀 자세히 보기: [`docs/CBL/**.md`](./docs/CBL/)

| Cycle | 목표 | Output | Check |
|-------|------|--------|---|
| #1 | 챌린지 학습 목표를 도와주는 App Statement 만들기 | App Statement | ✅ |
| #2 | 도전 가능한 기능 정리 | Feature List | ⬜️ |
| #3 | 기능을 적절한 UI 흐름으로 표현 | Lofi | ⬜️ |
| #4 | UI를 실제로 사용할 수 있도록 시각화 | Hifi | ⬜️ |
| #5 | 구현 목표에 맞는 학습 계획 수립 | Learning Plan | ⬜️ |
| #6 | 기능 재조정 및 브러시업 | Feature List 2 | ⬜️ |
| #7 | 학습 계획 보완 | Learning Backlog 2 | ⬜️ |
| #8 | 학습 성취 체크 | 결과 확인 | ⬜️ |
| #9 | 결과 공유 | 발표 & 회고 | ⬜️ |

## ⚙️ 개발 환경

- macOS Sequoia 15.4
- Xcode 16.2 / iOS 18.2
- Swift 6.0.3
- SwiftUI

## 🧩 구현 기능

### 🔹 여정 추적
- [ ] 전체 아카데미 여정에서 현재 위치 시각화 (ex. 30% 진행됨)
- [ ] 현재 사이클(Challenge/Bridge)에서의 진행률 표시 (ex. Day 2/15 → 13%)
- [ ] 주말 포함 기준 기본 설정 (향후 주말 제외 옵션 고려)

### 🔹 목표 설정 및 리마인드
- [ ] 전체 여정에 대한 성장 목표 입력 및 수정 (1개)
- [ ] 각 사이클 시작 시, 해당 사이클의 실천 목표 설정 기능
- [ ] 사이클 목표를 시작 시 자동 리마인드(화면 표시 등)

### 🔹 진행률 시각화
- [ ] 텍스트 기반 퍼센트 바 또는 물방울 피드백 UI
- [ ] 사이클별, 전체 여정별 진척도 분리 표현

### 🔹 감성적 인터페이스 (TO BE)
- [ ] 물방울 애니메이션 (응원 메시지 or 진행률 표현)
- [ ] 해저 탐험 세계관을 반영한 나침반/배경 등 테마 적용

### 🔹 회고 기능 (추후 고려)
- [ ] 각 사이클 종료 후 간단한 회고 작성 및 저장

<!-- ## 📚 배운 점 / 트러블슈팅 
| 주제 | 요약 |
|------|------|
| CLI 실험 | 기능을 글자 기반으로 테스트하며 구조 설계 방향성 점검 |
| 진행률 시각화 | 단순 수치보다 몰입감을 주는 감성적 요소의 필요성 인지 |
| 타임라인 계산 | 날짜 기반 현재 챌린지 자동 탐지 방식 |
-->

<!-- ## ⚙️ 설치 및 실행 (업데이트 예정)

```bash
git clone https://github.com/bisor0627/DiverCompass.git
``` -->

<!-- ## 🔍 프로젝트 구조 (업데이트 예정)

```
📦DiverCompass
┣ 📂Projects
┃ ┣ 📂CLIPrototype01
┃ ┣ 📂FlutterProto02
┃ ┗ 📂iOSApp
┣ 📄LICENSE
┗ 📄README.md
``` -->


<!-- ## 🧪 테스트 / 시연 (업데이트 예정) -->


## 🙋🏻‍♀️ 작성자

| 이름 | GitHub |
|------|--------|
|Bisor0627 | [@bisor0627](https://github.com/bisor0627) |


## 📝 라이선스

This project is licensed under the [MIT License](LICENSE)
