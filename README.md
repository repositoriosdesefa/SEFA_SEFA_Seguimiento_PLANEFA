# SEFA: Oficios y correos de seguimiento PLANEFA
El proyecto Oficios de seguimiento PLANEFA cumplió con el objetivo de automatizar los documentos generados por la SEFA y ODES, a fin de dar seguimiento al cumplimiento de la presentación del PLANEFA y Reportes Trimestrales de la EFA.

Al finalizar el proyecto se elaboró un script de automatización y los archivos correspondientes a las plantillas en RMarkdown para la generación de cada tipo de documento, los cuales son: 
1. Oficio recordatorio
2. Oficio de exhortación
3. Oficio a OCI.

# Archivos
- Automatizar_RT_Ex.R : Script en R para la automatización de oficios de exhortación.
- Automatizar_RT_OCI.R : Script en R para la automatización de oficios a OCI.
- Recordatorio_Planefa_Simplificado.Rmd : Archivo en RMarkdown para la generación de oficios recordatorios en PDF. 
- RT_Ex_Tipo_1.Rmd : Archivo en RMarkdown para la generación de oficios exhortación tipo 1 en Word. 
- plantilla_rt_exh_1 : Plantilla en Word para la generación de documentos.
- RT_Ex_Tipo_2.Rmd : Archivo en RMarkdown para la generación de oficios exhortación tipo 2 en Word.
- plantilla_rt_exh_2 : Plantilla en Word para la generación de documentos.
- RT_Ex_OCI.Rmd : Archivo en RMarkdown para la generación de oficios a OCI en Word.
- plantilla_rt_OCI : Plantilla en Word para la generación de documentos.
- Peru.png : Archivos necesarios para la generación del documento.
- Rlogo.png : Archivos necesarios para la generación del documento.
- Carpeta Imágenes: Galería de imágenes con los productos


# Observaciones
- Se eliminó la información sensible relacionada a ID de Google Sheets, rutas locales y objetos con accesos.
