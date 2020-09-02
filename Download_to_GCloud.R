pacman::p_load(tidyverse, googledrive)

# Primero, descargamos a todos los archivos CSV comprimidos de https://datos.sfp.gov.py/data/funcionarios/download 
# Para hacer eso, hagamos una lista de los links primero

url <- "https://datos.sfp.gov.py/list/data"
csv_list_json <- rjson::fromJSON(file=url)

# Convertimos JSON a un DataFrame

csv_df <- data.frame(csv_list_json)
names(csv_df) <- c("archivos")

# Creamos una lista de los CSVs del año actual

currentYear <- format(Sys.Date(), "%Y")
csvs <- csv_df %>%
  filter(str_detect(archivos, currentYear)) %>% 
  filter(str_detect(archivos, "csv"))
csv_list <- pull(csvs, archivos)

# Creamos a la funcion de descarga

get_data_from_url <- function(csv_name){
  download_url <- paste0("https://datos.sfp.gov.py/data/", csv_name)
  print(download_url)
  download.file(url = download_url, destfile = csv_name, method = "curl")
}

# Descargamos a los datos

# map(csv_list, get_data_from_url)

drive_auth(path = "service_account.json")

root_folder <- "Py Data Lake"
sfp_folder <- paste(root_folder, "SFP", sep = "/")
current_date <- format(Sys.Date(), "%d-%m-%Y")
full_path <- paste(sfp_folder, current_date, sep = "/")

# Creamos una carpeta nueva con la fecha actual

drive_mkdir(current_date, path = sfp_folder)

# Subimos los archivos a Google Drive

for (zfile in csv_list)
{
  tryCatch(
    expr = {
      
      upload <- drive_upload(
        media = zfile,
        path = full_path,
        name = zfile
      )
    },
    error = function(e){
      print(e)
    })
}


