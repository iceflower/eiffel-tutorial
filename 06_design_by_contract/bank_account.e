note
    description: "[
        은행 계좌 클래스 - Design by Contract의 핵심 개념 데모

        Design by Contract (DbC)의 3가지 핵심 요소:
        1. require (사전 조건): 호출자가 보장해야 하는 조건
        2. ensure (사후 조건): 메서드가 보장하는 결과
        3. invariant (클래스 불변식): 항상 유지되어야 하는 조건

        책임 분배:
        - require 위반 → 호출자(클라이언트)의 버그
        - ensure 위반 → 공급자(클래스)의 버그
        - invariant 위반 → 클래스 구현의 버그

        Bertrand Meyer의 계약 철학:
        "계약은 문서이자 테스트이며, 가장 중요한 것은 정확한 책임 분배다."

        EiffelStudio 25.02 기준
    ]"
    author: "Eiffel Tutorial"
    date: "2025"
    revision: "2.0"

class
    BANK_ACCOUNT

create
    make

feature {NONE} -- Initialization

    make (a_owner: STRING; initial_balance: INTEGER)
            -- 계좌 생성
        require
            -- 사전 조건: 호출자가 보장해야 함
            owner_not_empty: not a_owner.is_empty
            non_negative_balance: initial_balance >= 0
        do
            owner := a_owner
            balance := initial_balance
            create transaction_history.make (10)
            transaction_history.extend ("계좌 개설: " + initial_balance.out + "원")
        ensure
            -- 사후 조건: 이 메서드가 보장
            owner_set: owner = a_owner
            balance_set: balance = initial_balance
            history_initialized: transaction_history /= Void
        end

feature -- Access

    owner: STRING
            -- 계좌 소유자

    balance: INTEGER
            -- 현재 잔액

    transaction_history: ARRAYED_LIST [STRING]
            -- 거래 내역

feature -- Query

    can_withdraw (amount: INTEGER): BOOLEAN
            -- 출금 가능한가?
        do
            Result := amount > 0 and amount <= balance
        ensure
            definition: Result = (amount > 0 and amount <= balance)
        end

    is_empty: BOOLEAN
            -- 잔액이 0인가?
        do
            Result := balance = 0
        ensure
            definition: Result = (balance = 0)
        end

feature -- Command

    deposit (amount: INTEGER)
            -- 입금
        require
            positive_amount: amount > 0
        local
            old_balance: INTEGER
        do
            old_balance := balance
            balance := balance + amount
            transaction_history.extend ("입금: +" + amount.out + "원 (잔액: " + balance.out + "원)")
        ensure
            balance_increased: balance = old balance + amount
            history_updated: transaction_history.count = old transaction_history.count + 1
        end

    withdraw (amount: INTEGER)
            -- 출금
        require
            positive_amount: amount > 0
            sufficient_funds: amount <= balance  -- 잔액이 충분해야 함
        do
            balance := balance - amount
            transaction_history.extend ("출금: -" + amount.out + "원 (잔액: " + balance.out + "원)")
        ensure
            balance_decreased: balance = old balance - amount
            history_updated: transaction_history.count = old transaction_history.count + 1
        end

    transfer_to (other: BANK_ACCOUNT; amount: INTEGER)
            -- 다른 계좌로 이체
        require
            valid_recipient: other /= Void
            not_same_account: other /= Current
            positive_amount: amount > 0
            sufficient_funds: amount <= balance
        do
            withdraw (amount)
            other.deposit (amount)
            -- 이체 기록 업데이트
            transaction_history.put_i_th (
                "이체 → " + other.owner + ": -" + amount.out + "원 (잔액: " + balance.out + "원)",
                transaction_history.count
            )
        ensure
            my_balance_decreased: balance = old balance - amount
            other_balance_increased: other.balance = old other.balance + amount
        end

feature -- Output

    display_info
            -- 계좌 정보 출력
        do
            print ("=== 계좌 정보 ===%N")
            print ("소유자: " + owner + "%N")
            print ("잔액: " + balance.out + "원%N")
            print ("%N")
        end

    display_history
            -- 거래 내역 출력
        do
            print ("=== 거래 내역 (" + owner + ") ===%N")
            across transaction_history as cursor loop
                print ("  " + cursor.item + "%N")
            end
            print ("%N")
        end

invariant
    -- 클래스 불변식: 객체가 존재하는 동안 항상 참이어야 함
    owner_exists: owner /= Void and then not owner.is_empty
    non_negative_balance: balance >= 0  -- 잔액은 항상 0 이상
    history_exists: transaction_history /= Void

end
