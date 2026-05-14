*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Keywords ***
Click Inteligente
    [Arguments]    ${primary_locator}    ${fallback_locator}=None
    ${status}    ${value} =    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${primary_locator}    timeout=5s

    IF    '${status}' == 'PASS'
        Click Element    ${primary_locator}
    ELSE IF    '${fallback_locator}' != 'None'
        Log    El selector primario falló, intentando con respaldo...    WARN
        Wait Until Element Is Visible    ${fallback_locator}    timeout=5s
        Click Element    ${fallback_locator}
    ELSE
        Fail    No se pudo encontrar el elemento con ningún selector.
    END