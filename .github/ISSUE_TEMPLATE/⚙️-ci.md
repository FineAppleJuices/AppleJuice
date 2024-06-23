---
name: "⚙️ ci"
about: CI 관련 설정 수정에 대한 이슈
title: ''
labels: ''
assignees: ''

---

## CI 설정 요청

### 설명
- GitHub Actions 설정을 추가하여 CI 파이프라인을 구성합니다.

### 필요 이유
- 코드 변경 시 자동으로 빌드 및 테스트를 실행하여 품질을 유지하기 위함입니다.

### 변경 사항
- `.github/workflows/ci.yml` 파일을 추가하여 CI 파이프라인을 설정합니다.

### 테스트 방법
- PR 생성 시 GitHub Actions에서 빌드 및 테스트가 자동으로 실행되는지 확인합니다.

### 추가 정보
- CI 설정 예제는 [GitHub Actions Documentation](https://docs.github.com/en/actions)에서 확인할 수 있습니다.
