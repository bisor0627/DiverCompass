# 🌱 DiverCompass

> 아카데미 여정을 해저 탐험에 비유하여, 러너가 목표를 잊지 않고 지속적으로 리마인드하며 성장 방향을 확인할 수 있도록 돕는 앱입니다.

![alt text](/docs/assets/image.png)

[![Swift](https://img.shields.io/badge/Swift-6.0.3-orange.svg)]()
[![Xcode](https://img.shields.io/badge/Xcode-16.2-blue.svg)]()
[![License](https://img.shields.io/badge/license-MIT-green.svg)]()

---

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
    - [🔹 회고 관리](#-회고-관리)
    - [🔹 감성적 UI](#-감성적-ui)
  - [🙋🏻‍♀️ 작성자](#️-작성자)
  - [📝 라이선스](#-라이선스)

---

## 💡 프로젝트 동기

Apple Developer Academy에서는 약 9개월간의 긴 여정을 거칩니다.  
러너들은 자신만의 목표를 설정하지만, 시간이 흐르면서 목표와 다른 방향으로 벗어나거나 의욕을 잃을 수 있습니다.

> DiverCompass는 이 문제에 대한 탐구에서 시작된 프로젝트로,  
러너가 마치 해저를 탐험하는 다이버처럼, 자신의 방향을 잃지 않고 끝까지 여정을 완주할 수 있도록 돕기 위해 기획되었습니다.

---

## 📌 목표

- 러너의 목표 설정 및 리마인드 문제 해결
- CLI → Swift iOS 앱 전환 실험
- 감성적 디자인(수영자, 회고 버블 등)을 통한 UI/UX 도전
- Exploratory Learning Cycle 기반으로 문제-솔루션 간 학습 흐름 정리
- GitHub Issue & Milestone 기반 작업 흐름 실험

---

## 💡 Exploratory Learning Cycle

> 이 프로젝트는 Apple Developer Academy의 공식 CBL 커리큘럼을 기반으로 진행됩니다.

| Cycle | 목표 | Output | 상태 |
|-------|------|--------|------|
| #1 | App Statement 만들기 | App Statement | ✅ |
| #2 | 기능 도출 및 정리 | Feature List | ✅ |
| #3 | UI Flow 및 Lo-fi | Lo-fi 스케치 | ✅ |
| #4 | Hifi 완성 및 기능 연결 | Hifi, Task 구조 | ✅ |
| #5 | 구현 계획 수립 | Learning Plan | ✅ |
| #6 | 기능 재조정 | Feature List 2 | ✅ |
| #7 | 학습 백로그 정리 | Learning Backlog | ⬜️ |
| #8 | 학습 성취 체크 | 회고 + 확인 | ⬜️ |
| #9 | 공유 및 발표 | 발표자료, 최종 정리 | ⬜️ |

---

## ⚙️ 개발 환경

- macOS Sequoia 15.4
- Xcode 16.2 / iOS 18.2
- Swift 6.0.3
- SwiftUI

---

## 🧩 구현 기능

### 🔹 여정 추적
- [ ] 전체 여정 진행률 시각화 (퍼센트 + 수영자 이동)
- [ ] 현재 사이클 Day 진행률 표시
- [ ] 주말 제외 옵션 기능 (추후 고려)

### 🔹 목표 설정 및 리마인드
- [ ] 전체 여정 목표 1개 입력 및 수정
- [ ] 사이클별 목표 입력/수정 (1개만)
- [ ] 목표 미등록 시 등록 유도
- [ ] 공통 Dialog 컴포넌트로 입력 UI 통일

### 🔹 회고 관리
- [ ] 매일 회고 작성 (한 줄 메모)
- [ ] 회고 버블 리스트로 시각화
- [ ] 버블 터치 시 수정/삭제 Dialog 호출
- [ ] 사이클 종료 시 회고 리마인드

### 🔹 감성적 UI
- [ ] 수영자 + 파도 이모지 기반 퍼센트 바
- [ ] 회고 버블 스타일 적용 (채팅형 리스트)
- [ ] 배경 테마(해저, 나침반 등) 적용

---

## 🙋🏻‍♀️ 작성자

| 이름 | GitHub |
|------|--------|
| Bisor0627 | [@bisor0627](https://github.com/bisor0627) |

---

## 📝 라이선스

This project is licensed under the [MIT License](LICENSE)