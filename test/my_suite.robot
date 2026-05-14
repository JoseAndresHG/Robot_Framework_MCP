*** Settings ***
Documentation    Suite de pruebas para validar el flujo de compra en SauceDemo
...               Esta suite contiene pruebas de automatización web que validan
...               el proceso de login, navegación por el inventario, selección
...               de productos y manejo del carrito de compras.
...               
...               Estructura reorganizada con enfoque Gherkin (Dado/Cuando/Entonces)
...               utilizando keywords modulares de los archivos de recursos.

Library    SeleniumLibrary
Resource    ../resources/login_keywords.robot
Resource    ../resources/shopping_keywords.robot

*** Variables ***
${BROWSER}              chrome
${URL}                  https://www.saucedemo.com/
${USER}                 standard_user
${PASS}                 secret_sauce

*** Test Cases ***
Flujo Completo De Seleccion De Producto
    [Documentation]    Validar el flujo completo de selección de un producto
    [Tags]    smoke    regression    shopping
    
    Dado Que Estoy En La Página De Login    ${URL}    ${BROWSER}
    Cuando Inicio Sesión Con Credenciales Válidas    ${USER}    ${PASS}
    Entonces Debería Ver La Página De Inventario
    Cuando Selecciono Un Producto    ${PRODUCTO_1_ID}
    Entonces El Carrito Debería Tener Un Producto
    Cuando Navego Al Carrito
    Entonces Debería Ver El Producto En El Carrito    ${PRODUCTO_1_NOMBRE}
    [Teardown]    Cerrar Navegador

Seleccionar Dos Productos Al Carrito
    [Documentation]    Validar la selección de múltiples productos al carrito
    [Tags]    regression    shopping    multi-product
    
    Dado Que Estoy En La Página De Login    ${URL}    ${BROWSER}
    Cuando Inicio Sesión Con Credenciales Válidas    ${USER}    ${PASS}
    Entonces Debería Ver La Página De Inventario
    Cuando Selecciono Múltiples Productos    ${PRODUCTO_1_ID}    ${PRODUCTO_2_ID}
    Entonces El Carrito Debería Tener Dos Productos
    Cuando Navego Al Carrito
    Entonces Debería Ver Todos Los Productos En El Carrito    ${PRODUCTO_1_NOMBRE}    ${PRODUCTO_2_NOMBRE}
    [Teardown]    Cerrar Navegador