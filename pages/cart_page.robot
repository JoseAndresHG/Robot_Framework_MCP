*** Settings ***
Documentation    Page Object para la página del Carrito
...               Encapsula todas las interacciones y validaciones de la página del carrito.
Library           SeleniumLibrary
Library           Collections
Resource          ../resources/config.robot
Resource          base_page.robot

*** Keywords ***
# Validaciones de página
Validar Página Del Carrito
    [Documentation]    Valida que estamos en la página del carrito
    Validar Elemento Visible    ${CART_TITLE}
    ${titulo}=    Obtener Texto Del Elemento    ${CART_TITLE}
    Should Be Equal    ${titulo}    Your Cart

# Validaciones de productos en carrito
Validar Producto En Carrito
    [Documentation]    Valida que un producto específico está en el carrito
    [Arguments]    ${producto_nombre}
    ${xpath}=    Set Variable    //div[contains(@class,'inventory_item_name') and contains(text(),'${producto_nombre}')]
    Element Should Be Visible    ${xpath}

Validar Múltiples Productos En Carrito
    [Documentation]    Valida múltiples productos en el carrito
    [Arguments]    @{productos}
    FOR    ${producto}    IN    @{productos}
        Validar Producto En Carrito    ${producto}
    END

Validar Producto No Esta En Carrito
    [Documentation]    Valida que un producto no está en el carrito
    [Arguments]    ${producto_nombre}
    ${existe}=    Run Keyword And Return Status    Validar Producto En Carrito    ${producto_nombre}
    Should Not Be True    ${existe}    Producto '${producto_nombre}' encontrado en carrito cuando no debería

# Cantidad de items
Obtener Cantidad De Items
    [Documentation]    Obtiene la cantidad de items en el carrito
    ${items}=    Get WebElements    //div[contains(@class,'inventory_item_name')]
    ${cantidad}=    Get Length    ${items}
    RETURN    ${cantidad}

Validar Cantidad De Items
    [Documentation]    Valida la cantidad de items en el carrito
    [Arguments]    ${cantidad_esperada}
    ${cantidad_actual}=    Obtener Cantidad De Items
    Should Be Equal As Integers    ${cantidad_actual}    ${cantidad_esperada}
    ...    El carrito tiene ${cantidad_actual} items, se esperaban ${cantidad_esperada}

Validar Carrito Vacio
    [Documentation]    Valida que el carrito está vacío
    ${cantidad}=    Obtener Cantidad De Items
    Should Be Equal    ${cantidad}    0    Se esperaba carrito vacío pero tiene ${cantidad} items

# Precios
Obtener Precio Del Producto
    [Documentation]    Obtiene el precio de un producto en el carrito
    [Arguments]    ${producto_nombre}
    ${precio}=    Get Text    //div[contains(text(),'${producto_nombre}')]/following-sibling::div[contains(@class,'price')]
    RETURN    ${precio}

Validar Precio Del Producto
    [Documentation]    Valida el precio de un producto en el carrito
    [Arguments]    ${producto_nombre}    ${precio_esperado}
    ${precio_actual}=    Obtener Precio Del Producto    ${producto_nombre}
    Should Contain    ${precio_actual}    ${precio_esperado}

Obtener Subtotal
    [Documentation]    Obtiene el subtotal del carrito
    ${subtotal}=    Get Text    //div[contains(@class,'summary_subtotal')]
    RETURN    ${subtotal}

# Acciones con productos
Cerrar Popup Si Existe
    [Documentation]    Cierra el popup de cambio de contraseña si está presente
    ${existe}=    Run Keyword And Return Status    Esperar Elemento Visible    //button[contains(text(),'Cancel')]
    IF    ${existe}
        Click Element    //button[contains(text(),'Cancel')]
    END

Remover Producto Del Carrito
    [Documentation]    Remueve un producto del carrito
    [Arguments]    ${producto_nombre}
    Cerrar Popup Si Existe
    ${locator}=    Set Variable    //div[contains(text(),'${producto_nombre}')]/ancestor::div[contains(@class,'cart_item')]//button[contains(text(),'Remove')]
    Hacer Click    ${locator}

Remover Producto Por Indice
    [Documentation]    Remueve un producto por su índice en el carrito
    [Arguments]    ${indice}
    Esperar Elemento Visible    //button[contains(text(),'Remove')]
    ${botones}=    Get WebElements    //button[contains(text(),'Remove')]
    Click Element    ${botones}[${indice}]

Remover Todos Los Productos
    [Documentation]    Remueve todos los productos del carrito
    ${productos}=    Obtener Lista De Productos En Carrito
    FOR    ${producto}    IN    @{productos}
        Remover Producto Del Carrito    ${producto}
    END

# Navegación
Hacer Click En Checkout
    [Documentation]    Navega al checkout
    Hacer Click    ${CHECKOUT_BUTTON}

Hacer Click En Continuar Comprando
    [Documentation]    Regresa al inventario
    Hacer Click    ${CONTINUE_SHOPPING}
    Esperar Elemento Visible    ${INVENTORY_TITLE}

# Información de productos
Obtener Lista De Productos En Carrito
    [Documentation]    Obtiene una lista con los nombres de todos los productos en el carrito
    ${elementos}=    Get WebElements    class:inventory_item_name
    ${productos}=    Create List
    FOR    ${elemento}    IN    @{elementos}
        ${nombre}=    Get Text    ${elemento}
        Append To List    ${productos}    ${nombre}
    END
    RETURN    ${productos}

Obtener Detalles Del Producto
    [Documentation]    Obtiene los detalles de un producto (nombre, cantidad, precio)
    [Arguments]    ${producto_nombre}
    ${nombre}=    Get Text    //div[contains(text(),'${producto_nombre}')]
    ${cantidad}=    Get Text    //div[contains(text(),'${producto_nombre}')]/following-sibling::div[contains(@class,'qty')]
    ${precio}=    Obtener Precio Del Producto    ${producto_nombre}
    RETURN    ${nombre}    ${cantidad}    ${precio}

# Keywords de alto nivel
Flujo Checkout Completo
    [Documentation]    Navega al checkout desde el carrito
    Validar Página Del Carrito
    Hacer Click En Checkout

Validar Carrito Con Productos
    [Documentation]    Valida el carrito con productos específicos
    [Arguments]    @{productos_esperados}
    ${cantidad_esperada}=    Get Length    @{productos_esperados}
    Validar Página Del Carrito
    Validar Cantidad De Items    ${cantidad_esperada}
    Validar Múltiples Productos En Carrito    @{productos_esperados}
