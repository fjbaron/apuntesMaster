library(stringr)
library(openxlsx)


generaDatos=function(){
n=200;media=0;dt=1

generaMuestra=function (n,media=0,dt=1){
  muestra=rnorm(n,media,dt)
  media+(muestra-mean(muestra))/sd(muestra)*dt
}

generaResiduos=function (x,media=0,dt=1){
  e1=generaMuestra(length(x))
  e2=lm(e1 ~ x)$residuals
  media+(e2)/sd(e2)*dt
}

generaY=function(x,r,mediay=0,dty=1){
y = mediay+ ( (x-mean(x))/sd(x) * r + generaResiduos(x) * sqrt(1 - r^2))*dty
y
}

#x=generaMuestra(100,20,8)
#y=generaY(x,0.78,10,4)
#cor.test(x,y)
#plot(x,y)




n0=round(n/10*6)
n1=n-n0
p0=.1
p1=.2
n00=round(n0*p0,0)
n01=n0-n00
n10=round(n1*p1,0)
n11=n1-n10



Sexo=c(rep(0,n0),rep(1,n1))

Altura=round(rnorm(n0+n1,170,7)-5*Sexo,1)



Peso=round(-100 + Altura -4 *Sexo,1) + rnorm(n0+n1,0,4)


df=data.frame(Individuo=1:n,Sexo=Sexo,Altura=Altura,Peso=Peso)

df
}

library(haven)
write_sav(generaDatos(),"peso_altura_sexo.sav")


