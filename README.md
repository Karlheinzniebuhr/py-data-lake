# Py Data Lake
**Capturas regulares de datos públicos**

## Qué hace ? (hasta ahora)
Un script que descarga los csv.zip del SFP https://datos.sfp.gov.py/data/ y lo sube a [Google Drive](https://drive.google.com/drive/folders/1T-yPOn5pUHFNmA_KdkejpMVfscodd2ve?usp=sharing).

## Para qué sirve ?
Almacenar copias frecuentes de los datos públicos y almacenarlos para futuros análisis y auditorías.

## Cómo funciona actualmente ?
- El scheduler ejecuta al script durante una hora semi-fija del día.
- Se verifica la [lista de archivos del año actual](https://datos.sfp.gov.py/list/data), ya que son los datos que van modificándose regularmente.
- Se descargan los archivos csv.zip, luego se crea una carpeta con el nombre de la fecha actual en Google Drive.
- Se suben los archivos a la carpeta nueva.

Link de Google Drive: https://drive.google.com/drive/folders/1T-yPOn5pUHFNmA_KdkejpMVfscodd2ve?usp=sharing
