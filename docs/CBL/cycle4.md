# 🧭 Exploratory Cycle #4: 의도한 기능이 사용자에게 잘 이해되고, 잘 사용될 수 있도록 시각적 표현 다듬기

📅 날짜: 2025-04-14  
🎯 목표: 기능 설계와 감성적 표현을 조화롭게 구성하여,  
사용자가 자연스럽게 이해하고 사용할 수 있는 Hi-fi 시안을 완성한다.


## 1️⃣ Guiding Questions

- 사용자 입장에서 핵심 흐름(목표 설정 → 진행률 확인 → 회고 작성)이 얼마나 직관적으로 연결되는가?
- 감성 UI 요소는 기능 흐름을 방해하지 않고 오히려 의미를 강화하는가?
- 입력, 수정, 삭제와 같은 액션들이 UI 상에서 명확히 표현되는가?
- 같은 형태의 UI(dialog 등)는 일관된 사용자 경험을 위해 재사용되고 있는가?


## 2️⃣ Activities & Resources

- Cycle 3의 Feature List 기반으로 주요 기능 흐름 UI 시각화
- 감성적 세계관을 유지하면서도 기능 중심으로 정제된 Hifi 시안 구성
- SwiftUI 기준 View/State 분리를 고려한 구조 설계
- 반복되는 사용자 입력 UI(dialog)를 재사용 가능한 컴포넌트로 정의
- Color & Typo & Mood GA 세션 참여 → DivyDot의 톤앤매너 정의

📎 [Figma – Divy Hifi & Design System](https://www.figma.com/design/xuUaTtNMmAgtl477bS9wG1/C2-Divy?node-id=69-4784&t=ufQmYl3VVHtfu0Tt-1)


## 3️⃣ Key Findings & Design Decisions

| 항목 | 결정 및 인사이트 |
|------|------------------|
| 💬 회고/목표 수정 방식 | Tap → Dialog 호출 방식으로 전환 (롱탭, 숨겨진 제스처 지양) → 접근성 향상 |
| 🧑‍🎨 무드 정체성 | Color & Typo & Mood GA 세션을 통해 DivyDot의 톤 정의: 차분하고 친근한, 바닷속 감정 탐험 컨셉 확정 |
| 🐚 무드보드 생성 | 무드보드를 통해 앱을 사람처럼 상상하고, 관심사/행동/스타일/성격을 정의 → 감성 톤 가이드로 연결 |
| 🎨 컬러 스타일 가이드 | Primary: Deep Aqua (#249CAB), Sub: Ocean Navy (#0E2F44), Accent: Shell Beige (#EDE5DA) 등 Figma에 적용 |
| 🔤 타이포 스타일 가이드 | Title/Body/Caption 스타일로 구성, Pretendard 기반 설정 (향후 SF Pro 고려 가능) |

> 💭 Swift에서 DesignSystem을 구현하는 적절한 방법들은 어떤 것들이 있을까?

## 4️⃣ Task 관리 방식

- Hifi Deconstruction으로 도출된 UI 요소 및 기능 단위는  
  ➤ **GitHub Milestone / Issue 시스템**으로 직접 관리할 예정


## 5️⃣ 회고

- 감성적 연출 보다 사용자가 어떤 UI가 어떤 기능을 담고있다는 것을 직관적으로 이해할 수 있도록 하는 것이 중요하다고 느꼈다. (버튼같아 보이지 않는 예쁜 텍스트 등등..)
- 복잡한 제스처(롱탭 등)보다 “명확한 액션”을 기반으로 하는 UI가 실제 사용자에겐 더 접근성이 좋다는 걸 반영하게 되었다.
- 무드보드를 통해 앱을 사람처럼 상상해봄으로써, 감정과 기능의 균형을 잡을 수 있었다.  
  → 예: 친절하고 조용한 다이버 친구가 함께 여정을 기록해주는 느낌
- 디자인은 심플하지만, 행동의 명확성은 포기하지 않는 방향이 중요하다는 점을 체감했다.


## 6️⃣ Goal & Reflection 구조 기반 CRUD 흐름 1차

### 🎯 Goal (목표)

| 동작 | 설명 | 데이터 변화 |
|------|------|-------------|
| C | 목표 설정 → 저장 | `Cycle.goal = Goal(...)` 생성 |
| R | 홈 or 목표관리에서 확인 | `cycle.goal?.content` |
| U | 목표 내용 수정 | `goal.content` 변경 |
| D | 목표 삭제 | `cycle.goal = nil`, 회고는 유지 or `goalID = nil` 처리 가능 |


### 💬 Reflection (회고)

| 동작 | 설명 | 데이터 변화 |
|------|------|-------------|
| C | 회고 작성 후 저장 | `Reflection(goalID: goal?.id)` 추가 |
| R | 회고 리스트 확인 | `cycle.reflections` |
| U | 회고 내용 수정 | `reflection.text` 갱신 |
| D | 회고 삭제 | 리스트에서 해당 회고 제거 |


## 7️⃣ 상태 정의표 (State Matrix) 1차

### 🌀 Cycle 상태

| 상태 이름 | 조건 | 설명 |
|-----------|------|------|
| `cycle.empty` | 아직 시작 전 | 작성 불가, 안내만 표시 |
| `cycle.active` | 현재 기간 내 | 회고/목표 작성 가능 |
| `cycle.ended` | 종료 후 | 기록은 유지, 수정은 제한 가능 |


### 🎯 Goal 상태

| 상태 이름 | 조건 | 설명 |
|-----------|--------|--------|
| `goal.empty` | 목표 없음 | 입력 유도, 버튼 비활성 |
| `goal.exists` | 목표 있음 | 수정/삭제 가능 |


### 💬 Reflection 상태

| 상태 이름 | 조건 | 설명 |
|-----------|--------|--------|
| `reflection.none` | 회고 없음 | “오늘 어떤 생각이 드셨나요?” 안내 |
| `reflection.partial` | 목표 없는 회고만 있음 | 자유 회고만 존재 |
| `reflection.exists` | 목표 연동 회고 있음 | 리스트로 출력, 정렬 가능 |


### 🔘 버튼 상태

| 상태 이름 | 조건 | 설명 |
|-----------|--------|--------|
| `reflect.disabled` | 텍스트 없음 | 비활성화 |
| `reflect.enabled` | 텍스트 입력 중 | 저장 가능 상태 |


## 8️⃣ 다음 단계

| 작업 | 설명 |
|------|------|
| ✅ Task 단위 GitHub 이슈 등록 | TaskName 기준 이슈 발행 및 마일스톤 연동 |
| 🔜 Prototype1 개발 | 목표 생성/수정/삭제, 회고 입력/조회 기능 우선 구현 |
| 🔜 Cycle 5: Learning Plan 설계 | 구현 목표 기준 학습 계획 수립 예정 |