note
    description: "[
        사각형 클래스 - SHAPE를 상속하여 구체적인 도형 구현

        상속 예제:
        - SHAPE의 deferred feature들을 구현
        - Design by Contract 적용 (require, ensure, invariant)
        - scale 커맨드로 상태 변경 예제

        EiffelStudio 25.02 기준
    ]"
    author: "Eiffel Tutorial"
    date: "2025"
    revision: "2.0"

class
    RECTANGLE

inherit
    SHAPE

create
    make

feature {NONE} -- Initialization

    make (a_width, a_height: REAL_64)
            -- 너비와 높이로 사각형 생성
        require
            positive_width: a_width > 0
            positive_height: a_height > 0
        do
            width := a_width
            height := a_height
        ensure
            width_set: width = a_width
            height_set: height = a_height
        end

feature -- Access

    name: STRING = "사각형"

    width: REAL_64
            -- 너비

    height: REAL_64
            -- 높이

feature -- Measurement

    area: REAL_64
            -- 면적 = 너비 x 높이
        do
            Result := width * height
        end

    perimeter: REAL_64
            -- 둘레 = 2 x (너비 + 높이)
        do
            Result := 2 * (width + height)
        end

feature -- Command

    scale (factor: REAL_64)
            -- 크기 조절
        require
            positive_factor: factor > 0
        do
            width := width * factor
            height := height * factor
        ensure
            width_scaled: width = old width * factor
            height_scaled: height = old height * factor
        end

invariant
    positive_dimensions: width > 0 and height > 0

end
