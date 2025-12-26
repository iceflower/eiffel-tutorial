# Design by Contract (DbC)

> **2025년 업데이트** - EiffelStudio 25.02 기준

Design by Contract는 에펠의 **가장 중요한 특징**입니다. Bertrand Meyer가 에펠과 함께 창안했습니다.

---

## 계약의 개념

소프트웨어 컴포넌트 간의 관계를 **계약**으로 정의합니다.

### 일상의 계약 비유

```text
고객(Client)과 공급자(Supplier)의 계약:

고객의 의무 (사전 조건):
- 유효한 신용카드 제시
- 18세 이상

공급자의 의무 (사후 조건):
- 상품 배송
- 영수증 발급

불변 조건:
- 상품 재고 >= 0
- 거래 기록 보관
```

---

## 세 가지 계약 요소

| 요소 | 키워드 | 의미 | 위반 시 |
|------|--------|------|---------|
| **사전 조건** | `require` | 호출 전 만족해야 할 조건 | 호출자(Client) 버그 |
| **사후 조건** | `ensure` | 실행 후 보장하는 조건 | 공급자(Supplier) 버그 |
| **불변식** | `invariant` | 항상 참이어야 하는 조건 | 클래스 구현 버그 |

---

## 사전 조건 (Precondition)

`require` 키워드로 정의합니다.

```eiffel
deposit (amount: INTEGER)
        -- 입금
    require
        positive_amount: amount > 0
        account_active: is_active
    do
        balance := balance + amount
    end
```

### 의미

- **호출자의 책임**: 호출 전에 조건을 만족시켜야 함
- **위반 시**: 호출자의 버그
- **공급자 권리**: 조건이 참이라고 가정하고 구현

### 올바른 호출

```eiffel
if amount > 0 and account.is_active then
    account.deposit (amount)  -- 사전 조건 만족
else
    print ("입금 불가%N")
end
```

---

## 사후 조건 (Postcondition)

`ensure` 키워드로 정의합니다.

```eiffel
deposit (amount: INTEGER)
    require
        positive_amount: amount > 0
    do
        balance := balance + amount
    ensure
        balance_increased: balance = old balance + amount
        balance_positive: balance > 0
    end
```

### old 키워드

`old`는 메서드 **실행 전** 값을 참조합니다.

```eiffel
withdraw (amount: INTEGER)
    require
        positive: amount > 0
        sufficient: amount <= balance
    do
        balance := balance - amount
    ensure
        decreased: balance = old balance - amount  -- 이전 잔액 - amount
        non_negative: balance >= 0
    end
```

### 의미

- **공급자의 책임**: 실행 후 조건을 보장해야 함
- **위반 시**: 공급자의 버그
- **호출자 권리**: 조건이 만족된다고 가정

---

## 클래스 불변식 (Class Invariant)

클래스 끝에 `invariant` 절로 정의합니다.

```eiffel
class
    BANK_ACCOUNT

-- ... features ...

invariant
    non_negative_balance: balance >= 0
    owner_exists: owner /= Void and then not owner.is_empty
    valid_account_number: account_number.count = 10

end
```

### 검사 시점

불변식은 다음 시점에 검사됩니다:

1. 생성자 실행 후
2. public feature 호출 전
3. public feature 실행 후

### 의미

- 객체의 **일관성** 보장
- 위반 시 클래스 구현 버그

---

## 완전한 예제

```eiffel
class
    STACK [G]

create
    make

feature {NONE} -- Initialization

    make (a_capacity: INTEGER)
            -- 주어진 용량으로 스택 생성
        require
            positive_capacity: a_capacity > 0
        do
            capacity := a_capacity
            create items.make (a_capacity)
        ensure
            capacity_set: capacity = a_capacity
            empty: is_empty
        end

feature -- Access

    top: G
            -- 스택 맨 위 원소
        require
            not_empty: not is_empty
        do
            Result := items.last
        end

    count: INTEGER
        do
            Result := items.count
        end

    capacity: INTEGER

feature -- Status

    is_empty: BOOLEAN
        do
            Result := count = 0
        ensure
            definition: Result = (count = 0)
        end

    is_full: BOOLEAN
        do
            Result := count >= capacity
        ensure
            definition: Result = (count >= capacity)
        end

feature -- Element change

    push (item: G)
            -- 원소 추가
        require
            not_full: not is_full
        do
            items.extend (item)
        ensure
            count_increased: count = old count + 1
            item_pushed: top = item
            not_empty: not is_empty
        end

    pop
            -- 맨 위 원소 제거
        require
            not_empty: not is_empty
        do
            items.finish
            items.remove
        ensure
            count_decreased: count = old count - 1
        end

feature {NONE} -- Implementation

    items: ARRAYED_LIST [G]

invariant
    count_non_negative: count >= 0
    count_bounded: count <= capacity
    consistency: is_empty = (count = 0)

end
```

---

## 계약 레이블

각 assertion에 레이블을 붙이면 디버깅에 유용합니다.

```eiffel
require
    positive_amount: amount > 0      -- "positive_amount" 레이블
    sufficient_funds: amount <= balance
```

위반 시 에러 메시지에 레이블이 표시됩니다:

```text
Precondition violation: positive_amount in BANK_ACCOUNT.withdraw
```

---

## check 문

코드 중간에 assertion을 삽입합니다.

```eiffel
calculate_average (list: LIST [INTEGER]): REAL_64
    local
        sum: INTEGER
    do
        check
            not_empty: not list.is_empty
        end

        across list as cursor loop
            sum := sum + cursor.item
        end

        Result := sum / list.count

        check
            valid_result: Result >= 0
        end
    end
```

---

## 루프 불변식과 변형식

```eiffel
from
    i := 1
    sum := 0
invariant
    partial_sum_correct: sum = sum_of_first (i - 1)
    index_in_range: i >= 1 and i <= n + 1
variant
    n - i + 1  -- 매 반복마다 감소해야 함
until
    i > n
loop
    sum := sum + array [i]
    i := i + 1
end
```

| 절 | 목적 |
|-----|------|
| `invariant` | 매 반복 시작과 끝에 참 |
| `variant` | 양수이고 매 반복마다 감소 (종료 보장) |

---

## 상속과 계약

### 사전 조건 약화

자식 클래스는 사전 조건을 **약화**할 수 있습니다 (더 관대해질 수 있음).

```eiffel
class PARENT
feature
    process (x: INTEGER)
        require
            x > 0  -- 양수만 허용
        do ... end
end

class CHILD
inherit PARENT
    redefine process end
feature
    process (x: INTEGER)
        require else
            x >= 0  -- 0도 허용 (더 관대)
        do ... end
end
```

### 사후 조건 강화

자식 클래스는 사후 조건을 **강화**할 수 있습니다 (더 많이 보장).

```eiffel
class PARENT
feature
    calculate: INTEGER
        do ... end
        ensure
            Result >= 0
        end
end

class CHILD
inherit PARENT
    redefine calculate end
feature
    calculate: INTEGER
        do ... end
        ensure then
            Result >= 10  -- 더 강한 보장
        end
end
```

---

## Assertion 모니터링 설정

ECF 파일에서 assertion 검사 수준을 설정합니다:

```xml
<option>
    <assertions
        precondition="true"
        postcondition="true"
        invariant="true"
        check="true"
        loop="true"
    />
</option>
```

| 설정 | 의미 |
|------|------|
| `precondition` | require 검사 |
| `postcondition` | ensure 검사 |
| `invariant` | class invariant 검사 |
| `check` | check 문 검사 |
| `loop` | loop invariant/variant 검사 |

프로덕션에서는 성능을 위해 비활성화할 수 있습니다.

---

## DbC의 이점

1. **문서화**: 계약이 곧 문서
2. **조기 버그 발견**: 런타임에 위반 즉시 발견
3. **책임 명확화**: 누구의 버그인지 명확
4. **테스트 용이**: 계약이 테스트 오라클 역할
5. **안전한 리팩토링**: 계약이 변경 시 안전망

---

## require else / ensure then

상속에서 계약을 조정할 때 사용합니다.

```eiffel
-- 부모 클래스
class ACCOUNT
feature
    withdraw (amount: INTEGER)
        require
            amount > 0
            amount <= balance
        do ... end
        ensure
            balance = old balance - amount
        end
end

-- 자식 클래스
class PREMIUM_ACCOUNT
inherit
    ACCOUNT
        redefine withdraw end
feature
    withdraw (amount: INTEGER)
        require else
            -- OR로 연결됨: 부모 조건 OR 이 조건
            amount <= balance + credit_limit  -- 더 관대한 조건
        do ... end
        ensure then
            -- AND로 연결됨: 부모 조건 AND 이 조건
            bonus_points = old bonus_points + amount // 100  -- 추가 보장
        end
end
```

| 키워드 | 연결 방식 | 효과 |
|--------|----------|------|
| `require else` | OR | 사전 조건 약화 (더 관대) |
| `ensure then` | AND | 사후 조건 강화 (더 엄격) |

---

## 방어적 프로그래밍 vs DbC

```eiffel
-- 방어적 프로그래밍 (권장하지 않음)
withdraw_defensive (amount: INTEGER)
    do
        if amount > 0 and amount <= balance then
            balance := balance - amount
        else
            -- 조용히 실패하거나 오류 반환
        end
    end

-- Design by Contract (권장)
withdraw (amount: INTEGER)
    require
        positive: amount > 0
        sufficient: amount <= balance
    do
        balance := balance - amount
    ensure
        updated: balance = old balance - amount
    end
```

| 방식 | 장점 | 단점 |
|------|------|------|
| 방어적 | 런타임 안정성 | 버그 숨김, 코드 복잡 |
| DbC | 버그 즉시 발견, 명확한 책임 | 런타임 오버헤드 (개발 시) |

---

## AutoTest와 DbC

EiffelStudio의 AutoTest는 DbC 계약을 활용하여 자동으로 테스트를 생성합니다.

```text
EiffelStudio → Testing → AutoTest → 클래스 선택 → Run
```

AutoTest는:

1. 랜덤 입력값 생성
2. require 조건을 만족하는 값만 사용
3. ensure/invariant 위반 시 버그 보고
4. 경계값 및 극단적 케이스 테스트

---

## 계약과 문서화

계약은 자동으로 문서가 됩니다. EiffelStudio의 **Flat View**에서 모든 계약을 포함한 클래스 문서를 볼 수 있습니다.

```eiffel
-- 이 계약들이 API 문서 역할
deposit (amount: INTEGER)
        -- 계좌에 `amount`원 입금
    require
        positive_amount: amount > 0
    ensure
        balance_increased: balance = old balance + amount
    end
```

---

## 연습 문제

1. `QUEUE` 클래스를 DbC로 구현하세요.
2. `SORTED_LIST` 클래스를 만들어 "항상 정렬됨" 불변식을 추가하세요.
3. `TEMPERATURE` 클래스를 만들어 절대영도 이상 조건을 추가하세요.

---

## 참고 자료

- [Design by Contract 공식 문서](https://www.eiffel.org/doc/eiffel/Design_by_Contract)
- [Bertrand Meyer - Object-Oriented Software Construction](https://www.eiffel.com/resources/books/)
- [AutoTest Documentation](https://www.eiffel.org/doc/eiffelstudio/AutoTest)

---

## 다음 단계

[07_웹서버.md](../07_web_server/07_웹서버.md)에서 EWF를 사용한 웹 서버 개발을 학습합니다.
