# Remesas App - Guía de Usuario

## 📱 Aplicación para Registro de Remesas

### ¿Qué hace esta aplicación?
Esta aplicación te permite registrar y gestionar las remesas de dinero de tu empresa de una manera fácil y organizada.

### ✨ Características principales:
- ✅ Registrar nuevas remesas con todos los detalles
- ✅ Ver estadísticas de total enviado y número de remesas
- ✅ Buscar remesas por cliente o empleado
- ✅ Eliminar remesas con confirmación
- ✅ Datos guardados localmente en tu dispositivo

### 🚀 Cómo usar la aplicación:

#### 1. Pantalla Principal
Al abrir la app verás:
- **Dos tarjetas superiores** con estadísticas (total dinero y número de remesas)
- **Barra de búsqueda** para encontrar remesas específicas
- **Lista de remesas** ordenadas por fecha
- **Botón azul (+)** para agregar nueva remesa

#### 2. Agregar Nueva Remesa
1. Toca el botón **+** (flotante, color azul)
2. Completa el formulario:
   - **Nombre del Cliente**: Escribe el nombre completo
   - **Monto a Enviar**: Cantidad de dinero (ej: 1500.50)
   - **Fecha de Envío**: Toca para seleccionar fecha del calendario
   - **Registrado por**: Tu nombre o del empleado
3. Toca **"Registrar Remesa"**
4. ¡Listo! Verás la confirmación y regresarás a la pantalla principal

#### 3. Buscar Remesas
- Usa la barra de búsqueda en la pantalla principal
- Puedes buscar por nombre de cliente o empleado
- Los resultados se filtran automáticamente mientras escribes

#### 4. Eliminar Remesas
- En la lista, toca el ícono de **basura roja** 🗑️
- Confirma que quieres eliminar
- La remesa se eliminará permanentemente

### 🛠️ Cómo ejecutar la aplicación:

1. **Abrir terminal en el directorio del proyecto:**
   ```bash
   cd remesas_app
   ```

2. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación:**
   ```bash
   flutter run
   ```

### 📊 Información técnica:
- Los datos se guardan en tu dispositivo (no se necesita internet)
- Usa base de datos SQLite para almacenamiento
- Compatible con Android e iOS
- Interfaz Material Design moderna

### 💡 Consejos de uso:
- Siempre revisa los datos antes de guardar
- Usa nombres completos para facilitar las búsquedas
- Las fechas se pueden seleccionar desde el calendario
- Los montos aceptan decimales (usa punto, no coma)
