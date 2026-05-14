*** Settings ***
Documentation    Configuración global y selectores para Page Object Model
...               Centraliza todas las URLs, credenciales y selectores del proyecto.

*** Variables ***
# URLs
${BASE_URL}           https://www.saucedemo.com/
${LOGIN_URL}          ${BASE_URL}
${INVENTORY_URL}      ${BASE_URL}inventory.html
${CART_URL}           ${BASE_URL}cart.html

# Credenciales
${VALID_USERNAME}     standard_user
${VALID_PASSWORD}     secret_sauce
${LOCKED_USERNAME}    locked_out_user
${PROBLEM_USERNAME}   problem_user

# Navegador y Timeouts
${BROWSER}            chrome
${TIMEOUT}            10s
${IMPLICIT_WAIT}      5s

# Selectores - Login Page
${LOGIN_USERNAME_FIELD}     id:user-name
${LOGIN_PASSWORD_FIELD}     id:password
${LOGIN_BUTTON}             id:login-button
${LOGIN_ERROR_MESSAGE}      class:error-message-container
${LOGIN_ERROR_COPY}         class:error-button

# Selectores - Inventory Page
${INVENTORY_TITLE}          class:title
${INVENTORY_ITEM}           class:inventory_item
${INVENTORY_ITEM_NAME}      class:inventory_item_name
${INVENTORY_ITEM_DESC}      class:inventory_item_desc
${INVENTORY_ITEM_PRICE}     class:inventory_item_price
${ADD_TO_CART_PREFIX}       add-to-cart-
${REMOVE_PREFIX}            remove-
${SHOPPING_CART_LINK}       class:shopping_cart_link
${SHOPPING_CART_BADGE}      class:shopping_cart_badge
${SORT_DROPDOWN}            class:product_sort_container

# Selectores - Cart Page
${CART_TITLE}               class:title
${CART_ITEM}                class:inventory_item
${CART_ITEM_NAME}           class:inventory_item_name
${CART_ITEM_QTY}            class:inventory_item_qty
${CART_ITEM_PRICE}          class:inventory_item_price
${REMOVE_ITEM_PREFIX}       remove-
${CHECKOUT_BUTTON}          id:checkout
${CONTINUE_SHOPPING}        //button[contains(text(),'Continue Shopping')]

# Selectores - Checkout Page
${CHECKOUT_TITLE}           class:title
${FIRST_NAME_FIELD}         id:first-name
${LAST_NAME_FIELD}          id:last-name
${POSTAL_CODE_FIELD}        id:postal-code
${CANCEL_BUTTON}            id:cancel
${CONTINUE_BUTTON}          id:continue
${FINISH_BUTTON}            id:finish
${COMPLETE_HEADER}          class:complete-header

# Selectores - Elementos Comunes
${HAMBURGUR_MENU}           class:bm-burger-button
${SIDEBAR}                  class:bm-menu-wrap
${LOGOUT_LINK}              id:logout_sidebar_link
${ABOUT_LINK}               id:about_sidebar_link
${RESET_LINK}               id:reset_sidebar_link
${ALL_ITEMS_LINK}           id:inventory_sidebar_link
${TWITTER_LINK}             class:twitter-nav
${FACEBOOK_LINK}            class:facebook-nav
${LINKEDIN_LINK}            class:linkedin-nav