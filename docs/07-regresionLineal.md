


#Regresión lineal múltiple
Utilizamos regresión lineal múltiple cuando estudiamos la posible relación entre varias variables independientes (predictoras o explicativas) y otra variable dependiente (criterio, explicada, respuesta).

Por ejemplo, podemos estar interesados en saber cómo influyen en la presión arterial sistólica de un paciente el peso, la edad y el sexo, donde la variable sexo es una variable dicotómica (o indicadora), codificada como 0 para las mujeres y 1 para los hombres. 


La técnica de regresión múltiple se usa frecuentemente en investigación. Se aplica al caso en que la variable respuesta es de tipo numérico. Cuando la respuesta es de tipo dicotómico (muere/vive, enferma/no enferma), usamos otra técnica denominada regresión logística y que tratamos en un capítulo posterior.

####Ejemplo {-}
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
   <td style="text-align:left;"> Mujer </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> 190 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hombre </td>
   <td style="text-align:right;"> 56 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 192 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hombre </td>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> 190 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mujer </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:right;"> 85 </td>
   <td style="text-align:right;"> 193 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hombre </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 182 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mujer </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 195 </td>
  </tr>
</tbody>
</table>
Estudiamos el modelo de regresión lineal donde intentamos estudiar la inflencia de *sexo, edad, peso* en *pas*:

```r
ajuste <- df %>% lm(pas ~ sexo+edad+peso, data=.) 
tab_model(ajuste,show.se = TRUE) %>% return() %$% 
    knitr %>% 
    asis_output()
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="4" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">PresiÃ³n arterial<br>sistÃ³lica medida en mm Hg</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">std. Error</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">(Intercept)</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">100.49</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">8.50</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">83.82&nbsp;&ndash;&nbsp;117.16</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">sexoMujer</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">4.91</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.73</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.53&nbsp;&ndash;&nbsp;8.29</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.005</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">Edad del paciente en aÃ±os</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.41</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.08</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.25&nbsp;&ndash;&nbsp;0.57</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">Peso del paciente</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.15</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.06</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.03&nbsp;&ndash;&nbsp;0.28</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.018</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="4">429</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / adjusted R<sup>2</sup></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="4">0.074 / 0.067</td>
</tr>

</table>

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
   <th style="text-align:left;"> Dependent: pas </th>
   <th style="text-align:left;">  </th>
   <th style="text-align:left;"> Mean (sd) </th>
   <th style="text-align:left;"> Coefficient (univariable) </th>
   <th style="text-align:left;"> Coefficient (multivariable) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> sexo </td>
   <td style="text-align:left;"> Hombre </td>
   <td style="text-align:left;"> 140.9 (18.7) </td>
   <td style="text-align:left;"> - </td>
   <td style="text-align:left;"> - </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> Mujer </td>
   <td style="text-align:left;"> 143.9 (17.7) </td>
   <td style="text-align:left;"> 3.03 (-0.10 to 6.16, p=0.058) </td>
   <td style="text-align:left;"> 4.91 (1.52 to 8.30, p=0.005) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> edad </td>
   <td style="text-align:left;"> [31,93] </td>
   <td style="text-align:left;"> 142.7 (18.1) </td>
   <td style="text-align:left;"> 0.39 (0.25 to 0.54, p&lt;0.001) </td>
   <td style="text-align:left;"> 0.41 (0.25 to 0.57, p&lt;0.001) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> peso </td>
   <td style="text-align:left;"> [46.5,150] </td>
   <td style="text-align:left;"> 142.1 (17.5) </td>
   <td style="text-align:left;"> 0.03 (-0.10 to 0.15, p=0.671) </td>
   <td style="text-align:left;"> 0.15 (0.03 to 0.28, p=0.018) </td>
  </tr>
</tbody>
</table>

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> x </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Number in dataframe = 536, Number in model = 429, Missing = 107, Log-likelihood = -1818.96, R-squared = 0.074, Adjusted r-squared = 0.067 </td>
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

####Ejemplo
La base de datos [peso_altura_sexo.sav](datos/peso_altura_sexo.sav) contiene datos simulados que han sido contruidos para dar un modelo de regresión similar al descrito anteriormente. Una analisis de regresión nos ofrecería por resultado:


```r
df=read_sav("datos/peso_altura_sexo.sav") %>% haven::as_factor()
ajuste <- df %>% lm(Peso ~ Sexo+ Altura, data=.) 
tab_model(ajuste,show.se = TRUE) %>% return() %$% 
    knitr %>% 
    asis_output()
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="4" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">Peso</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">std. Error</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">(Intercept)</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-94.62</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">8.03</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-110.36&nbsp;&ndash;&nbsp;-78.87</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">SexoMujer</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-4.92</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.68</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-6.25&nbsp;&ndash;&nbsp;-3.59</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">Altura</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.97</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.05</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.88&nbsp;&ndash;&nbsp;1.06</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="4">200</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / adjusted R<sup>2</sup></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="4">0.749 / 0.746</td>
</tr>

</table>



###Ejemplo: Regresión lineal generaliza a las pruebas t-student para dos muestras, y ANOVA de un factor {-}
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
ajuste <- df %>% lm(Diferencia ~ gr1 + gr2, data=.) 
tab_model(ajuste,show.se = TRUE) %>% return() %$% 
    knitr %>% 
    asis_output()
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="4" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">Diferencia</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">std. Error</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">(Intercept)</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">9.87</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.58</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">8.74&nbsp;&ndash;&nbsp;11.01</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">Indic Técnica I</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">3.63</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">2.02&nbsp;&ndash;&nbsp;5.23</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">Indic Técnica II</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">3.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.61&nbsp;&ndash;&nbsp;4.83</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="4">66</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / adjusted R<sup>2</sup></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="4">0.272 / 0.249</td>
</tr>

</table>
y la salida del modelo ANOVA de un factor:


```r
modelo1 <- df %>% lm(Diferencia ~ Grupo, data=.) 
modelo1 %>% tab_model(show.se = TRUE) %>% return() %$% 
    knitr %>% 
    asis_output()
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="4" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">Diferencia</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">std. Error</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">(Intercept)</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">9.87</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.58</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">8.74&nbsp;&ndash;&nbsp;11.01</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">GrupoTécnica I</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">3.63</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">2.02&nbsp;&ndash;&nbsp;5.23</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">GrupoTécnica II</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">3.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.82</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.61&nbsp;&ndash;&nbsp;4.83</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="4">66</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / adjusted R<sup>2</sup></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="4">0.272 / 0.249</td>
</tr>

</table>
Realmente las dos formas de escribir el análisis han hecho exactamente lo mismo internamente.

Podemos refinar el estudio del siguiente modo: 

-	Variable dependiente: La diferencia entre la capacidad “después” y “antes”.

-	Variables explicativas:

  -	La capacidad al inicio del experimento. Posiblemente los estudiantes con mejor capacidad inicial sacaron menos provecho que el resto.
  
  - La técnica utilizada. Como es una variable categórica que se utiliza para identificar la muestra y tiene tres categorías podemos codificarla usando dos variables indicadoras (**gr1 y gr2**, o lo que será equivalente, considerar solo la variable *Grupo*).

El resultado del análisis sería:


```r
modelo2 <- df %>% lm(Diferencia ~ Grupo+Antes, data=.)
modelo2 %>%  tab_model(show.se = TRUE) %>% return() %$% 
    knitr %>% 
    asis_output()
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm;  text-align:left; ">&nbsp;</th>
<th colspan="4" style="border-top: double; text-align:center; font-style:normal; font-weight:bold; padding:0.2cm; ">Diferencia</th>
</tr>
<tr>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  text-align:left; ">Predictors</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">Estimates</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">std. Error</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">CI</td>
<td style=" text-align:center; border-bottom:1px solid; font-style:italic; font-weight:normal;  ">p</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">(Intercept)</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">13.56</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.29</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">11.03&nbsp;&ndash;&nbsp;16.09</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">GrupoTécnica I</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">3.41</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.77</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.90&nbsp;&ndash;&nbsp;4.92</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">GrupoTécnica II</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">2.83</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.78</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.30&nbsp;&ndash;&nbsp;4.35</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.001</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">Antes</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.47</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">0.15</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.76&nbsp;&ndash;&nbsp;-0.18</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>0.003</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="4">66</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / adjusted R<sup>2</sup></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left;" colspan="4">0.372 / 0.342</td>
</tr>

</table>

Obsérvese que al mejorar $R^2$ hemos obtenido un mejor modelo explicativo, independientemente de que nos interese o no la significación de la nueva variable introducida. En ocasiones es útil mostrar una comparativa entre varios modelos. La forma que se suele dar a la tabla para compararlos es la siguiente:






```r
tab_model(modelo1, modelo2,show.se = FALSE,show.aic = TRUE) %>% return() %$% 
    knitr %>% 
    asis_output()
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
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">8.74&nbsp;&ndash;&nbsp;11.01</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">13.56</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">11.03&nbsp;&ndash;&nbsp;16.09</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7"><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">GrupoTécnica I</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">3.63</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">2.02&nbsp;&ndash;&nbsp;5.23</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">3.41</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.90&nbsp;&ndash;&nbsp;4.92</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7"><strong>&lt;0.001</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">GrupoTécnica II</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">3.22</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.61&nbsp;&ndash;&nbsp;4.83</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "><strong>&lt;0.001</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">2.83</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">1.30&nbsp;&ndash;&nbsp;4.35</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7"><strong>0.001</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; ">Antes</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  "></td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.47</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  ">-0.76&nbsp;&ndash;&nbsp;-0.18</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center;  col7"><strong>0.003</strong></td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm; border-top:1px solid;">Observations</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">66</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; padding-top:0.1cm; padding-bottom:0.1cm; text-align:left; border-top:1px solid;" colspan="3">66</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left; padding-top:0.1cm; padding-bottom:0.1cm;">R<sup>2</sup> / adjusted R<sup>2</sup></td>
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


Para hacer lo mismo en SPSS, no se puede utilizar como hemos hecho aquí la variable *Grupo*, pero si las dos indicadoras (*gr1 y gr2*) que contienen la misma información. Para ello vamos a la opción de menú “Analizar – Regresión - Lineales”, y situamos en su lugar las variables independientes y la dependiente.

 

