*** Settings ***
Documentation    Suite de pruebas inmortales para validar login en SauceDemo
...               Esta suite contiene pruebas de automatización web que validan
...               el proceso de login usando selectores inmunes a cambios de IDs.
Library    SeleniumLibrary

*** Variables ***
${BROWSER}      chrome
${URL}          https://www.saucedemo.com/
${USER}         standard_user
${PASS}         secret_sauce

*** Test Cases ***
LoginInmortal
    [Documentation]    Prueba de login inmortal usando selectores avanzados
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    
    # Ingresar usuario usando XPath que busca placeholder 'Username'
    Input Text    xpath=//input[@placeholder='Username']    ${USER}
    
    # Ingresar password usando selector por tipo 'password'
    Input Password    css=input[type='password']    ${PASS}
    
    # Hacer clic en login usando XPath que busca valor 'Login'
    Click Button    xpath=//input[@value='Login' or @type='submit' and @value='Login']
    
    # Validar que entramos al inventario buscando texto 'Products' sin usar clases CSS
    Wait Until Page Contains    Products
    Element Should Be Visible    xpath=//*[contains(text(), 'Products')]
    
    [Teardown]    Close Browser