note
    description: "클래스 사용 예제 - 메인 프로그램"
    author: "Eiffel Learner"

class
    MAIN

create
    make

feature -- Initialization

    make
            -- 메인 진입점
        local
            alice: PERSON
            bob: PERSON
        do
            print ("=== 에펠 클래스 예제 ===%N%N")

            -- 객체 생성 (create 키워드 사용)
            create alice.make ("Alice")
            create bob.make_with_age ("Bob", 25)

            -- 속성 접근 (Query)
            print ("=== 객체 정보 ===%N")
            print ("Alice: " + alice.info + "%N")
            print ("Bob: " + bob.info + "%N%N")

            -- 메서드 호출 (Command)
            print ("=== 나이 설정 ===%N")
            alice.set_age (17)
            print ("Alice 나이 설정 후: " + alice.info + "%N")

            -- 성인 여부 확인
            print ("%N=== 성인 여부 ===%N")
            if alice.is_adult then
                print ("Alice는 성인입니다.%N")
            else
                print ("Alice는 미성년자입니다.%N")
            end

            if bob.is_adult then
                print ("Bob은 성인입니다.%N")
            else
                print ("Bob은 미성년자입니다.%N")
            end

            -- 생일 축하
            print ("%N=== 생일 축하 ===%N")
            alice.celebrate_birthday
            alice.celebrate_birthday

            -- 최종 상태
            print ("%N=== 최종 상태 ===%N")
            print ("Alice: " + alice.info + "%N")
            print ("Bob: " + bob.info + "%N")

            -- 인사말
            print ("%N=== 인사말 ===%N")
            print (alice.greeting + "%N")
            print (bob.greeting + "%N")
        end

end
