*** Settings ***
Documentation    Tests para la funcionalidad de login
...               Pruebas de login exitoso, fallido y casos edge.
Library           SeleniumLibrary
Resource          ../pages/login_page.robot
Resource          ../resources/config.robot

*** Test Cases ***
Login Exitoso Con Credenciales Válidas
    [Documentation]    Valida que un usuario con credenciales válidas puede iniciar sesión
    [Tags]    smoke    login    positive
    Login Exitoso    ${VALID_USERNAME}    ${VALID_PASSWORD}
    [Teardown]    Cerrar Navegador

Login Fallido Con Usuario Invalido
    [Documentation]    Valida que un usuario inválido no puede iniciar sesión
    [Tags]    regression    login    negative
    Login Fallido Con Validacion    usuario_invalido    ${VALID_PASSWORD}
    [Teardown]    Cerrar Navegador

Login Fallido Con Password Invalido
    [Documentation]    Valida que una contraseña inválida no permite iniciar sesión
    [Tags]    regression    login    negative
    Login Fallido Con Validacion    ${VALID_USERNAME}    password_invalida
    [Teardown]    Cerrar Navegador

Login Con Campos Vacios
    [Documentation]    Valida que no se puede iniciar sesión con campos vacíos
    [Tags]    regression    login    negative
    Login Con Campos Vacios
    [Teardown]    Cerrar Navegador

Login Con Solo Usuario
    [Documentation]    Valida que no se puede iniciar sesión solo con usuario
    [Tags]    regression    login    negative
    Login Con Solo Usuario    ${VALID_USERNAME}
    [Teardown]    Cerrar Navegador

Login Con Solo Password
    [Documentation]    Valida que no se puede iniciar sesión solo con password
    [Tags]    regression    login    negative
    Login Con Solo Password    ${VALID_PASSWORD}
    [Teardown]    Cerrar Navegador

Login Con Usuario Bloqueado
    [Documentation]    Valida que un usuario bloqueado no puede iniciar sesión
    [Tags]    regression    login    negative
    Login Fallido Con Validacion    ${LOCKED_USERNAME}    ${VALID_PASSWORD}
    [Teardown]    Cerrar Navegador

Login Multiple Con Diferentes Usuarios
    [Documentation]    Valida login fallido con múltiples usuarios inválidos/bloqueados
    [Tags]    regression    login    data-driven
    @{usuarios}=    Create List    ${LOCKED_USERNAME}
    FOR    ${usuario}    IN    @{usuarios}
        Login Fallido Con Validacion    ${usuario}    ${VALID_PASSWORD}
        Close Browser
    END
