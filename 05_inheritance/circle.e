note
    description: "[
        원 클래스 - SHAPE를 상속하여 원형 도형 구현

        특징:
        - REAL_64 상수로 Pi 정의 (에펠의 상수 명명 규칙: 첫 글자 대문자)
        - {MATH_CONST} 클래스의 Pi를 사용할 수도 있음
        - diameter 추가 쿼리 제공

        EiffelStudio 25.02 기준
    ]"
    author: "Eiffel Tutorial"
    date: "2025"
    revision: "2.0"

class
    CIRCLE

inherit
    SHAPE

create
    make

feature {NONE} -- Initialization

    make (a_radius: REAL_64)
            -- 반지름으로 원 생성
        require
            positive_radius: a_radius > 0
        do
            radius := a_radius
        ensure
            radius_set: radius = a_radius
        end

feature -- Access

    name: STRING = "원"

    radius: REAL_64
            -- 반지름

feature -- Constants

    Pi: REAL_64 = 3.14159265358979

feature -- Measurement

    area: REAL_64
            -- 면적 = π × r²
        do
            Result := Pi * radius * radius
        end

    perimeter: REAL_64
            -- 둘레 (원주) = 2πr
        do
            Result := 2 * Pi * radius
        end

    diameter: REAL_64
            -- 지름
        do
            Result := 2 * radius
        end

invariant
    positive_radius: radius > 0

end
