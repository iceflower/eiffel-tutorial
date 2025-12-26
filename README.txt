===============================================================================
                    에펠(Eiffel) 프로그래밍 튜토리얼
===============================================================================

이 프로젝트는 에펠 언어를 기초부터 웹 서버까지 배우기 위한 예제 모음입니다.

-------------------------------------------------------------------------------
필수 준비물
-------------------------------------------------------------------------------

1. EiffelStudio 설치
   - 다운로드: https://www.eiffel.com/eiffelstudio/
   - 무료 Community Edition 사용 가능

2. 환경 변수 설정
   - ISE_EIFFEL: EiffelStudio 설치 경로
   - ISE_LIBRARY: Eiffel 라이브러리 경로

-------------------------------------------------------------------------------
프로젝트 구조
-------------------------------------------------------------------------------

eiffel-tutorial/
|
|-- 01_hello_world/          # 첫 번째 프로그램
|   |-- hello.e              # Hello World 코드
|   |-- hello.ecf            # 프로젝트 설정 파일
|
|-- 02_variables_types/      # 변수와 타입
|   |-- variables.e          # 기본 타입, 변수 선언, 타입 변환
|   |-- variables.ecf
|
|-- 03_conditionals_loops/   # 조건문과 반복문
|   |-- control_flow.e       # if-then-else, inspect, from-until-loop, across
|   |-- control_flow.ecf
|
|-- 04_classes/              # 클래스 정의
|   |-- person.e             # 클래스 예제 (속성, 메서드, 생성자)
|   |-- main.e               # 메인 프로그램
|   |-- classes.ecf
|
|-- 05_inheritance/          # 상속과 다형성
|   |-- shape.e              # 추상 클래스 (deferred)
|   |-- rectangle.e          # 상속 받는 클래스
|   |-- circle.e             # 상속 받는 클래스
|   |-- square.e             # 다단계 상속
|   |-- main.e
|   |-- inheritance.ecf
|
|-- 06_design_by_contract/   # Design by Contract
|   |-- bank_account.e       # require, ensure, invariant 예제
|   |-- stack.e              # 제네릭 + DbC 예제
|   |-- main.e
|   |-- dbc.ecf
|
|-- 07_web_server/           # EWF 웹 서버
    |-- application.e        # HTTP 서버 구현
    |-- web_server.ecf

-------------------------------------------------------------------------------
실행 방법
-------------------------------------------------------------------------------

1. EiffelStudio 열기

2. 프로젝트 열기
   - File > Open Project
   - 원하는 폴더의 .ecf 파일 선택

3. 컴파일
   - Project > Compile (또는 F7)

4. 실행
   - Project > Run (또는 Ctrl+F5)

-------------------------------------------------------------------------------
학습 순서
-------------------------------------------------------------------------------

1단계: 기초 문법
   - 01_hello_world: 첫 프로그램 작성
   - 02_variables_types: 변수와 타입 이해
   - 03_conditionals_loops: 제어 구조 학습

2단계: 객체지향
   - 04_classes: 클래스 정의와 사용
   - 05_inheritance: 상속과 다형성

3단계: 에펠의 핵심
   - 06_design_by_contract: DbC 이해와 활용

4단계: 응용
   - 07_web_server: EWF로 웹 서버 만들기

-------------------------------------------------------------------------------
에펠 문법 요약
-------------------------------------------------------------------------------

변수 선언:
   name: STRING
   count: INTEGER

할당:
   name := "Eiffel"   -- := 사용 (= 가 아님!)

조건문:
   if condition then
       ...
   elseif other_condition then
       ...
   else
       ...
   end

반복문:
   from
       i := 1
   until
       i > 10   -- TRUE가 되면 종료
   loop
       ...
       i := i + 1
   end

클래스:
   class
       MY_CLASS
   create
       make
   feature
       ...
   end

Design by Contract:
   require    -- 사전 조건
   ensure     -- 사후 조건
   invariant  -- 클래스 불변식

-------------------------------------------------------------------------------
참고 자료
-------------------------------------------------------------------------------

- 공식 사이트: https://www.eiffel.org
- 튜토리얼: https://www.eiffel.org/doc/eiffel/An_Eiffel_Tutorial_(ET)
- EWF 프레임워크: https://github.com/EiffelWebFramework/EWF
- Design by Contract: https://www.eiffel.com/values/design-by-contract/

===============================================================================
