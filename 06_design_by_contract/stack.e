note
    description: "[
        제네릭 스택 클래스 - Design by Contract 심화 예제

        이 예제는 다음을 보여줍니다:
        - 제네릭 타입 [G]를 사용한 타입 안전 컬렉션
        - old 키워드로 이전 상태 참조
        - 복잡한 사전/사후 조건 조합
        - 클래스 불변식으로 일관성 보장

        스택 데이터 구조:
        - LIFO (Last In, First Out)
        - push: 맨 위에 원소 추가
        - pop: 맨 위 원소 제거
        - top: 맨 위 원소 조회 (제거 없이)

        EiffelStudio 25.02 기준
    ]"
    author: "Eiffel Tutorial"
    date: "2025"
    revision: "2.0"

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
            empty_stack: is_empty
        end

feature -- Access

    top: G
            -- 스택 맨 위 원소
        require
            not_empty: not is_empty
        do
            Result := items.last
        end

    capacity: INTEGER
            -- 최대 용량

    count: INTEGER
            -- 현재 원소 개수
        do
            Result := items.count
        end

feature -- Status

    is_empty: BOOLEAN
            -- 스택이 비어있는가?
        do
            Result := items.is_empty
        ensure
            definition: Result = (count = 0)
        end

    is_full: BOOLEAN
            -- 스택이 가득 찼는가?
        do
            Result := count >= capacity
        ensure
            definition: Result = (count >= capacity)
        end

feature -- Command

    push (item: G)
            -- 원소 추가
        require
            not_full: not is_full
        do
            items.extend (item)
        ensure
            count_increased: count = old count + 1
            item_on_top: top = item
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

    clear
            -- 모든 원소 제거
        do
            items.wipe_out
        ensure
            is_empty: is_empty
            count_zero: count = 0
        end

feature {NONE} -- Implementation

    items: ARRAYED_LIST [G]
            -- 내부 저장소

invariant
    count_non_negative: count >= 0
    count_bounded: count <= capacity
    items_exist: items /= Void

end
