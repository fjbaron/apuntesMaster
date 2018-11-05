--- 
title: "Apuntes de estadística"
author: "Francisco Javier Barón López"
date: "2018-11-05"
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib]
biblio-style: apalike
link-citations: yes
github-repo: fjbaron/apuntesEstadistica.git
url: 'https\://www.bioestadistica.uma.es/apuntesMaster/'
description: "Apuntes de estadística para estudiantes de Master de Nuevas Tendencias"
---




# Introducción {-}

Apuntes para las asignatura de Estadística básica y avanzada del Máster en Nuevas Tendencias en Ciencias de la Salud.

<!--chapter:end:index.Rmd-->

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


 
 










<!--chapter:end:01-Descriptiva.Rmd-->




#Intervalos de confianza

Un problema habitual es el de estimar parámetros que ayuden a caracterizar una variable. Por ejemplo el porcentaje de individuos que mejora ante un cierto tratamiento, o el tiempo medio que tarda un anestésico en hacer efecto. 

Podríamos decir, tras realizar un estudio, “el 75% de los pacientes tratados experimentó una mejoría”. Una respuesta más sofisticada usando intervalos de confianza podría ser: “Nuestro estudio muestra que en el 75% de los casos se experimenta una mejoría, siendo el margen de error del 6%. El nivel de confianza es del 95%”.

El cálculo de intervalos de confianza para la estimación de parámetros son técnicas que nos permiten hacer declaraciones sobre qué valores podemos esperar para un parámetro. El intervalo calculado dependerá de:

-	Lo estimado en la muestra (porcentaje, media,…) El intervalo de confianza esta formado por valores ligeramente menores y mayores que la aproximación ofrecida por la muestra.

-	El tamaño muestral. Cuantos más datos hayan participado en el cálculo, más pequeño esperamos que sea la diferencia entre el valor estimado y el valor real desconocido.

-	La probabilidad (nivel de confianza) con la que el método dará una respuesta correcta. Un nivel de confianza habitual para los intervalos de confianza es el 95%.

Puede parecer sorprendente que no busquemos respuestas con una confianza del 100%, pero ocurre que en ese caso, los intervalos serían tan grandes que no serían de gran provecho. La elección de un nivel de confianza como el 95% es un compromiso entre hacer declaraciones con una razonable probabilidad de acertar, y que además el intervalo declarado, sea lo suficientemente pequeño como para suscitar algún interés. El nivel de confianza hay que interpretarlo como que disponemos de un método de calcular intervalos que seguido con rigor, en cierto porcentaje de casos acierta (nivel de confianza) y en el resto falla.


## Error típico o estándar
En multitud de ocasiones al utilizar un programa estadístico encontramos junto a las más diversas estimaciones como una media, una proporción, un coeficiente de regresión, un coeficiente de asimetría, etc.,  una cantidad denominada error estándar  o también error típico.

El error estándar tiene mucho que ver con los intervalos de confianza. Para muchos parámetros, su intervalo de confianza es habitualmente la estimación obtenida sobre la muestra (proporción, media,…), y un margen de error que nos es más que un múltiplo del error estándar. Un ejemplo muy común, consiste en elegir niveles de confianza del 95%. Para ello un margen de error de dos errores estándar es habitualmente la respuesta. 

Cuando un programa estadístico nos ofrece una estimación de una cantidad, junto a su error estándar, podemos estar seguros de que si se dan ciertas condiciones de validez, el estimador del parámetro tiene comportamiento normal cuya desviación típica es el error estándar, y por tanto una declaración como: 

>“La proporción de pacientes que mejoraron con el tratamiento es del 0.75, con un error estándar del 0.03” 

puede enunciarse de forma más clara en forma de intervalo de confianza:

>	La proporción de pacientes que mejoró fue del 0.75, siendo el intervalo de confianza al 95% 0.69---0.81 .


Es fácil confundir desviación típica con error típico. Ambos hablan de la dispersión en torno a un valor central y se usan en distribuciones aproximadamente normales. Peo el segundo se utiliza  solo en el contexto de estimar un valor a partir de una muestra.

>[Practique con la diferencia entre desviación típica y error típico](https://www.bioestadistica.uma.es/analisis/teoremacentral/)


###Ejemplo de intervalos de confianza y errores estándar {-}

Se consideran dos grupos de individuos que desmpeñan un trabajo similar, pero que siguen una forma de alimentación muy diferente. Están formados por albañiles de Málaga y Tánger. Descargue la base de datos [2poblaciones-Mismotrabajo-DiferenteNutricion.sav](datos/2poblaciones-Mismotrabajo-DiferenteNutricion.sav). Las primeras líneas tienen el siguiente aspecto:


```r
df=read_sav("datos/2poblaciones-Mismotrabajo-DiferenteNutricion.sav", user_na=FALSE) %>% haven::as_factor()
```


```r
df %>% head()  %>% knitr::kable(booktabs=T)
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Grupo </th>
   <th style="text-align:right;"> Colesterol </th>
   <th style="text-align:right;"> Trigliceridos </th>
   <th style="text-align:right;"> Glucemia </th>
   <th style="text-align:right;"> PAS </th>
   <th style="text-align:right;"> PAD </th>
   <th style="text-align:right;"> Peso </th>
   <th style="text-align:right;"> Talla </th>
   <th style="text-align:right;"> Consumo </th>
   <th style="text-align:right;"> Gasto </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Málaga </td>
   <td style="text-align:right;"> 238 </td>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 3521 </td>
   <td style="text-align:right;"> 1400 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Tanger </td>
   <td style="text-align:right;"> 251 </td>
   <td style="text-align:right;"> 163 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 1490 </td>
   <td style="text-align:right;"> 1730 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Málaga </td>
   <td style="text-align:right;"> 194 </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 3701 </td>
   <td style="text-align:right;"> 2180 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Tanger </td>
   <td style="text-align:right;"> 169 </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 86 </td>
   <td style="text-align:right;"> 1.8 </td>
   <td style="text-align:right;"> 3200 </td>
   <td style="text-align:right;"> 2150 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Málaga </td>
   <td style="text-align:right;"> 227 </td>
   <td style="text-align:right;"> 114 </td>
   <td style="text-align:right;"> 121 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 4124 </td>
   <td style="text-align:right;"> 1700 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Málaga </td>
   <td style="text-align:right;"> 214 </td>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:right;"> 1.8 </td>
   <td style="text-align:right;"> 4209 </td>
   <td style="text-align:right;"> 1845 </td>
  </tr>
</tbody>
</table>


Si usa SPSS en el menú "_Analizar - Estadística discriptiva - Explorar_", colocando las variables numéricas en el campo _Dependientes_ y el Grupo en el campo _Factor_ puede obtener información para construir estos resultados:



```r
grid.arrange(
sjp.grpfrq(df$Colesterol, df$Grupo, type="boxplot"),
sjp.grpfrq(df$Trigliceridos, df$Grupo, type="boxplot"),
sjp.grpfrq(df$Glucemia, df$Grupo, type="boxplot"),
sjp.grpfrq(df$PAS, df$Grupo, type="boxplot"),
sjp.grpfrq(df$PAD, df$Grupo, type="boxplot"),
sjp.grpfrq(df$Peso, df$Grupo, type="boxplot"),
sjp.grpfrq(df$Talla, df$Grupo, type="boxplot",ylim = c(1.50,1.90)),
sjp.grpfrq(df$Consumo, df$Grupo, type="boxplot"),
sjp.grpfrq(df$Gasto, df$Grupo, type="boxplot"), ncol=3)
```

<img src="02-IntConf_files/figure-html/unnamed-chunk-3-1.png" width="768" />

Visualmente se aprecia que los individuos de _Grupo==Málaga_ siendo de _Talla_ similar, presentan mayor _Consumo de energía_ y similar _Gasto_. Se observa en ellos mayores valores de _Colesterol, Trigliceridos, Glucemia y Peso_, y valores similares de _Presión arterial_.

Los intervalos de confianza y errores estándar podrían mostrarse en una tabla como sigue:


```r
vNumericas=names(df) %>% setdiff("Grupo")
df %>% generaTablatTestPorGrupo("Grupo", vNumericas,
                                columnas = c("media","dt","et","ic1","ic2")) %>% 
  knitr::kable( booktabs = T, 
                col.names=c("Variable",
                        "media","dt","et","ic(min)","ic(max)",
                        "media","dt","et","ic(min)","ic(max)")) %>%
  add_header_above(c(" " = 1, "Tanger" = 5, "Málaga" = 5)) %>%
  kable_styling(font_size = 9)
```

<table class="table" style="font-size: 9px; margin-left: auto; margin-right: auto;">
 <thead>
<tr>
<th style="border-bottom:hidden" colspan="1"></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="5"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">Tanger</div></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="5"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">Málaga</div></th>
</tr>
  <tr>
   <th style="text-align:left;"> Variable </th>
   <th style="text-align:right;"> media </th>
   <th style="text-align:right;"> dt </th>
   <th style="text-align:right;"> et </th>
   <th style="text-align:right;"> ic(min) </th>
   <th style="text-align:right;"> ic(max) </th>
   <th style="text-align:right;"> media </th>
   <th style="text-align:right;"> dt </th>
   <th style="text-align:right;"> et </th>
   <th style="text-align:right;"> ic(min) </th>
   <th style="text-align:right;"> ic(max) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Colesterol </td>
   <td style="text-align:right;"> 162.7 </td>
   <td style="text-align:right;"> 44.81 </td>
   <td style="text-align:right;"> 8.32 </td>
   <td style="text-align:right;"> 145.7 </td>
   <td style="text-align:right;"> 179.7 </td>
   <td style="text-align:right;"> 209.1 </td>
   <td style="text-align:right;"> 42.42 </td>
   <td style="text-align:right;"> 6.06 </td>
   <td style="text-align:right;"> 196.9 </td>
   <td style="text-align:right;"> 221.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Trigliceridos </td>
   <td style="text-align:right;"> 82.1 </td>
   <td style="text-align:right;"> 45.18 </td>
   <td style="text-align:right;"> 8.39 </td>
   <td style="text-align:right;"> 65.0 </td>
   <td style="text-align:right;"> 99.3 </td>
   <td style="text-align:right;"> 113.2 </td>
   <td style="text-align:right;"> 69.89 </td>
   <td style="text-align:right;"> 9.98 </td>
   <td style="text-align:right;"> 93.2 </td>
   <td style="text-align:right;"> 133.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Glucemia </td>
   <td style="text-align:right;"> 78.0 </td>
   <td style="text-align:right;"> 11.27 </td>
   <td style="text-align:right;"> 2.09 </td>
   <td style="text-align:right;"> 73.8 </td>
   <td style="text-align:right;"> 82.3 </td>
   <td style="text-align:right;"> 88.2 </td>
   <td style="text-align:right;"> 19.03 </td>
   <td style="text-align:right;"> 2.72 </td>
   <td style="text-align:right;"> 82.7 </td>
   <td style="text-align:right;"> 93.6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PAS </td>
   <td style="text-align:right;"> 119.8 </td>
   <td style="text-align:right;"> 10.04 </td>
   <td style="text-align:right;"> 1.86 </td>
   <td style="text-align:right;"> 116.0 </td>
   <td style="text-align:right;"> 123.7 </td>
   <td style="text-align:right;"> 121.7 </td>
   <td style="text-align:right;"> 12.84 </td>
   <td style="text-align:right;"> 1.83 </td>
   <td style="text-align:right;"> 118.0 </td>
   <td style="text-align:right;"> 125.4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PAD </td>
   <td style="text-align:right;"> 72.5 </td>
   <td style="text-align:right;"> 9.72 </td>
   <td style="text-align:right;"> 1.80 </td>
   <td style="text-align:right;"> 68.8 </td>
   <td style="text-align:right;"> 76.2 </td>
   <td style="text-align:right;"> 70.3 </td>
   <td style="text-align:right;"> 9.60 </td>
   <td style="text-align:right;"> 1.37 </td>
   <td style="text-align:right;"> 67.5 </td>
   <td style="text-align:right;"> 73.1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Peso </td>
   <td style="text-align:right;"> 72.7 </td>
   <td style="text-align:right;"> 7.84 </td>
   <td style="text-align:right;"> 1.46 </td>
   <td style="text-align:right;"> 69.7 </td>
   <td style="text-align:right;"> 75.7 </td>
   <td style="text-align:right;"> 81.4 </td>
   <td style="text-align:right;"> 8.73 </td>
   <td style="text-align:right;"> 1.25 </td>
   <td style="text-align:right;"> 78.9 </td>
   <td style="text-align:right;"> 83.9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Talla </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 0.05 </td>
   <td style="text-align:right;"> 0.01 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 0.05 </td>
   <td style="text-align:right;"> 0.01 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 1.7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Consumo </td>
   <td style="text-align:right;"> 1909.2 </td>
   <td style="text-align:right;"> 469.75 </td>
   <td style="text-align:right;"> 87.23 </td>
   <td style="text-align:right;"> 1730.8 </td>
   <td style="text-align:right;"> 2087.6 </td>
   <td style="text-align:right;"> 3528.0 </td>
   <td style="text-align:right;"> 550.94 </td>
   <td style="text-align:right;"> 78.71 </td>
   <td style="text-align:right;"> 3369.9 </td>
   <td style="text-align:right;"> 3686.2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gasto </td>
   <td style="text-align:right;"> 1894.2 </td>
   <td style="text-align:right;"> 185.89 </td>
   <td style="text-align:right;"> 34.52 </td>
   <td style="text-align:right;"> 1823.6 </td>
   <td style="text-align:right;"> 1964.8 </td>
   <td style="text-align:right;"> 1880.3 </td>
   <td style="text-align:right;"> 438.12 </td>
   <td style="text-align:right;"> 62.59 </td>
   <td style="text-align:right;"> 1754.5 </td>
   <td style="text-align:right;"> 2006.1 </td>
  </tr>
</tbody>
</table>

En la tabla anterior vemos para cada grupo no solo la media y desviación típica de cada grupo (que nos da una idea de donde se sitúan los individuos de cada grupo), sino un la precisión con la que se ha estimado la media de cada grupo (en forma de error estándar e intervalo de confianza al 95%). 

Realmente no es esta la forma habitual de presentar los resultados en una publicación científica. Normalmente queremos mostrar como es la precisión de nuestras estimaciones, y el intervalo de confianza se muestra más bien para la diferencia que hay entre los dos grupos. Hay que esperar a ver la **prueba t-student** para ver como construir la tabla habitual:


```r
df %>% generaTablatTestPorGrupo("Grupo", vNumericas,
                                columnas = c("n","mediaet","p.t","ci95")) %>% 
  knitr::kable( booktabs = T, 
                col.names=c("Variable",
                        "n","media±et", 
                        "n","media±et",
                        "p dif.","ic95% dif.")) %>%
  add_header_above(c(" " = 1, "Tanger" = 2, "Málaga" = 2," "=2))
```

<table>
 <thead>
<tr>
<th style="border-bottom:hidden" colspan="1"></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">Tanger</div></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">Málaga</div></th>
<th style="border-bottom:hidden" colspan="2"></th>
</tr>
  <tr>
   <th style="text-align:left;"> Variable </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:left;"> media±et </th>
   <th style="text-align:right;"> n </th>
   <th style="text-align:left;"> media±et </th>
   <th style="text-align:left;"> p dif. </th>
   <th style="text-align:left;"> ic95% dif. </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Colesterol </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> 162.67±8.32 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> 209.12±6.06 </td>
   <td style="text-align:left;"> &lt;0.001* </td>
   <td style="text-align:left;"> 46.45[26.15,66.76] </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Trigliceridos </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> 82.13±8.39 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> 113.22±9.98 </td>
   <td style="text-align:left;"> 0.018* </td>
   <td style="text-align:left;"> 31.09[5.45,56.72] </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Glucemia </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> 78.03±2.09 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> 88.18±2.72 </td>
   <td style="text-align:left;"> 0.004* </td>
   <td style="text-align:left;"> 10.15[3.40,16.89] </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PAS </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> 119.83±1.86 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> 121.70±1.83 </td>
   <td style="text-align:left;"> 0.472 </td>
   <td style="text-align:left;"> 1.87[-3.28,7.01] </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PAD </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> 72.50±1.80 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> 70.30±1.37 </td>
   <td style="text-align:left;"> 0.329 </td>
   <td style="text-align:left;"> -2.20[-6.67,2.27] </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Peso </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> 72.67±1.46 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> 81.38±1.25 </td>
   <td style="text-align:left;"> &lt;0.001* </td>
   <td style="text-align:left;"> 8.71[4.94,12.49] </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Talla </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> 1.70±0.01 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> 1.69±0.01 </td>
   <td style="text-align:left;"> 0.431 </td>
   <td style="text-align:left;"> -0.01[-0.03,0.01] </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Consumo </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> 1909.17±87.23 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> 3528.04±78.71 </td>
   <td style="text-align:left;"> &lt;0.001* </td>
   <td style="text-align:left;"> 1618.87[1387.71,1850.04] </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gasto </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:left;"> 1894.20±34.52 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:left;"> 1880.30±62.59 </td>
   <td style="text-align:left;"> 0.845 </td>
   <td style="text-align:left;"> -13.90[-154.73,126.93] </td>
  </tr>
</tbody>
</table>



```r
resumen=df %>% gather(Variable,Valor,-Grupo) %>% group_by(Grupo,Variable) %>% summarise(Media=mean(Valor),n=length(Valor),ET=sd(Valor)/sqrt(n))
```

```r
grid.arrange(
ggplot(resumen %>% filter(Variable=="Colesterol"), aes(x=Grupo,y=Media)) +
  geom_errorbar(aes(ymin=Media-ET,ymax=Media+ET),width=0.2, size=1, color="navyblue")+
  geom_bar(stat="identity", fill="lightblue", alpha=0.5)+
  geom_point( size=4, shape=21, fill="white")+ylab("Colesterol"),
ggplot(resumen %>% filter(Variable=="Trigliceridos"), aes(x=Grupo,y=Media)) +
  geom_errorbar(aes(ymin=Media-ET,ymax=Media+ET),width=0.2, size=1, color="navyblue")+
  geom_bar(stat="identity", fill="lightblue", alpha=0.5)+
  geom_point( size=4, shape=21, fill="white")+ylab("Triglicéridos"),
ggplot(resumen %>% filter(Variable=="Glucemia"), aes(x=Grupo,y=Media)) +
  geom_errorbar(aes(ymin=Media-ET,ymax=Media+ET),width=0.2, size=1, color="navyblue")+
  geom_bar(stat="identity", fill="lightblue", alpha=0.5)+
  geom_point( size=4, shape=21, fill="white")+ylab("Glucemia"),
ggplot(resumen %>% filter(Variable=="Peso"), aes(x=Grupo,y=Media)) +
  geom_errorbar(aes(ymin=Media-ET,ymax=Media+ET),width=0.2, size=1, color="navyblue")+
  geom_bar(stat="identity", fill="lightblue", alpha=0.5)+
  geom_point( size=4, shape=21, fill="white")+ylab("Peso"),nrow=2)
```

<img src="02-IntConf_files/figure-html/unnamed-chunk-7-1.png" width="672" />


Las barras ocupan mucho espacio y no permiten apreciar bien las diferencias. Personalmente pienso que es mejor mostrar solo los intervalos formados por las medias y el error típico como sigue:

```r
grid.arrange(
ggplot(resumen %>% filter(Variable=="Colesterol"), aes(x=Grupo,y=Media)) +
  geom_errorbar(aes(ymin=Media-ET,ymax=Media+ET),width=0.2, size=1, color="navyblue")+
  geom_point( size=4, shape=21, fill="white")+ylab("Colesterol"),
ggplot(resumen %>% filter(Variable=="Trigliceridos"), aes(x=Grupo,y=Media)) +
  geom_errorbar(aes(ymin=Media-ET,ymax=Media+ET),width=0.2, size=1, color="navyblue")+
  geom_point( size=4, shape=21, fill="white")+ylab("Triglicéridos"),
ggplot(resumen %>% filter(Variable=="Glucemia"), aes(x=Grupo,y=Media)) +
  geom_errorbar(aes(ymin=Media-ET,ymax=Media+ET),width=0.2, size=1, color="navyblue")+
  geom_point( size=4, shape=21, fill="white")+ylab("Glucemia"),
ggplot(resumen %>% filter(Variable=="Peso"), aes(x=Grupo,y=Media)) +
  geom_errorbar(aes(ymin=Media-ET,ymax=Media+ET),width=0.2, size=1, color="navyblue")+
  geom_point( size=4, shape=21, fill="white")+ylab("Peso"),nrow=2)
```

<img src="02-IntConf_files/figure-html/unnamed-chunk-8-1.png" width="672" />




<!--chapter:end:02-IntConf.Rmd-->




#Contrastes de hipótesis

Aunque gran parte de la investigación médica esta relacionada con la recogida de datos con propósito descriptivo, otra buena parte lo está con la recolección de información con el plan de responder a cuestiones puntuales, es decir, contrastes de hipótesis.

Las técnicas de contrastes de hipótesis están muy vinculadas a las de cálculo de intervalos de confianza, como mencionábamos al hablar de estos últimos. Aunque la aproximación es diferente:

-	Al hacer un intervalo de confianza establecemos una región donde esperamos que esté el valor del parámetro.

-	Al hacer un contraste de hipótesis establecemos posibles valores para unos parámetros y calculamos la probabilidad de que se obtengan muestras tan discrepantes o más que la obtenida, bajo la suposición de que la hipótesis es cierta. Si dicha probabilidad es muy baja (por debajo de una cantidad denominada nivel de significación) la hipótesis es rechazada.

Vamos a ilustrarlo retomando el ejemplo del tema anterior de intervalos de confianza. Descargue la base de datos [2poblaciones-Mismotrabajo-DiferenteNutricion.sav](datos/2poblaciones-Mismotrabajo-DiferenteNutricion.sav) y observemos las primeras líneas:


```r
df=read_sav("datos/2poblaciones-Mismotrabajo-DiferenteNutricion.sav", user_na=FALSE) %>% haven::as_factor()
```


```r
df %>% head()  %>% knitr::kable(booktabs=T)
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Grupo </th>
   <th style="text-align:right;"> Colesterol </th>
   <th style="text-align:right;"> Trigliceridos </th>
   <th style="text-align:right;"> Glucemia </th>
   <th style="text-align:right;"> PAS </th>
   <th style="text-align:right;"> PAD </th>
   <th style="text-align:right;"> Peso </th>
   <th style="text-align:right;"> Talla </th>
   <th style="text-align:right;"> Consumo </th>
   <th style="text-align:right;"> Gasto </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Málaga </td>
   <td style="text-align:right;"> 238 </td>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 3521 </td>
   <td style="text-align:right;"> 1400 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Tanger </td>
   <td style="text-align:right;"> 251 </td>
   <td style="text-align:right;"> 163 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 1490 </td>
   <td style="text-align:right;"> 1730 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Málaga </td>
   <td style="text-align:right;"> 194 </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 3701 </td>
   <td style="text-align:right;"> 2180 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Tanger </td>
   <td style="text-align:right;"> 169 </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 86 </td>
   <td style="text-align:right;"> 1.8 </td>
   <td style="text-align:right;"> 3200 </td>
   <td style="text-align:right;"> 2150 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Málaga </td>
   <td style="text-align:right;"> 227 </td>
   <td style="text-align:right;"> 114 </td>
   <td style="text-align:right;"> 121 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 4124 </td>
   <td style="text-align:right;"> 1700 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Málaga </td>
   <td style="text-align:right;"> 214 </td>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:right;"> 1.8 </td>
   <td style="text-align:right;"> 4209 </td>
   <td style="text-align:right;"> 1845 </td>
  </tr>
</tbody>
</table>

Exploremos los intervalos de confianza de las medias de cada grupo. En *SPSS* recordamos que se obtenían en el menú "_Analizar - Estadística discriptiva - Explorar_", colocando las variables numéricas en el campo _Dependientes_ y el Grupo en el campo _Factor_. Los valores que nos interesan son:



```r
vNumericas=names(df) %>% setdiff("Grupo")
df %>% generaTablatTestPorGrupo("Grupo", vNumericas,
                                columnas = c("ic1","ic2")) %>% 
  knitr::kable( booktabs = T, 
                col.names=c("Variable",
                        "ic(min)","ic(max)",
                        "ic(min)","ic(max)")) %>%
  add_header_above(c(" " = 1, "Tanger" = 2, "Málaga" = 2))
```

<table>
 <thead>
<tr>
<th style="border-bottom:hidden" colspan="1"></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">Tanger</div></th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px;">Málaga</div></th>
</tr>
  <tr>
   <th style="text-align:left;"> Variable </th>
   <th style="text-align:right;"> ic(min) </th>
   <th style="text-align:right;"> ic(max) </th>
   <th style="text-align:right;"> ic(min) </th>
   <th style="text-align:right;"> ic(max) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Colesterol </td>
   <td style="text-align:right;"> 145.7 </td>
   <td style="text-align:right;"> 179.7 </td>
   <td style="text-align:right;"> 196.9 </td>
   <td style="text-align:right;"> 221.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Trigliceridos </td>
   <td style="text-align:right;"> 65.0 </td>
   <td style="text-align:right;"> 99.3 </td>
   <td style="text-align:right;"> 93.2 </td>
   <td style="text-align:right;"> 133.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Glucemia </td>
   <td style="text-align:right;"> 73.8 </td>
   <td style="text-align:right;"> 82.3 </td>
   <td style="text-align:right;"> 82.7 </td>
   <td style="text-align:right;"> 93.6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PAS </td>
   <td style="text-align:right;"> 116.0 </td>
   <td style="text-align:right;"> 123.7 </td>
   <td style="text-align:right;"> 118.0 </td>
   <td style="text-align:right;"> 125.4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PAD </td>
   <td style="text-align:right;"> 68.8 </td>
   <td style="text-align:right;"> 76.2 </td>
   <td style="text-align:right;"> 67.5 </td>
   <td style="text-align:right;"> 73.1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Peso </td>
   <td style="text-align:right;"> 69.7 </td>
   <td style="text-align:right;"> 75.7 </td>
   <td style="text-align:right;"> 78.9 </td>
   <td style="text-align:right;"> 83.9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Talla </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 1.7 </td>
   <td style="text-align:right;"> 1.7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Consumo </td>
   <td style="text-align:right;"> 1730.8 </td>
   <td style="text-align:right;"> 2087.6 </td>
   <td style="text-align:right;"> 3369.9 </td>
   <td style="text-align:right;"> 3686.2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gasto </td>
   <td style="text-align:right;"> 1823.6 </td>
   <td style="text-align:right;"> 1964.8 </td>
   <td style="text-align:right;"> 1754.5 </td>
   <td style="text-align:right;"> 2006.1 </td>
  </tr>
</tbody>
</table>

Si pretendemos contrastar la hipótesis (no muy interesante) de si el Colesterol medio en la población de la que se han obtenidos las muestras en Tánger es 190, la respuesta que elegiríamos es **NO**, dado que 190 no forma parte del intervalo dende _casi seguro_ esperamos encontrar la media. Los datos indican que la media allí es inferior.

Análogamente, en Málaga podríamos decir que la media de la población _casi seguro_ que no es 190. Los datos apuntan a que la media es superior.



```r
resumen=df %>% gather(Variable,Valor,-Grupo) %>% 
  group_by(Grupo,Variable) %>% 
  summarise(Media=mean(Valor),
                n=length(Valor),
               IC=sd(Valor)/sqrt(n)*qt(0.975,n-1))
ggplot(resumen %>% filter(Variable=="Colesterol"), aes(x=Grupo,y=Media)) +
  geom_errorbar(aes(ymin=Media-IC,ymax=Media+IC),width=0.2, size=1, color="navyblue")+
  geom_point( size=4, shape=21, fill="white")+ylab("Colesterol")+
  geom_hline(yintercept=190,lty=2)
```

<img src="03-contHip_files/figure-html/unnamed-chunk-4-1.png" width="672" />


En término de contrastes de hipótesis diríamos que *tenemos evidencia estadísticamente significativa* de que tanto en Málaga como en Tanger la media de colesterol de las poblaciones donde se han extraído las muestras no es 190, con un *nivel de significación* del 5%. Este nivel de significación hace el papel de probabilidad de observar unas muestras tan extañas como las observadas si la media fuese 190.



## ¿Qué es una hipótesis?
Las hipótesis que se contrastan hay que entenderlas como una declaración, no como una pregunta a responder. No se formulan como la cuestión “¿El tratamiento tiene efecto?”. Se formulan bien como “El tratamiento no tiene efecto” o como “el tratamiento sí tiene efecto”. 

- A una hipótesis que traduce las ideas de “no hay efecto”, “no hay relación”, “los resultados en los grupos son similares”, se la denomina **hipótesis nula**. 

- La hipótesis alternativa es la que se aceptará cuando los datos nos inviten a rechazar la nula.

Las hipótesis se formularán normalmente como una declaración sobre una o más poblaciones, especialmente sobre sus parámetros. Ejemplos de hipótesis pueden ser:

-	La edad media de los individuos con la enfermedad X es 50 años.

-	El tratamiento X tiene el mismo efecto que un placebo (por tanto no tiene valor terapéutico). Se podría traducir como que el efecto medio del placebo es igual al efecto medio del tratamiento.

-	Para determinar la cantidad de anestésico a aplicar a un paciente, se utiliza un modelo de regresión lineal, siendo el peso y la edad del mismo variables independientes. Alguna hipótesis podría ser que no deberíamos tener en cuenta la edad, por ejemplo. Esto se traduciría en que el coeficiente asociado en el modelo de regresión es cero.

-	 Al tratar de identificar factores de riesgo para el desarrollo de una enfermedad podríamos estar interesados en saber si fumar es uno de ellos. Para ello podríamos realizar una regresión logística y contrastar si la “odds ratio” es igual a uno, lo que equivale a decir que no es un factor de riesgo.


En todo contraste de hipótesis se enfrenta la denominada **hipótesis nula** (“no efecto”), frente a la **hipótesis alternativa**, que la niega. La hipótesis nula puede interpretarse como aquella que normalmente sería aceptada mientras los datos no indiquen otra cosa. Cuando los datos se muestran contrarios a la hipótesis nula a la vez que favorables a la hipótesis alternativa, se rechaza la nula y se acepta la alternativa. El mecanismo no puede ser más simple, pero hay que tener cuidado con interpretarlo bien, pues pueden esconderse trampas de no emplearse con atención.

Un contraste se declara como **estadísticamente significativo**, cuando a partir de los resultados muestrales concluimos que se *rechaza la hipótesis nula*.

En los capítulos siguientes trataremos contrastes de hipótesis de frecuente uso en la ciencia médica, indicando en cada caso la hipótesis nula y la alternativa.

## Tipos de error, significación, nivel de significación y potencia
Al realizar un contraste de hipótesis hay dos tipos de errores posibles:

-	Rechazar la hipótesis nula, cuando esta es cierta. A esto se le denomina error de tipo I. 

-	No rechazar la hipótesis nula, cuando esta es falsa. Lo denominamos error de tipo II, y a la probabilidad de que ocurra se la denomina β. 

### Nivel de significación
Se denomina nivel de significación de un contraste, a la probabilidad de cometer un error de tipo I. La probabilidad de que este evento ocurra, es una cantidad que se fija de antemano (antes incluso de extraer las muestras) en un número pequeño denominado nivel de significación, y se representa con la letra α. Típicamente se elige un valor pequeño, 5% o 1%. Todo experimento, en su definición y antes de elegir las muestras, debe llevar descrito cuál es el criterio con el que rechazaremos una hipótesis. Esto se traduce en prefijar el nivel de significación del contraste.

Al leer un artículo, en la sección “material y métodos”, es frecuente encontrárselo referenciado en frases del estilo: “Se declararán significativos los contrastes cuando la significación sea inferior al 5%”. Esta frase debe entenderse como que se rechazará la hipótesis nula del contraste si, al examinar la muestra, se observa que discrepa tanto de la hipótesis nula, que si esta fuese realmente cierta, la probabilidad de obtener una muestra como la obtenida (o aún peor), es inferior al 5%. Dicho con otros términos, “Declaramos que no hay efecto, hasta que los datos nos indique otra cosa más allá de una duda razonable”.

### Significación
Se denomina significación de un contraste, y se suele representar con la letra p, al valor calculado tras observar la muestra, y que debería tomar el nivel de significación para estar en una situación donde dudemos entre rechazar o no una hipótesis.

Visto así, podemos considerar la significación como un indicador de la discrepancia entre una hipótesis nula y los datos muestrales. Cuanto más cercano sea a cero, más evidencia tenemos en contra de la hipótesis nula; Hasta el punto que cuando la significación es inferior al nivel de significación fijado de antemano (por ejemplo el 5%), directamente se rechaza la hipótesis nula (se ha superado el umbral de los que se había fijado de antemano como una “duda razonable a favor de que no hay efecto”)

### Potencia
La probabilidad de que no ocurra el error de tipo II, cuando esta puede calcularse, se la denomina potencia del contraste. Es decir, la potencia del contraste es una medida de la habilidad de un contraste para detectar un efecto que está presente.

En los casos en que es posible fijar la potencia del contraste suele tomarse valores como 85% o 90%. Aparece normalmente en contrastes donde la hipótesis alternativa afirma que no solo un tratamiento X es mejor que un placebo, sino que además es mejor en, al menos, cierta cantidad que se considera clínicamente significativa (no confundir con estadísticamente significativa).

Normalmente los programas estadísticos solamente hacen referencia a la significación de un contraste, y no a la potencia. Ello se debe a que para determinar la potencia es necesario que la hipótesis alternativa no sea simplemente una negación de la hipótesis nula, sino que debe especificar explícitamente una diferencia cuantitativa con ella.

Ejemplo: Se espera que un tratamiento X produzca un efecto beneficioso en la reducción del colesterol de al menos 10 unidades. Para ello se eligen dos grupos de pacientes de características similares y se prueba con un grupo un placebo y con el otro el tratamiento en cuestión. Mientras los datos no indiquen lo contrario pensaremos que el tratamiento no tiene efecto (no consigue reducir de media las 10 unidades). Esta es la hipótesis nula. La hipótesis alternativa es que el tratamiento sí tiene efecto (bajará el colesterol esas 10 unidades, o más). Un nivel de significación del 5% se interpreta como que a menos que los resultados del experimento discrepen suficientemente de que el tratamiento no tiene efecto, consideraremos que el tratamiento no sirve. Si el tratamiento muestra resultados muy buenos con respecto al placebo decidiremos que sí sirve, y rechazaremos la hipótesis nula. Por supuesto, excepcionalmente puede ocurrir que un tratamiento que no tiene ninguna utilidad muestre resultados buenos sobre una muestra, y acabemos concluyendo por error que es bueno. La probabilidad de que esto ocurra evidentemente esperamos que sea baja y es lo que hemos denominado nivel de significación. Supongamos que tras estudiar los resultados del experimento con algún contraste obtenemos que la significación es p=0.001=0.1%. Esto quiere decir que los resultados de la muestra son incoherentes con la hipótesis nula (son más improbables que el valor límite que fue fijado en 5%). Concluimos que hay evidencia estadísticamente significativa en contra de que el tratamiento no reduce el colesterol en al menos 10 unidades. ¿Cómo se interpreta la potencia en este ejemplo? Supongamos que el tratamiento realmente es efectivo (reduce al menos 10 unidades el colesterol). ¿Cuál sería la probabilidad de que una prueba estadística lo detecte (rechace la hipótesis nula)? Esta probabilidad sería la potencia.
 


<!--chapter:end:03-contHip.Rmd-->

