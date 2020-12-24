%banda(Nombre, AnioDeFormacion, Localidad, Integrantes).
banda(finta, 2001, haedo, [ale, juli, gabo, ludo, anuk]).
banda(aloeVera, 2007, cordoba, [lula, bren, gaby]).
banda(losEscarabajos, 1960, losPiletones, [juan, pablo, jorge, ricardo]).
banda(plastica, 1983, palermoHollywood, [jaime, kirk, rober, lars]).
banda(oceania, 1978, lasHeras, [jose, juanito, juancito, mic, ian]).
banda(brazoFuerte, 1914, nuevaOrleans, [luis]).
banda(rodrigo,1986,cordoba,[rodrigo]).

%genero(NombreBanda, Genero).
genero(finta, pop(20, 7)).
genero(losEscarabajos, rock(mixto ,60)).
genero(plastica, rock(heavy, 80)).
genero(oceania, rock(glam, 80)).
genero(brazoFuerte, jazz([trompeta, corneta])).
genero(rodrigo,cuarteto).

%pop(CantidadDeHits, CantidadDeDiscos)
%rock(TipoDeRock, Decada)
%jazz(Instrumentos)

%1 Agregar a la base la información de los festivales y bandas confirmadas

%festival(Festival,Localidad).
festival(mangueraMusmanoRockFestival,cordoba).
festival(nueveAuxilios,haedo).

%bandaConfirmada(Banda,Festival).
bandaConfirmada(aloeVera,mangueraMusmanoRockFestival).
bandaConfirmada(mariaLaCuerda,mangueraMusmanoRockFestival).
bandaConfirmada(reyesDeLaEraDelHielo,mangueraMusmanoRockFestival).

bandaConfirmada(cantoRodado,nueveAuxilios).
bandaConfirmada(lasLiendres,nueveAuxilios).
bandaConfirmada(juanPrincipe,nueveAuxilios).
bandaConfirmada(fluidoVerde,nueveAuxilios).

%2 esExitosa/1

esExitosa(Banda):-banda(Banda,_,_,_),genero(Banda,Genero),generoExitoso(Genero).
generoExitoso(pop(CantidadDeHits,CantidadDeDiscos)):-Promedio is CantidadDeHits / CantidadDeDiscos,Promedio >= 4.
generoExitoso(rock(mixto,_)).
generoExitoso(rock(glam,80)).
generoExitoso(jazz(Instrumentos)):-member(trompeta,Instrumentos).

%3 seraEterna/1

seraEterna(Banda):-esExitosa(Banda),cumpleCondicionEterna(Banda).
cumpleCondicionEterna(Banda):-banda(Banda,_,_,Integrantes),length(Integrantes, 4).
cumpleCondicionEterna(Banda):-banda(Banda,AnioDeFormacion,_,_),between(1960, 1980, AnioDeFormacion).

%4 leConvieneParticipar/2
leConvieneParticipar(Banda,Festival):-banda(Banda,_,Localidad,_),festival(Festival,Localidad),noParticipa(Banda,Festival).
noParticipa(Banda,Festival):-not(bandaConfirmada(Banda,Festival)).

%5 seGraba/1
seGraba(Festival):-festival(Festival,_,Bandas),forall(member(Banda,Bandas),seraEterna(Banda)).

%6 anioHistorico/1
anioHistorico(Anio):-banda(_,Anio,_,_),findall(Banda,seFormoEn(Banda,Anio),Bandas),length(Bandas,BandasFormadas),BandasFormadas > 10.
seFormoEn(Banda,Anio):-banda(Banda,Anio,_,_).