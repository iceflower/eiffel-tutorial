note
    description: "[
        도형 기본 클래스 - 상속의 기반이 되는 추상(deferred) 클래스

        에펠에서 deferred class는 다른 언어의 추상 클래스에 해당합니다.
        - 직접 인스턴스 생성 불가
        - deferred feature는 자식 클래스에서 반드시 구현
        - 일반 feature는 기본 구현 제공 가능

        EiffelStudio 25.02 기준
    ]"
    author: "Eiffel Tutorial"
    date: "2025"
    revision: "2.0"

deferred class
    SHAPE

feature -- Access

    name: STRING
            -- 도형 이름
        deferred
        end

feature -- Measurement

    area: REAL_64
            -- 면적 계산 (자식 클래스에서 구현)
        deferred
        ensure
            non_negative: Result >= 0
        end

    perimeter: REAL_64
            -- 둘레 계산 (자식 클래스에서 구현)
        deferred
        ensure
            non_negative: Result >= 0
        end

feature -- Output

    display
            -- 도형 정보 출력
        do
            print ("도형: " + name + "%N")
            print ("  면적: " + area.out + "%N")
            print ("  둘레: " + perimeter.out + "%N")
        end

end
