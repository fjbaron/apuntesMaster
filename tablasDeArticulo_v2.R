
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'


#' Crea tabla de resumen descriptivo para variables numéricas
#'
#' Toma un data frame, una lista de noombres de variables numéricas, una traducción de los nombres de las variables a descripciones más
#'
#'@param df El data frame
#'@param vNumericas El vector que contiene los nombres de las variables numéricas
#'@param traduccion Puede consistir en repetir el vector vNumericas o bien unos textos que sustituyan el nombre
#'de cada variable en la tabla de resultado
#'
#' @return Una tabla con las columnas de descriptiva que se indiquen para cada variable numérica
#'
#' @export
#'


library(exact2x2)
library(apaTables)
library(MBESS)
library(effsize)

#Solo una minimodificación para probar.
#Ahora desde rstudio
#\u00B1 = ±
desc1vn=function(df,vNum,formato="%1.2f\u00B1%1.2f",formatoIntervalo="%1.2f-%1.2f",columnas=NULL){
  shapiro50="-"
  shapiro.p=1
  resultado=tibble("Fallo"=1,"n"=0,"media"=NA, "mediadt"="","mediaet"="","medianaRI"="","rango"="","gauss"="","out3SD"=NA,"out5SD"=NA,"shapiro"="","p25"=NA,"p50"=NA,"p75"=NA,"p.intra"="",ic1=NA,ic2=NA)

  try({
    datos=df[[vNum]][!is.na(df[[vNum]])]


    if(length(datos)>0){
      if(length(datos)>4){
        set.seed(10)
        try({
          shapiro50.p=shapiro.test(sample(datos,min(40,length(datos))))$p.value
        }, silent = TRUE)
        subdatos=datos
        if(length(datos)>4900) subdatos=subdatos[1:4900]
        try({
          shapiro.p=shapiro.test(subdatos)$p.value
          shapiro50=c("No","Ok")[1+as.integer(max(shapiro50.p,shapiro.p)>0.01)]
        }, silent = TRUE)
      }
      zdatos=abs(scale(datos))
      zout3SD=sum(zdatos>3,na.rm=T)
      zout5SD=sum(zdatos>5,na.rm=T)

      if(length(datos)>1) anchoIC=qt(.975,length(datos)-1) else anchoIC=NA

      resultado=df %>% mutate(numerica=df[[vNum]]) %>% summarise(
        n=length(datos),
        media=mean(numerica,na.rm=T),
        dt=sd(numerica,na.rm=T),
        et=dt/sqrt(n-1),
        minimo=min(numerica,na.rm=T),
        maximo=max(numerica,na.rm=T),
        p25=round(quantile(numerica,.25,na.rm=T),1),
        p50=round(quantile(numerica,.50,na.rm=T),1),
        p75=round(quantile(numerica,.75,na.rm=T),1),
        mediadt=sprintf(formato,media,dt),
        mediaet=sprintf(formato,media,et),
        medianaRI=sprintf(formato,p50,p75-p25),
        rango=sprintf(formatoIntervalo,minimo,maximo),
        gauss=shapiro50,
        shapiro=pvalores(shapiro.p),
        out3SD=zout3SD,
        out5SD=zout5SD,
        p.intra=pvalores(2*pt(abs(media/et),n-1,lower.tail = F)),
        ic1=media-anchoIC*et,
        ic2=media+anchoIC*et
      )
    }
  }, silent = TRUE)
  if(!is.null(columnas)) resultado=resultado[names(resultado) %in% columnas]
  resultado
}



descChi2=function(df,vCualiFila,vCualiColumna,margin=2,formato="%1.1f(%d)"){
  if(!is.factor(df[[vCualiFila]])) df[[vCualiFila]]=factor(df[[vCualiFila]])
  if(!is.factor(df[[vCualiColumna]])) df[[vCualiColumna]]=factor(df[[vCualiColumna]])
  frecuencias=xtabs( formula(sprintf("~ %s+%s",vCualiFila,vCualiColumna)),data=df)
  porcentajes=100*prop.table(frecuencias,margin=margin)
  resultado=as_tibble(matrix(sprintf(formato,porcentajes,frecuencias),nrow = dim(frecuencias)[1],ncol= dim(frecuencias)[2]))%>%
    setNames(levels(df[[vCualiColumna]]))  %>%
  add_column(Valores=levels(df[[vCualiFila]]),.before=1) %>%
  add_column(Variable=vCualiFila,.before=1) %>%
  mutate(p="")

  options(warn=-1)
  try({
    analisis=vDeCramer(df[[vCualiFila]],df[[vCualiColumna]])
    resultado$p=pvalores(analisis$p.value)
    resultado$p.value=analisis$p.value
    resultado$effSize=analisis$estimate
    resultado$effSize_min=analisis$conf.int[1]
    resultado$effSize_max=analisis$conf.int[2]
    resultado$effSize_mag=analisis$magnitude
  }, silent = TRUE)
  options(warn=0)


  resultado
  }






descTtest=function(df,vNum,vFac,formato="%1.2f",columnas=NULL){
  res=tibble("Error"=1,"p.t"="-","t"="-","dif"="-","ci_min"=NA,"ci_max"=NA,"ci95"="-","W"="-","p.w"="-", "p.value"="-","effSize"="-","effSize_min"="-","effSize_max"="-","effSize_lab"="-")
  try({
    modelo=        t.test(formula(sprintf("%s ~ %s",vNum,vFac)),data=df)
    modelo.mw=wilcox.test(formula(sprintf("%s ~ %s",vNum,vFac)),data=df)
    modelo.cohen= cohen.d(formula(sprintf("%s ~ as.factor(%s)",vNum,vFac)),data=df)
    res=tibble("p.t"=pvalores(modelo$p.value),
                   "t"=round(modelo$statistic,2),
                   "dif"=-modelo$estimate[2]-modelo$estimate[1],
                   "ci_min"=-modelo$conf.int[2],
                   "ci_max"=-modelo$conf.int[1],
                   "ci95"=sprintf(sprintf("%s[%s,%s]",formato,formato,formato),-modelo$estimate[1]+modelo$estimate[2],-modelo$conf.int[2],-modelo$conf.int[1]),
                   "W"=round(modelo.mw$statistic,3),
                   "p.w"=pvalores(modelo.mw$p.value),
                   "p.value"=modelo$p.value,
                   "effSize"=modelo.cohen$estimate,
                   "effSize_min"=modelo.cohen$conf.int[1],
                   "effSize_max"=modelo.cohen$conf.int[2],
                   "effSize_mag"=modelo.cohen$magnitude
    )
  }, silent = FALSE)
  if(!is.null(columnas)) res=res[names(res) %in% columnas]
  res
}

########ZZZZZZZZZZ
descAnova1F=function(df,vNum,vFac,formato="%1.3f",columnas=NULL){
  res=tibble("Error"=1,"p.F"="-", "p.value"="-","F"="-","p.kw"="-",
             "effSize"="-","effSize_min"="-","effSize_max"="-","effSize_lab"="-",
             "gauss"="-","shapiro"="-")
  shapiro50=shapiro.p=p.kw=NA

  laFormula=formula(sprintf("%s ~ as.factor(%s)",vNum,vFac))
  try({
    #modelo=summary(lm(laFormula,data=df))
    #datos=modelo$residuals[!is.na(modelo$residuals)]

    modelo=aov(laFormula,data=df)
    omega2=omega_sq(modelo,ci.lvl=0.95)
    anova.b=anova(modelo)
    datos=modelo$residuals[!is.na(modelo$residuals)]
    if(length(datos)>0){
      if(length(datos)>4){
        set.seed(10)
        try({
          shapiro50.p=shapiro.test(sample(datos,min(40,length(datos))))$p.value
        }, silent = TRUE)
        subdatos=datos
        if(length(datos)>4900) subdatos=subdatos[1:4900]
        try({
          shapiro.p=shapiro.test(subdatos)$p.value
          shapiro50=c("No","Ok")[1+as.integer(max(shapiro50.p,shapiro.p)>0.01)]
        }, silent = TRUE)
      }
    }
    try ({
      kw=kruskal.test(laFormula, data = df)
      p.kw=kw$p.value
    }, silent = FALSE)

    try({
      res=tibble("p.F"=pvalores(anova.b$`Pr(>F)`[1]),
                  "p.value"=anova.b$`Pr(>F)`[1],
                 "F"=round(anova.b$`F value`,2)[1],
                 "p.kw"=pvalores(p.kw),
                 "effSize"=max(0,omega2$omegasq),
                 "effSize_min"=max(0,ifelse(is.na(omega2$conf.low),0,omega2$conf.low)),
                 "effSize_max"=omega2$conf.high,
                 "effSize_mag"=cut(abs(omega2$omegasq), breaks=c(-Inf, 0.01, 0.06, 0.14, Inf), labels=c("negligible","small","medium","large")),
                 "gauss"=shapiro50,
                 "shapiro"=pvalores(shapiro.p)
                 )
    }, silent = FALSE)
  }, silent = FALSE)

  rownames(res)=NULL
  if(!is.null(columnas)) res=res[names(res) %in% columnas]
  res
}






descAnova1Fijo1Random=function(df,vCodigo,vNum,vFacFijo,vFacRandom){
  nFilas=length(unique(df[[vFacRandom]]))
  #Por si falla ANOVA
  res=tibble(
    "F.FacFijo"=rep("-",nFilas),
    "p.FacFijo"=rep("-",nFilas),
    "F.FacRandom"=rep("-",nFilas),
    "p.FacRandom"=rep("-",nFilas),
    "F.Inter"=rep("-",nFilas),
    "p.inter"=rep("-",nFilas)
  )

  try({

    modelo=lme(formula(sprintf("%s ~ %s*%s", vNum,vFacFijo,vFacRandom)),random= formula(sprintf("~1|%s",vCodigo)) ,
               correlation=corCompSymm(form=formula(sprintf("~1|%s",vCodigo))),
               data=df%>% filter(complete.cases(df[c(vCodigo,vFacFijo,vFacRandom,vNum)])))
    analisis=anova(modelo)


    res=tibble(
      "F.FacFijo"=rep(sprintf("F(%d,%d)=%1.1f",analisis$numDF[2],analisis$denDF[2],analisis[["F-value"]][2]),nFilas),
      "p.FacFijo"=rep(pvalores(analisis[["p-value"]][2]),nFilas),
      "F.FacRandom"=rep(sprintf("F(%d,%d)=%1.1f",analisis$numDF[3],analisis$denDF[3],analisis[["F-value"]][3]),nFilas),
      "p.FacRandom"=rep(pvalores(analisis[["p-value"]][3]),nFilas),
      "F.Inter"=rep(sprintf("F(%d,%d)=%1.1f",analisis$numDF[4],analisis$denDF[4],analisis[["F-value"]][4]),nFilas),
      "p.inter"=rep(pvalores(analisis[["p-value"]][4]),nFilas)
    )

  }, silent = TRUE)


  res %>%
    setNames(paste(c("F","p","F","p","F","p"),c(vFacFijo,vFacFijo,vFacRandom,vFacRandom,"Interaccion","Interaccion"), sep="."))%>%
    mutate(Variable=vNum,Tiempo=unique(df$Tiempo)) %>%
    select(Variable, Tiempo,everything())
}

descMWtest=function(df,vNum,VFac){
  modelo=wilcox.test(formula(sprintf("%s ~ %s",vNum,vFac)),data=df)
  tibble("p.w"=pvalores(modelo$p.value),
             "w"=modelo$statistic
  )
}



lineaNumerica=function(df,vNum,vFac,columnas=c("n","mediaet","t","p.t","ci95", "W","p.w")){
  extra_t=tibble("Vacio"=1)
  bloques1f=split(df,df[[vFac]]) %>% map(function(df){desc1vn(df,vNum,columnas=columnas)})
#  try({
    extra_t=descTtest(df,vNum,vFac,"%1.3f",columnas=columnas)
#  }, silent = TRUE)
  res=Reduce(cbind,list(Reduce(cbind,bloques1f),extra_t))
  cbind(Variable=vNum,res)
}


desc2x2=function(df,vFila,vCol,fila=2 ){
    res=data.frame("Variable"=vFila,vRef="-",C1="-",C2="-",C3="-",p="-",dif="-",RR="-")
    tabla=xtabs( formula(sprintf("~ %s+ %s" ,vFila,vCol)),data=df)
  try({
    tabla.total=addmargins(tabla,2)
  tabla.total.total=addmargins(tabla.total,1)
  tabla.prop=prop.table(tabla.total,2)
  res=data.frame(Variable=vFila,vRef=dimnames(tabla)[[1]][fila],C1="",C2="",C3="")
  names(res)[3:5]=dimnames(tabla.total)[[2] ]
  res[1,3:5]=sprintf("%1.3f(%s/%s)",tabla.prop[fila,],tabla.total.total[fila,],tabla.total.total[3,])
  res.dif=binomMeld.test(tabla[2,1],tabla.total.total[3,1],tabla[2,2],tabla.total.total[3,2],conf.int = T,parmtype = "difference")
  res.rr=binomMeld.test(tabla[2,1],tabla.total.total[3,1],tabla[2,2],tabla.total.total[3,2],conf.int = T,parmtype = "ratio")
  #   res.or=binomMeld.test(tabla[2,1],tabla.total.total[3,1],tabla[2,2],tabla.total.total[3,2],conf.int = T,parmtype = "odds")


    res=res %>% mutate(p=pvalores(res.dif$p.value),
                       dif=sprintf("%1.3f[%1.3f-%1.3f]",res.dif$estimate,res.dif$conf.int[1],res.dif$conf.int[2]),
                       RR=sprintf("%1.3f[%1.3f-%1.3f]",res.rr$estimate,res.rr$conf.int[1],res.rr$conf.int[2])
                       #OR=sprintf("%1.3f[%1.3f-%1.3f]",res.or$estimate,res.or$conf.int[1],res.or$conf.int[2])
    )
  }, silent = FALSE)
  res=res %>% select(Variable,vRef,everything()) %>% as_tibble()
  res
}



#
# Funciones para mostrar significaciones
#




asteriscos=function(y){
  sapply(y,function(x){
    resultado=""
    if(!is.na(x)){
      if(x<0.10) resultado="."
      if(x<0.05) resultado="*"
      #      if(x<0.01) resultado="**"
      #      if(x<0.001) resultado="***"
    }
    resultado
  })
}


asteriscos2=function(y){
  sapply(y,function(x){
    resultado=""
    if(!is.na(x)){
      if(x<0.05) resultado="*"
      if(x<0.01) resultado="**"
      if(x<0.001) resultado="***"
    }
    resultado
  })
}

pvalores=function(y){
  sapply(y,function(x){
    resultado="---"
    if(!is.na(x)){
      resultado="n.s."
      if(is.numeric(x)){
        if(x<1.15) resultado=sprintf("%1.3f%s",x,asteriscos(x))
        if(x<0.001) resultado=sprintf("<0.001%s",asteriscos(x))
      }
    }
    resultado
  })
}





######################################3
#Parte funcional
###################################33





generaTablaDescriptivaNumericas=function(df,vNumericas,traduccion,columnas=c("n","mediaet","gauss","rango","out3SD","out5SD")){
  if(is.null(traduccion)) traduccion=vNumericas
  listaLineas= vNumericas %>% map ( ~ desc1vn(df,.,columnas=columnas))
  longitud=listaLineas %>% map_int(length)
  listaLineas[longitud==max(longitud)] %>% reduce(rbind) %>%
    mutate(Variable=traduccion) %>%
    select(Variable, everything())
}








generaTablaDescriptivaNumericasPorTiempo=function(df,TiempoFactor,vNumericas,traduccion=NULL,columnas=c("n","mediaet","gauss","rango","out3SD","out5SD")){
  if(is.null(traduccion)) traduccion=vNumericas
  names(traduccion)=vNumericas
  df=as.data.frame(df)
  tablaRes=Reduce(rbind,lapply(vNumericas, function(vNum)Reduce(rbind,lapply(
    split(df,df[,c(TiempoFactor)]),
    function(df)desc1vn(df,vNum,columnas=columnas))) %>%
      mutate(Tiempo=levels(df[,TiempoFactor])) %>%
      select(Tiempo,everything()) %>%
      mutate(Variable=traduccion[vNum]) %>%
      select(Variable, everything()))
  )
  tablaRes
}








generaTablatTestPorGrupo=function(df,vGrupo,vNumericas,traduccion=NULL,columnas=c("n","mediaet","ci95" ,"p.t","p.w")){
 if(is.null(traduccion)) traduccion=vNumericas
  names(traduccion)=vNumericas
  vNumericas %>% map (function(vNum)
                        split(df,df[[vGrupo]]) %>% map(
                          function(dfGr){
                            desc1vn(dfGr, vNum,columnas=columnas) %>%
                            setNames(sprintf("%s.%s",names(.),as.character(dfGr[[vGrupo]][1])))
                        }
                    ) %>% append(list(descTtest(df,vNum,vGrupo,columnas=columnas))) %>%
                      reduce (cbind) %>%
                      mutate(Variable=traduccion[vNum]) %>%
                      select(Variable,everything())
                    ) %>%
                  reduce (rbind) %>%
                  as_tibble()
}



generaTablatTestPorTiempoGrupo=generaTablatTestPorGrupo_Tiempo=function(df,vGrupo,vTiempo,vNumericas,traduccion=NULL,columnas=c("n","mediaet","p.t","ci95","p.w")){
  if(is.null(traduccion)) traduccion=vNumericas
  names(traduccion)=vNumericas

  df %>% split(df[[vTiempo]]) %>%
    map(
      function(dfx) generaTablatTestPorGrupo(dfx,vGrupo,vNumericas,traduccion,columnas) %>%
        mutate(.Orden=1:n(),
               Tiempo=dfx[[vTiempo]][1])
      ) %>%
    reduce(rbind) %>%
    arrange(.Orden,Tiempo) %>%
    select(Variable,Tiempo,everything(),-.Orden)
}





generaTablaANOVA1F=function(df,vGrupo,vNumericas,traduccion=NULL,columnas=c("n","mediaet","p.F","p.kw")){
  if(is.null(traduccion)) traduccion=vNumericas
  names(traduccion)=vNumericas
  vNumericas %>% map (function(vNum)
                      split(df,df[,vGrupo]) %>%
                        map(function(dfGr){
                          desc1vn(dfGr, vNum,columnas=columnas) %>%
                          setNames(sprintf("%s.%s",names(.),as.character(dfGr[[vGrupo]][1])))
                      }
                    ) %>% append(list(descAnova1F(df,vNum,vGrupo,columnas=columnas))) %>%
                    reduce (cbind) %>%
                    mutate(Variable=traduccion[vNum]) %>%
                    select(Variable,everything())
                  ) %>%
    reduce(rbind) %>%
    as_tibble()
}

generaTablaANOVA1FPorTiempo=generaTablaANOVA1F_Tiempo=function(df,vGrupo,vTiempo,vNumericas,traduccion=NULL,columnas=c("n","mediaet")){
  if(is.null(traduccion)) traduccion=vNumericas
  names(traduccion)=vNumericas

  df %>% split(df[[vTiempo]]) %>%
    map(
      function(dfx) generaTablaANOVA1F(dfx,vGrupo,vNumericas,traduccion,columnas) %>%
        mutate(.Orden=1:n(),
               Tiempo=dfx[[vTiempo]][1])
    ) %>%
    reduce(rbind) %>%
    arrange(.Orden,Tiempo) %>%
    select(Variable,Tiempo,everything(),-.Orden)
}



generaTablaChi2PorGrupo=function(df,vGrupo,vCuali,traduccion=NULL,margin=2){
  if(is.null(traduccion)) traduccion=vCuali
  names(traduccion)=vCuali
  vCuali=vCuali[vCuali!=vGrupo]
  vCuali %>% map(function(vCualiFila) descChi2(df, vCualiFila,vGrupo,margin)) %>% reduce(rbind) %>%
    mutate(Variable=traduccion[Variable])
}





generaTabla2x2PorGrupo=function(df,vGrupo,vCuali,traduccion=NULL,fila=2){
  if(is.null(traduccion)) traduccion=vCuali
  names(traduccion)=vCuali
  vCuali=vCuali[! vCuali==vGrupo]
  vCuali %>% map(function(vCualiFila) desc2x2(df, vCualiFila,vGrupo,fila)) %>% reduce(rbind) %>%
    mutate(Variable=traduccion[Variable])
}


generaTablaChi2PorGrupo_Tiempo=function(df,vGrupo,vTiempo,vCuali,traduccion=NULL,fila=2){
  if(is.null(traduccion)) traduccion=vCuali
  names(traduccion)=vCuali
  vCuali=vCuali[! vCuali %in% c(vGrupo,vTiempo)]
  df %>% split(df[[vTiempo]]) %>%
    map(
      function(dfx) generaTablaChi2PorGrupo(dfx,vGrupo,vCuali,traduccion,fila) %>%
        mutate(.Orden=1:n(),
               Tiempo=dfx[[vTiempo]][1])
    ) %>%
    reduce(rbind) %>%
    select(Variable,Tiempo,everything(),-.Orden)
}



generaTablaBinariasPorTiempoGrupo=generaTabla2x2PorGrupo_Tiempo=function(df,vGrupo,vTiempo,vCuali,traduccion=NULL,fila=2){
  if(is.null(traduccion)) traduccion=vCuali
  names(traduccion)=vCuali

  df %>% split(df[[vTiempo]]) %>%
    map(
      function(dfx) generaTabla2x2PorGrupo(dfx,vGrupo,vCuali,traduccion,fila) %>%
        mutate(.Orden=1:n(),
               Tiempo=dfx[[vTiempo]][1])
    ) %>%
    reduce(rbind) %>%
    arrange(.Orden,Tiempo) %>%
    select(Variable,Tiempo,everything(),-.Orden)
}




vDeCramer=function(datosFila,datosColumna){
  mat=xtabs(~datosFila+datosColumna)
  if(nrow(mat)<2 | ncol(mat)<2) error("Las dimensiones de la tabla no son adecuadas para calcular V de Cramer")
  #You could get similar results using a conversion to Fisher Z and then back again. I.e.:
  #"mat" being a r x c matrix/table
  test=chisq.test(mat)

  chicalc <- test$statistic
  p=test$p.value
  # calculate Cramer's v -
  K <- min(nrow(mat),ncol(mat))
  crv <- sqrt(chicalc / (sum(mat)*(K-1)))

  # convert the Cramer's V to a Fisher's Z
  fz <- 0.5 * log((1 + crv)/(1 - crv))

  # calculate 95% conf.int around Fisher Z
  conf.level <- 0.05
  se <- 1/sqrt(sum(mat)-3) * qnorm(1-(conf.level/2))
  cifz <- fz + c(-se,se)

  # convert it back to conf.int around Cramer's V
  cicrv <- (exp(2 * cifz) - 1)/(1 + exp(2 * cifz))
  list(p.value=test$p.value,estimate=crv,conf.int=cicrv,magnitude=cut(crv, breaks=c(-Inf,0.1, 0.30, 0.5, Inf), labels=c("negligible","small","medium","large")))
}











































###############################################
# Funciones que a veces vienen bien

saneaACENTOS=function(x){chartr("áâàèêéìîíòôóùûúüÁÀÂÈÊÉÌÍÎÒÓÔÚÜÛÙÛñÑºª","aaaeeeiiiooouuuuAAAEEEIIIOOOUUUUUnN..",x)}

limpiaCaracteres=function(x){
  if(is.null(x)) x=""
  if(is.na(x)) x=""
  x=chartr("áâàèêéìîíòôóùûúüÁÀÂÈÊÉÌÍÎÒÓÔÚÜÛÙÛñÑºª","aaaeeeiiiooouuuuAAAEEEIIIOOOUUUUUnN..",x)
  x=str_replace_all(x,"'","")
  x
}


clase=function(v){
  resultado=class(v)
  if(resultado=="factor") v=as.character(v)
  if(resultado=="character" | resultado=="factor"){
    v=str_trim(as.character(v),"both")
    #Probar si es de verdad
    relleno=(!is.na(v)) & v!=""
    if(sum(relleno)==0){
      resultado="vacio"
    } else {#Probemos si son numeros
      options(warn=-1)
      numeros=!is.na(as.numeric(v))
      options(warn=1)
      if (sum(numeros|!relleno)==length(v)){
        #Son numeros
        resultado="numeric"
      } else {#Probemos si son fechas
        numFechas=sum(!is.na(str_extract(v[relleno],"^[1-2][0,1,9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]$")))
        if(numFechas==sum(relleno)){
          #Todo son fechas.
          resultado="fecha"
        }
      }
    }
  }
  resultado
}


esEntero=function(v){
  resultado=FALSE
  tipo=clase(v)
  if(tipo=="numeric") {
    v=as.numeric(v)
    w=v[!is.na(v)]
    if(all(w==as.integer(w))) resultado=TRUE
  }
  resultado
}



# INPUT
rbindMioRestringido=function(dfA,dfB){
  if(class(dfA)!="data.frame"| class (dfB)!="data.frame") stop("Solo vale con DataFrames");

  faltaEnB=names(dfA)[!names(dfA) %in% names(dfB)]
  if (length(faltaEnB)>0){
    for (v in faltaEnB) dfB[,v]=""
    dfB[,v]=as.character(dfB[,v])
  }
  dfB=dfB[,names(dfA)]
  rbind(dfA,dfB)
}

