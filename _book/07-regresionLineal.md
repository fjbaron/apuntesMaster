# (PART) Curso estadística avanzada {-}

# Regresión lineal múltiple
Utilizamos regresión lineal múltiple cuando estudiamos la posible relación entre varias variables independientes (predictoras o explicativas) y otra variable dependiente (criterio, explicada, respuesta).

Por ejemplo, podemos estar interesados en saber cómo influyen en la presión arterial sistólica de un paciente el peso, la edad y el sexo, donde la variable sexo es una variable dicotómica (o indicadora), codificada como 0 para las mujeres y 1 para los hombres. 


La técnica de regresión múltiple se usa frecuentemente en investigación. Se aplica al caso en que la variable respuesta es de tipo numérico. Cuando la respuesta es de tipo dicotómico (muere/vive, enferma/no enferma), usamos otra técnica denominada regresión logística y que tratamos en un capítulo posterior.

#### Ejemplo {-}
Descargamos la base de datos que hemos usado en ocasiones anteriores [centroSalud-transversal.sav](datos/centroSalud-transversal.sav) y exploramos algunas las primeras líneas de las variables *sexo, edad, peso y pas*:


```r
df=read_sav("datos/centroSalud-transversal.sav", user_na=FALSE) %>% haven::as_factor()
```

```r
df %>% select(sexo,edad,peso,pas) %>% head()  %>% knitr::kable(booktabs=T)
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> sexo </th>
   <th style="text-align:right;"> edad </th>
   <th style="text-align:right;"> peso </th>
   <th style="text-align:right;"> pas </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Hombre </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 130 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hombre </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 155 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hombre </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 96 </td>
   <td style="text-align:right;"> 158 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mujer </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:right;"> 134 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mujer </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:right;"> 150 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hombre </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:right;"> 144 </td>
  </tr>
</tbody>
</table>
Estudiamos el modelo de regresión lineal donde intentamos estudiar la inflencia de *sexo, edad, peso* en *pas*:

```r
df %>% lm(pas ~ sexo+edad+peso, data=.) %>% model_parameters(show.se = TRUE,summary = TRUE) %>% print_html()
```

```{=html}
<div id="eziaqroyfj" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#eziaqroyfj .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#eziaqroyfj .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#eziaqroyfj .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#eziaqroyfj .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#eziaqroyfj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#eziaqroyfj .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#eziaqroyfj .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#eziaqroyfj .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#eziaqroyfj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#eziaqroyfj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#eziaqroyfj .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#eziaqroyfj .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#eziaqroyfj .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#eziaqroyfj .gt_from_md > :first-child {
  margin-top: 0;
}

#eziaqroyfj .gt_from_md > :last-child {
  margin-bottom: 0;
}

#eziaqroyfj .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#eziaqroyfj .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#eziaqroyfj .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#eziaqroyfj .gt_row_group_first td {
  border-top-width: 2px;
}

#eziaqroyfj .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#eziaqroyfj .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#eziaqroyfj .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#eziaqroyfj .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#eziaqroyfj .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#eziaqroyfj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#eziaqroyfj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#eziaqroyfj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#eziaqroyfj .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#eziaqroyfj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#eziaqroyfj .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#eziaqroyfj .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#eziaqroyfj .gt_left {
  text-align: left;
}

#eziaqroyfj .gt_center {
  text-align: center;
}

#eziaqroyfj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#eziaqroyfj .gt_font_normal {
  font-weight: normal;
}

#eziaqroyfj .gt_font_bold {
  font-weight: bold;
}

#eziaqroyfj .gt_font_italic {
  font-style: italic;
}

#eziaqroyfj .gt_super {
  font-size: 65%;
}

#eziaqroyfj .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#eziaqroyfj .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#eziaqroyfj .gt_indent_1 {
  text-indent: 5px;
}

#eziaqroyfj .gt_indent_2 {
  text-indent: 10px;
}

#eziaqroyfj .gt_indent_3 {
  text-indent: 15px;
}

#eziaqroyfj .gt_indent_4 {
  text-indent: 20px;
}

#eziaqroyfj .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">Parameter</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">Coefficient</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">SE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">95% CI</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">t(348)</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">p</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">(Intercept)</td>
<td class="gt_row gt_center">96.10</td>
<td class="gt_row gt_center">10.19</td>
<td class="gt_row gt_center">(76.06, 116.13)</td>
<td class="gt_row gt_center">9.43</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
    <tr><td class="gt_row gt_left">sexo (Mujer)</td>
<td class="gt_row gt_center">5.38</td>
<td class="gt_row gt_center">2.13</td>
<td class="gt_row gt_center">(1.19, 9.58)</td>
<td class="gt_row gt_center">2.52</td>
<td class="gt_row gt_center">0.012 </td></tr>
    <tr><td class="gt_row gt_left">edad</td>
<td class="gt_row gt_center">0.45</td>
<td class="gt_row gt_center">0.10</td>
<td class="gt_row gt_center">(0.26, 0.65)</td>
<td class="gt_row gt_center">4.54</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
    <tr><td class="gt_row gt_left">peso</td>
<td class="gt_row gt_center">0.18</td>
<td class="gt_row gt_center">0.08</td>
<td class="gt_row gt_center">(0.03, 0.33)</td>
<td class="gt_row gt_center">2.30</td>
<td class="gt_row gt_center">0.022 </td></tr>
  </tbody>
  <tfoot class="gt_sourcenotes">
    <tr>
      <td class="gt_sourcenote" colspan="6">Model: pas ~ sexo + edad + peso (352 Observations)<br/>Residual standard deviation: 18.791 (df = 348)<br/>R2: 0.077; adjusted R2: 0.069</td>
    </tr>
  </tfoot>
  
</table>
</div>
```

Esta salida de se puede interpretar  como que el mejor modelo lineal para explicar la *pas* a partir de las variables elegidas es:

$$ pas = 100.5 +4.9 sexoMujer + 0.41 * edad + 0.13*peso $$
O como resulta normalmente más interesante de interpretar:

- A igualdad de peso y edad, una mujer suele tener una pas 4.9 mmHG más alta que un hombre.

- A igualdad de sexo y peso, los individuos aumentan 0.41 mmHg de pas cada año que cumplen.

- A igualdad de sexo y edad, la pas sube 0.13 mmHg por cada kg de peso que aumentan.


Cada una de esas estimaciones se muestra con su respectivo error estándar y significación. La significación del sexo por ejemplo, se interpreta como que a igualdad de peso y edad, las mujeres muestran unos valores medios de pas que son significativamente diferentes de cero.


También es habitual el mostrar, además de los coeficientes ajustados (multivariable), los coeficientes crudos (univariable), que son los que se obtendrían al analizar de forma separada la variable dependiente con cada una de las independientes. Presentar las tablas así permite identificar variables confusoras.


```r
tabla=df %>% finalfit(dependent = "pas", explanatory=c("sexo","edad","peso"),metrics = TRUE)  
```




<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Dependent: Presión arterial sistólica medida en mmHg </th>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> unit </th>
   <th style="text-align:left;"> value </th>
   <th style="text-align:left;"> OR (univariable) </th>
   <th style="text-align:left;"> OR (multivariable) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Sexo del paciente </td>
   <td style="text-align:left;"> Hombre </td>
   <td style="text-align:left;"> Mean (sd) </td>
   <td style="text-align:left;"> 139.6 (20.7) </td>
   <td style="text-align:left;"> - </td>
   <td style="text-align:left;"> - </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> Mujer </td>
   <td style="text-align:left;"> Mean (sd) </td>
   <td style="text-align:left;"> 145.1 (18.5) </td>
   <td style="text-align:left;"> 5.49 (1.30 to 9.69, p=0.010) </td>
   <td style="text-align:left;"> 5.38 (1.19 to 9.58, p=0.012) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Edad del paciente en años </td>
   <td style="text-align:left;"> [31.0,92.0] </td>
   <td style="text-align:left;"> Mean (sd) </td>
   <td style="text-align:left;"> 143.1 (19.5) </td>
   <td style="text-align:left;"> 0.42 (0.23 to 0.61, p&lt;0.001) </td>
   <td style="text-align:left;"> 0.45 (0.26 to 0.65, p&lt;0.001) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Peso del paciente </td>
   <td style="text-align:left;"> [46.5,150.0] </td>
   <td style="text-align:left;"> Mean (sd) </td>
   <td style="text-align:left;"> 143.1 (19.5) </td>
   <td style="text-align:left;"> 0.04 (-0.11 to 0.19, p=0.592) </td>
   <td style="text-align:left;"> 0.18 (0.03 to 0.33, p=0.022) </td>
  </tr>
</tbody>
</table>

<table>
<tbody>
  <tr>
   <td style="text-align:left;"> Number in dataframe = 352, Number in model = 352, Missing = 0, Log-likelihood = -1530, AIC = 3070, R-squared = 0.077, Adjusted R-squared = 0.069 </td>
  </tr>
</tbody>
</table>

Para obtener los resultados anteriores en SPSS usaríamos el menú *-Analizar - Regresión - Lineales*,
 colocaríamos en *dependientes* las variable pas, y en independientes el resto.
 
 


## Aplicaciones de la regresión múltiple
Es cierto que la regresión múltiple se utiliza para la predicción de respuestas a partir de variables explicativas. Pero no es ésta realmente la aplicación que se le suele dar en investigación. Los usos que con mayor frecuencia encontraremos en las publicaciones son los siguientes:

-	Identificación de variables explicativas. Nos ayuda a crear un modelo donde se seleccionen las variables que puedan influir en la respuesta, descartando aquellas que no aporten información.

-	Detección de interacciones entre variables independientes que afectan a la variable respuesta. Un ejemplo de interacción clásico es el de estudiar la respuesta de un paciente al alcohol y a un barbitúrico, y observar que cuando se ingieren ambos, el efecto es mucho mayor del esperado como suma de los dos.

-	Identificación de variables confusoras. Es un problema difícil el de su detección, pero de interés en investigación no experimental, ya que el investigador frecuentemente no tiene control sobre las variables independientes.

## Requisitos y limitaciones

Hay ciertos requerimientos necesarios para poder utilizar la técnica de regresión múltiple:

-	Linealidad: Se supone que la variable respuesta depende linealmente de las variables explicativas. Si la respuesta no aparenta ser lineal, debemos introducir en el modelo componentes no lineales (como incluir transformaciones no lineales de las variables independientes en el modelo). Otro tipo de respuesta no lineal es la interacción. Para ello se ha de incluir en el modelo términos de interacción, que equivalen a introducir nuevas variables explicativas que en realidad son el producto de dos o más de las independientes.

-	Normalidad y equidistribución de los residuos: Se llaman residuos las diferencias entre los valores calculados por el modelo y los realmente observados en la variable dependiente. Para tener un buen modelo de regresión no es suficiente con que los residuos sean pequeños. La validez del modelo requiere, en teoríam que los mismos se distribuyan de modo normal y con la misma dispersión para cada combinación de valores de las variables independientes. Por supuesto, esta condición en la práctica es inverificable, puesto que para cada combinación de variables independientes tendremos normalmente ninguna o una respuesta. Lo que se suele hacer es examinar una serie de gráficos de residuos que nos hagan sospechar. Por ejemplo si los residuos aumentan al aumentar la  respuesta, o vemos que aparecen tendencias,… Es decir, hay una serie de reglas heurísticas que nos ayudan a decidir si aceptar o no el modelo de regresión, pero no están basadas en contrastes de hipótesis como hemos usado hasta ahora. Es la experiencia del investigador observando residuos la que le decide a usarlo o no.


-	Número de variables independientes: Podemos estar tentados en incluir en el modelo cualquier cosa que tengamos en una base de datos, con la esperanza de que cuantas más variables incluyamos, más posibilidades hay de que “suene la flauta”. Si nos aborda esta tentación, hemos de recordar que corremos el riesgo de cometer error de tipo I. Otra razón es que si esperamos ajustar unas pocas observaciones usando muchas variables, muy probablemente consigamos una aproximación muy artificial, y además muy sensible a los valores observados. La inclusión de una nueva observación puede cambiar completamente el valor de los coeficientes del modelo. Una regla que se suele recomendar es la de incluir *al menos 20 observaciones por cada variable independiente* que estimemos a priori interesantes en el modelo. 

-	Colinealidad: Si dos variables independientes están estrechamente relacionadas (consumo de refrescos y temperatura ambiente por ejemplo) y ambas son incluidas en un modelo, muy posiblemente ninguna de las dos sea considerada significativa, aunque si hubiésemos incluido sólo una de ellas, sí. Hay diferentes técnicas para detectar la colinealidad pero que requieren profundizar en documentos más sofisticados. Aquí vamos a indicar una técnica muy simple: examinar los coeficientes del modelo para ver si se vuelven inestables al introducir una nueva variable. Si es así posiblemente hay colinealidad entre la nueva variable y las anteriores.

-	Observaciones anómalas: Está muy relacionada con la cuestión de los residuos, pero merece destacarlo aparte. Debemos poner especial cuidado en identificarlas (y descartarlas si procede), pues tienen gran influencia en el resultado. A veces, son sólo errores en la entrada de datos, pero de gran consecuencia en el análisis. Hay técnicas de regresión robustas que permiten minimizar su efecto.

## Variables numéricas e indicadoras (dummy)
Un modelo de regresión lineal tiene el aspecto:
 
 $$ Y = b_0 +b_1 X_1 + b_2 X_2+...+b_n X_n $$
donde:

-	Y es la variable dependiente

-	Los términos  $X_i$ representan las variables independientes o explicativas

-	Los coeficientes del modelo, $b_i$  son calculados por el programa estadístico, de mode que se minimicen los residuos.

Esencialmente cuando obtengamos para los coeficientes valores “compatibles” con cero (no significativos), la variable asociada se elimina del modelo, y en otro caso se considera a la variable asociada de interés. Esta regla no hay que aplicarla ciegamente. Si por ejemplo la variable con coeficiente no significativo se observa que es confusora o laliteratura nos indica que debe ser tenida en cuenta en el análisis, debemos considerarla como parte del modelo, bien explícitamente o estratificando la muestra según los diferentes valores de la misma.

Está claro que para ajustar el modelo la variable respuesta debe ser numérica. Sin embargo, aunque pueda parecer extraño no tienen por qué serlo las variables explicativas. Aunque requiere un artificio, podemos utilizar predictores categóricos mediante la introducción de variables indicadoras (también denominadas mudas o dummy)

Si una variable es dicotómica, puede ser codificada como 0 ó 1. Así si estudiamos la explicación del peso de una persona como función de su altura y su sexo, un modelo como:
$$Peso =-100 + 1 \times Altura - 5\times Sexo$$

donde se ha codificado con Sexo=0 a los hombres y Sexo=1 a las mujeres, puede ser interpretado como que las mujeres, a igualdad de altura, pesan de media 5 Kg menos que los hombres. El coeficiente 1 de la altura, se interpreta como que por cada diferencia de altura de un centímetro en personas que tienen el resto de variables independientes iguales (mismo sexo), el peso aumenta, por término medio, en **1** kg.

#### Ejemplo
La base de datos [peso_altura_sexo.sav](datos/peso_altura_sexo.sav) contiene datos simulados que han sido contruidos para dar un modelo de regresión similar al descrito anteriormente. Una analisis de regresión nos ofrecería por resultado:


```r
df=read_sav("datos/peso_altura_sexo.sav") %>% haven::as_factor()
df %>% lm(Peso ~ Sexo+ Altura, data=.) %>% model_parameters(show.se = TRUE,summary = TRUE) %>% print_html()
```

```{=html}
<div id="xcifrbuwah" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#xcifrbuwah .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#xcifrbuwah .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#xcifrbuwah .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#xcifrbuwah .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#xcifrbuwah .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xcifrbuwah .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#xcifrbuwah .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#xcifrbuwah .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#xcifrbuwah .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#xcifrbuwah .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#xcifrbuwah .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#xcifrbuwah .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#xcifrbuwah .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#xcifrbuwah .gt_from_md > :first-child {
  margin-top: 0;
}

#xcifrbuwah .gt_from_md > :last-child {
  margin-bottom: 0;
}

#xcifrbuwah .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#xcifrbuwah .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#xcifrbuwah .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#xcifrbuwah .gt_row_group_first td {
  border-top-width: 2px;
}

#xcifrbuwah .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xcifrbuwah .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#xcifrbuwah .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#xcifrbuwah .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xcifrbuwah .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xcifrbuwah .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#xcifrbuwah .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#xcifrbuwah .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xcifrbuwah .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#xcifrbuwah .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#xcifrbuwah .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#xcifrbuwah .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#xcifrbuwah .gt_left {
  text-align: left;
}

#xcifrbuwah .gt_center {
  text-align: center;
}

#xcifrbuwah .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#xcifrbuwah .gt_font_normal {
  font-weight: normal;
}

#xcifrbuwah .gt_font_bold {
  font-weight: bold;
}

#xcifrbuwah .gt_font_italic {
  font-style: italic;
}

#xcifrbuwah .gt_super {
  font-size: 65%;
}

#xcifrbuwah .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#xcifrbuwah .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#xcifrbuwah .gt_indent_1 {
  text-indent: 5px;
}

#xcifrbuwah .gt_indent_2 {
  text-indent: 10px;
}

#xcifrbuwah .gt_indent_3 {
  text-indent: 15px;
}

#xcifrbuwah .gt_indent_4 {
  text-indent: 20px;
}

#xcifrbuwah .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">Parameter</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">Coefficient</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">SE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">95% CI</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">t(197)</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">p</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">(Intercept)</td>
<td class="gt_row gt_center">-94.62</td>
<td class="gt_row gt_center">8.03</td>
<td class="gt_row gt_center">(-110.45, -78.78)</td>
<td class="gt_row gt_center">-11.78</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
    <tr><td class="gt_row gt_left">Sexo (Mujer)</td>
<td class="gt_row gt_center">-4.92</td>
<td class="gt_row gt_center">0.68</td>
<td class="gt_row gt_center">(-6.26, -3.58)</td>
<td class="gt_row gt_center">-7.24</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
    <tr><td class="gt_row gt_left">Altura</td>
<td class="gt_row gt_center">0.97</td>
<td class="gt_row gt_center">0.05</td>
<td class="gt_row gt_center">(0.88, 1.06)</td>
<td class="gt_row gt_center">20.62</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
  </tbody>
  <tfoot class="gt_sourcenotes">
    <tr>
      <td class="gt_sourcenote" colspan="6">Model: Peso ~ Sexo + Altura (200 Observations)<br/>Residual standard deviation: 4.564 (df = 197)<br/>R2: 0.749; adjusted R2: 0.746</td>
    </tr>
  </tfoot>
  
</table>
</div>
```



### Ejemplo: Regresión lineal generaliza a las pruebas t-student para dos muestras, y ANOVA de un factor {-}
Observe que el modelo de regresión múltiple generaliza a otras técnicas estadísticas que conocemos a estas alturas como el modelo t-student para 2 muestras independientes o ANOVA de un factor. Un contraste de dos medias independientes puede resolverse con una regresión de la variable respuesta en función de una variable indicadora que identifica sendas muestras. Un modelo ANOVA de un factor se puede expresar usando variables indicadoras suficientes para codificar el grupo. Para poder interpretar cómodamente los resultados es importante que los grupos sean equilibrados (cada muestra debe tener un número similar de elementos).

## Bondad de ajuste
Al ajustar un modelo de regresión es necesario mostar un término denominado $R^2$, **bondad de ajuste**, o **porcentaje de variabilidad exolicado por el modelo** o bien, **coeficiente de determinación**. Se interpreta del siguiente modo: La variable respuesta presenta cierta variabilidad (incertidumbre), pero cuando se conoce el valor de las variables independientes, dicha incertidumbre disminuye. El término R cuadrado es una cantidad que puede interpretarse como un factor (porcentaje) de reducción de la incertidumbre cuando son conocidas las variables independientes. Cuanto más se acerque a uno, más poder explicativo tendrá el modelo. Pero esto esconde una trampa. Cada vez que introducimos una nueva variable independiente en el modelo, R cuadrado no puede hacer otra cosa que aumentar. Si introducimos un número artificialmente grande de ellas, podremos llegar a acercarla a uno tanto como queramos.

> Para practicar con $R^2$, en un modelo de regresión [siga este enlace](https://www.bioestadistica.uma.es/analisis/correlacion/):

Los programas estadísticos nos muestran un término R cuadrado corregida, que puede interpretarse como una corrección de honestidad. Nos castigará disminuyendo cuando introduzcamos variables innecesarias. Si al ir complicando el modelo este término aumenta una cantidad “razonable”, podemos considerarlo posiblemente una variable de interés, pero si disminuye, deberíamos pensar dos veces si nos merece la pena la complejidad del modelo para tan poco beneficio.


## Matriz de correlaciones
La matriz de correlaciones nos ayuda a identificar correlaciones lineales entre pares de variables. Encontrar correlaciones lineales entre la variable dependiente y cualquiera de las independientes es siempre de interés. Pero es una mala señal la alta correlación entre variables independientes y tal vez nos haga excluir alguna del modelo, por contener información muy similar.

La matriz de correlaciones está formada por todos los coeficientes de correlación lineal de Pearson para cada par de variables. Los mismos son cantidades que pueden tomar valores comprendidos entre -1 y +1. Cuanto más extremo sea el coeficiente, mejor asociación lineal existe entre el par de variables. Cuando es cercano a cero, no. El signo positivo del coeficiente nos indica que la asociación es directa (cuando una variable crece la otra también). Un valor negativo indica que la relación es inversa (cuando una crece, la otra decrece).

## Variables confusoras
Dos variables o más variables están confundidas cuando sus efectos sobre la variable dependiente no pueden ser separados. Dicho de otra forma, una variable es confusora cuando estando relacionada con alguna variable independiente, a su vez afecta a la dependiente.

Cuando se identifica una variable que está confundida con alguna de las variables independientes significativa, es necesario dejarla formar parte del modelo, tenga o no mucha significación. Las variables confusoras no pueden ser ignoradas.

Puede ayudarnos a identificar una variable confusora el encontrarnos con un modelo en el que una variable independiente parece tener cierta influencia significativa del signo que sea en la variable respuesta, pero al incluir una nueva variable previamente ignorada (variable confusora) se observa que la primera tiene una influencia claramente diferente (incluso con el signo cambiado y aún significativa). El simple hecho de que lo anteriormente mencionado ocurra, no es la prueba de que ambas variables estén confundidas, pero nos invita a reflexionar.
 
###Ejemplo {-}

Vamos a retomar un ejemplo que desarrollamos en el capítulo donde tratábamos la técnica ANOVA, para usar con él un modelo de regresión múltiple: [lectura-anova.sav](datos/lectura-anova.sav).


```r
df=read_sav("datos/lectura-anova.sav", user_na=FALSE) %>% haven::as_factor() 
```


```r
df %>% head()  %>% knitr::kable(booktabs=T)
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Grupo </th>
   <th style="text-align:right;"> Antes </th>
   <th style="text-align:right;"> Despues </th>
   <th style="text-align:right;"> Diferencia </th>
   <th style="text-align:right;"> gr1 </th>
   <th style="text-align:right;"> gr2 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 10.0 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 9.3 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 7.0 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 13.0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Técnica I </td>
   <td style="text-align:right;"> 6.5 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 16.2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Técnica I </td>
   <td style="text-align:right;"> 9.5 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 9.5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Control </td>
   <td style="text-align:right;"> 7.5 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 8.5 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Técnica II </td>
   <td style="text-align:right;"> 7.5 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 9.5 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
</tbody>
</table>

Recordamos que se realizó un experimento para comparar tres métodos de aprendizaje de lectura. Se asignó aleatoriamente los estudiantes a cada uno de los tres métodos. Cada método fue probado con 22 estudiantes. Se evaluó mediante diferentes pruebas la capacidad de comprensión de los estudiantes, antes y después de recibir la instrucción. Por tanto tenemos 3 variables numéricas que son la capacidad al inicio del experimento, al final, y la que resulta más interesante, la diferencia. 

Podemos usar la pareja de variables *gr1 y gr2* como indicadoras de pertenencia al *Grupo*. Un análisis de regresión lineal nos ofrece el mismo resultado que la prueba ANOVA. Compruebe la diferencia existente entre la salida del modelo de regresión lineal con las variables indicadoras:


```r
df %>% lm(Diferencia ~ gr1 + gr2, data=.) %>% model_parameters(show.se = TRUE,summary = TRUE) %>% print_html()
```

```{=html}
<div id="whpvbnmpdh" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#whpvbnmpdh .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#whpvbnmpdh .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#whpvbnmpdh .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#whpvbnmpdh .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#whpvbnmpdh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#whpvbnmpdh .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#whpvbnmpdh .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#whpvbnmpdh .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#whpvbnmpdh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#whpvbnmpdh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#whpvbnmpdh .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#whpvbnmpdh .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#whpvbnmpdh .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#whpvbnmpdh .gt_from_md > :first-child {
  margin-top: 0;
}

#whpvbnmpdh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#whpvbnmpdh .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#whpvbnmpdh .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#whpvbnmpdh .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#whpvbnmpdh .gt_row_group_first td {
  border-top-width: 2px;
}

#whpvbnmpdh .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#whpvbnmpdh .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#whpvbnmpdh .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#whpvbnmpdh .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#whpvbnmpdh .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#whpvbnmpdh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#whpvbnmpdh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#whpvbnmpdh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#whpvbnmpdh .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#whpvbnmpdh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#whpvbnmpdh .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#whpvbnmpdh .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#whpvbnmpdh .gt_left {
  text-align: left;
}

#whpvbnmpdh .gt_center {
  text-align: center;
}

#whpvbnmpdh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#whpvbnmpdh .gt_font_normal {
  font-weight: normal;
}

#whpvbnmpdh .gt_font_bold {
  font-weight: bold;
}

#whpvbnmpdh .gt_font_italic {
  font-style: italic;
}

#whpvbnmpdh .gt_super {
  font-size: 65%;
}

#whpvbnmpdh .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#whpvbnmpdh .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#whpvbnmpdh .gt_indent_1 {
  text-indent: 5px;
}

#whpvbnmpdh .gt_indent_2 {
  text-indent: 10px;
}

#whpvbnmpdh .gt_indent_3 {
  text-indent: 15px;
}

#whpvbnmpdh .gt_indent_4 {
  text-indent: 20px;
}

#whpvbnmpdh .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">Parameter</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">Coefficient</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">SE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">95% CI</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">t(63)</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">p</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">(Intercept)</td>
<td class="gt_row gt_center">9.87</td>
<td class="gt_row gt_center">0.58</td>
<td class="gt_row gt_center">(8.71, 11.03)</td>
<td class="gt_row gt_center">17.04</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
    <tr><td class="gt_row gt_left">gr1</td>
<td class="gt_row gt_center">3.63</td>
<td class="gt_row gt_center">0.82</td>
<td class="gt_row gt_center">(1.99, 5.27)</td>
<td class="gt_row gt_center">4.43</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
    <tr><td class="gt_row gt_left">gr2</td>
<td class="gt_row gt_center">3.22</td>
<td class="gt_row gt_center">0.82</td>
<td class="gt_row gt_center">(1.58, 4.86)</td>
<td class="gt_row gt_center">3.93</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
  </tbody>
  <tfoot class="gt_sourcenotes">
    <tr>
      <td class="gt_sourcenote" colspan="6">Model: Diferencia ~ gr1 + gr2 (66 Observations)<br/>Residual standard deviation: 2.717 (df = 63)<br/>R2: 0.272; adjusted R2: 0.249</td>
    </tr>
  </tfoot>
  
</table>
</div>
```
y la salida del modelo ANOVA de un factor:


```r
modelo1=df %>% lm(Diferencia ~ Grupo, data=.) 
modelo1 %>% model_parameters(show.se = TRUE,summary = TRUE) %>% print_html()
```

```{=html}
<div id="vpciiigrta" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#vpciiigrta .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#vpciiigrta .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#vpciiigrta .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#vpciiigrta .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#vpciiigrta .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vpciiigrta .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#vpciiigrta .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#vpciiigrta .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#vpciiigrta .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#vpciiigrta .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#vpciiigrta .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#vpciiigrta .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#vpciiigrta .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#vpciiigrta .gt_from_md > :first-child {
  margin-top: 0;
}

#vpciiigrta .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vpciiigrta .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#vpciiigrta .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#vpciiigrta .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#vpciiigrta .gt_row_group_first td {
  border-top-width: 2px;
}

#vpciiigrta .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vpciiigrta .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#vpciiigrta .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#vpciiigrta .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vpciiigrta .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vpciiigrta .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#vpciiigrta .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#vpciiigrta .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vpciiigrta .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#vpciiigrta .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vpciiigrta .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#vpciiigrta .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vpciiigrta .gt_left {
  text-align: left;
}

#vpciiigrta .gt_center {
  text-align: center;
}

#vpciiigrta .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vpciiigrta .gt_font_normal {
  font-weight: normal;
}

#vpciiigrta .gt_font_bold {
  font-weight: bold;
}

#vpciiigrta .gt_font_italic {
  font-style: italic;
}

#vpciiigrta .gt_super {
  font-size: 65%;
}

#vpciiigrta .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#vpciiigrta .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#vpciiigrta .gt_indent_1 {
  text-indent: 5px;
}

#vpciiigrta .gt_indent_2 {
  text-indent: 10px;
}

#vpciiigrta .gt_indent_3 {
  text-indent: 15px;
}

#vpciiigrta .gt_indent_4 {
  text-indent: 20px;
}

#vpciiigrta .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">Parameter</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">Coefficient</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">SE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">95% CI</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">t(63)</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">p</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">(Intercept)</td>
<td class="gt_row gt_center">9.87</td>
<td class="gt_row gt_center">0.58</td>
<td class="gt_row gt_center">(8.71, 11.03)</td>
<td class="gt_row gt_center">17.04</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
    <tr><td class="gt_row gt_left">Grupo (Técnica I)</td>
<td class="gt_row gt_center">3.63</td>
<td class="gt_row gt_center">0.82</td>
<td class="gt_row gt_center">(1.99, 5.27)</td>
<td class="gt_row gt_center">4.43</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
    <tr><td class="gt_row gt_left">Grupo (Técnica II)</td>
<td class="gt_row gt_center">3.22</td>
<td class="gt_row gt_center">0.82</td>
<td class="gt_row gt_center">(1.58, 4.86)</td>
<td class="gt_row gt_center">3.93</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
  </tbody>
  <tfoot class="gt_sourcenotes">
    <tr>
      <td class="gt_sourcenote" colspan="6">Model: Diferencia ~ Grupo (66 Observations)<br/>Residual standard deviation: 2.717 (df = 63)<br/>R2: 0.272; adjusted R2: 0.249</td>
    </tr>
  </tfoot>
  
</table>
</div>
```
Realmente las dos formas de escribir el análisis han hecho exactamente lo mismo internamente.

Podemos refinar el estudio del siguiente modo: 

-	Variable dependiente: La diferencia entre la capacidad “después” y “antes”.

-	Variables explicativas:

  -	La capacidad al inicio del experimento. Posiblemente los estudiantes con mejor capacidad inicial sacaron menos provecho que el resto.
  
  - La técnica utilizada. Como es una variable categórica que se utiliza para identificar la muestra y tiene tres categorías podemos codificarla usando dos variables indicadoras (**gr1 y gr2**, o lo que será equivalente, considerar solo la variable *Grupo*).

El resultado del análisis sería:


```r
modelo2=df %>% lm(Diferencia ~ Grupo+Antes, data=.) 

modelo2%>% model_parameters(show.se = TRUE,summary = TRUE) %>% print_html()
```

```{=html}
<div id="nqcarpqvyv" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#nqcarpqvyv .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#nqcarpqvyv .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#nqcarpqvyv .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#nqcarpqvyv .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#nqcarpqvyv .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nqcarpqvyv .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#nqcarpqvyv .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#nqcarpqvyv .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#nqcarpqvyv .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#nqcarpqvyv .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#nqcarpqvyv .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#nqcarpqvyv .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#nqcarpqvyv .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#nqcarpqvyv .gt_from_md > :first-child {
  margin-top: 0;
}

#nqcarpqvyv .gt_from_md > :last-child {
  margin-bottom: 0;
}

#nqcarpqvyv .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#nqcarpqvyv .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#nqcarpqvyv .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#nqcarpqvyv .gt_row_group_first td {
  border-top-width: 2px;
}

#nqcarpqvyv .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nqcarpqvyv .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#nqcarpqvyv .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#nqcarpqvyv .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nqcarpqvyv .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nqcarpqvyv .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#nqcarpqvyv .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#nqcarpqvyv .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nqcarpqvyv .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#nqcarpqvyv .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nqcarpqvyv .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#nqcarpqvyv .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nqcarpqvyv .gt_left {
  text-align: left;
}

#nqcarpqvyv .gt_center {
  text-align: center;
}

#nqcarpqvyv .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#nqcarpqvyv .gt_font_normal {
  font-weight: normal;
}

#nqcarpqvyv .gt_font_bold {
  font-weight: bold;
}

#nqcarpqvyv .gt_font_italic {
  font-style: italic;
}

#nqcarpqvyv .gt_super {
  font-size: 65%;
}

#nqcarpqvyv .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#nqcarpqvyv .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#nqcarpqvyv .gt_indent_1 {
  text-indent: 5px;
}

#nqcarpqvyv .gt_indent_2 {
  text-indent: 10px;
}

#nqcarpqvyv .gt_indent_3 {
  text-indent: 15px;
}

#nqcarpqvyv .gt_indent_4 {
  text-indent: 20px;
}

#nqcarpqvyv .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">Parameter</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">Coefficient</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">SE</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">95% CI</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">t(62)</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col">p</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">(Intercept)</td>
<td class="gt_row gt_center">13.56</td>
<td class="gt_row gt_center">1.29</td>
<td class="gt_row gt_center">(10.97, 16.14)</td>
<td class="gt_row gt_center">10.49</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
    <tr><td class="gt_row gt_left">Grupo (Técnica I)</td>
<td class="gt_row gt_center">3.41</td>
<td class="gt_row gt_center">0.77</td>
<td class="gt_row gt_center">(1.87, 4.95)</td>
<td class="gt_row gt_center">4.42</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
    <tr><td class="gt_row gt_left">Grupo (Técnica II)</td>
<td class="gt_row gt_center">2.83</td>
<td class="gt_row gt_center">0.78</td>
<td class="gt_row gt_center">(1.27, 4.38)</td>
<td class="gt_row gt_center">3.64</td>
<td class="gt_row gt_center">&lt; .001</td></tr>
    <tr><td class="gt_row gt_left">Antes</td>
<td class="gt_row gt_center">-0.47</td>
<td class="gt_row gt_center">0.15</td>
<td class="gt_row gt_center">(-0.76, -0.17)</td>
<td class="gt_row gt_center">-3.14</td>
<td class="gt_row gt_center">0.003 </td></tr>
  </tbody>
  <tfoot class="gt_sourcenotes">
    <tr>
      <td class="gt_sourcenote" colspan="6">Model: Diferencia ~ Grupo + Antes (66 Observations)<br/>Residual standard deviation: 2.544 (df = 62)<br/>R2: 0.372; adjusted R2: 0.342</td>
    </tr>
  </tfoot>
  
</table>
</div>
```

Obsérvese que al mejorar $R^2$ hemos obtenido un mejor modelo explicativo, independientemente de que nos interese o no la significación de la nueva variable introducida. En ocasiones es útil mostrar una comparativa entre varios modelos. La forma que se suele dar a la tabla para compararlos es la siguiente:






```r
tab_model(modelo1, modelo2,show.se = FALSE,show.aic = TRUE) %>% .[["knitr"]] %>% asis_output()
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="3" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">Diferencia</th>
<th colspan="3" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">Diferencia</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  col7">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">(Intercept)</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">9.87</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">8.71&nbsp;&ndash;&nbsp;11.03</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</strong></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">13.56</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">10.97&nbsp;&ndash;&nbsp;16.14</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7"><strong>&lt;0.001</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">Grupo: Técnica I</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">3.63</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.99&nbsp;&ndash;&nbsp;5.27</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</strong></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">3.41</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.87&nbsp;&ndash;&nbsp;4.95</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7"><strong>&lt;0.001</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">Grupo: Técnica II</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">3.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.58&nbsp;&ndash;&nbsp;4.86</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</strong></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">2.83</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.27&nbsp;&ndash;&nbsp;4.38</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7"><strong>0.001</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">Antes</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">&#45;0.47</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">&#45;0.76&nbsp;&ndash;&nbsp;-0.17</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7"><strong>0.003</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">66</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">66</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / R<sup>2</sup> adjusted</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">0.272 / 0.249</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">0.372 / 0.342</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">AIC</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">324.178</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="3">316.416</td>
</tr>

</table>

Podríamos interpretar que el segundo modelo es preferible al primero. Tiene no solo mejor $R^2$ (cuanto más alto, mejor), si no que otro indicador, **AIC** (*Akaike Information Criteria*), tiene un valor más bajo (cuanto más bajo, mejor a la hora de decidir entre múltiples modelos).


Para hacer lo mismo en SPSS, no se puede utilizar como hemos hecho aquí la variable *Grupo*, pero sí las dos indicadoras (*gr1 y gr2*) que contienen la misma información. Para ello vamos a la opción de menú “Analizar – Regresión - Lineales”, y situamos en su lugar las variables independientes y la dependiente.

 

