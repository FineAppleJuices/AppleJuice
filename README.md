# 🍎 사과쥬스가 되고 싶어!!



## 🧩 Team 
<table style="width: 100%; table-layout: fixed;">
  <tr>
    <td style="text-align: center; padding: 10px;">
      <h3>노랑</h3>
    </td>
    <td style="text-align: center; padding: 10px;">
      <h3>벨</h3>
    </td>
    <td style="text-align: center; padding: 10px;">
      <h3>파인</h3>
    </td>
    <td style="text-align: center; padding: 10px;">
      <h3>해피</h3>
    </td>
  </tr>
  <tr>
    <td style="text-align: center; padding: 10px;">
      <img src="https://github.com/FineAppleJuices/AppleJuice/assets/121593683/2d516a63-84df-4082-a2eb-de331ac21f4c" width="100" alt="Image 1">
    </td>
    <td style="text-align: center; padding: 10px;">
      <img src="https://github.com/FineAppleJuices/AppleJuice/assets/121593683/8b3e6d09-7459-40ff-870f-44e668d51a1b" width="100" alt="Image 2">
    </td>
    <td style="text-align: center; padding: 10px;">
      <img src= "https://github.com/FineAppleJuices/AppleJuice/assets/121593683/da57e123-6c7e-42f0-a89d-f71d3da206af" width="100" alt="Image 3">
    </td>
    <td style="text-align: center; padding: 10px;">
      <img src="https://github.com/FineAppleJuices/AppleJuice/assets/121593683/b78111b5-185d-4161-898d-9ef037a87546" width="100" alt="Image 4">
    </td>
  </tr>
</table>





## 🧭 Github Strategy 
- Main Branch로부터 각 Topic에 대한 branch를 내고 작업이 완료되면 해당 커밋들을 pull request를 통해 main Branch로 병합합니다. 
![image](https://github.com/FineAppleJuices/AppleJuice/assets/121593683/447eee07-efe6-4a86-9adf-eef90daf08f1)



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
