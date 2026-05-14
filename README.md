# 🤖 Robot Framework - Proyecto de Automatización IA

Este repositorio contiene un framework de automatización de pruebas robusto y escalable, utilizando **Robot Framework** para pruebas Web y API. El proyecto implementa las mejores prácticas de automatización, incluyendo el patrón **Page Object Model (POM)** y pruebas dirigidas por datos (**Data-Driven Testing**).

## 🚀 Características Principales

- **Pruebas Web**: Automatización del sitio [SauceDemo](https://www.saucedemo.com/) utilizando POM.
- **Pruebas API**: Validación de servicios REST (JSONPlaceholder y PetStore).
- **Data-Driven Testing**: Pruebas parametrizadas usando archivos CSV.
- **CI/CD**: Integración continua configurada con GitHub Actions.
- **Reportes**: Generación automática de reportes HTML y logs detallados.

## 🛠️ Requisitos Previos

Asegúrate de tener instalado:
- [Python 3.8+](https://www.python.org/)
- [Google Chrome](https://www.google.com/chrome/) (u otro navegador compatible)
- [ChromeDriver](https://chromedriver.chromium.org/) (gestionado automáticamente por la mayoría de las librerías modernas)

## 📦 Instalación

1. Clona este repositorio:
   ```bash
   git clone <url-del-repositorio>
   cd Robot_IA
   ```

2. Instala las dependencias necesarias:
   ```bash
   pip install -r requirements.txt
   ```

## 🏗️ Estructura del Proyecto

```text
Robot_IA/
├── pages/          # Page Objects (Lógica de páginas Web)
├── tests/          # Suites de pruebas principales (POM)
├── test/           # Pruebas de API y casos legacy
├── resources/      # Keywords compartidas y configuración global
├── data/           # Archivos de datos para pruebas (CSV)
├── .github/        # Workflows de GitHub Actions
└── README_POM.md   # Documentación detallada del patrón POM
```

## 🧪 Ejecución de Pruebas

### Pruebas Web (POM)
Para ejecutar las pruebas de la tienda virtual:
```bash
# Ejecutar todos los tests POM
robot tests/

# Ejecutar solo login
robot tests/login_tests.robot
```

### Pruebas de API
Para ejecutar las validaciones de servicios REST:
```bash
# Pruebas de API Users
robot test/api_users.robot

# Pruebas de PetStore
robot test/petstore_api.robot
```

### Pruebas Data-Driven
```bash
robot test/data_driven_test.robot
```

### Ejecución por Tags
```bash
robot --include smoke tests/
```

## 📊 Reportes

Después de cada ejecución, Robot Framework genera:
- `report.html`: Resumen visual de alto nivel.
- `log.html`: Detalle paso a paso de la ejecución.
- `output.xml`: Datos técnicos para integraciones.

## ⚙️ CI/CD

El proyecto cuenta con un workflow de **GitHub Actions** en `.github/workflows/robot_tests.yml` que ejecuta las pruebas automáticamente ante cada `push` o `pull_request` a la rama principal.

## 📖 Documentación Adicional

Para detalles profundos sobre la implementación del **Page Object Model**, consulta el archivo:
👉 [README_POM.md](./README_POM.md)

---
Desarrollado con ❤️ para la automatización de calidad.
