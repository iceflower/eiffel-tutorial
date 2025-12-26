note
    description: "[
        정사각형 클래스 - RECTANGLE을 상속 (다단계 상속)

        상속 조정 예제:
        - rename: 부모의 make를 make_rectangle로 이름 변경
        - redefine: name 속성을 재정의
        - 다단계 상속: SQUARE → RECTANGLE → SHAPE

        에펠의 상속 철학:
        - 명시적 상속 조정으로 다이아몬드 문제 해결
        - 부모 feature 이름 충돌 시 rename 필수

        EiffelStudio 25.02 기준
    ]"
    author: "Eiffel Tutorial"
    date: "2025"
    revision: "2.0"

class
    SQUARE

inherit
    RECTANGLE
        rename
            make as make_rectangle
        redefine
            name
        end

create
    make

feature {NONE} -- Initialization

    make (a_side: REAL_64)
            -- 한 변의 길이로 정사각형 생성
        require
            positive_side: a_side > 0
        do
            make_rectangle (a_side, a_side)  -- 부모 생성자 호출
        ensure
            side_set: side = a_side
        end

feature -- Access

    name: STRING = "정사각형"

    side: REAL_64
            -- 한 변의 길이
        do
            Result := width  -- width와 height가 같으므로 width 반환
        end

end
