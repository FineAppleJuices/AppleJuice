---
name: "\U0001F9D9 perf"
about: 성능 개선에 대한 이슈
title: ''
labels: ''
assignees: ''

---

## 성능 개선 요청

### 설명
- 리스트 뷰에서 이미지 로딩 성능을 개선합니다.

### 필요 이유
- 리스트 뷰의 스크롤 성능을 향상시키기 위함입니다.

### 변경 사항
- 비동기 이미지 로딩 및 캐싱을 적용합니다.
- `ImageLoader` 유틸리티를 사용하여 이미지 로딩 최적화

### 테스트 방법
- 대용량 데이터로 리스트 뷰를 테스트하여 스크롤 성능을 확인합니다.

### 추가 정보
- 이미지 로딩 최적화 방법은 [SwiftUI Image Loading](https://developer.apple.com/documentation/swiftui/image)에서 확인할 수 있습니다.
