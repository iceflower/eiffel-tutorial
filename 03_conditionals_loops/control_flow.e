note
    description: "[
        에펠의 조건문과 반복문 예제

        에펠의 제어 구조는 다른 언어와 유사하지만,
        몇 가지 독특한 특징이 있습니다:
        - until: True가 되면 종료 (while과 반대)
        - implies: 논리적 함축 연산자
        - across: 현대적 컬렉션 순회
        - loop invariant/variant: Design by Contract 지원

        EiffelStudio 25.02 기준
    ]"
    author: "Eiffel Tutorial"
    date: "2025"
    revision: "2.0"

class
    CONTROL_FLOW

create
    make

feature -- Initialization

    make
        do
            print ("=== 에펠 제어 구조 (2025) ===%N%N")

            demonstrate_if_then_else
            demonstrate_inspect
            demonstrate_loops
            demonstrate_across
            demonstrate_loop_contracts
            demonstrate_quantifiers
        end

feature -- Conditionals

    demonstrate_if_then_else
            -- if-then-else 조건문
        local
            score: INTEGER
            grade: STRING
            is_passed: BOOLEAN
        do
            print ("=== IF-THEN-ELSE ===%N")

            score := 85

            -- 기본 if-then-else 구조
            if score >= 90 then
                grade := "A"
            elseif score >= 80 then
                grade := "B"
            elseif score >= 70 then
                grade := "C"
            elseif score >= 60 then
                grade := "D"
            else
                grade := "F"
            end

            print ("점수 " + score.out + " -> 학점: " + grade + "%N")

            -- 논리 연산자: and, or, not, xor, implies
            if score >= 80 and score < 90 then
                print ("B 학점 범위입니다.%N")
            end

            if not (score < 60) then
                print ("통과했습니다!%N")
            end

            -- 단락 평가 (Short-circuit evaluation)
            -- and then: 첫 번째가 False면 두 번째 평가 안 함
            -- or else: 첫 번째가 True면 두 번째 평가 안 함
            is_passed := score >= 60
            if is_passed and then (score - 60) // 10 >= 2 then
                print ("우수 통과 (70점 이상)%N")
            end

            -- implies 연산자 (논리적 함축)
            -- A implies B = not A or else B
            if (score >= 90) implies (grade ~ "A") then
                print ("90점 이상이면 A학점 (implies 연산자 테스트)%N")
            end

            -- xor 연산자 (배타적 OR)
            if (score >= 80) xor (score >= 90) then
                print ("80-89점 범위입니다 (xor 연산자)%N")
            end

            print ("%N")
        end

    demonstrate_inspect
            -- inspect (switch/case와 유사)
        local
            day: INTEGER
            day_name: STRING
            month: INTEGER
            season: STRING
            char_code: CHARACTER
        do
            print ("=== INSPECT (Switch/Case) ===%N")

            day := 3

            -- 기본 inspect
            inspect day
            when 1 then
                day_name := "월요일"
            when 2 then
                day_name := "화요일"
            when 3 then
                day_name := "수요일"
            when 4 then
                day_name := "목요일"
            when 5 then
                day_name := "금요일"
            when 6, 7 then  -- 여러 값을 하나로 처리
                day_name := "주말"
            else
                day_name := "잘못된 요일"
            end

            print ("Day " + day.out + " = " + day_name + "%N")

            -- 범위를 사용한 inspect
            month := 7
            inspect month
            when 3, 4, 5 then
                season := "봄"
            when 6, 7, 8 then
                season := "여름"
            when 9, 10, 11 then
                season := "가을"
            when 12, 1, 2 then
                season := "겨울"
            else
                season := "알 수 없음"
            end
            print ("Month " + month.out + " = " + season + "%N")

            -- CHARACTER inspect
            char_code := 'B'
            inspect char_code
            when 'A', 'a' then
                print ("문자: A%N")
            when 'B', 'b' then
                print ("문자: B%N")
            when 'C', 'c' then
                print ("문자: C%N")
            else
                print ("기타 문자%N")
            end

            print ("%N")
        end

feature -- Loops

    demonstrate_loops
            -- 에펠의 반복문 (from-until-loop)
        local
            i: INTEGER
            sum: INTEGER
            factorial: INTEGER_64
            fib_prev, fib_curr, fib_next: INTEGER
        do
            print ("=== FROM-UNTIL-LOOP ===%N")

            -- 기본 반복문: 1부터 5까지 출력
            -- 주의: until 조건이 TRUE가 되면 종료 (while과 반대!)
            print ("1부터 5까지: ")
            from
                i := 1
            until
                i > 5  -- i > 5가 TRUE가 되면 종료
            loop
                print (i.out + " ")
                i := i + 1
            end
            print ("%N")

            -- 합계 계산: 1 + 2 + ... + 10
            from
                i := 1
                sum := 0
            until
                i > 10
            loop
                sum := sum + i
                i := i + 1
            end
            print ("1부터 10까지 합: " + sum.out + "%N")

            -- 팩토리얼 계산: 10! (INTEGER_64 사용)
            from
                i := 1
                factorial := 1
            until
                i > 10
            loop
                factorial := factorial * i
                i := i + 1
            end
            print ("10! = " + factorial.out + "%N")

            -- 피보나치 수열 (처음 10개)
            print ("피보나치: ")
            from
                i := 1
                fib_prev := 0
                fib_curr := 1
            until
                i > 10
            loop
                print (fib_curr.out + " ")
                fib_next := fib_prev + fib_curr
                fib_prev := fib_curr
                fib_curr := fib_next
                i := i + 1
            end
            print ("%N%N")
        end

    demonstrate_across
            -- across 반복문 (컬렉션 순회)
        local
            numbers: ARRAY [INTEGER]
            names: ARRAYED_LIST [STRING]
            table: HASH_TABLE [INTEGER, STRING]
            sum: INTEGER
        do
            print ("=== ACROSS (컬렉션 순회) ===%N")

            -- 배열 생성 및 순회
            numbers := <<10, 20, 30, 40, 50>>  -- 매니페스트 배열

            print ("배열 원소: ")
            across numbers as cursor loop
                print (cursor.item.out + " ")
            end
            print ("%N")

            -- 인덱스와 함께 순회
            print ("인덱스 포함: ")
            across numbers as cursor loop
                print ("[" + cursor.cursor_index.out + "]=" + cursor.item.out + " ")
            end
            print ("%N")

            -- 리스트 순회
            create names.make (3)
            names.extend ("Alice")
            names.extend ("Bob")
            names.extend ("Charlie")

            print ("리스트 원소:%N")
            across names as cursor loop
                print ("  - " + cursor.item + "%N")
            end

            -- 해시 테이블 순회
            create table.make (3)
            table.put (30, "Alice")
            table.put (25, "Bob")
            table.put (35, "Charlie")

            print ("해시 테이블 (키 순회):%N")
            across table as cursor loop
                print ("  " + cursor.key + ": " + cursor.item.out + "세%N")
            end

            -- across를 이용한 합계 계산
            sum := 0
            across numbers as cursor loop
                sum := sum + cursor.item
            end
            print ("배열 합계: " + sum.out + "%N%N")
        end

feature -- Loop Contracts

    demonstrate_loop_contracts
            -- 루프 불변식과 변형식 예제
        local
            i, n, sum: INTEGER
        do
            print ("=== 루프 불변식/변형식 (Design by Contract) ===%N")

            n := 10
            from
                i := 1
                sum := 0
            invariant
                -- 루프 불변식: 매 반복 전후에 참이어야 함
                sum_correct: sum = (i - 1) * i // 2
                index_valid: i >= 1 and i <= n + 1
            variant
                -- 변형식: 매 반복마다 감소, 음수가 되면 안 됨 (종료 보장)
                n - i + 1
            until
                i > n
            loop
                sum := sum + i
                i := i + 1
            end

            print ("루프 계약 적용: 1~" + n.out + " 합 = " + sum.out + "%N%N")
        end

feature -- Quantifiers

    demonstrate_quantifiers
            -- across의 all/some 표현식 (수학적 양화사)
        local
            numbers: ARRAY [INTEGER]
            names: ARRAYED_LIST [STRING]
            all_positive: BOOLEAN
            has_negative: BOOLEAN
            has_long_name: BOOLEAN
            all_non_empty: BOOLEAN
        do
            print ("=== ALL/SOME 양화사 (Quantifiers) ===%N")

            numbers := <<5, 10, 15, 20, 25>>

            -- all: 모든 원소가 조건 만족? (전칭 양화사 ∀)
            all_positive := across numbers as c all c.item > 0 end
            print ("모두 양수? " + all_positive.out + "%N")

            -- some: 하나라도 조건 만족? (존재 양화사 ∃)
            has_negative := across numbers as c some c.item < 0 end
            print ("음수 있음? " + has_negative.out + "%N")

            -- 문자열 리스트 예제
            create names.make (3)
            names.extend ("Alice")
            names.extend ("Bob")
            names.extend ("Charlie")

            has_long_name := across names as c some c.item.count > 5 end
            print ("5글자 초과 이름 있음? " + has_long_name.out + "%N")

            all_non_empty := across names as c all not c.item.is_empty end
            print ("모두 비어있지 않음? " + all_non_empty.out + "%N")

            -- 복합 조건
            print ("%N복합 조건 예제:%N")
            print ("모두 10 이상? " + (across numbers as c all c.item >= 10 end).out + "%N")
            print ("5의 배수만? " + (across numbers as c all c.item \\ 5 = 0 end).out + "%N")
            print ("30 이상 있음? " + (across numbers as c some c.item >= 30 end).out + "%N")
        end

end
