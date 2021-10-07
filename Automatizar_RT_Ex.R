####################################################################-
############  Generación masiva de oficios automatizados  ###########-
############################# By LE ################################-

# Parámetros Locales
DIRECTORIO <- ""
PROYECTO <- file.path(DIRECTORIO, "")
CARPETA <- file.path(PROYECTO, "Oficios_RT-2")
# Parámetros No Locales (En la web)
NOMBRE_PEDIDO <- "RT2 - "
EXHORTACION_RT <- ""
TABLA_INSUMOS <- "INSUMOS_RT2"
TABLA_CONTACTO_OD <- "OD - Directorio"
MOD_T1 <- "RT_Word_Tipo_1.Rmd"
MOD_T2 <- "RT_Word_Tipo_2.Rmd"

##################### I. Librerias y parámetros #####################
# I.1 Librerias y conexión a base----

# i) Librerias
library(dplyr)
library(readxl)
library(rmarkdown)
library(purrr)
library(lubridate)
library(blastula)
library(googledrive)
library(googlesheets4)

# ii) Google
correo_usuario <- ""
drive_auth(email = correo_usuario)
gs4_auth(token = drive_auth(email = correo_usuario),
         email = correo_usuario)

# iii) Conexion a las base
RT_2_INSUMOS <- read_sheet(ss = EXHORTACION_RT,
                           sheet = TABLA_INSUMOS)
CONTACTO_OD <- read_sheet(ss = EXHORTACION_RT,
                          sheet = TABLA_CONTACTO_OD, skip = 1)

# I.2 Parámetros para envío de correos ----

# i) Envio de correos
code_actores <- c("")
sefa_actores <- c("")
sefa_desarrolladores  <- c("")
  
dest_cc <- c(sefa_actores, sefa_desarrolladores)


# ii) Email: Cabecera
Arriba <- add_image(
  file = "https://i.imgur.com/lXPwSPX.png",
  width = 1000,
  align = c("right"))
Cabecera <- md(Arriba)

# iii) Email: Pie de página
Logo_Oefa <- add_image(
  file = "https://i.imgur.com/ImFWSQj.png",
  width = 280)
Pie_de_pagina <- blocks(
  md(Logo_Oefa),
  block_text(md("Av. Faustino Sánchez Carrión N.° 603, 607 y 615 - Jesús María"), align = c("center")),
  block_text(md("Teléfonos: 204-9900 Anexo 7154"), align = c("center")),
  block_text("www.oefa.gob.pe", align = c("center")),
  block_text(md("**Síguenos** en nuestras redes sociales"), align = c("center")),
  block_social_links(
    social_link(
      service = "Twitter",
      link = "https://twitter.com/OEFAperu",
      variant = "dark_gray"
    ),
    social_link(
      service = "Facebook",
      link = "https://www.facebook.com/oefa.peru",
      variant = "dark_gray"
    ),
    social_link(
      service = "Instagram",
      link = "https://www.instagram.com/somosoefa/",
      variant = "dark_gray"
    ),
    social_link(
      service = "LinkedIn",
      link = "https://www.linkedin.com/company/oefa/",
      variant = "dark_gray"
    ),
    social_link(
      service = "YouTube",
      link = "https://www.youtube.com/user/OEFAperu",
      variant = "dark_gray"
    )
  ),
  block_spacer(),
  block_text(md("Imprime este correo electrónico sólo si es necesario. Cuidar el ambiente es responsabilidad de todos."), align = c("center"))
)


# iu) Botón CODE
boton_CODE <- add_cta_button(
  url = "",
  text = "Oficios de exhortación PLANEFA"
)

########################### II. Funciones ###########################
# II.1 Funcion de renderizado de documento ----
auto_lec_rep <- function(tipo, oficina,
                         ht, num, lugar, nombre, 
                         efa, defa, prefa, direfa,
                         oci, doci, proci, diroci, 
                         firma, aux_1, aux_2, aux_3){
  
  # Se eliminan carácteres especiales
  efa_n = gsub("Ñ", "N", efa)
  
  # Carpeta de la oficina
  carpeta_oficina = file.path(CARPETA, oficina)
  
  # Se selecciona el Rmd según el tipo
  if (tipo == "Tipo 1") {
    MODELO_RMD = MOD_T1
    carpeta_oficina = file.path(CARPETA, "ODES", oficina)
    ht_n = ""
  } else {
    MODELO_RMD = MOD_T2
    carpeta_oficina = file.path(CARPETA, "ODES", oficina)
    ht_n = ""
  }
  
  rmarkdown::render(input = file.path(PROYECTO, MODELO_RMD),
                    # Heredamos los par?metros desde la matriz de insumos
                    params = list(HT_1 = ht,
                                  N_OFICIO_2 = num,
                                  LUGAR_3 = lugar,
                                  DESTINATARIO_4 = nombre,
                                  EFA_5 = efa,
                                  DPTO_EFA_6 = defa,
                                  PROV_EFA_7 = prefa,
                                  DIR_EFA_8 = direfa,
                                  OCI_9 = oci,
                                  DPTO_OCI_10 = doci,
                                  PROV_OCI_11 = proci,
                                  DIR_OCI_12 = diroci,
                                  FIRMANTE_13 = firma,
                                  ADICIONAL_14 = aux_1,
                                  ADICIONAL_15 = aux_2,
                                  ADICIONAL_16 = aux_3),
                    output_file = paste0(carpeta_oficina,
                                         "/",
                                         NOMBRE_PEDIDO,
                                         tipo,
                                         " - ",
                                         ht_n,
                                         " ",
                                         efa_n))
}

# II.2 Funcion robustecida ----
R_auto_lec_rep <- function(tipo, oficina,
                           ht, num, lugar, nombre, 
                           efa, defa, prefa, direfa,
                           oci, doci, proci, diroci, 
                           firma, aux_1, aux_2, aux_3){
  out = tryCatch(auto_lec_rep(tipo, oficina,
                              ht, num, lugar, nombre, 
                              efa, defa, prefa, direfa,
                              oci, doci, proci, diroci, 
                              firma, aux_1, aux_2, aux_3),
                 error = function(e){
                   auto_lec_rep(tipo, oficina,
                                ht, num, lugar, nombre, 
                                efa, defa, prefa, direfa,
                                oci, doci, proci, diroci, 
                                firma, aux_1, aux_2, aux_3) 
                 })
  return(out)
}


########################### III. Renderizado ###########################

# III.1 Selección de datos SC ----
INSUMOS <- RT_2_INSUMOS %>%
  filter(TIPO_EXHORTACION=="Tipo 1" | TIPO_EXHORTACION=="Tipo 2")  %>%
  arrange(OD_COMPETENTE, EFA_5)

# III.2 Generación de documentos ----
pwalk(list(INSUMOS$TIPO_EXHORTACION,
           INSUMOS$OD_COMPETENTE,
           INSUMOS$HT_1,
           INSUMOS$N_OFICIO_2,
           INSUMOS$LUGAR_3,
           INSUMOS$DESTINATARIO_4,
           INSUMOS$EFA_5,
           INSUMOS$DPTO_EFA_6,
           INSUMOS$PROV_EFA_7,
           INSUMOS$DIR_EFA_8,
           INSUMOS$OCI_9,
           INSUMOS$DPTO_OCI_10,
           INSUMOS$PROV_OCI_11,
           INSUMOS$DIR_OCI_12,
           INSUMOS$FIRMANTE_13,
           INSUMOS$ADICIONAL_14,
           INSUMOS$ADICIONAL_15,
           INSUMOS$ADICIONAL_16),
      slowly(R_auto_lec_rep,
             rate_backoff(10, max_times = Inf)))

#-----------------------------------------------------------------

##################### IV Envío de correo #########################

# IV.1 Correo a ODES ----

correo_OD <- function(od, jefe,
                      correo, num_oficios, url_od){
  
  # Destinatarios
  dest_od = correo
  dest_od_cc = sefa_actores
  dest_od_bcc = sefa_desarrolladores
  
  # Estilo de texto
  od_n = paste0("**", od, "**")
  num_oficios_n = paste0("**", num_oficios, "**")
  
  # Botón
  boton_OD <- add_cta_button(
    url = url_od,
    text = "Oficios de exhortación PLANEFA"
  )
  
  # Composición de correo
  Asunto_OD <- paste("Oficios Automatizados PLANEFA | Oficios de exhortación RT2")
  Cuerpo_del_mensaje_OD <- blocks(
    md(c("
Buenas tardes, ", jefe, ":   
       ",
         od_n,
"
El Equipo de Proyectos e Innovación de la Subdirección de Seguimiento de Entidades de Fiscalización
Ambiental les informa que se han generado exitosamente los documentos automatizados para el 
seguimiento PLANEFA: ", num_oficios_n, " oficios de exhortación en este segundo trimestre.

Estos documentos fueron elaborados de manera automatizada, gracias a la información registrada 
en las bases de datos.

Pueden acceder a los archivos haciendo click en el siguiente botón:")),
    
    md(c(boton_OD)),
    md(c("
 
 ***
 **Es importante tomar en cuenta las siguientes indicaciones:**
 - Una vez que el documento se sube al SIGED, este debe **eliminarse de la carpeta compartida** (Desde el Drive).
 - Para modificaciones del documento, este debe descargarse y abrirse en Word. **No utilizar Google Docs para editar el documento**,
   dado que podría generar conflictos en el formato.
 - Este correo electrónico ha sido generado de manera automática. Para mayor información contactarse con ***.
 - El uso de lenguajes de programación de alto nivel para facilitar el trabajo realizado en SEFA es parte de un proyecto impulsado desde la Subdirección.")))
  
  email_OD <- compose_email(
    header = Cabecera,
    body = Cuerpo_del_mensaje_OD, 
    footer = Pie_de_pagina,
    content_width = 1000
  )
  
  # II.3.3 Email: Envío ----
  smtp_send(
    email_OD,
    to = dest_od,
    from = c("SEFA - Equipo de Proyectos e Innovación" = ""),
    subject = Asunto_OD,
    cc = dest_od_cc,
    bcc = dest_od_bcc,
    credentials = creds_key(id = ""),
    verbose = TRUE
  )
  
}

# Función robustecida
R_correo_OD <- function(od, jefe,
                        correo, num_oficios, url_od){
  out = tryCatch(correo_OD(od, jefe,
                          correo, num_oficios, url_od),
                 error = function(e){
                   correo_OD(od, jefe,
                             correo, num_oficios, url_od) 
                 })
  return(out)
}


# Envio de correos
CONTACTO_OD <- CONTACTO_OD %>%
  filter(!is.na(ID_OD_COMPLETO),
         CONTACTO_OD$NUMERO_OFICIOS != 0)

pwalk(list(CONTACTO_OD$ID_OD_COMPLETO,
           CONTACTO_OD$`NOMBRE JEFE DE OD`,
           CONTACTO_OD$CORREO_OD_CONTACTO_PLANEFA,
           CONTACTO_OD$NUMERO_OFICIOS,
           CONTACTO_OD$URL_CARPETA),
      slowly(R_correo_OD, 
             rate_backoff(10, max_times = Inf)))

# IV.2 Correo a CODES ----
Asunto_CODE <- paste("Oficios Automatizados PLANEFA | Seguimiento al reporte trimestral")

# Cuerpo del mensaje
Cuerpo_del_mensaje_CODE <- blocks(
  md(c("
Buenas tardes, 

**Coordinadora de Oficinas Desconcentradas - CODE**

El Equipo de Proyectos e Innovación de la Subdirección de Seguimiento de Entidades de Fiscalización
Ambiental le informa que se han generado exitosamente los documentos automatizados para el seguimiento PLANEFA:
**867** oficios de exhortación en este segundo trimestre.

Estos documentos fueron elaborados de manera automatizada, gracias a la información registrada 
en las bases de datos.

Pueden acceder a los archivos haciendo click en el siguiente botón:")),
  
  md(c(boton_CODE)),
  md(c("
 
 ***
 **Es importante tomar en cuenta las siguientes indicaciones:**
 - Una vez que el documento se sube al SIGED, este debe **eliminarse de la carpeta compartida** (Desde el Drive).
 - Para modificaciones del documento, este debe descargarse y abrirse en Word. **No utilizar Google Docs para editar el documento**,
   dado que podría generar conflictos en el formato.
 - Este correo electrónico ha sido generado de manera automática. Para mayor información contactarse con ***.
 - El uso de lenguajes de programación de alto nivel para facilitar el trabajo realizado en SEFA es parte de un proyecto impulsado desde la Subdirección.")))



# II.3.2 Email: Composición ----
email_CODE <- compose_email(
  header = Cabecera,
  body = Cuerpo_del_mensaje_CODE, 
  footer = Pie_de_pagina,
  content_width = 1000
)

# II.3.3 Email: Envío ----
smtp_send(
  email_CODE,
  to = code_actores,
  from = c("SEFA - Equipo de Proyectos e Innovación" = ""),
  subject = Asunto_CODE,
  cc = dest_cc,
  credentials = creds_key(id = ""),
  verbose = TRUE
)
