# AppleJuice









## 🐈‍⬛ Github Convention

### 이슈 : 이슈이름 -> [이슈 종류] 이슈 이름 

1.  발행할 이슈 종류 파악하기
   <table>
  <thead>
    <tr>
      <th>이슈 종류</th>
      <th>내용</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>feat</td>
      <td>새로운 기능에 대한 이슈</td>
    </tr>
    <tr>
      <td>fix</td>
      <td>버그 수정에 대한 이슈</td>
    </tr>
    <tr>
      <td>build</td>
      <td>빌드 관련 파일 수정 / 모듈 설치 또는 삭제에 대한 이슈</td>
    </tr>
    <tr>
      <td>chore</td>
      <td>그 외 자잘한 수정에 대한 이슈</td>
    </tr>
    <tr>
      <td>ci</td>
      <td>ci 관련 설정 수정에 대한 이슈</td>
    </tr>
    <tr>
      <td>docs</td>
      <td>문서 수정에 대한 이슈</td>
    </tr>
    <tr>
      <td>style</td>
      <td>코드 스타일 혹은 포맷 등에 관한 이슈</td>
    </tr>
    <tr>
      <td>refactor</td>
      <td>코드 리팩토링에 대한 이슈</td>
    </tr>
    <tr>
      <td>test</td>
      <td>테스트 코드 수정에 대한 이슈</td>
    </tr>
    <tr>
      <td>perf</td>
      <td>성능 개선에 대한 이슈</td>
    </tr>
  </tbody>
</table>

2. 이슈종류에 맞는 Template 선택하기

ex) feat (새로운 기능에 대한 이슈) 
```
## 기능 요청

### 설명
- 새로운 로그인 화면을 추가합니다.

### 필요 이유
- 사용자들이 앱에 로그인할 수 있도록 하기 위함입니다.

### 구현 방법
- SwiftUI를 사용하여 로그인 화면을 구성합니다.
- 이메일과 비밀번호 입력 필드, 로그인 버튼을 추가합니다.
- 로그인 버튼을 누르면 Firebase Auth를 사용하여 인증을 처리합니다.

### 관련 자료
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Firebase Auth Documentation](https://firebase.google.com/docs/auth)

### 추가 정보
- UI 디자인은 Figma에서 확인할 수 있습니다.
- 로그인 화면은 앱의 루트 뷰로 설정해야 합니다.
```

### 브랜치 : 브랜치 이름 -> 이슈종류/#이슈 번호/적업할내용
ex) feat/#3-Login


### 커밋 : 커밋이름 -> [#이슈번호] 이슈종류 : 변경내용 
ex) [#10] feat : 로그인 버튼 추가 
