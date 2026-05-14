*** Settings ***
Documentation    Suite de pruebas API para JSONPlaceholder
...               Esta suite valida el ciclo de vida CRUD de un post
Library    RequestsLibrary
Library    Collections
Library    String

*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com
${POST_TITLE}    Test Post
${POST_BODY}    This is a test post body
${UPDATED_BODY}    This is an updated test post body
${USER_ID}    1

*** Test Cases ***
TestJSONPlaceholderCRUD
    [Documentation]    Prueba completa del ciclo de vida CRUD de un post
    [Tags]    api
    
    # Paso 1: Crear sesión con headers necesarios
    ${headers}=    Create Dictionary    Accept=application/json    Content-Type=application/json
    Create Session    jsonplaceholder_session    ${BASE_URL}    headers=${headers}
    
    # Paso 2: POST /posts - Crear nuevo post
    ${post_payload}=    Create Dictionary
    ...    title=${POST_TITLE}
    ...    body=${POST_BODY}
    ...    userId=${USER_ID}
    
    Log    Payload enviado: ${post_payload}
    
    ${create_response}=    POST On Session    jsonplaceholder_session    /posts    json=${post_payload}
    Log    Response: ${create_response.content}
    
    # Validación del POST
    Should Be Equal As Integers    ${create_response.status_code}    201
    ${create_json}=    ${create_response.json()}
    ${created_post_id}=    Get From Dictionary    ${create_json}    id
    Log    Post creado con ID: ${created_post_id}
    
    # Paso 3: GET /posts/{id} - Recuperar post
    ${get_response}=    GET On Session    jsonplaceholder_session    /posts/${created_post_id}
    Log    GET Response: ${get_response.content}
    
    # Validación del GET
    Should Be Equal As Integers    ${get_response.status_code}    200
    ${get_json}=    Evaluate    ${get_response.json()}
    ${retrieved_title}=    Get From Dictionary    ${get_json}    title
    Should Be Equal    ${retrieved_title}    ${POST_TITLE}
    Log    Título validado: ${retrieved_title}
    
    # Paso 4: PUT /posts/{id} - Actualizar post
    Set To Dictionary    ${post_payload}    body=${UPDATED_BODY}
    ${update_response}=    PUT On Session    jsonplaceholder_session    /posts/${created_post_id}    json=${post_payload}
    Log    PUT Response: ${update_response.content}
    
    # Validación del PUT
    Should Be Equal As Integers    ${update_response.status_code}    200
    ${update_json}=    Evaluate    ${update_response.json()}
    ${updated_body}=    Get From Dictionary    ${update_json}    body
    Should Be Equal    ${updated_body}    ${UPDATED_BODY}
    Log    Body actualizado: ${updated_body}
    
    # Paso 5: DELETE /posts/{id} - Eliminar post
    ${delete_response}=    DELETE On Session    jsonplaceholder_session    /posts/${created_post_id}
    Log    DELETE Response: ${delete_response.content}
    
    # Validación del DELETE
    Should Be Equal As Integers    ${delete_response.status_code}    200
    Log    Post eliminado exitosamente
    
    [Teardown]    Delete All Sessions