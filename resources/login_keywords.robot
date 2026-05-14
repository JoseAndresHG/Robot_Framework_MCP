*** Settings ***
Documentation    Archivo de recursos para keywords de login reutilizables
...               Este archivo contiene keywords comunes para operaciones de login
...               que pueden ser importadas en múltiples suites de pruebas.
Library    SeleniumLibrary

*** Variables ***
${BROWSER}      chrome
${URL}          https://www.saucedemo.com/

*** Keywords ***
Abrir Navegador Y Maximizar
    [Documentation]    Abre el navegador y maximiza la ventana
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Login Con Credenciales
    [Documentation]    Realiza login con usuario y contraseña específicos
    [Arguments]    ${username}    ${password}
    Input Text      id:user-name    ${username}
    Input Password  id:password     ${password}
    Click Button    id:login-false

Validar Login Exitoso
    [Documentation]    Verifica que el login fue exitoso validando la presencia del inventario
    ${login_exitoso}=    Run Keyword And Return Status    Element Should Be Visible    class:title
    RETURN    ${login_exitoso}

Login Completo
    [Documentation]    Realiza el proceso completo de login (abrir navegador, login, validar)
    [Arguments]    ${username}    ${password}
    Abrir Navegador Y Maximizar
    Login Con Credenciales    ${username}    ${password}
    ${resultado}=    Validar Login Exitoso
    RETURN    ${resultado}
