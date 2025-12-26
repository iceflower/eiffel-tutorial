note
    description: "[
        상속 예제 메인 프로그램

        에펠 상속의 주요 특징 시연:
        - 추상 클래스(deferred class)와 구체 클래스
        - 다단계 상속 (SQUARE → RECTANGLE → SHAPE)
        - 다형성 (polymorphism)
        - 타입 검사 및 캐스팅 (attached ... as)
        - 동적 타입 생성 (create {TYPE})

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
            print ("=== 에펠 상속 예제 (2025) ===%N%N")

            demonstrate_basic_inheritance
            demonstrate_polymorphism
            demonstrate_type_checking
            demonstrate_dynamic_creation
        end

feature -- Demonstrations

    demonstrate_basic_inheritance
            -- 기본 상속 및 다단계 상속 예제
        local
            rect: RECTANGLE
            circle: CIRCLE
            square: SQUARE
        do
            print ("=== 기본 상속 ===%N")

            -- 각 도형 객체 생성
            create rect.make (10.0, 5.0)
            create circle.make (7.0)
            create square.make (4.0)  -- 다단계 상속: SQUARE → RECTANGLE → SHAPE

            -- 개별 도형 정보 출력
            rect.display
            print ("%N")
            circle.display
            print ("%N")
            square.display
            print ("%N")

            -- 크기 조절 예제 (RECTANGLE의 scale 커맨드)
            print ("사각형 크기 2배 확대 전: 면적 = " + rect.area.out + "%N")
            rect.scale (2.0)
            print ("사각형 크기 2배 확대 후: 면적 = " + rect.area.out + "%N%N")
        end

    demonstrate_polymorphism
            -- 다형성 예제: 부모 타입 컬렉션에 자식 객체 저장
        local
            shapes: ARRAYED_LIST [SHAPE]
            rect: RECTANGLE
            circle: CIRCLE
            square: SQUARE
            total_area: REAL_64
        do
            print ("=== 다형성 (Polymorphism) ===%N")

            create shapes.make (3)
            create rect.make (10.0, 5.0)
            create circle.make (7.0)
            create square.make (4.0)

            -- SHAPE 리스트에 모든 도형 저장 (업캐스팅)
            shapes.extend (rect)    -- RECTANGLE은 SHAPE
            shapes.extend (circle)  -- CIRCLE은 SHAPE
            shapes.extend (square)  -- SQUARE는 RECTANGLE이고, RECTANGLE은 SHAPE

            -- 다형성: 실제 타입에 맞는 area 메서드 호출
            across shapes as cursor loop
                cursor.item.display
                total_area := total_area + cursor.item.area
            end

            print ("전체 면적 합계: " + total_area.out + "%N%N")
        end

    demonstrate_type_checking
            -- 타입 검사 및 다운캐스팅 예제
        local
            shape: SHAPE
        do
            print ("=== 타입 검사 (Type Checking) ===%N")

            -- 동적 타입 생성: 변수는 SHAPE이지만 실제 객체는 RECTANGLE
            create {RECTANGLE} shape.make (8.0, 4.0)

            print ("shape 변수의 동적 타입: RECTANGLE%N")
            print ("shape.name = " + shape.name + "%N")
            print ("shape.area = " + shape.area.out + "%N")

            -- attached ... as 패턴으로 타입 검사 및 캐스팅
            if attached {RECTANGLE} shape as rect then
                -- 이 블록 안에서 rect는 RECTANGLE 타입
                print ("RECTANGLE로 캐스팅 성공!%N")
                print ("  width = " + rect.width.out + "%N")
                print ("  height = " + rect.height.out + "%N")
            end

            if attached {CIRCLE} shape as circ then
                print ("CIRCLE로 캐스팅 성공%N")
            else
                print ("CIRCLE로 캐스팅 실패 (예상대로)%N")
            end

            print ("%N")
        end

    demonstrate_dynamic_creation
            -- 동적 타입 생성 및 conforms_to 예제
        local
            shapes: ARRAY [SHAPE]
            i: INTEGER
        do
            print ("=== 동적 타입 생성 ===%N")

            -- 다양한 타입의 SHAPE 배열 생성
            shapes := <<
                create {RECTANGLE}.make (5.0, 3.0),
                create {CIRCLE}.make (4.0),
                create {SQUARE}.make (6.0)
            >>

            from i := shapes.lower until i > shapes.upper loop
                print ("shapes[" + i.out + "]: " + shapes[i].name)
                print (" (면적: " + shapes[i].area.out + ")%N")
                i := i + 1
            end

            -- conforms_to 예제: 상속 관계 확인
            print ("%N상속 관계 확인:%N")
            print ("SQUARE conforms_to RECTANGLE? ")
            if shapes[3].conforms_to (shapes[1]) then
                print ("Yes%N")
            else
                print ("No%N")
            end
        end

end
