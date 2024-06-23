---
name: "\U0001F9F1 Build "
about: 빌드 관련 파일 수정 / 모듈 설치 또는 삭제에 대한 이슈
title: ''
labels: ''
assignees: ''

---

## 빌드 요청

### 설명
- Firebase SDK를 프로젝트에 추가합니다.

### 필요 이유
- 로그인 기능 구현을 위해 Firebase Auth를 사용해야 합니다.

### 변경 사항
- `Podfile`에 Firebase Auth 추가
- `pod install` 명령어 실행

### 테스트 방법
- Firebase Auth가 정상적으로 설치되었는지 확인합니다.
- 빌드가 성공적으로 완료되는지 확인합니다.

### 추가 정보
- Firebase 프로젝트 설정은 [Firebase Console](https://console.firebase.google.com/)에서 확인할 수 있습니다.
