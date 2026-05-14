*** Settings ***
Documentation    Tests para la funcionalidad de compras
...               Pruebas de selección de productos y manejo del carrito.
Library           SeleniumLibrary
Resource          ../pages/login_page.robot
Resource          ../pages/inventory_page.robot
Resource          ../pages/cart_page.robot
Resource          ../resources/config.robot

*** Test Cases ***
Agregar Un Producto Al Carrito
    [Documentation]    Valida agregar un producto al carrito
    [Tags]    smoke    shopping
    Login Exitoso    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Agregar Producto Al Carrito    sauce-labs-backpack
    Validar Cantidad En Carrito    1
    [Teardown]    Cerrar Navegador

Agregar Dos Productos Al Carrito
    [Documentation]    Valida agregar dos productos diferentes al carrito
    [Tags]    regression    shopping
    Login Exitoso    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Agregar Producto Al Carrito    sauce-labs-backpack
    Agregar Producto Al Carrito    sauce-labs-bike-light
    Validar Cantidad En Carrito    2
    [Teardown]    Cerrar Navegador

Agregar Múltiples Productos Y Validar En Carrito
    [Documentation]    Valida agregar múltiples productos y verificar en carrito
    [Tags]    smoke    shopping    cart
    Login Exitoso    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Agregar Producto Al Carrito    sauce-labs-backpack
    Agregar Producto Al Carrito    sauce-labs-bike-light
    Navegar Al Carrito
    Validar Página Del Carrito
    Validar Producto En Carrito    Sauce Labs Backpack
    Validar Producto En Carrito    Sauce Labs Bike Light
    [Teardown]    Cerrar Navegador

Flujo Completo De Compra
    [Documentation]    Valida el flujo completo: login, seleccionar producto, ir al carrito
    [Tags]    smoke    shopping    e2e
    Login Exitoso    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Validar Página De Inventario
    Agregar Producto Al Carrito    sauce-labs-backpack
    Validar Cantidad En Carrito    1
    Navegar Al Carrito
    Validar Página Del Carrito
    Validar Producto En Carrito    Sauce Labs Backpack
    [Teardown]    Cerrar Navegador

Remover Producto Del Carrito
    [Documentation]    Valida remover un producto del carrito
    [Tags]    regression    shopping    cart
    Login Exitoso    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Agregar Producto Al Carrito    sauce-labs-backpack
    Agregar Producto Al Carrito    sauce-labs-bike-light
    # Cerrar popup de cambio de contraseña si aparece
    ${existe}=    Run Keyword And Return Status    Esperar Elemento Visible    //button[contains(text(),'Cancel')]
    IF    ${existe}
        Click Element    //button[contains(text(),'Cancel')]
    END
    Navegar Al Carrito
    Validar Página Del Carrito
    Validar Cantidad De Items    2
    cart_page.Remover Producto Del Carrito    Sauce Labs Backpack
    Validar Cantidad De Items    1
    Validar Producto No Esta En Carrito    Sauce Labs Backpack
    [Teardown]    Cerrar Navegador

Continuar Comprando Desde Carrito
    [Documentation]    Valida regresar al inventario desde el carrito
    [Tags]    regression    shopping    navigation
    Login Exitoso    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Agregar Producto Al Carrito    sauce-labs-backpack
    Navegar Al Carrito
    Hacer Click En Continuar Comprando
    Validar Página De Inventario
    [Teardown]    Cerrar Navegador

Ordenar Productos Por Precio
    [Documentation]    Valida el ordenamiento de productos por precio
    [Tags]    regression    shopping    sorting
    Login Exitoso    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Ordenar Productos Por    lohi
    # Aquí podríamos validar que los productos estén ordenados
    [Teardown]    Cerrar Navegador

Validar Información De Productos En Inventario
    [Documentation]    Valida que los productos muestren información correcta
    [Tags]    regression    shopping    validation
    Login Exitoso    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Validar Producto En Inventario    Sauce Labs Backpack
    Validar Producto En Inventario    Sauce Labs Bike Light
    Validar Producto En Inventario    Sauce Labs Bolt T-Shirt
    [Teardown]    Cerrar Navegador

Carrito Conserva Productos Al Navegar
    [Documentation]    Valida que el carrito mantiene productos al navegar
    [Tags]    regression    shopping    cart
    Login Exitoso    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Agregar Producto Al Carrito    sauce-labs-backpack
    Navegar Al Carrito
    Hacer Click En Continuar Comprando
    ${cantidad}=    Obtener Cantidad En Carrito
    Should Be Equal    ${cantidad}    1
    [Teardown]    Cerrar Navegador