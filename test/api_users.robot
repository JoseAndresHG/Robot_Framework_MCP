*** Settings ***
Documentation    Suite de pruebas API profesional para reqres.in
...               Esta suite valida operaciones GET y POST en la API de usuarios
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://reqres.in

*** Test Cases ***
TestAPIUsers
    [Documentation]    Prueba profesional de API GET y POST
    [Tags]    api
    
    # Paso 1: Crear sesión hacia https://reqres.in
    ${headers}=    Create Dictionary    User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36
    Create Session    api_session    ${BASE_URL}    verify=False    headers=${headers}
    
    # Paso 2: GET a /api/users/2
    ${response}=    GET On Session    api_session    /api/users/2
    Log    Response: ${response.content}
    
    # Validación del GET
    Should Be Equal As Integers    ${response.status_code}    200
    ${json_data}=    Evaluate    ${response.json()}
    ${first_name}=    Get From Dictionary    ${json_data['data']}    first_name
    Should Be Equal    ${first_name}    Janet
    
    # Paso 3: POST a /api/users
    ${payload}=    Create Dictionary    name=Jose Andres    job=QA Expert
    ${post_response}=    POST On Session    api_session    /api/users    json=${payload}
    Log    POST Response: ${post_response.content}
    
    # Validación del POST
    Should Be Equal As Integers    ${post_response.status_code}    201
    ${post_json}=    Evaluate    ${post_response.json()}
    ${user_id}=    Get From Dictionary    ${post_json}    id
    Log    User ID creado: ${user_id}
    
    [Teardown]    Delete All Sessions