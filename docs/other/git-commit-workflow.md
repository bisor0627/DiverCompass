## 🧾 gitmessage — 기본 커밋 메시지 템플릿

### 📌 개념

- Git에서 커밋 메시지를 입력할 때 자동으로 **기본 텍스트 템플릿을 보여주는 기능**
- 일관된 커밋 메시지 구조를 유지할 수 있도록 도와줌

> 참고: `--global` 설정은 사용자 전역에 적용되며, 특정 프로젝트에만 설정하고 싶다면 `--local` 옵션도 사용 가능


### ✅ 사용 방법

1. 템플릿 파일 생성 (예: `~/.gitmessage.txt`)

```bash
nano ~/.gitmessage.txt
```

2. 파일에 원하는 템플릿 내용 입력 (예: 자체 정의한 커밋 템플릿)

```txt
<Gitmoji> <Type>. 요약 설명

Why:
-

How:
-

Tag: #...
```

3. Git 설정에 템플릿 경로 등록

```bash
git config --global commit.template ~/.gitmessage.txt
```

4. 이후 `git commit` 시 자동으로 템플릿이 에디터에 표시됨


## 🪝 prepare-commit-msg 훅 — 커밋 메시지 자동 삽입 및 조작

### 📌 개념

- `.git/hooks/prepare-commit-msg`에 위치한 **Git Hook 스크립트**
- 커밋 메시지 창이 뜨기 전에 자동으로 메시지를 조작하거나 텍스트 삽입 가능
- 예: 브랜치 이름에서 이슈 번호를 추출해 자동으로 메시지에 붙이기


### ✅ 사용 예시

1. 훅 스크립트 생성 및 실행 권한 부여

```bash
touch .git/hooks/prepare-commit-msg
chmod +x .git/hooks/prepare-commit-msg
```

2. 예시 스크립트 작성

```bash
#!/bin/bash

MSG_FILE=$1
COMMIT_SOURCE=$2

# 병합 커밋 등은 제외
if [[ "$COMMIT_SOURCE" == "merge" || "$COMMIT_SOURCE" == "commit" ]]; then
  exit 0
fi

# 현재 브랜치 이름 확인
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# 슬래시(/) 뒤에 나오는 첫 숫자 추출
ISSUE_NUM=$(echo "$BRANCH_NAME" | grep -oE '/[0-9]+' | head -1 | tr -d '/')

# 메시지 파일에 자동 삽입
if [[ "$ISSUE_NUM" != "" ]]; then
  echo "" >> "$MSG_FILE"
  echo "Related Issue: #$ISSUE_NUM" >> "$MSG_FILE"
fi
```

3. 사용 예:

- 브랜치 이름이 `feat/32-add-goal`일 경우, 커밋 메시지에 다음이 자동 추가됨:

```txt
Related Issue: #32
```


## 🔄 차이 요약

| 항목 | `gitmessage` 템플릿 | `prepare-commit-msg` 훅 |
|------|---------------------|--------------------------|
| 동작 시점 | 커밋 메시지 에디터가 열릴 때 | 커밋 메시지 파일이 만들어지는 직후 |
| 주요 목적 | 커밋 메시지 틀 제공 | 자동 삽입, 조건부 조작, 규칙 강제 |
| 설정 방식 | `git config --global commit.template` 사용 | `.git/hooks/prepare-commit-msg`에 직접 작성 |
| 실행 권한 필요 여부 | ❌ (단순 파일 참조) | ✅ `chmod +x`로 실행 권한 필요 |


## 🛠️ 추가 팁

- `gitmessage`와 `prepare-commit-msg`는 **함께 사용할 수 있음**
- 팀 단위에서는 템플릿을 `.gitmessage.txt`로 공유하고, 커밋 메시지 룰 자동화를 훅으로 강화하는 방식 추천