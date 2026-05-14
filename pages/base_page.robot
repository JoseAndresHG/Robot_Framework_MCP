*** Settings ***
Documentation    Página base con métodos comunes para todas las páginas
...               Proporciona funcionalidad básica que puede ser reutilizada en todos los Page Objects.
Library           SeleniumLibrary
Resource          ../resources/config.robot

*** Keywords ***
Abrir Navegador En URL
    [Documentation]    Abre el navegador en una URL específica
    [Arguments]    ${url}
    Open Browser    ${url}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}

Abrir Navegador
    [Documentation]    Abre el navegador en la URL base
    Abrir Navegador En URL    ${BASE_URL}

Cerrar Navegador
    [Documentation]    Cierra el navegador
    Close Browser

# Interacción con elementos
Esperar Elemento Visible
    [Documentation]    Espera a que un elemento sea visible
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}

Esperar Elemento Invisible
    [Documentation]    Espera a que un elemento sea invisible
    [Arguments]    ${locator}
    Wait Until Element Is Not Visible    ${locator}    ${TIMEOUT}

Hacer Click
    [Documentation]    Hace click en un elemento
    [Arguments]    ${locator}
    Click Element    ${locator}

Hacer Click Con JavaScript
    [Documentation]    Hace click usando JavaScript (para elementos difíciles de clicar)
    [Arguments]    ${locator}
    Execute Javascript    arguments[0].click();    ${locator}

Ingresar Texto
    [Documentation]    Ingresa texto en un campo
    [Arguments]    ${locator}    ${texto}
    Input Text    ${locator}    ${texto}

Limpiar Campo
    [Documentation]    Limpia un campo de texto
    [Arguments]    ${locator}
    Clear Element Text    ${locator}

# Validaciones
Validar Elemento Visible
    [Documentation]    Valida que un elemento sea visible
    [Arguments]    ${locator}
    Element Should Be Visible    ${locator}

Validar Elemento No Visible
    [Documentation]    Valida que un elemento no sea visible
    [Arguments]    ${locator}
    Element Should Not Be Visible    ${locator}

Validar Texto Del Elemento
    [Documentation]    Valida el texto de un elemento
    [Arguments]    ${locator}    ${texto_esperado}
    Element Text Should Be    ${locator}    ${texto_esperado}

Validar Elemento Contiene Texto
    [Documentation]    Valida que un elemento contiene un texto específico
    [Arguments]    ${locator}    ${texto}
    Element Should Contain    ${locator}    ${texto}

Validar Atributo
    [Documentation]    Valida el atributo de un elemento
    [Arguments]    ${locator}    ${atributo}    ${valor_esperado}
    ${valor_actual}=    Get Element Attribute    ${locator}    ${atributo}
    Should Be Equal    ${valor_actual}    ${valor_esperado}

# Obtención de información
Obtener Texto Del Elemento
    [Documentation]    Obtiene el texto de un elemento
    [Arguments]    ${locator}
    ${texto}=    Get Text    ${locator}
    RETURN    ${texto}

Obtener Atributo Del Elemento
    [Documentation]    Obtiene un atributo de un elemento
    [Arguments]    ${locator}    ${atributo}
    ${valor}=    Get Element Attribute    ${locator}    ${atributo}
    RETURN    ${valor}

Obtener Cantidad De Elementos
    [Documentation]    Obtiene la cantidad de elementos que coinciden con un locator
    [Arguments]    ${locator}
    ${elementos}=    Get WebElements    ${locator}
    ${cantidad}=    Get Length    ${elementos}
    RETURN    ${cantidad}

Elemento Existe
    [Documentation]    Verifica si un elemento existe en la página
    [Arguments]    ${locator}
    ${existe}=    Run Keyword And Return Status    Esperar Elemento Visible    ${locator}
    RETURN    ${existe}

# Navegación avanzada
Navegar A URL
    [Documentation]    Navega a una URL específica
    [Arguments]    ${url}
    Go To    ${url}

Recargar Página
    [Documentation]    Recarga la página actual
    Reload Page

Volver Atrás
    [Documentation]    Vuelve a la página anterior
    Go Back

Ir Adelante
    [Documentation]    Avanza a la siguiente página
    Execute Javascript    window.history.forward();

# Esperas y delays
Esperar
    [Documentation]    Espera un tiempo específico (usar solo cuando sea necesario)
    [Arguments]    ${segundos}
    Sleep    ${segundos}s

Esperar Hasta Condicion
    [Documentation]    Espera hasta que una condición sea verdadera
    [Arguments]    ${keyword}    @{args}
    Wait Until Keyword Succeeds    ${TIMEOUT}    1s    ${keyword}    @{args}

# Scroll y viewport
Scroll Al Elemento
    [Documentation]    Hace scroll hasta un elemento
    [Arguments]    ${locator}
    Scroll Element Into View    ${locator}

Scroll A Posicion
    [Documentation]    Hace scroll a una posición específica
    [Arguments]    ${x}    ${y}
    Execute Javascript    window.scrollTo(${x}, ${y});

# Capturas de pantalla
Capturar Pantalla
    [Documentation]    Captura una screenshot de la página
    [Arguments]    ${nombre_archivo}
    Capture Page Screenshot    ${nombre_archivo}

Capturar Elemento
    [Documentation]    Captura una screenshot de un elemento específico
    [Arguments]    ${locator}    ${nombre_archivo}
    Capture Element Screenshot    ${locator}    ${nombre_archivo}