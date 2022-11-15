# Regresión logística binaria
En ocasiones estamos interesados en conocer la influencia que una serie de variables tienen en una variable respuesta. Cuando la misma era numérica una herramienta que estaba a nuestra disposición era la regresión múltiple. Pero, ¿qué podemos hacer cuando la respuesta es dicotómica? Por ejemplo, ¿qué podemos hacer si la respuesta observada es el desarrollo o no de una enfermedad?

Este tipo de sitiaciones aparecen de manera natural en investigaciones médicas. Citemos unos cuantos ejemplos:

 -	Se cree que la apnea del sueño obstructiva es un factor de riesgo para la hipertensión arterial. Podríamos reformularlo en lenguaje estadístico como que la variable independiente padecer apnea obstructiva del sueño, está asociado (es factor de riesgo) para el la ocurrencia del evento hipertensión arterial.

-	Se cree que la intervención por laparoscopia para tratar la hernia de hiato ofrece menor riesgo de complicaciones postoperatorias que otra técnica tradicional. La variable respuesta sería padecer complicaciones (sí o no), y la variable independiente sería el tipo de operación.

-	Se cree que fumar es un factor de riesgo para la muerte fetal tardía. Esto se podría formular de varias maneras:

  -	Podemos considerar una variable independiente que es la “madre fuma” (sí o no) y una variable respuesta (dependiente) que es el “feto muere” (sí o no). Nos interesará evaluar cuánto aumenta el riesgo de que se pruduzca el evento de interés (muerte del feto) cuando está presente el factor de riesgo (la madre fuma).

  - Otra aproximación podría ser considerar como variable numérica “número medio de cigarrillos que fuma la madre”. En este caso nos puede interesar estimar cuánto aumenta el riesgo de muerte del feto, por cada cigarrilo adicional que fuma la madre diariamente.

 - Si el aumento del riesgo (se evalúe como se evalúe) no parece tener una tendencia constante con el número de cigarrillos, sino que mas bién se puede dividir a las madres en tres categorías “No fuma”, “Fuma poco”, “Fuma mucho”, nos interesará evaluar cómo aumenta el riesgo en las dos últimas categorías con respecto a las madres del primer grupo (grupo de control, o de referencia).

El **modelo de regresión logística binaria** es muy útil para abordar este tipo de cuestiones bajo la condición de que hayamos tenido en cuenta al realizar el estudio todas las variables importantes para explicar la variable respuesta, y que hagamos el estudio con una muestra suficientemente numerosa y bien distribuida.

Antes de pasar directamente al modelo de regresión logística vamos a refrescar rápidamente una serie de conceptos relacionados con la comparaciones de riesgos.

## Riesgo, Oportunidad, Riesgo Relativo y Odds Ratio
En medicina es frecuente encontrar todos estos términos. Vamos a repasarlos pues será necesario manejarlos con cierta soltura en el resto del capítulo.


> [Aquí tiene un simulador para practicar con **Odds Ratio**](https://www.bioestadistica.uma.es/app/oddsratio/)

En 1 de cada 200 nacimientos ocurre un parto gemelar. Por tanto la probabilidad o riesgo de que elegido un embarazo al azar éste de lugar a gemelos es de $R_1=1/200$. Esto es simplemente, el número de casos en que el evento ocurre dividido por el total de casos.

Hay otra forma de decir lo mismo, que seguramente ha sido tomada del lenguaje usado por los anglosajones en las apuestas. Consiste en la *oportunidad/ventaja* (del inglés *odds*). Podemos decir que de 200 partos, 1 es gemelar y 199 no lo son. Las apuestas están 1 a 199. Se denomina oportunidad a la cantidad $O_1=1/199$, es decir, el número de casos en los que el evento ocurre dividido por el número de casos en que no ocurre. En el fondo es sólo una manera anglosajona de decir lo mismo que con probabilidades. Hasta aquí no hay nada especial.

Compliquemos la cosa un poquito, introduciendo un factor de riesgo. Se observó que entre las mujeres que han tomado ácido fólico para disminuir la probabilidad de espina bífida en sus hijos, ocurrió algo no esperado: 3 de cada 200 partos eran gemelares. 
Esto corresponde a un riesgo de  $R_2=3/200$, o si lo preferimos, a una oportunidad (odds) de 3 a 197, $O_2=3/197$.

¿Cómo podemos expresar numéricamente el aumento del riesgo de embarazo gemelar? Hay dos maneras. Una de ellas es más fácil de entender, y la otra tiene mejores propiedades matemáticas.

-	**Riesgo Relativo (RR)**: Este es el más simple de entender. Claramente el riesgo ha aumentado por 3, lo que corresponde a un **Riesgo Relativo** (*RR*) que es el cociente entre el riesgo de los embarazos expuestos al ácido fólico (factor de riesgo) y los que no han sido expuestos, 
$$RR =  \frac{R_2}{R_1} =  \frac{3/200}{1/200} = 3$$

-	**Odds Ratio (OR)**: En español se traduce a veces en textos académicos como *Oportunidad Relativa* o *Razón de Ventajas*, aunque en las publicaciones aparece más frecuentemente con el término inglés. Es parecido al *RR*, pero usando oportunidades (odds). Es el  cociente entre la oportunidad de los embarazos expuestos al ácido fólico (factor de riesgo) y los que no han sido expuestos, 

$$OR = \frac{O_2}{O_1} =  \frac{3/197}{1/199} = 3.03$$

Desde luego no es tan fácil de interpretar una *OR* como lo es un *RR*, aunque en este caso poseen valores muy similares. Esto ocurre siempre que la probabilidad de que ocurra un evento sea cercana a cero, como en el caso de un embarazo gemelar. Cuando las probabilidades del evento no son cercanas a cero, ambas cantidades no son iguales y hay que tener cuidado con no confundirlas.

Tanto para  *OR* como *RR*,  tenemos las siguientes propiedades:

-	Un valor de $OR=1$ se interpreta como que no hay tal factor de riesgo, ya que la oportunidad para los expuestos es la misma que para los no expuestos.

-	 En epidemiología es frecuente intentar localizar factores dañinos. Eso corresponde a buscar valores de $OR \gt 1$. Se interpreta como qué se ha localizado un factor de riesgo, pues es mayor la oportunidad de que ocurra el evento a los expuestos al factor que a los controles.

-	En los ensayos clínicos, se persigue encontrar tratamientos que reduzcan la frecuencia de un evento (por ejemplo, la muerte del enfermo). En este caso se buscan valores $OR \lt 1$. Es decir, que sea menor la oportunidad de que ocurra el evento en los individuos expuestos al tratamiento que en los controles.

Por otro lado $OR$ tiene muy buenas propiedades matemáticas:

- $OR$ toma valores entre cero e infinito. Esto lo hace muy adecuado para ser modelado matemáticamente. Sobre todo si tomamos su logaritmo, ya que en ese caso cualquier valor es posible. El modelo que consideraremos posteriormente será el de regresión logística.

-	El modelo logístico de regresión puede usarse para determinar intervalos de confianza para la $OR$:
  -	Si dichos intervalos contienen al valor $OR=1$, no puede rechazarse que el factor de riesgo (o el tratamiento) no sea tal. 
  -	En otro caso decimos que aumenta o disminuye la oportunidad del evento en función de que el intervalo de confianza sea de valores mayores o menores que uno respectivamente.

-	Cuando se evalúa la eficacia de una prueba diagnóstica es razonablemente simple conocer la sensibilidad y especificidad de la misma, pero los valores predictivos requieren del conocimiento de la prevalencia, que no está siempre disponible. Si realizamos un estudio caso-control, donde la prevalencia de la enfermedad es desconocida, aunque no podamos calcular índices predictivos, siempre podremos estimar la $OR$. Si la enfermedad (el evento de interés) es rara, podemos considerarla como una aproximación del $RR$, que tiene una interpretación muy natural.

## El modelo de regresión logística binaria
Si tenemos una variable que describe una respuesta en forma de dos posibles eventos (vivir o no, enfermar o no), y queremos estudiar el efecto que otras variables (independientes) tienen sobre ella (fumar, edad), el modelo de regresión logística binaria puede resultarnos de gran utilidad para:

-	Dado los valores de las variables independientes, estimar la probabilidad de que se presente el evento de interés (por ejemplo, enfermar.)

-	 Podemos evaluar la influencia que cada variable independiente tiene sobre la respuesta, en forma de OR. Una OR mayor que uno indica aumento en la probabilidad del evento y OR menor que uno, implica disminución.

Para construir un modelo de regresión logística binarianecesitamos:

-	Un conjunto de variables independientes o predictoras, muy en el estilo de la regresión lineal múltiple.

-	Una variable respuesta dicotómica. Aquí se diferencia del modelo de regresión múltiple, donde la variable respuesta era numérica.

### Codificación de las variables

Para simplificar la interpretación del análisis del modelo de regresión logística es conveniente llegar a cierto convenio en la codificación de las variables. Realmente compensa seguir las siguientes recomendaciones:

-	En la variable dependiente se codifica como 1 la ocurrencia del evento de interés y como 0 la ausencia.

-	Las variables independientes pueden ser varias y cada una de un tipo diferente. Analicemos cada caso:

  -	Caso dicotómico: Se codifica como 1 el caso que se cree favorece la ocurrencia del evento. Se codifica como 0 el caso contrario. Por ejemplo con 0 codificamos típicamente a los individuos no expuestos a un posible factor de riesgo (casos de referencia, controles), y como 1 a los expuestos.

  -	Caso categórico: Cuando la variable independiente puede tomar más de dos posibles valores podemos codificarlas usando variables indicadoras (dummy), como se hacía con el modelo de regresión lineal múltiple. Si estamos usando SPSS, el programa nos ayuda a hacerlo sobre la marcha (hay que indicar el diálogo de regresión logística qué variables son categóricas). Es necesario destacar una modalidad que represente al caso de referencia, y al que le corresponde la codificación con todas las variables indicadoras puestas a 0.

  -	Caso de variable numérica: pueden darse dos situaciones:
    -	Si creemos que por cada unidad que aumente la variable, la OR aumenta en un factor multiplicativo constante, podemos usar la variable tal cual en el modelo.  Si tenemos dudas de que esto sea así, o no sepamos ni siquiera lo que significa la frase anterior, mejor olvidamos esta posibilidad y consideramos la siguiente;
    - Si creemos que la variable numérica puede afectar a la respuesta, pero no tenemos muy claro de qué manera, podemos “categorizar” la variable. Esto consiste por ejemplo en estratificar la variable en valores pequeños, medianos y grandes. Los puntos de corte los podemos elegir nosotros manualmente, o usar cortes automáticos basados en que cada categoría tenga el mismo número de observaciones (usando percentiles). En SPSS la opción de menú “Transformar – Categorizador visual…” de SPSS nos puede ser de gran ayuda.

### Requisitos y limitaciones
Además de las mencionadas en cuanto a los criterios para codificar la variables debemos tener en cuenta muchas otras cuestiones para confiar en la validez del modelo. De entre ellas destacamos:

-	Los parámetros del modelo se calculan usando una estimación de máxima verosimilitud. Estas sólo son válidas cuando para cada combinación de variables independientes tenemos un número suficientemente alto de observaciones. Si los parámetros estimados en el modelo son anormalmente grandes, posiblemente esta condición sea violada. Tal vez se solucione el problema agrupando categorías (donde tenga sentido).

-	 No debemos introducir variables innecesarias. Ver el punto anterior.

-	Ninguna variable relevante debe ser excluida. Si identificamos variables confusoras, tengámoslas en cuenta introduciéndolas en el modelo o estratificando el estudio en submuestras.

-	La colinealidad es un problema como ocurría en la regresión lineal múltiple. Si los errores típicos en la estimación de los coeficientes, o los intervalos de confianza son anormalmente grandes, es posible que esta situación se esté dando.

### Interpretación del modelo
El modelo de regresión logística puede escribirse como:
 
 $$\log(\frac{p}{1-p})=b_0 + b_1 x_1 +b_2 x_2+\dots$$
donde $p$ es la probabilidad (riesgo) de que ocurra el evento de interés, las variables independientes están representadas con la letra $x$, y los coeficientes asociados a cada variable con la letra $b4. Tal vez con esa expresión el modelo no resulte muy elocuente, pero tras unas transformaciones, que nos mostramos para ahorrar espacio mostramos lo que resulta de mayor interés:

$$
p=\frac{e^{suma}}{1+e^{suma}}, \mbox{ siendo } suma=b_0 + b_1 x_1 +b_2 x_2+\dots
$$

-	Dado el valor de las variables independientes, podemos calcular directamente la estimación del riesgo de que ocurra el evento de interés:
 
-	La oportunidad (odds) para los individuos donde todos $x_i$ vale cero es $e^{b_0}$. En estudios caso-control, estos suelen ser los controles.

-	Si nos fijamos en cualquier otro coeficiente del modelo, la cantidad $e*{b_i}$  coincide con la **OR** del aumento del valor de $x_i$ en una unidad con respecto a aquellos individuos que presentan los valores de todas las demás variables iguales. Si hemos seguido el criterio de codificación recomendado, y la variable de la que hablamos es dicotómica, esto corresponde a la **OR** del factor de riesgo $x_i$. Si la variable es numérica como el número de bypass coronarios, estima la OR del factor de riesgo “tener un bypass más”.

Hay mucho que interpretar en una salida de ordenador en un cálculo de regresión logística. Aquí vamos a mencionar sólo algunas de las que consideramos más interesantes en una primera aproximación:

-Significación de cada coeficiente del modelo (basada en el estadístico de Wald): Ofrece el equivalente a la significación de los coeficientes de regresión lineal múltiple. Si una variable independiente resulta no significativa podemos considerar eliminarla del modelo (a menos que esté confundida con otra variable independiente significativa, claro está).
La significación del estadístico de Wald para el coeficiente bi es la que corresponde a contrastar la hipótesis nula de que éste vale cero. O lo que es lo mismo que la OR asociada, exp(bi)=1, es decir, que la variable xi no es factor de riesgo y por ello podemos olvidarnos de ella a menos que la encontremos confundida con otra que sí lo sea.

-	 $e^{b_i}=OR$ estimada para la variable $x_i$, donde $b_i$ Aparecen en la columna “B” de la salida de SPSS. Más interesante aún son los intervalos de confianza para la $Exp(bi)=OR$  (si hemos marcado la opción para que los calcule). Si no contienen al valor uno, es señal de que la variable es de interés en el modelo. Estadísticamente es  lo mismo que lo mencionado en el punto anterior, pero de este modo tiene más significado clínico.

> Para interpretar un modelo de regresión logística binaria, siga el enlace: [https://www.bioestadistica.uma.es/analisis/logistica/](https://www.bioestadistica.uma.es/analisis/logistica/)


El análisis con SPSS de la base de datos que descargaremos de allí (datos/regresionLogistica.sav)[datos/regresionLogistica.sav] lo haremos en el menú de SPSS: "Analizar - Regresión - Logística binaria", colocando en el campo "Dependiente" la variable *Enfermedad*, y en las demás en el campo "Covariables". Es conveniente pedir que se muestren los intervalos de confianza para Odds Ratios. Para ello en el botón "Opciones" marcamos "CI para exp(B)". Los valores *Exp(B)* y sus intervalos de confianza en la tabla nos muestran las *OR*. También conviene marcar la casilla de cálculo de *Bondad de ajuste de Hosmer-Lemeshow*. Esta es una prueba que cuanto más alejado esté de la significación mejor indicador es de que el modelo de regresión logística no es es inadecuado para los datos.





