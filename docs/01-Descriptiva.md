---
output:
  pdf_document: default
  html_document: default
---



# Capítulo 1: Exploración de los datos



Cuando abordamos el estudio de un conjunto de datos, antes de introducirnos en cuestiones más detalladas, es necesario hacer una exploración inicial de los mismos. Así podemos tener una idea más clara de las características principales de los datos que hemos recogido, y de las posibles asociaciones.

En primer lugar, daremos unas ideas sobre la manera de presentar ordenadamente y resumir variables consideradas aisladamente de las demás, para después explorar conjuntamente grupos de variables.

## Datos Univariantes
Los métodos para visualizar y resumir los datos dependen de sus tipos, que básicamente diferenciamos en dos: **categóricos** y **numéricos**.

Los datos *categóricos (o factores)* son aquellos que registran categorías o cualidades. Si descargamos esta [base de datos de pacientes](datos/centroSalud-transversal.sav), ejemplos de variables categóricas son el *sexo*, el *estado civil* y el *nivel de estudios*. Dentro de las categóricas podemos a su vez distinguir entre variable **nominal** y **ordinal**. En esta última hay un orden entre las distintas categorías como  se aprecia en la la variable *nivel de estudios* y *tabaqismo*:


```r
df=read_sav("datos/centroSalud-transversal.sav", user_na=FALSE) %>% haven::as_factor()
```

```r
df %>% head() %>% select(sexo:peso) %>% knitr::kable(booktabs=T)
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> sexo </th>
   <th style="text-align:left;"> nivelest </th>
   <th style="text-align:left;"> tabaco </th>
   <th style="text-align:left;"> estcivil </th>
   <th style="text-align:left;"> laboro </th>
   <th style="text-align:right;"> hijos </th>
   <th style="text-align:right;"> edad </th>
   <th style="text-align:right;"> peso </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Hombre </td>
   <td style="text-align:left;"> Primarios </td>
   <td style="text-align:left;"> Ex fumador (10+) años </td>
   <td style="text-align:left;"> Viudo </td>
   <td style="text-align:left;"> Jubilado </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mujer </td>
   <td style="text-align:left;"> Primarios </td>
   <td style="text-align:left;"> Fumador </td>
   <td style="text-align:left;"> Casado/pareja </td>
   <td style="text-align:left;"> Ama de casa </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 72 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mujer </td>
   <td style="text-align:left;"> Primarios </td>
   <td style="text-align:left;"> Fumador </td>
   <td style="text-align:left;"> Casado/pareja </td>
   <td style="text-align:left;"> Trabaja </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 57 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mujer </td>
   <td style="text-align:left;"> Primarios </td>
   <td style="text-align:left;"> Ex fumador (9-) años </td>
   <td style="text-align:left;"> Casado/pareja </td>
   <td style="text-align:left;"> Ama de casa </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mujer </td>
   <td style="text-align:left;"> Sin estudios </td>
   <td style="text-align:left;"> Ex fumador (9-) años </td>
   <td style="text-align:left;"> Casado/pareja </td>
   <td style="text-align:left;"> Ama de casa </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hombre </td>
   <td style="text-align:left;"> Sabe leer y escribir </td>
   <td style="text-align:left;"> No fuma </td>
   <td style="text-align:left;"> Casado/pareja </td>
   <td style="text-align:left;"> Jubilado </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
</tbody>
</table>

Siguiendo con la misma base de datos de pacientes, si recogemos, el peso de una persona es una cantidad numérica. En particular **continua** (los valores dentro de cualquier intervalo son posibles); Esto no ocurre cuando recogemos el *número de hijos*; Esta variable es **discreta**.

###Datos categóricos
Los datos categóricos los examinamos bien con tablas de frecuencias o con representaciones gráficas como diagramas de barras o de sectores.


####Frecuencias y porcentajes
Las frecuencias pueden obtenerse en términos absolutos (frecuencias absolutas), mostrando las repeticiones de cada categoría, o bien en términos relativos (porcentajes), mostrando los participación de cada categoría en relación con el total. Las frecuencias absolutas se utilizan con muestras de tamaño pequeño, y las relativas tienen más sentido con muestras de tamaño grande.


```r
CreateTableOne(vars=c("sexo","laboro", "nivelest", "tabaco",  "diabm"),data = df) %>%summary()
```

```
## 
##      ### Summary of categorical variables ### 
## 
## strata: Overall
##       var   n miss p.miss                 level freq percent cum.percent
##      sexo 536    0    0.0                Hombre  218    40.7        40.7
##                                           Mujer  318    59.3       100.0
##                                                                         
##    laboro 536    5    0.9               Trabaja   97    18.3        18.3
##                                          Parado   16     3.0        21.3
##                                        Jubilado  254    47.8        69.1
##                                     Ama de casa  164    30.9       100.0
##                                                                         
##  nivelest 536    6    1.1          Sin estudios   93    17.5        17.5
##                            Sabe leer y escribir  150    28.3        45.8
##                                       Primarios  188    35.5        81.3
##                                    Bachillerato   53    10.0        91.3
##                                      Superiores   46     8.7       100.0
##                                                                         
##    tabaco 536   16    3.0               No fuma  133    25.6        25.6
##                           Ex fumador (10+) años   32     6.2        31.7
##                            Ex fumador (9-) años  272    52.3        84.0
##                                         Fumador   83    16.0       100.0
##                                                                         
##     diabm 536    4    0.7                    Sí  163    30.6        30.6
##                                              No  369    69.4       100.0
## 
```





Si las variables son categóricas ordinales (o numéricas) pueden sernos de interés los porcentajes acumulados. Nos indican para cada valor de la variable, en qué porcentaje de ocasiones se presentó un valor inferior o igual.



####Diagrama de barras
El diagrama de barras se representa asignándole a cada modalidad de la variable una barra de una altura proporcional a su frecuencia absoluta o a su porcentaje. En ambos casos el gráfico es el mismo, sólo se modifica la escala.


```r
grid.arrange(sjp.frq(df$sexo),  sjp.frq(df$laboro) , sjp.frq(df$nivelest), sjp.frq(df$diabm),ncol=2)
```

<img src="01-Descriptiva_files/figure-html/unnamed-chunk-4-1.png" width="960" />


####Diagramas de sectores
En este diagrama se le asigna a cada valor un sector cuyo ángulo sea proporcional a su frecuencia. Se suele utilizar en datos categóricos nominales y no tanto en los ordinales (es menos clara de interpretar).


```r
grid.arrange(
ggplot(df, aes(x = factor(1), fill = sexo)) + geom_bar(width = 1) + coord_polar(theta = "y") + theme_void(),
ggplot(df, aes(x = factor(1), fill = nivelest)) + geom_bar(width = 1) + coord_polar(theta = "y") + theme_void(),
nrow=1)
```

<img src="01-Descriptiva_files/figure-html/unnamed-chunk-5-1.png" width="672" />


Si usamos SPSS, tanto tablas de frecuencias como los gráficos mencionados los encontramos en la opción de menú “_Analizar – Estadísticos Descriptivos – Frecuencias_”.

### Datos Numéricos.
Los datos numéricos son mucho más ricos en información que los datos categóricos. Por tanto además de las tablas, tenemos otras medidas que sirven para resumir la información que contienen. Dependiendo de cómo se distribuyan los datos, usaremos grupos de medidas de resumen diferentes.

Cuando se tiene una variable numérica, lo primero que nos puede interesar es alrededor de qué valor se agrupan los datos, y cómo se dispersan con respecto a él.

En múltiples ocasiones los datos presentan cierta distribución acampanada como la de la figura adjunta, denominada distribución normal. En estos casos con sólo dos medidas como son la media y la desviación típica tenemos resumida prácticamente toda la información contenida en las observaciones.


```r
sjp.frq(df$talla, type = "hist", show.mean = TRUE,normal.curve = TRUE)
```

<img src="01-Descriptiva_files/figure-html/unnamed-chunk-6-1.png" width="672" />





La media: es el promedio de todos los valores de la variable, es decir, la suma de todos los datos dividido por el número de ellos. La **desviación típica (S)** nos da una medida de la dispersión que tienen los datos con respecto a la media. En datos de distribución _acampanada_ (aproximadamente normal), ocurre lo siguiente:

- Entre la media y a una distancia de **una** desviación típica se encuentra (aproximadamente) el **68%** central de los datos.

- Entre la media y a una distancia de **dos** desviación típica se encuentra (aproximadamente) el **95%** central de los datos.

 
> [Sigue este enlace para practicar con la desviación típica](https://www.bioestadistica.uma.es/analisis/teoremacentral/)


La media y la desviación muestral no tienen tanto interés cuando los datos presentan largas colas u observaciones anómalas  (outliers), es decir, son muy influenciables por las asimetrías y los valores extremos. En estos casos, debemos considerar medidas más resistentes a estas influencias. 


```r
grid.arrange(
sjp.frq(df$peso, type = "hist", show.mean = TRUE,normal.curve = TRUE)+coord_cartesian(xlim=c(40,160)),
sjp.frq(df$peso, type = "boxplot", show.mean = TRUE,normal.curve = TRUE) + 
  coord_cartesian(ylim=c(40,160))+ coord_flip(), nrow=2)
```

<img src="01-Descriptiva_files/figure-html/unnamed-chunk-7-1.png" width="672" />

Como medidas de centralización resistentes podemos utilizar en sustitución de la media:

 - La mediana, que es aquel valor que deja la mitad de los datos por debajo de él.

 - La media recortada (trimmed mean), muy utilizada en datos preferentemente simétricos, con muchas observaciones anómalas y, que se obtiene eliminando un determinado porcentaje de los datos menores y mayores; Así calculamos la media sin contar con ese porcentaje de datos extremos, haciendo desaparecer su influencia.

En cuanto a las medidas de dispersión más resistentes podemos utilizar el **rango intercuartílico** (_IQR_), que es la diferencia entre el tercer cuartil y el primero. El primer cuartil (Q1) deja al 25% de los datos por debajo de él y el tercer cuartil (Q3) deja al 75%, por tanto sabemos que entre ambos valores se encuentra el 50% central de las observaciones. 

> [Para practicar con percentiles sigue este enlace](https://www.bioestadistica.uma.es/analisis/percentil/)

Ahora bien, ¿qué criterios aproximados podemos utilizar para clasificar unos datos como normales o no? Para ello destacamos varias características de la distribución normal. El alejamiento de las mismas es indicación de falta de normalidad: 

 - Es simétrica (el coeficiente de asimetría vale cero)
 - Tiene forma de campana (el apuntamiento o curtosis vale cero).
 - Coinciden la media y la mediana
 - Aproximadamente el 95% de las observaciones se encuentran en el intervalo de centro la media y radio dos veces la desviación típica.

 

Los indicadores que miden la simetría y la forma de la campana son el **coeficiente de asimetría** (_skewness_) (negativo en distribuciones con cola a la izquierda, positivo en distribuciones con cola a la derecha) y la **curtosis** (_kurtosis_) (negativa para las aplanadas y positiva para las apuntadas).



```r
dftmp=df%>% select(edad:imc)
dftmp %>% CreateTableOne(data = .) %>% summary()
```

```
## 
##      ### Summary of continuous variables ###
## 
## strata: Overall
##         n miss p.miss mean sd median p25 p75 min max skew   kurt
## edad  536    0      0   65 10     65  58  72  31  93 -0.2  0.089
## peso  536  106     20   77 13     76  69  85  46 150  0.9  2.763
## talla 536  182     34  159 10    158 152 165 130 188  0.3 -0.008
## imc   536  185     35   31  5     30  28  33  20  51  1.0  2.095
```



```r
grid.arrange(
ggplot(df,aes(x=edad))+geom_histogram(),
ggplot(df,aes(x=talla))+geom_histogram(),
ggplot(df,aes(x=peso))+geom_histogram(),
ggplot(df,aes(x=imc))+geom_histogram(),
nrow=2)
```

<img src="01-Descriptiva_files/figure-html/unnamed-chunk-9-1.png" width="672" />


En la tablas anteriores, así como en los gráficos (llamados **histogramas**) vemos como _peso_ e _IMC_ presentan una cierta falta de normalidad; Podríamos entonces presentar un resumen de estas variables del siguiente modo:


```r
dftmp %>% CreateTableOne(data = .) %>% print(nonnormal=c("peso","imc"))
```

```
##                      
##                       Overall              
##   n                      536               
##   edad (mean (sd))     65.19 (10.39)       
##   peso (median [IQR])  76.00 [69.00, 84.57]
##   talla (mean (sd))   158.68 (9.71)        
##   imc (median [IQR])   30.12 [27.61, 33.20]
```


La falta de normalidad no es fácil de apreciarlo mirando directamente el histograma. Hay gráficos como el Q-Q plot, que nos indican la falta de normalidad como desviaciones de la observaciones con respecto a una línea recta:


```r
grid.arrange(
ggplot(df, aes(sample =edad))  +  stat_qq() + stat_qq_line()+ggtitle("edad"),
ggplot(df, aes(sample =talla))  +  stat_qq() + stat_qq_line()+ggtitle("peso"),
ggplot(df, aes(sample =peso)) + stat_qq() +  stat_qq_line()+ggtitle("talla"),
ggplot(df, aes(sample =imc))   +  stat_qq() + stat_qq_line()+ggtitle("imc"), 
nrow=2)
```

<img src="01-Descriptiva_files/figure-html/unnamed-chunk-11-1.png" width="672" />


Las medida mencionadas podemos calcularlas con SPSS en el menú “_Analizar – Estadísticos Descriptivos – Frecuencias_”  y pulsando el botón “_Estadísticos…_”, o bien podemos usar el menú "_Analizar - Estadísticos descriptivos - Explorar_", donde podemos añadir los gráficos con pruebas de normalidad.



##Datos bivariantes
Si resumir la información de una variable es de por sí interesante, en investigación lo es mucho más el poner de manifiesto la posible relación entre dos de ellas:

> ¿Hay relación entre el tabaco y el cáncer de pulmón? ¿Aumentando la dosis de un medicamento, mejoramos la respuesta? 

Para ello realizamos estudios donde intervienen ambas variables simultáneamente. Según sean los tipos de cada una de ellas usaremos técnicas diferentes.

### Categórica-categórica
Cuando ambas variables son categóricas (o discretas con pocas modalidades), se suele presentar las observaciones en una tabla de contingencia. Esta una tabla de doble entrada donde se presentan la distribución de frecuencias conjunta de las dos variables.

Continuando con la base de datos del ejemplo, podríamos estudiar qué distribución presentan otras variables cualitativas según el sexo del paciente. Lo mostraríamos como sigue:

```r
df %>% CreateTableOne(vars = c("tabaco","estcivil","sedentar","diabm","hipercol"), strata = "sexo" , data = .)
```

```
##                           Stratified by sexo
##                            Hombre      Mujer       p      test
##   n                        218         318                    
##   tabaco (%)                                       <0.001     
##      No fuma                43 (20.8)   90 (28.8)             
##      Ex fumador (10+) años  30 (14.5)    2 ( 0.6)             
##      Ex fumador (9-) años   70 (33.8)  202 (64.5)             
##      Fumador                64 (30.9)   19 ( 6.1)             
##   estcivil (%)                                     <0.001     
##      Soltero                 7 ( 3.2)   15 ( 4.7)             
##      Casado/pareja         191 (87.6)  188 (59.3)             
##      Separado                5 ( 2.3)   12 ( 3.8)             
##      Viudo                  15 ( 6.9)  102 (32.2)             
##   sedentar = No (%)         81 (47.9)  100 (37.9)   0.049     
##   diabm = No (%)           157 (73.0)  212 (66.9)   0.158     
##   hipercol = No (%)        162 (74.7)  211 (67.4)   0.089
```


En la tabla anterior hay una columna denominada _p_ (**significación**) que será my importante en temas posteriores.
 

En cuanto a la representación gráfica, podemos utilizar  el diagrama de barras apiladas o agrupadas, aunque en ellos no es inmediato apreciar las diferencias por sexos

```r
grid.arrange(
sjp.grpfrq(df$tabaco, df$sexo,show.prc = FALSE),
sjp.grpfrq(df$estcivil, df$sexo,,show.prc = FALSE),
sjp.grpfrq(df$sedentar, df$sexo,show.prc = FALSE),
sjp.grpfrq(df$diabm, df$sexo,show.prc = FALSE),
sjp.grpfrq(df$hipercol, df$sexo,show.prc = FALSE),ncol=1)
```

<img src="01-Descriptiva_files/figure-html/unnamed-chunk-13-1.png" width="576" />
 
Desglosando en cada categoría de la variable los porcentajes de cada sexo es más sencillo de ver:
 

```r
#ggplot(df, aes(tabaco)) + geom_bar(aes(fill = sexo))
dftmp=df %>% select(sexo,tabaco)%>% filter(!is.na(tabaco)) %>% 
  mutate(cuenta=1) %>% group_by(sexo,tabaco) %>% 
  tally() %>% mutate(fraccion=n/sum(n))
ggplot(dftmp, aes(fill=sexo, y=fraccion, x=tabaco)) + 
    geom_bar( stat="identity", position="fill")
```

<img src="01-Descriptiva_files/figure-html/unnamed-chunk-14-1.png" width="672" />


```r
#ggplot(df, aes(tabaco)) + geom_bar(aes(fill = sexo))
dftmp=df %>% select(sexo,diabm) %>% filter(!is.na(diabm)) %>% mutate(cuenta=1) %>% group_by(sexo,diabm) %>% tally() %>% mutate(fraccion=n/sum(n))
ggplot(dftmp, aes(fill=sexo, y=fraccion, x=diabm)) + 
    geom_bar( stat="identity", position="fill")
```

<img src="01-Descriptiva_files/figure-html/unnamed-chunk-15-1.png" width="672" />
 
 


### Categórica-Numérica


Supongamos que tenemos datos numéricos para varias categorías. Por ejemplo, en un experimento donde hacemos mediciones numéricas en dos grupos: uno al que se le aplica determinado tratamiento y otro de control. Podemos describir los resultados del experimento con sólo dos variables: Una variable categórica que representa el grupo de tratamiento, y otra que representa el resultado numérico

En estos casos, lo que se realiza es un estudio descriptivo de la variable numérica en cada una de las muestras y comparamos los resultados.

Volviendo a nuestro ejemplo, vamos a comparar las variables numéricas de la base de datos entre sexos:



```r
df %>% CreateTableOne(vars = c("edad", "talla","peso","imc"), strata = "sexo" , data = .) %>% print(nonnormal=c("peso","imc"))
```

```
##                      Stratified by sexo
##                       Hombre                Mujer                 p     
##   n                      218                   318                      
##   edad (mean (sd))     63.85 (10.70)         66.11 (10.08)         0.013
##   talla (mean (sd))   167.03 (7.22)         153.70 (7.28)         <0.001
##   peso (median [IQR])  80.00 [73.38, 87.55]  73.60 [66.00, 81.50] <0.001
##   imc (median [IQR])   28.97 [26.86, 31.22]  31.41 [28.14, 34.19] <0.001
##                      Stratified by sexo
##                       test   
##   n                          
##   edad (mean (sd))           
##   talla (mean (sd))          
##   peso (median [IQR]) nonnorm
##   imc (median [IQR])  nonnorm
```




```r
CreateTableOne(vars = c("edad","peso","talla","imc","pas","pad","fc"), strata = "tabaco" , data = df)
```

```
##                    Stratified by tabaco
##                     No fuma        Ex fumador (10+) años
##   n                    133             32               
##   edad (mean (sd))   67.14 (9.28)   64.09 (8.19)        
##   peso (mean (sd))   77.77 (14.44)  79.97 (10.46)       
##   talla (mean (sd)) 158.10 (9.73)  165.67 (5.25)        
##   imc (mean (sd))    31.15 (5.11)   29.00 (2.72)        
##   pas (mean (sd))   150.33 (20.89) 133.03 (13.88)       
##   pad (mean (sd))    81.00 (11.05)  81.84 (9.96)        
##   fc (mean (sd))     74.93 (12.10)  58.66 (33.20)       
##                    Stratified by tabaco
##                     Ex fumador (9-) años Fumador        p      test
##   n                    272                   83                    
##   edad (mean (sd))   66.13 (10.75)        59.36 (9.81)  <0.001     
##   peso (mean (sd))   75.75 (13.24)        80.56 (12.94)  0.053     
##   talla (mean (sd)) 155.94 (8.70)        167.13 (9.03)  <0.001     
##   imc (mean (sd))    31.39 (5.59)         29.10 (3.56)   0.022     
##   pas (mean (sd))   142.25 (18.19)       141.08 (17.57) <0.001     
##   pad (mean (sd))    81.24 (10.61)        84.20 (10.06)  0.127     
##   fc (mean (sd))     58.25 (29.20)        64.35 (28.23) <0.001
```


En las tablas anteriores aparecen de nuevos las cantidades **p (significación)** de las que hablaremos más adelante.


Los diagramas de cajas muestran los cuartiles en unas cajas centrales, así como observaciones más alejadas, y permiten hacerse una idea visual de qué diferencias existen entre los grupos. Por ejemplo, en las tablas anteriores se apreciaba una cierta diferencia de *talla* entre hombres y mujeres, aunque no así en *pad*:



```r
grid.arrange(
ggplot(df,aes(x=sexo,y=talla))+geom_boxplot(),
ggplot(df,aes(x=sexo,y=pad))+geom_boxplot(),ncol=2)
```

<img src="01-Descriptiva_files/figure-html/unnamed-chunk-18-1.png" width="672" />





Si usamos _SPSS_, tenemos a nuestra disposición la opción de menú “*Analizar – Estadísticos descriptivos – Explorar…*”. En la casilla denominada “_dependientes_” situamos la variable numérica y en “_factores_” situamos la categórica. 

### Numérica-Numérica.

Cuando hablamos de comparar dos variables numéricas, pensamos en establecer la posible relación entre ellas. 

>¿Estarán relacionados la altura y el peso de los individuos? ¿Cuanto mayor es el tamaño del cerebro, mayor es el coeficiente intelectual?

La vía más directa para estudiar la posible asociación consiste en inspeccionar visualmente un diagrama de dispersión (nube de puntos). Si reconocemos una tendencia, es una indicación de que puede valer la pena explorar con más profundidad. Si es el caso, puede interesarnos proseguir con un análisis de regresión. En este tipo de análisis se pretende encontrar un modelo matemático (recta de regresión) que explique los valores de una de las variables (dependiente) en función de la otra (independiente). A ello le dedicamos un capítulo con posterioridad.


Por ejemplo, en la base de datos con que trabajamos, es lógicco esperar una buena relación entre el _peso_ y el _imc_, y eso es justo lo que encontramos.


```r
ggplot(df, aes(x=peso, y=imc)) + geom_jitter(alpha=0.3)
```

<img src="01-Descriptiva_files/figure-html/unnamed-chunk-19-1.png" width="672" />

En otras variables la relación no es tan evidente, como la que existe entre _edad_ y mayor _presi´on arterial diastólica_ y menor _presión arterial sistólica_. Las rectas de regresión no serán muy útiles para percibir la tendencia con más facilidad:


```r
grid.arrange(
  ggplot(df, aes(x=edad, y=pas)) + geom_jitter(alpha=0.3)+geom_smooth(method="lm"),
ggplot(df, aes(x=edad, y=pad)) + geom_jitter(alpha=0.3)+geom_smooth(method="lm"),nrow=1)
```

<img src="01-Descriptiva_files/figure-html/unnamed-chunk-20-1.png" width="672" />








En *SPSS* estos tipos de gráficos podemos encontrarlos en el menú: “*Gráficos – Dispersión… – Simple*“.


 
 









