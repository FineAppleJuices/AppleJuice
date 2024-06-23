---
name: "\U0001F528 reactor"
about: 코드 리팩토링에 대한 이슈
title: ''
labels: ''
assignees: ''

---

## 리팩토링 요청

### 설명
- 로그인 로직을 ViewModel로 분리합니다.

### 필요 이유
- MVVM 아키텍처를 따르기 위해 로직을 ViewModel로 분리하여 코드의 유지보수성을 향상시키기 위함입니다.

### 변경 사항
- View에서 로그인 로직을 제거하고 ViewModel에 추가합니다.
- View와 ViewModel 간의 바인딩을 설정합니다.

### 추가 정보
- MVVM 아키텍처에 대한 설명은 [MVVM 패턴 문서](#)에서 확인할 수 있습니다.
