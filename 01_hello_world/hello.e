note
    description: "[
        첫 번째 에펠 프로그램 - Hello World

        에펠(Eiffel)은 1985년 Bertrand Meyer가 설계한 객체지향 언어입니다.
        ISO/ECMA 국제 표준 언어이며, Design by Contract의 본고장입니다.

        최신 버전: EiffelStudio 25.02 (2025년 2월)
    ]"
    author: "Eiffel Tutorial"
    date: "2025"
    revision: "2.0"

class
    HELLO

create
    make

feature -- Initialization

    make
            -- 프로그램 진입점
            -- Eiffel에서 모든 프로그램은 클래스 내 feature로 시작합니다.
        do
            print ("Hello, World!%N")
            print ("에펠(Eiffel) 프로그래밍에 오신 것을 환영합니다!%N")
            print ("%N")

            -- 추가 예제: 기본 출력과 문자열 연결
            demonstrate_output
        end

feature -- Demonstration

    demonstrate_output
            -- 다양한 출력 방법 데모
        local
            message: STRING
            year: INTEGER
        do
            print ("=== 에펠 기본 출력 예제 ===%N")

            -- 변수 선언과 할당 (:= 사용)
            year := 2025
            message := "EiffelStudio " + year.out + " 버전으로 학습 중!"

            print (message)
            print ("%N")

            -- 여러 줄 출력
            print ("[
에펠의 특징:
  - Design by Contract (계약에 의한 설계)
  - 순수 객체지향 (모든 것이 객체)
  - 다중 상속 지원
  - Void 안전성 (null 참조 방지)
  - 자동 메모리 관리 (가비지 컬렉션)
            ]")
            print ("%N")
        end

end
