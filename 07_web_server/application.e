note
    description: "[
        EWF (Eiffel Web Framework) 웹 서버 예제

        이 예제는 EWF를 사용하여 HTTP 웹 서버를 구현합니다.
        실행 후 http://localhost:9090 에서 접속할 수 있습니다.

        EWF 구조:
        - WSF_DEFAULT_SERVICE: 기본 서비스 클래스 상속
        - WSF_REQUEST: HTTP 요청 정보 (메서드, 경로, 파라미터)
        - WSF_RESPONSE: HTTP 응답 작성 (상태 코드, 헤더, 본문)
        - Nino: 독립 실행형 내장 서버

        지원 라우트:
        - / : 홈페이지
        - /about : 소개 페이지
        - /greet/{이름} : 동적 인사
        - /api/hello : JSON API
        - /api/time : 현재 시간 API (신규)

        EiffelStudio 25.02 기준
    ]"
    author: "Eiffel Tutorial"
    date: "2025"
    revision: "2.0"

class
    APPLICATION

inherit
    WSF_DEFAULT_SERVICE
        redefine
            initialize
        end

create
    make_and_launch

feature {NONE} -- Initialization

    make_and_launch
            -- 서버 시작
        do
            print ("EWF 웹 서버를 시작합니다...%N")
            print ("http://localhost:9090 에서 접속하세요.%N")
            print ("종료하려면 Ctrl+C를 누르세요.%N%N")
            make_and_launch_nino
        end

    initialize
            -- 서비스 초기화
        do
            Precursor
            -- 포트 설정 (기본값: 9090)
            set_service_option ("port", 9090)
        end

feature -- Execution

    execute (req: WSF_REQUEST; res: WSF_RESPONSE)
            -- HTTP 요청 처리
        local
            path: STRING
            html: STRING
        do
            path := req.path_info

            -- 경로에 따른 라우팅
            if path.is_equal ("/") then
                handle_home (req, res)
            elseif path.is_equal ("/about") then
                handle_about (req, res)
            elseif path.is_equal ("/api/hello") then
                handle_api_hello (req, res)
            elseif path.is_equal ("/api/time") then
                handle_api_time (req, res)
            elseif path.starts_with ("/greet/") then
                handle_greet (req, res)
            else
                handle_not_found (req, res)
            end
        end

feature -- Request Handlers

    handle_home (req: WSF_REQUEST; res: WSF_RESPONSE)
            -- 홈페이지 처리
        local
            html: STRING
        do
            html := "[
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>EWF 웹 서버</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 50px auto; padding: 20px; }
        h1 { color: #333; }
        a { color: #007bff; text-decoration: none; }
        a:hover { text-decoration: underline; }
        .nav { margin: 20px 0; }
        .nav a { margin-right: 15px; }
        code { background: #f4f4f4; padding: 2px 6px; border-radius: 3px; }
    </style>
</head>
<body>
    <h1>안녕하세요! EWF 웹 서버입니다.</h1>
    <p>이 웹 서버는 에펠(Eiffel) 언어로 작성되었습니다.</p>

    <div class="nav">
        <a href="/">홈</a>
        <a href="/about">소개</a>
        <a href="/greet/World">인사하기</a>
        <a href="/api/hello">API 예제</a>
    </div>

    <h2>페이지 목록</h2>
    <ul>
        <li><code>/</code> - 홈페이지 (현재 페이지)</li>
        <li><code>/about</code> - 소개 페이지</li>
        <li><code>/greet/{이름}</code> - 동적 인사 페이지</li>
        <li><code>/api/hello</code> - JSON API 예제</li>
    </ul>
</body>
</html>
            ]"

            res.set_status_code (200)
            res.header.put_content_type_text_html
            res.header.put_content_length (html.count)
            res.put_string (html)
        end

    handle_about (req: WSF_REQUEST; res: WSF_RESPONSE)
            -- 소개 페이지
        local
            html: STRING
        do
            html := "[
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>소개 - EWF</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 50px auto; padding: 20px; }
        h1 { color: #333; }
        a { color: #007bff; }
    </style>
</head>
<body>
    <h1>EWF (Eiffel Web Framework) 소개</h1>

    <h2>에펠 언어란?</h2>
    <p>에펠은 Bertrand Meyer가 1986년에 설계한 객체지향 프로그래밍 언어입니다.</p>

    <h2>주요 특징</h2>
    <ul>
        <li><strong>Design by Contract</strong>: 사전조건, 사후조건, 불변식</li>
        <li><strong>다중 상속</strong>: 여러 클래스로부터 상속 가능</li>
        <li><strong>강력한 타입 시스템</strong>: 컴파일 타임 타입 체크</li>
        <li><strong>자동 메모리 관리</strong>: 가비지 컬렉션</li>
    </ul>

    <h2>EWF란?</h2>
    <p>EWF는 에펠로 웹 애플리케이션을 개발하기 위한 프레임워크입니다.</p>
    <ul>
        <li>독립 실행형 서버 (Nino)</li>
        <li>CGI/FastCGI 지원</li>
        <li>라우터 기반 URL 처리</li>
    </ul>

    <p><a href="/">← 홈으로 돌아가기</a></p>
</body>
</html>
            ]"

            res.set_status_code (200)
            res.header.put_content_type_text_html
            res.header.put_content_length (html.count)
            res.put_string (html)
        end

    handle_greet (req: WSF_REQUEST; res: WSF_RESPONSE)
            -- 동적 인사 페이지: /greet/{name}
        local
            name: STRING
            html: STRING
        do
            -- URL에서 이름 추출: /greet/이름
            name := req.path_info.substring (8, req.path_info.count)
            if name.is_empty then
                name := "Guest"
            end

            html := "<!DOCTYPE html><html><head><meta charset=%"UTF-8%"><title>인사</title>"
            html.append ("<style>body{font-family:Arial;max-width:800px;margin:50px auto;text-align:center;}</style></head>")
            html.append ("<body><h1>안녕하세요, " + name + "님!</h1>")
            html.append ("<p>에펠 웹 서버에서 인사드립니다.</p>")
            html.append ("<p><a href=%"/%" style=%"color:#007bff%">← 홈으로</a></p></body></html>")

            res.set_status_code (200)
            res.header.put_content_type_text_html
            res.header.put_content_length (html.count)
            res.put_string (html)
        end

    handle_api_hello (req: WSF_REQUEST; res: WSF_RESPONSE)
            -- JSON API 예제
        local
            json: STRING
        do
            json := "{%"message%": %"Hello from Eiffel!%", %"status%": %"success%", %"framework%": %"EWF%", %"version%": %"2025%"}"

            res.set_status_code (200)
            res.header.put_content_type ("application/json")
            res.header.put_content_length (json.count)
            res.put_string (json)
        end

    handle_api_time (req: WSF_REQUEST; res: WSF_RESPONSE)
            -- 현재 시간 JSON API (EiffelStudio 25.02)
        local
            json: STRING
            now: DATE_TIME
        do
            create now.make_now

            json := "{%"year%": " + now.year.out
            json.append (", %"month%": " + now.month.out)
            json.append (", %"day%": " + now.day.out)
            json.append (", %"hour%": " + now.hour.out)
            json.append (", %"minute%": " + now.minute.out)
            json.append (", %"second%": " + now.second.out)
            json.append (", %"formatted%": %"" + now.out + "%"}")

            res.set_status_code (200)
            res.header.put_content_type ("application/json")
            res.header.put_content_length (json.count)
            res.put_string (json)
        end

    handle_not_found (req: WSF_REQUEST; res: WSF_RESPONSE)
            -- 404 페이지
        local
            html: STRING
        do
            html := "<!DOCTYPE html><html><head><meta charset=%"UTF-8%"><title>404</title></head>"
            html.append ("<body style=%"font-family:Arial;text-align:center;margin-top:100px%">")
            html.append ("<h1>404 - 페이지를 찾을 수 없습니다</h1>")
            html.append ("<p>요청한 경로: " + req.path_info + "</p>")
            html.append ("<p><a href=%"/%" style=%"color:#007bff%">홈으로 돌아가기</a></p></body></html>")

            res.set_status_code (404)
            res.header.put_content_type_text_html
            res.header.put_content_length (html.count)
            res.put_string (html)
        end

end
