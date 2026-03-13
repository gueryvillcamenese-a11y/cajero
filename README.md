# Demi Cashier - Módulo Cajero

Un sistema de punto de venta (POS) móvil desarrollado con Flutter para gestionar transacciones, inventario y órdenes de compra. Esta aplicación proporciona una solución completa para comercios y negocios que requieren un sistema de caja digital moderno y eficiente.

## 📋 Tabla de Contenidos

- [Características](#características)
- [Requisitos Previos](#requisitos-previos)
- [Instalación](#instalación)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Configuración](#configuración)
- [Uso](#uso)
- [Arquitectura](#arquitectura)
- [Dependencias Principales](#dependencias-principales)
- [Desarrollo](#desarrollo)
- [Contribuciones](#contribuciones)

## ✨ Características

### Gestión de Ventas
- **Sistema de Carrito**: Añade, modifica y elimina productos del carrito de compras
- **Procesamiento de Pagos**: Soporte para múltiples métodos de pago
- **Generación de Órdenes**: Crea y guarda órdenes de compra para seguimiento

### Catálogo de Productos
- **Búsqueda y Filtrado**: Busca productos fácilmente por nombre o categoría
- **Vista Detallada**: Información completa de productos incluyendo precio, descripción e imágenes
- **Gestión de Inventario**: Monitorea stock disponible de productos

### Funcionalidades Avanzadas
- **Escaneo de Códigos**: Captura códigos de barras usando la cámara del dispositivo
- **Autenticación**: Sistema de login seguro para usuarios
- **Historial de Transacciones**: Consulta órdenes anteriores y transacciones
- **Reportes**: Analiza ventas, ingresos y estadísticas de negocio
- **Supervisión**: Panel administrativo para supervisar operaciones
- **Perfil de Usuario**: Gestiona información personal y preferencias

## 🔧 Requisitos Previos

Antes de iniciar, asegúrate de tener instalado:

- **Flutter SDK**: versión 3.2.0 o superior
- **Dart SDK**: incluido con Flutter
- **Android SDK**: para desarrollo en Android (API level 21 o superior)
- **Xcode**: para desarrollo en iOS (macOS)
- **Git**: para control de versiones

### Verificar instalación
```bash
flutter --version
dart --version
flutter doctor
```

## 📦 Instalación

### 1. Clonar o descargar el proyecto
```bash
git clone <url-del-repositorio>
cd cajero
```

### 2. Obtener las dependencias
```bash
flutter pub get
```

### 3. Generar archivos (si es necesario)
```bash
flutter pub run build_runner build
```

## 🗂️ Estructura del Proyecto

La aplicación sigue la arquitectura limpia con separación por capas:

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── core/
│   ├── constants/           # Constantes globales
│   ├── errors/              # Manejo de errores personalizado
│   ├── providers/           # Proveedores de estado (Provider)
│   ├── theme/               # Temas y estilos visuales
│   └── utils/               # Utilidades generales
├── data/
│   ├── datasources/         # Fuentes de datos (APIs, BD local)
│   ├── mappers/             # Conversión de modelos
│   └── repositories/        # Implementación de repositorios
├── domain/
│   ├── entities/            # Modelos de negocio
│   ├── repositories/        # Interfaces de repositorios
│   └── usecases/            # Casos de uso de la aplicación
├── injection/
│   ├── injection_container.dart  # Inyección de dependencias (GetIt)
│   └── modules/             # Módulos de configuración
└── presentation/
    ├── features/            # Características UI
    │   ├── auth/            # Autenticación
    │   ├── cart/            # Carrito de compras
    │   ├── catalog/         # Catálogo de productos
    │   ├── history/         # Historial de órdenes
    │   ├── home/            # Pantalla principal
    │   ├── inventory/       # Gestión de inventario
    │   ├── payment/         # Procesamiento de pagos
    │   ├── product_detail/  # Detalles del producto
    │   ├── profile/         # Perfil de usuario
    │   ├── reports/         # Reportes y estadísticas
    │   ├── scanner/         # Escaneo de códigos
    │   └── supervision/     # Panel de supervisión
    ├── routes/              # Configuración de rutas
    └── widgets/             # Widgets reutilizables
```

## ⚙️ Configuración

### Configuración de Rutas
Las rutas se definen en `lib/presentation/routes/app_routes.dart`:

```dart
class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String cart = '/cart';
  // ... más rutas
}
```

### Tema de la Aplicación
El tema se configura en `lib/core/theme/app_theme.dart` con colores, tipografías y estilos globales.

### Gestión de Estado
- **Provider**: Para gestión reactiva de estado (CartProvider, OrderProvider, AuthProvider)
- **GetIt**: Service Locator para inyección de dependencias

## 🚀 Uso

### Iniciar la aplicación (Android)
```bash
flutter run -d android
```

### Iniciar la aplicación (iOS)
```bash
flutter run -d ios
```

### Ejecutar en modo debug
```bash
flutter run --debug
```

### Compilar para producción
```bash
# Android (APK)
flutter build apk --release

# Android (App Bundle)
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 🏗️ Arquitectura

La aplicación implementa **Clean Architecture** con tres capas principales:

### 1. **Presentation Layer** (Presentación)
- Contiene la interfaz de usuario (widgets, pantallas)
- Gestiona el estado con Provider
- Maneja eventos del usuario

### 2. **Domain Layer** (Dominio)
- Define entidades de negocio (modelos)
- Especifica interfaces de repositorios
- Implementa los casos de uso (business logic)

### 3. **Data Layer** (Datos)
- Accede a fuentes de datos (APIs, bases de datos locales)
- Implementa los repositorios
- Realiza mapeos entre modelos

Esta arquitectura proporciona:
- ✅ Código modular y reutilizable
- ✅ Fácil de testear
- ✅ Mantenibili independencia de frameworks
- ✅ Escalabilidad

## 📚 Dependencias Principales

| Dependencia | Versión | Propósito |
|---|---|---|
| `flutter` | SDK | Framework principal |
| `provider` | ^6.1.5+1 | Gestión de estado |
| `get_it` | ^7.7.0 | Service Locator (inyección de dependencias) |
| `mobile_scanner` | ^5.1.0 | Escaneo de códigos de barras |
| `permission_handler` | ^11.3.1 | Manejo de permisos del dispositivo |
| `equatable` | ^2.0.5 | Comparación de objetos |
| `intl` | ^0.19.0 | Internacionalización |
| `cupertino_icons` | ^1.0.8 | Iconos iOS |

## 💻 Desarrollo

### Crear un nuevo Caso de Uso
1. Define la entidad en `domain/entities/`
2. Crea la interfaz del repositorio en `domain/repositories/`
3. Implementa el caso de uso en `domain/usecases/`
4. Implementa el repositorio en `data/repositories/`

### Crear una nueva Pantalla
1. Crea una carpeta en `presentation/features/`
2. Organiza en subcarpetas: `pages`, `widgets`, `provider`
3. Conecta con rutas en `app_routes.dart`

### Buenas Prácticas
- Usa ChangeNotifierProvider para gestionar estado
- Implementa manejo de errores robusto
- Documenta funciones públicas
- Sigue convenciones de nombres (camelCase para variables, PascalCase para clases)
- Reutiliza widgets comunes

## 👥 Contribuciones

Para contribuir al proyecto:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo licencia [especificar licencia]. Ver el archivo LICENSE para más detalles.

## 📞 Soporte

Para reportar problemas, sugerencias o preguntas, por favor:
- Abre un Issue en el repositorio
- Contacta al equipo de desarrollo
- Revisa la documentación de Flutter: https://docs.flutter.dev/

---

**Última actualización**: Marzo 2026
**Versión de la aplicación**: 1.0.0
