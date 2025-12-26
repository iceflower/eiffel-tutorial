note
    description: "[
        Design by Contract 예제 메인 프로그램

        에펠의 핵심 철학인 Design by Contract를 시연합니다:
        - 은행 계좌 예제: 실용적인 DbC 적용
        - 제네릭 스택 예제: old 키워드와 불변식
        - 계약 위반 시나리오: 버그 책임 분배

        EiffelStudio 25.02 기준
    ]"
    author: "Eiffel Tutorial"
    date: "2025"
    revision: "2.0"

class
    MAIN

create
    make

feature -- Initialization

    make
        do
            print ("=== Design by Contract 예제 (2025) ===%N%N")

            demonstrate_bank_account
            demonstrate_stack
            demonstrate_contract_violation
            demonstrate_check_statement
        end

feature -- Demos

    demonstrate_bank_account
            -- 은행 계좌 예제
        local
            alice_account: BANK_ACCOUNT
            bob_account: BANK_ACCOUNT
        do
            print ("========================================%N")
            print ("1. 은행 계좌 예제%N")
            print ("========================================%N%N")

            -- 계좌 생성
            create alice_account.make ("Alice", 10000)
            create bob_account.make ("Bob", 5000)

            -- 초기 상태
            alice_account.display_info
            bob_account.display_info

            -- 입금
            print ("--- Alice 3000원 입금 ---%N")
            alice_account.deposit (3000)
            alice_account.display_info

            -- 출금
            print ("--- Alice 2000원 출금 ---%N")
            alice_account.withdraw (2000)
            alice_account.display_info

            -- 이체
            print ("--- Alice → Bob 5000원 이체 ---%N")
            alice_account.transfer_to (bob_account, 5000)
            alice_account.display_info
            bob_account.display_info

            -- 거래 내역
            alice_account.display_history
            bob_account.display_history
        end

    demonstrate_stack
            -- 스택 예제
        local
            int_stack: STACK [INTEGER]
            str_stack: STACK [STRING]
        do
            print ("========================================%N")
            print ("2. 제네릭 스택 예제%N")
            print ("========================================%N%N")

            -- 정수 스택
            create int_stack.make (5)
            print ("정수 스택 (용량: 5)%N")

            int_stack.push (10)
            int_stack.push (20)
            int_stack.push (30)
            print ("push 10, 20, 30 후 top: " + int_stack.top.out + "%N")
            print ("count: " + int_stack.count.out + "%N")

            int_stack.pop
            print ("pop 후 top: " + int_stack.top.out + "%N")
            print ("count: " + int_stack.count.out + "%N%N")

            -- 문자열 스택
            create str_stack.make (3)
            print ("문자열 스택 (용량: 3)%N")

            str_stack.push ("Hello")
            str_stack.push ("Eiffel")
            str_stack.push ("World")
            print ("3개 push 후 is_full: " + str_stack.is_full.out + "%N")
            print ("top: " + str_stack.top + "%N%N")
        end

    demonstrate_contract_violation
            -- 계약 위반 시나리오 설명
        do
            print ("========================================%N")
            print ("3. 계약 위반 시나리오 (주석 처리됨)%N")
            print ("========================================%N%N")

            print ("다음 코드는 계약 위반을 발생시킵니다:%N%N")

            print ("-- 사전 조건 위반 (require)%N")
            print ("-- 호출자의 책임 위반%N")
            print ("account.withdraw (-100)  -- 음수 출금 시도%N")
            print ("account.withdraw (99999) -- 잔액 초과 출금 시도%N%N")

            print ("-- 사후 조건 위반 (ensure)%N")
            print ("-- 구현자의 책임 위반 (버그)%N")
            print ("-- 메서드가 약속한 결과를 보장하지 못함%N%N")

            print ("-- 불변식 위반 (invariant)%N")
            print ("-- 객체 상태가 일관성을 잃음%N")
            print ("-- 예: 잔액이 음수가 됨%N%N")

            print ("에펠에서는 이러한 위반 시 예외가 발생합니다!%N")
            print ("assertion 옵션이 켜져 있을 때만 체크됩니다.%N%N")
        end

    demonstrate_check_statement
            -- check 문 예제
        local
            numbers: ARRAY [INTEGER]
            sum: INTEGER
            average: REAL_64
        do
            print ("========================================%N")
            print ("4. check 문 예제%N")
            print ("========================================%N%N")

            numbers := <<10, 20, 30, 40, 50>>

            -- check 문으로 중간 assertion 삽입
            check
                array_not_empty: not numbers.is_empty
            end

            across numbers as cursor loop
                sum := sum + cursor.item
            end

            check
                positive_sum: sum > 0
            end

            average := sum / numbers.count

            check
                valid_average: average >= numbers.lower and average <= 50
            end

            print ("배열: <<10, 20, 30, 40, 50>>%N")
            print ("합계: " + sum.out + "%N")
            print ("평균: " + average.out + "%N")
            print ("%Ncheck 문은 코드 중간에 assertion을 삽입합니다.%N")
            print ("assertion 옵션이 켜져 있으면 런타임에 검사됩니다.%N")
        end

end
