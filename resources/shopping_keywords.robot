*** Settings ***
Documentation    Keywords reutilizables para operaciones de compra en SauceDemo
...               Este archivo contiene keywords modulares para el flujo de selección
...               de productos y manejo del carrito de compras.
Library    SeleniumLibrary

*** Variables ***
${PRODUCTO_1_ID}        add-to-cart-sauce-labs-backpack
${PRODUCTO_2_ID}        add-to-cart-sauce-labs-bike-light
${PRODUCTO_1_NOMBRE}    Sauce Labs Backpack
${PRODUCTO_2_NOMBRE}    Sauce Labs Bike Light

*** Keywords ***
Dado Que Estoy En La Página De Login
    [Documentation]    Abre el navegador y navega a la página de login
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Title Should Be    Swag Labs

Cuando Inicio Sesión Con Credenciales Válidas
    [Documentation]    Realiza el login con las credenciales configuradas
    [Arguments]    ${username}    ${password}
    Input Text      id:user-name    ${username}
    Input Password  id:password     ${password}
    Click Button    id:login-button

Cuando Selecciono Un Producto
    [Documentation]    Añade un producto específico al carrito
    [Arguments]    ${producto_id}
    Click Button    id:${producto_id}

Cuando Selecciono Múltiples Productos
    [Documentation]    Añade múltiples productos al carrito
    [Arguments]    @{productos_ids}
    FOR    ${producto_id}    IN    @{productos_ids}
        Click Button    id:${producto_id}
    END

Cuando Navego Al Carrito
    [Documentation]    Navega a la página del carrito de compras
    Click Link    class:shopping_cart_link

Entonces Debería Ver La Página De Inventario
    [Documentation]    Valida que el login fue exitoso y estamos en el inventario
    Element Should Be Visible    class:title
    Element Text Should Be       class:title    Products

Entonces El Carrito Debería Tener Un Producto
    [Documentation]    Valida que el contador del carrito muestra 1 producto
    Wait Until Element Is Visible    class:shopping_cart_badge
    Element Text Should Be    class:shopping_cart_badge    1

Entonces El Carrito Debería Tener Dos Productos
    [Documentation]    Valida que el contador del carrito muestra 2 productos
    Wait Until Element Is Visible    class:shopping_cart_badge
    Element Text Should Be    class:shopping_cart_badge    2

Entonces El Carrito Debería Tener ${cantidad} Productos
    [Documentation]    Valida que el contador del carrito muestra la cantidad esperada
    Wait Until Element Is Visible    class:shopping_cart_badge
    Element Text Should Be    class:shopping_cart_badge    ${cantidad}

Entonces Debería Ver El Producto En El Carrito
    [Documentation]    Valida que el producto seleccionado está en el carrito
    [Arguments]    ${producto_nombre}
    Element Should Contain    class:inventory_item_name    ${producto_nombre}

Entonces Debería Ver Todos Los Productos En El Carrito
    [Documentation]    Valida que todos los productos seleccionados están en el carrito
    [Arguments]    @{productos_nombres}
    FOR    ${producto_nombre}    IN    @{productos_nombres}
        Page Should Contain    ${producto_nombre}
    END

Cerrar Navegador
    [Documentation]    Cierra el navegador
    Close Browser