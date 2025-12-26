note
    description: "[
        에펠의 변수와 기본 타입 예제

        에펠은 정적 타입 언어로, 모든 변수는 선언 시 타입을 명시해야 합니다.
        기본 타입(expanded class)은 값으로 저장되고,
        참조 타입은 힙에 할당된 객체를 가리킵니다.

        EiffelStudio 25.02 기준
    ]"
    author: "Eiffel Tutorial"
    date: "2025"
    revision: "2.0"

class
    VARIABLES

create
    make

feature -- Attributes (클래스 속성 = 멤버 변수)

    -- 정수 타입들
    my_integer: INTEGER        -- 정수 (32비트, -2^31 ~ 2^31-1)
    my_integer_64: INTEGER_64  -- 64비트 정수

    -- 부호 없는 정수
    my_natural: NATURAL        -- 부호 없는 32비트 (0 ~ 2^32-1)

    -- 실수 타입들
    my_real: REAL_64           -- 실수 (64비트, 배정밀도)

    -- 기타 기본 타입
    my_boolean: BOOLEAN        -- 참/거짓 (True, False)
    my_character: CHARACTER    -- 문자 (유니코드)
    my_string: STRING          -- 문자열 (참조 타입)

feature -- Initialization

    make
            -- 변수와 타입 사용법 데모
        local
            -- 지역 변수 선언 (local 블록에서)
            temp_int: INTEGER
            name: STRING
            price: REAL_64
            is_valid: BOOLEAN
        do
            print ("=== 에펠 변수와 타입 (2025) ===%N%N")

            -- 할당 연산자는 := 입니다 (= 가 아님!)
            temp_int := 42
            name := "에펠"
            price := 99.99
            is_valid := True

            -- 클래스 속성에도 값 할당
            my_integer := 100
            my_natural := 255
            my_real := 3.14159
            my_boolean := False
            my_character := 'A'
            my_string := "Hello, Eiffel!"

            -- 출력
            print ("정수: " + my_integer.out + "%N")
            print ("실수: " + my_real.out + "%N")
            print ("불리언: " + my_boolean.out + "%N")
            print ("문자: " + my_character.out + "%N")
            print ("문자열: " + my_string + "%N%N")

            -- 타입 변환 예제
            demonstrate_type_conversion

            -- 문자열 조작
            demonstrate_strings

            -- Void 안전성 예제 (2025 필수 개념)
            demonstrate_void_safety

            -- 튜플과 에이전트 맛보기
            demonstrate_tuples
        end

feature -- Type Conversion

    demonstrate_type_conversion
            -- 타입 변환 예제
        local
            int_val: INTEGER
            int64_val: INTEGER_64
            real_val: REAL_64
            str_val: STRING
            nat_val: NATURAL
        do
            print ("=== 타입 변환 ===%N")

            -- INTEGER -> REAL
            int_val := 42
            real_val := int_val.to_double
            print ("INTEGER -> REAL: " + real_val.out + "%N")

            -- INTEGER -> INTEGER_64
            int64_val := int_val.to_integer_64
            print ("INTEGER -> INTEGER_64: " + int64_val.out + "%N")

            -- INTEGER -> STRING
            str_val := int_val.out
            print ("INTEGER -> STRING: %"" + str_val + "%"%N")

            -- REAL -> INTEGER (반올림, 버림)
            real_val := 3.7
            print ("REAL 3.7 -> INTEGER (truncated): " + real_val.truncated_to_integer.out + "%N")
            print ("REAL 3.7 -> INTEGER (rounded): " + real_val.rounded.out + "%N")

            -- STRING -> INTEGER
            str_val := "123"
            if str_val.is_integer then
                int_val := str_val.to_integer
                print ("STRING %"123%" -> INTEGER: " + int_val.out + "%N")
            end

            -- INTEGER -> NATURAL (양수일 때만)
            int_val := 50
            if int_val >= 0 then
                nat_val := int_val.to_natural_32
                print ("INTEGER 50 -> NATURAL: " + nat_val.out + "%N")
            end

            print ("%N")
        end

feature -- String Operations

    demonstrate_strings
            -- 문자열 조작 예제
        local
            s1, s2, result: STRING
            immutable_s: IMMUTABLE_STRING_32
        do
            print ("=== 문자열 조작 ===%N")

            s1 := "Hello"
            s2 := "World"

            -- 문자열 연결
            result := s1 + ", " + s2 + "!"
            print ("연결: " + result + "%N")

            -- 문자열 길이
            print ("길이: " + result.count.out + "%N")

            -- 대소문자 변환
            print ("대문자: " + result.as_upper + "%N")
            print ("소문자: " + result.as_lower + "%N")

            -- 특정 문자 접근 (1부터 시작!)
            print ("첫 번째 문자: " + result.item (1).out + "%N")
            print ("마지막 문자: " + result.item (result.count).out + "%N")

            -- 부분 문자열
            print ("부분 문자열 (1-5): " + result.substring (1, 5) + "%N")

            -- 검색
            if result.has_substring ("World") then
                print ("%"World%" 포함: 위치 " + result.substring_index ("World", 1).out + "%N")
            end

            -- 불변 문자열 (성능 최적화)
            immutable_s := "이 문자열은 변경 불가"
            print ("불변 문자열: " + immutable_s + "%N")

            -- 문자열 복제 (깊은 복사)
            result := s1.twin
            result.append (" (복제됨)")
            print ("원본: " + s1 + ", 복제본: " + result + "%N")

            print ("%N")
        end

feature -- Void Safety (Attached Types)

    demonstrate_void_safety
            -- Void 안전성 예제 - 에펠의 핵심 기능
        local
            attached_string: STRING           -- attached (기본값) - Void 불가
            detachable_string: detachable STRING  -- Void 가능
        do
            print ("=== Void 안전성 (Attached Types) ===%N")

            -- attached 변수는 반드시 초기화 필요
            attached_string := "반드시 값이 있음"
            print ("Attached: " + attached_string + "%N")

            -- detachable 변수는 Void일 수 있음
            detachable_string := Void  -- 명시적으로 Void 할당 가능

            -- Void 체크 방법 1: 직접 비교
            if detachable_string /= Void then
                print ("detachable_string is not Void%N")
            else
                print ("detachable_string is Void%N")
            end

            -- Void 체크 방법 2: attached ... as 구문 (권장)
            detachable_string := "이제 값이 있음"
            if attached detachable_string as s then
                -- 이 블록 안에서 s는 attached STRING
                print ("Attached as: " + s + " (길이: " + s.count.out + ")%N")
            end

            print ("%N")
        end

feature -- Tuples

    demonstrate_tuples
            -- 튜플 예제 - 여러 값을 하나로 묶기
        local
            person: TUPLE [name: STRING; age: INTEGER; is_active: BOOLEAN]
            point: TUPLE [x: REAL_64; y: REAL_64]
            result: TUPLE [success: BOOLEAN; message: STRING; code: INTEGER]
        do
            print ("=== 튜플 (TUPLE) ===%N")

            -- 튜플 생성 및 접근
            person := ["홍길동", 30, True]
            print ("이름: " + person.name + ", 나이: " + person.age.out + "%N")

            -- 좌표 튜플
            point := [10.5, 20.3]
            print ("좌표: (" + point.x.out + ", " + point.y.out + ")%N")

            -- 함수 반환값으로 유용
            result := [True, "성공", 200]
            if result.success then
                print ("결과: " + result.message + " (코드: " + result.code.out + ")%N")
            end

            print ("%N")
        end

feature -- Constants (상수 정의)

    Pi: REAL_64 = 3.14159265358979
        -- 원주율 상수

    Max_size: INTEGER = 1000
        -- 최대 크기

    App_name: STRING = "Eiffel Tutorial 2025"
        -- 애플리케이션 이름

    Version: NATURAL = 2
        -- 버전 번호

end
