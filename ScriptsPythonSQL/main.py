# -*- coding: utf-8 -*-
"""
Created on Sat May 27 08:53:09 2023

@author: MARCELO CHçVEZ
"""

# =============================================================================
# 1 | Servicio Web (Instituciones Educativas Aprobadas):
# =============================================================================

import requests
import pandas as pd
from credenciales import *
import os

os.chdir(path_work)

def descargar_datos(url, token):
    headers = {'Authorization': token}
    try:
        respuesta = requests.get(url, headers=headers)

        if respuesta.status_code == 200:
            datos = respuesta.json()
            df = pd.DataFrame(datos)
            
            # Extraer la columna "listado" como un nuevo DataFrame
            df_listado = pd.json_normalize(df["listado"])
            
            print("Datos descargados correctamente. DataFrame resultante:")
            print(df.head())
            
            print("DataFrame 'listado' resultante:")
            print(df_listado.head())
            
            return df, df_listado
        else:
            print("Error al descargar los datos. Cdigo de estado:", respuesta.status_code)
    except requests.exceptions.RequestException as e:
        print("Error en la solicitud:", e)


# Credenciales:
instituciones_educativas_aprobadas = instituciones_educativas_aprobadas
header_authorization = header_authorization
lista_json, instituciones_educativas = descargar_datos(instituciones_educativas_aprobadas, header_authorization)
instituciones_educativas["servicio_web"] = "SÍ está en el WS"

# =============================================================================
# Lectura del Excel
# =============================================================================

db_proy = pd.read_excel("db_innovacion.xlsm", sheet_name="Proyectos")

# =============================================================================
# Análisis de Instituciones Educativas Repetidas:
# Dimensión de la tabla Instituciones Educativas: 
# =============================================================================

print('El número de filas educativas es: ',instituciones_educativas.shape[0])
amie_repetidos = pd.DataFrame(instituciones_educativas["codAmie"].value_counts()).reset_index().rename(columns={'codAmie':'AMIE','count':'Repetidos'})
filtro = instituciones_educativas[instituciones_educativas['codAmie']=='08H00300']
print('Instituciones Repetidas: ', amie_repetidos)
print('Ejemplo de Institución Educativa repetida: ', filtro)

# =============================================================================
# Análisis de coincidencias entre proyectos y prácticas educativas aprobadas y ws:
# =============================================================================

db_proy = pd.read_excel(r"C:\Users\marcelochavez\Documents\MINEDUC\PRODUCTOS CONSULTORIA - LABORATORIO INNOVACION EDUCATIVA ECUADOR\BACKUP\db_innovacion_vs_2.xlsm", 
                        sheet_name='Proyectos')
db_proy.columns = db_proy.columns.str.lower()

db_ws_1 = instituciones_educativas[["codAmie","servicio_web"]].drop_duplicates().rename(columns={"codAmie":"cod_amie"})

reporte_coincidencias = db_proy.merge(db_ws_1, how="left", on="cod_amie")

reporte_ws_db_proy = reporte_coincidencias[["cod_amie","nombre_institucion","servicio_web"]].fillna("NO está en el WS")

reporte_ws_db_proy.servicio_web.value_counts()

# Revisión en la db de proyectos y prácticas:
    
reporte_fil = instituciones_educativas[instituciones_educativas.codAmie.isin(["24H00138"])]

# =============================================================================
# 2 | Funcin que transforma coordenadas: UTM WGS84 a GEOGRÁFICAS ZONA 17 SUR:
# =============================================================================

from pyproj import CRS, Transformer

def convertir_coordenadas_geograficas(df, utm_east_col, utm_north_col):
    # Definir sistema de coordenadas UTM y geogáficas
    utm_crs = CRS.from_epsg(32717)  # UTM zona 17N
    geog_crs = CRS.from_epsg(4326)  # WGS84 (coordenadas geogáficas)

    # Crear transformador de coordenadas
    transformer = Transformer.from_crs(utm_crs, geog_crs)

    def obtener_coordenadas_geograficas(row):
        utm_easting = row[utm_east_col]
        utm_northing = row[utm_north_col]

        # Invertir coordenadas para el hemisferio sur
        utm_northing_south = 10000000 - utm_northing

        # Convertir coordenadas UTM a geográficas
        lon, lat = transformer.transform(utm_easting, utm_northing_south)

        row['geolocalizacion_lat'] = lat
        row['geolocalizacion_lon'] = lon
        return row

    df = df.apply(obtener_coordenadas_geograficas, axis=1)
    return df

instituciones_educativas = convertir_coordenadas_geograficas(instituciones_educativas, "coordenadaX", "coordenadaY")

# =============================================================================
# 3 | Servicio Web (Oferta Educativa): Testing
# =============================================================================

def descargar_datos(url, token, body_params):
    headers = {'Authorization': token, 'Content-Type': 'application/json'}
    try:
        respuesta = requests.post(url, headers=headers, json=body_params)

        if respuesta.status_code == 200:
            datos = respuesta.json()
            df = pd.DataFrame(datos)
            print("Datos descargados correctamente. DataFrame resultante:")
            print(df.head())
            return df
        else:
            print("Error al descargar los datos. Código de estado:", respuesta.status_code)
    except requests.exceptions.RequestException as e:
        print("Error en la solicitud:", e)


# Ejemplo de uso
oferta_educativa = oferta_educativa
header_authorization = header_authorization
body_params = {
    "amie": '17H00384',
    "codAnoLectivo": 483,
    "codigoRegimen": 1
}

dataset = descargar_datos(oferta_educativa, header_authorization, body_params)

# =============================================================================
# 4 | Servicio Web Iterativo (Oferta Educativa):
# =============================================================================

def descargar_datos(url, token, body_params):
    headers = {'Authorization': token, 'Content-Type': 'application/json'}
    try:
        respuesta = requests.post(url, headers=headers, json=body_params)

        if respuesta.status_code == 200:
            datos = respuesta.json()
            df = pd.DataFrame(datos)
            print("Datos descargados correctamente. DataFrame resultante:")
            print(df.head())
            return df
        else:
            print("Error al descargar los datos. Código de estado:", respuesta.status_code)
    except requests.exceptions.RequestException as e:
        print("Error en la solicitud:", e)

# Credenciales:
oferta_educativa = oferta_educativa
header_authorization = header_authorization

# Obtener todos los diccionarios de la columna en una lista
lista_diccionarios = lista_json['listado'].tolist()

# Iterar sobre los datos del primer DataFrame y realizar bsqueda en el segundo servicio web
dataframes_coincidencias = []

for diccionario in lista_diccionarios:
    body_params = {
        "amie": diccionario["codAmie"],
        "codAnoLectivo": diccionario["codAnioLectivo"],
        "codigoRegimen": diccionario["codRegimen"]
    }
    df_coincidencias = descargar_datos(oferta_educativa , header_authorization, body_params)
    dataframes_coincidencias.append(df_coincidencias)

oferta_e = pd.concat(dataframes_coincidencias, ignore_index=True)

oferta_e.to_pickle("oferta_e.pkl")















