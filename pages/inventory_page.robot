*** Settings ***
Documentation    Page Object para la página de Inventario
...               Encapsula todas las interacciones y validaciones de la página de productos.
Library           SeleniumLibrary
Library           Collections
Resource          ../resources/config.robot
Resource          base_page.robot

*** Keywords ***
# Validaciones de página
Validar Página De Inventario
    [Documentation]    Valida que estamos en la página de inventario
    Validar Elemento Visible    ${INVENTORY_TITLE}
    ${titulo}=    Obtener Texto Del Elemento    ${INVENTORY_TITLE}
    Should Be Equal    ${titulo}    Products

Validar Elementos De Inventario Visibles
    [Documentation]    Valida que los elementos del inventario son visibles
    Validar Elemento Visible    ${INVENTORY_ITEM}

# Interacciones con productos
Agregar Producto Al Carrito
    [Documentation]    Agrega un producto específico al carrito usando su ID
    [Arguments]    ${producto_id}
    ${locator}=    Set Variable    id:${ADD_TO_CART_PREFIX}${producto_id}
    Hacer Click    ${locator}

Agregar Producto Por Nombre
    [Documentation]    Agrega un producto al carrito buscando por su nombre
    [Arguments]    ${producto_nombre}
    ${locator}=    Set Variable    //div[contains(text(),'${producto_nombre}')]/following-sibling::button[contains(@class,'btn_inventory')]
    Hacer Click    ${locator}

Remover Producto Del Carrito
    [Documentation]    Remueve un producto del carrito usando su ID
    [Arguments]    ${producto_id}
    ${locator}=    Set Variable    id:${REMOVE_PREFIX}${producto_id}
    Hacer Click    ${locator}

# Validaciones de productos
Validar Producto Visible
    [Documentation]    Valida que un producto específico es visible
    [Arguments]    ${producto_nombre}
    ${xpath}=    Set Variable    //div[contains(@class,'inventory_item_name') and contains(text(),'${producto_nombre}')]
    Element Should Be Visible    ${xpath}

Validar Producto En Inventario
    [Documentation]    Valida que un producto está en el inventario
    [Arguments]    ${producto_nombre}
    ${existe}=    Run Keyword And Return Status    Validar Producto Visible    ${producto_nombre}
    Should Be True    ${existe}    Producto '${producto_nombre}' no encontrado en el inventario

Validar Precio Del Producto
    [Documentation]    Valida el precio de un producto
    [Arguments]    ${producto_nombre}    ${precio_esperado}
    ${precio_actual}=    Get Text    //div[contains(text(),'${producto_nombre}')]/following-sibling::div[contains(@class,'price')]
    Should Contain    ${precio_actual}    ${precio_esperado}

# Manejo del carrito
Obtener Cantidad En Carrito
    [Documentation]    Obtiene la cantidad actual de productos en el carrito
    Validar Elemento Visible    ${SHOPPING_CART_BADGE}
    ${cantidad}=    Obtener Texto Del Elemento    ${SHOPPING_CART_BADGE}
    RETURN    ${cantidad}

Validar Cantidad En Carrito
    [Documentation]    Valida la cantidad de productos en el carrito
    [Arguments]    ${cantidad_esperada}
    ${cantidad_actual}=    Obtener Cantidad En Carrito
    Should Be Equal    ${cantidad_actual}    ${cantidad_esperada}
    ...    El carrito tiene ${cantidad_actual} productos, se esperaban ${cantidad_esperada}

Validar Carrito Vacio
    [Documentation]    Valida que no hay productos en el carrito
    ${existe_badge}=    Run Keyword And Return Status    Validar Elemento Visible    ${SHOPPING_CART_BADGE}
    Should Not Be True    ${existe_badge}    Se esperaba carrito vacío pero hay productos

Navegar Al Carrito
    [Documentation]    Navega a la página del carrito de compras
    Go To    ${CART_URL}

# Ordenamiento
Ordenar Productos Por
    [Documentation]    Ordena los productos por un criterio específico
    [Arguments]    ${criterio}
    Select From List By Value    ${SORT_DROPDOWN}    ${criterio}

Obtener Criterio De Ordenamiento Actual
    [Documentation]    Obtiene el criterio de ordenamiento seleccionado
    ${criterio}=    Get Selected List Label    ${SORT_DROPDOWN}
    RETURN    ${criterio}

# Keywords de alto nivel
Agregar Producto Y Validar
    [Documentation]    Agrega un producto y valida que se agregó al carrito
    [Arguments]    ${producto_id}    ${cantidad_esperada}
    Agregar Producto Al Carrito    ${producto_id}
    Validar Cantidad En Carrito    ${cantidad_esperada}

Flujo Seleccion Multiple
    [Documentation]    Selecciona múltiples productos y valida el carrito
    [Arguments]    @{productos_ids}
    ${cantidad}=    Get Length    @{productos_ids}
    FOR    ${index}    ${producto_id}    IN ENUMERATE    @{productos_ids}
        Agregar Producto Al Carrito    ${producto_id}
        ${cantidad_actual}=    Evaluate    ${index} + 1
        Validar Cantidad En Carrito    ${cantidad_actual}
    END

# Validaciones avanzadas
Validar Todos Los Productos Visibles
    [Documentation]    Valida que todos los productos del inventario son visibles
    ${productos}=    Get WebElements    class:inventory_item
    ${cantidad}=    Get Length    ${productos}
    Should Be True    ${cantidad} > 0    No se encontraron productos en el inventario

Obtener Lista De Productos
    [Documentation]    Obtiene una lista con los nombres de todos los productos
    ${elementos}=    Get WebElements    class:inventory_item_name
    ${productos}=    Create List
    FOR    ${elemento}    IN    @{elementos}
        ${nombre}=    Get Text    ${elemento}
        Append To List    ${productos}    ${nombre}
    END
    RETURN    ${productos}

Validar Producto No Existe
    [Documentation]    Valida que un producto no está en el inventario
    [Arguments]    ${producto_nombre}
    ${existe}=    Run Keyword And Return Status    Validar Producto Visible    ${producto_nombre}
    Should Not Be True    ${existe}    Producto '${producto_nombre}' encontrado cuando no debería existir

Contar Productos En Inventario
    [Documentation]    Cuenta la cantidad de productos en el inventario
    ${cantidad}=    Obtener Cantidad De Elementos    class:inventory_item
    RETURN    ${cantidad}