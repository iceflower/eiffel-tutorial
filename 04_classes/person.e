note
    description: "[
        사람을 나타내는 클래스 - 기본 클래스 정의 예제

        이 예제는 에펠 클래스의 핵심 개념을 보여줍니다:
        - feature 분류 (Attribute, Query, Command)
        - 접근 제어 ({NONE}, {ANY})
        - Design by Contract (require, ensure, invariant)
        - Command-Query Separation 원칙

        EiffelStudio 25.02 기준
    ]"
    author: "Eiffel Tutorial"
    date: "2025"
    revision: "2.0"

class
    PERSON

create
    make, make_with_age

feature {NONE} -- Initialization (외부에서 접근 불가)

    make (a_name: STRING)
            -- 이름만으로 생성
        require
            name_not_empty: not a_name.is_empty
        do
            name := a_name
            age := 0
        ensure
            name_set: name = a_name
            age_zero: age = 0
        end

    make_with_age (a_name: STRING; a_age: INTEGER)
            -- 이름과 나이로 생성
        require
            name_not_empty: not a_name.is_empty
            age_non_negative: a_age >= 0
        do
            name := a_name
            age := a_age
        ensure
            name_set: name = a_name
            age_set: age = a_age
        end

feature -- Access (공개 - 읽기용 속성)

    name: STRING
            -- 사람의 이름

    age: INTEGER
            -- 사람의 나이

feature -- Query (상태를 변경하지 않는 함수)

    is_adult: BOOLEAN
            -- 성인인가?
        do
            Result := age >= 18
        end

    greeting: STRING
            -- 인사말 반환
        do
            Result := "안녕하세요, 저는 " + name + "입니다."
        end

    info: STRING
            -- 정보 문자열 반환
        do
            Result := name + " (" + age.out + "세)"
        end

feature -- Command (상태를 변경하는 프로시저)

    set_age (a_age: INTEGER)
            -- 나이 설정
        require
            non_negative: a_age >= 0
        do
            age := a_age
        ensure
            age_set: age = a_age
        end

    celebrate_birthday
            -- 생일 축하 - 나이 1 증가
        do
            age := age + 1
            print (name + "님, 생일 축하합니다! 이제 " + age.out + "세입니다.%N")
        ensure
            age_increased: age = old age + 1
        end

    rename_to (new_name: STRING)
            -- 이름 변경
        require
            name_not_empty: not new_name.is_empty
        do
            name := new_name
        ensure
            name_changed: name = new_name
        end

invariant
    name_exists: name /= Void and then not name.is_empty
    age_non_negative: age >= 0

end
