import pandas as pd
import sqlite3
from datetime import datetime

def main():
    archivo = "lista_clientes.csv"  # Cambia si el tuyo tiene otro nombre

    print("Cargando datos...")
    df = pd.read_csv(archivo)

    # Renombrar columnas
    df = df.rename(columns={
        "Fecha de nacimiento": "fecha_nacimiento",
        "Fecha de alta": "fecha_alta",
        "Grupo de clientes": "grupo"
    })

    # Convertir a fecha
    df["fecha_nacimiento"] = pd.to_datetime(df["fecha_nacimiento"], errors="coerce")
    df["fecha_alta"] = pd.to_datetime(df["fecha_alta"], errors="coerce")

    # Calcular edad y antigüedad
    hoy = pd.Timestamp.today()
    df["Edad"] = df["fecha_nacimiento"].apply(
        lambda x: hoy.year - x.year - ((hoy.month, hoy.day) < (x.month, x.day))
        if pd.notnull(x) else None
    )
    df["Antiguedad"] = df["fecha_alta"].apply(
        lambda x: hoy.year - x.year - ((hoy.month, hoy.day) < (x.month, x.day))
        if pd.notnull(x) else None
    )

    # Seleccionar solo las columnas necesarias
    columnas_seleccionadas = ["ID", "Nombre completo", "fecha_nacimiento", "fecha_alta", "grupo", "Edad", "Antiguedad"]
    df_detalle = df[columnas_seleccionadas]

    # Guardar detalle filtrado
    df_detalle.to_csv("clientes_detalle.csv", index=False, encoding="utf-8-sig")
    print("✅ Datos filtrados guardados en 'clientes_detalle.csv'.")

    # Conexión a base de datos
    conn = sqlite3.connect("clientes.db")
    df_detalle.to_sql("clientes_detalle", conn, if_exists="replace", index=False)

    # Crear resumen por grupo
    resumen = df.groupby("grupo").agg(
        Promedio_Edad=("Edad", "mean"),
        Edad_Max=("Edad", "max"),
        Edad_Min=("Edad", "min"),
        Promedio_Antiguedad=("Antiguedad", "mean"),
        Antiguedad_Max=("Antiguedad", "max"),
        Antiguedad_Min=("Antiguedad", "min")
    ).reset_index()

    # Guardar resumen en CSV
    resumen.to_csv("clientes_resumen.csv", index=False, encoding="utf-8-sig")
    print("✅ Resumen guardado en 'clientes_resumen.csv'.")

    # Guardar resumen en BD
    resumen.to_sql("clientes_resumen", conn, if_exists="replace", index=False)
    conn.close()
    print("✅ Datos insertados en 'clientes.db' (detalle y resumen).")

if __name__ == "__main__":
    main()


