*** Settings ***
Documentation    Suite de pruebas de datos para validación de login con múltiples usuarios
...               Esta suite lee un archivo CSV con datos de usuarios y valida el login para cada uno.
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    String
Resource    ../resources/login_keywords.robot

*** Variables ***
${CSV_FILE}     /Users/joseandres/PycharmProjects/Robot_IA/data/users_test.csv

*** Test Cases ***
ValidacionLoginUsuarios
    [Documentation]    Prueba de login para múltiples usuarios desde archivo CSV
    ${users}=    Cargar Usuarios Desde CSV    ${CSV_FILE}
    
    FOR    ${user}    IN    @{users}
        ${username}=    Get From Dictionary    ${user}    user
        ${password}=    Get From Dictionary    ${user}    pass
        
        Log    Validando login para usuario: ${username}
        ${login_result}=    Run Keyword And Return Status    Login Con Usuario    ${username}    ${password}
        Run Keyword If    ${login_result}    Log    Login exitoso para ${username}
        ...    ELSE    Log    Login fallido para ${username}
    END
    
    [Teardown]     Cerrar Navegador

*** Keywords ***
Cargar Usuarios Desde CSV
    [Arguments]    ${csv_file}
    ${content}=    Get File    ${csv_file}
    ${lines}=    Split To Lines    ${content}
    ${users}=    Create List
    
    FOR    ${line}    IN    @{lines}[1:]  # Saltar encabezado
        ${parts}=    Split String    ${line}    ,
        ${user_dict}=    Create Dictionary
        ...    user=${parts}[0]
        ...    pass=${parts}[1]
        Append To List    ${users}    ${user_dict}
    END
    
    [Return]    ${users}

Login Con Usuario
    [Arguments]    ${username}    ${password}
    Login Completo    ${username}    ${password}
    [Return]    ${True}
