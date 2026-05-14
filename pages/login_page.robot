*** Settings ***
Documentation    Page Object para la página de Login
...               Encapsula todas las interacciones y validaciones de la página de login.
Library           SeleniumLibrary
Resource          ../resources/config.robot
Resource          base_page.robot

*** Keywords ***
# Navegación
Navegar A Login
    [Documentation]    Navega a la página de login
    Abrir Navegador En URL    ${LOGIN_URL}

# Interacciones con campos
Ingresar Usuario
    [Documentation]    Ingresa el nombre de usuario en el campo correspondiente
    [Arguments]    ${username}
    Ingresar Texto    ${LOGIN_USERNAME_FIELD}    ${username}

Ingresar Password
    [Documentation]    Ingresa la contraseña en el campo correspondiente
    [Arguments]    ${password}
    Ingresar Texto    ${LOGIN_PASSWORD_FIELD}    ${password}

Hacer Click En Login
    [Documentation]    Hace click en el botón de login
    Hacer Click    ${LOGIN_BUTTON}

# Acciones combinadas
Login Con Credenciales
    [Documentation]    Realiza el proceso de login con credenciales
    [Arguments]    ${username}    ${password}
    Ingresar Usuario    ${username}
    Ingresar Password    ${password}
    Hacer Click En Login

Login Completo
    [Documentation]    Navega a login y realiza el proceso completo
    [Arguments]    ${username}    ${password}
    Navegar A Login
    Login Con Credenciales    ${username}    ${password}

# Validaciones
Validar Login Exitoso
    [Documentation]    Valida que el login fue exitoso verificando la página de inventario
    Validar Elemento Visible    ${INVENTORY_TITLE}
    ${titulo}=    Obtener Texto Del Elemento    ${INVENTORY_TITLE}
    Should Be Equal    ${titulo}    Products

Validar Login Fallido
    [Documentation]    Valida que el login falló mostrando mensaje de error
    Validar Elemento Visible    ${LOGIN_ERROR_MESSAGE}

Validar Mensaje De Error
    [Documentation]    Valida el mensaje de error específico
    [Arguments]    ${mensaje_esperado}
    Validar Elemento Contiene Texto    ${LOGIN_ERROR_MESSAGE}    ${mensaje_esperado}

Validar Campo Usuario Vacio
    [Documentation]    Valida que el campo de usuario está vacío
    ${valor}=    Obtener Atributo Del Elemento    ${LOGIN_USERNAME_FIELD}    value
    Should Be Empty    ${valor}

Validar Campo Password Vacio
    [Documentation]    Valida que el campo de password está vacío
    ${valor}=    Obtener Atributo Del Elemento    ${LOGIN_PASSWORD_FIELD}    value
    Should Be Empty    ${valor}

# Keywords de alto nivel
Login Exitoso
    [Documentation]    Realiza login exitoso y valida el resultado
    [Arguments]    ${username}    ${password}
    Login Completo    ${username}    ${password}
    Validar Login Exitoso

Login Fallido Con Validacion
    [Documentation]    Realiza login fallido y valida el error
    [Arguments]    ${username}    ${password}
    Navegar A Login
    Login Con Credenciales    ${username}    ${password}
    Validar Login Fallido

# Casos específicos de prueba
Login Con Credenciales Validas
    [Documentation]    Login con credenciales válidas predefinidas
    Login Exitoso    ${VALID_USERNAME}    ${VALID_PASSWORD}

Login Con Usuario Bloqueado
    [Documentation]    Login con usuario bloqueado
    Login Fallido Con Validacion    ${LOCKED_USERNAME}    ${VALID_PASSWORD}

Login Con Campos Vacios
    [Documentation]    Intenta login sin ingresar credenciales
    Navegar A Login
    Hacer Click En Login
    Validar Login Fallido

Login Con Solo Usuario
    [Documentation]    Login solo con usuario, sin password
    [Arguments]    ${username}
    Navegar A Login
    Ingresar Usuario    ${username}
    Hacer Click En Login
    Validar Login Fallido

Login Con Solo Password
    [Documentation]    Login solo con password, sin usuario
    [Arguments]    ${password}
    Navegar A Login
    Ingresar Password    ${password}
    Hacer Click En Login
    Validar Login Fallido