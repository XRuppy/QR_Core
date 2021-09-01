# QR Core

# Descripción

Aplicación desarrollada para la empresa **Manusa** con el **SDK Flutter de Google** para obtener mayor compatibilidad con **dispositivos móviles y en la Web**. Esta aplicación permite mediante un formulario previo **crear el etiquetaje con código QR para ser descargado en formato PDF y en A4.**

# Uso de la aplicación y vista previa
## Pantalla principal
[![Pantalla principal](https://github.com/XRuppy/QR_Core/blob/63b5c892ac3fd83e0dcefbacae2c625df62dd09a/Readme_Resource/Main.PNG "Pantalla principal")](https://github.com/XRuppy/QR_Core/blob/63b5c892ac3fd83e0dcefbacae2c625df62dd09a/Readme_Resource/Main.PNG "Pantalla principal")

Esta es la pantalla principal de la web. Para poder continuar presione sobre la opción ***GENERAR ETIQUETAS.***

## Pantalla del formulario

![Formulario](https://github.com/XRuppy/QR_Core/blob/63b5c892ac3fd83e0dcefbacae2c625df62dd09a/Readme_Resource/Form.PNG "Formulario")

En la siguiente pantalla deberá rellenar los campos. En la sección **DEFINIR DATOS DE LA ETIQUETA** introduciremos el número de teléfono e identificador de puerta. También pondremos la posición por la que queremos comenzar a imprimir. Tendremos un botón para poder subo la imagen del logo, es **recomendable que el tamaño de la imagen no sea elevado.**

En la siguiente sección estableceremos el numero inicial y final del rango con el número de copias por cada etiqueta. Si son diferentes rangos tendremos el botón de **AÑADIR** más rangos. Una vez terminado le daremos a **DESCARGAR PDF** que tardará más o menos dependiendo del tamaño de la imagen del logo.

![PDF generado con etiquetas](https://github.com/XRuppy/QR_Core/blob/63b5c892ac3fd83e0dcefbacae2c625df62dd09a/Readme_Resource/Etiquetas_Descarga.PNG "PDF generado con etiquetas")

Como se puede ver en la imagen tenemos el PDF con la cantidad de etiquetas y en su rango como le habíamos establecido en la imagen anterior.

# Recursos y software utilizado
## Dependencias
   ```yaml
    <dependencies:
  	flutter:
    sdk: flutter
	  flutter_localizations:
 	   sdk: flutter
	  cupertino_icons: ^0.1.2
	  fluttertoast: ^8.0.7
	  path_provider: ^2.0.2
	  path_provider_platform_interface: ^2.0.1
	  universal_html: ^2.0.8
	  barcode_scan: ^3.0.1
	  qr_flutter: ^4.0.0
	  pdf: ^3.4.2
	  open_file: ^3.2.1
	  file_picker: ^3.0.3
 	 plugin_platform_interface: ^2.0.1
 	 intl: ^0.17.0>
```
  
## Software utilizado
- Android Studio
- Microsoft Edge (Versión Chromium)
- Android 10

## Otros recursos
### Fuentes
La fuente principal es Product Sans. Los ficheros *.ttf* están ubicados en la **carpeta Fonts.**
```yaml
  fonts:
    - family: Product Sans
      fonts:
        - asset: fonts/Product-Sans-Regular.ttf
        - asset: fonts/Product-Sans-Bold-Italic.ttf
        - asset: fonts/Product-Sans-Italic.ttf
        - asset: fonts/Product-Sans-Bold.ttf
```
### Assets

Logos de Manusa y CE. Las imágenes están ubicados en la **carpeta Assets.**

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/logo_manusa.png
    - assets/logo_manusa_little.png
    - assets/ce.png
```
### Idiomas
Lo idiomas son los siguientes: 
- Inglés
- Castellano
- Francés
- Portugués

Los ficheros *.json* están ubicados en la **carpeta i18n**

```yaml
<flutter:
  uses-material-design: true
  assets:
    - i18n/en.json #Inglés
    - i18n/es.json #Castellano
    - i18n/fr.json #Francés
    - i18n/pt.json> #Portugués
```
