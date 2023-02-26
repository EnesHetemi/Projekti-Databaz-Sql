/*Punuar Nga Enes Hetemi*/


/*Query-it e thjeshta me nje relacion*/
/*Selekto te Gjithe Konsumatoret*/
select * from Konsumatori

/*Selecto te Gjitha Produktet*/
select * from Produkt

/*Selekto te Gjitha Produktet qe gjenden ne stok*/
select * from Produkt
where Stoku = 1

/*Selekto te Gjitha Produktet qe nuk jane te aktivizuara*/
select * from Produkt
where Aktivizimi = 0

/*Selekto Pordoruesit qe nuk jane te aktivizuar*/
select * from Pordoruesi
where Aktivizimi = 0

/*Selekto Kategorit qe jane te Aktivizuara*/
select * from Kategoria
where Aktivizimi = 1

/*Selekto te Gjitha Brand-et*/
select * from Brand

/*Selekto te Gjitha Seksionet qe nuk jane te aktivizuara*/
select * from Seksion
where Aktivizimi = 0



/*Query-it te thjeshta me minimumi dy tabela*/
/*Selekto Pordoruesit dhe rolin e tyre*/
select *
from Pordoruesi p, Roli r, Pordorues_Role pr
where p.PordoruesiId = pr.PordoruesiId and r.RoliId = pr.RoliId

/*Selekto Produktet aktivizuara dhe vlersimet e Produkteve te aktivizuara*/
select p.Emri, p.Aktivizimi, v.Komenti
from Produkt p, Vlersimi v
where p.ProduktId = v.ProduktId and p.Aktivizimi = 1

/*Selekto Produktet dhe te tregohet secili profukt se ciles kategori i takon*/
select p.Emri, k.Emri
from Produkt p, Kategoria k
where p.KategoriaId = k.KategoriaId

/*Selekto Konsumatoret dhe Pyetjet e tyre*/
select *
from Konsumatori k, Pyetja p
where k.KonsumatoriId = p.KonsumatoriId

/*Selekto seksionet te cilat jane te lidhura me produkte dhe te cilat jane te aktivizuara*/
select s.Pershkrimi, p.Pershkrimi
from Seksion s, SeksionProdukt sp, Produkt p
where s.SeksionId = sp.SeksionId and sp.ProduktId = p.ProduktId and s.Aktivizimi = 1

/*Selekto Produktet dhe brandet qe i takojn atyre produkteve*/
select p.Emri, b.Emri
from Produkt p, Brand b
where p.BrandId = b.BrandId

/*Selekto pergjigjet e pordoruesve*/
select p.Emri, p.Mbiemri, py.Pergjigjja 
from Pordoruesi p, Pyetja py
where p.PordoruesiId = py.PordoruesiId

/*Selekto produktet qe jane porositur ndonjehere dhe nga kush jane porositur*/
select p.Emri, k.Emri, k.Email
from Produkt p, Porosia pr, Konsumatori k
where p.ProduktId = pr.ProduktId and pr.KonsumatoriId = k.KonsumatoriId



/*Query-it e avancuar me minimumi 2 relacione*/

/*Selekto Produktet qe jane ne artikuj te shporteve dhe konsumatoret qe kane artikuj ne shporte
dhe produktet te jene te aktivizuara dhe emrat e produkteve te jane asc*/

select p.Emri, a.Sasia, k.Emri
from Produkt p inner join ArtikujShporte a on p.ProduktId = a.ProduktId inner join Konsumatori k on a.KonsumatoriId = k.KonsumatoriId
where p.Aktivizimi = 1
order by p.Emri asc

/*Selekto Konsumatorin me id 9 dhe produktet qe i ka porositur te jene barabarte me 8 ose me shume*/
select p.Emri, k.Emri, a.Sasia
from Produkt p inner join ArtikujShporte a on p.ProduktId = a.ProduktId inner join Konsumatori k on a.KonsumatoriId = k.KonsumatoriId
where k.KonsumatoriId = 9 and a.Sasia >= 8


/*Selekto produktet te cilat nuk jane vlersuar asnjehere*/
select p.Emri, v.Komenti
from Produkt p left join Vlersimi v on p.ProduktId = v.ProduktId
where v.VlersimiId is null

/*Selekto numrin e produkteve se sa jane porositur per konsumator dhe totalin e porosis se tyre*/
select k.KonsumatoriId, k.Emri, count(p.sasia) as 'Sasia e Porositur', sum(p.totali) as 'Totali i Porosis nga Klienti'
from Porosia p inner join Produkt pr on p.ProduktId = pr.ProduktId inner join Konsumatori k on p.KonsumatoriId = k.KonsumatoriId
group by k.KonsumatoriId, k.Emri
order by k.Emri desc


/*Te selektohen produktet qe jane porositur me shume ose barabarte me 2 here dhe totali i porosis nga klienti te jete me i larte se 2000 mije euro*/
select pr.ProduktId, pr.Emri, count(p.sasia) as 'Sasia e Porositur', sum(p.totali) as 'Totali i Porosis'
from Porosia p inner join Produkt pr on p.ProduktId = pr.ProduktId inner join Konsumatori k on p.KonsumatoriId = k.KonsumatoriId
group by pr.ProduktId, pr.Emri
having count(p.sasia) >= 2 and sum(p.totali) > 2000


/*Selekto Konsumatoret qe kane shpenzur mbi 1500 euro dhe te cilet jane nga prishtina*/
select k.Emri, sum(p.totali) as 'Shpenzimet_Konsumatorit'
from Konsumatori k inner join Porosia p on k.KonsumatoriId = p.KonsumatoriId
where k.Qyteti like 'Podujeve'
group by k.Emri
having sum(p.totali) > 1500

/*Te krijohet nje view per seksionet e brand-eve qe jane te aktivizuara*/
create view SeksionBrandAktivzum
as
select s.Pershkrimi, s.Aktivizimi, s.Titulli, b.Emri
from Seksion s inner join SeksionBrand sb on s.SeksionId = sb.SeksionId inner join Brand b on b.BrandId = sb.SeksionBrandId
where s.Aktivizimi = 1

select * from SeksionBrandAktivzum

/*Selekto produktet dhe brand-et dhe kategorit qe i takon produkti dhe kategoria dhe produkti duhet te jene te aktivizume dhe stoku u produktit te jete true*/
select *
from Produkt p inner join Kategoria k on p.KategoriaId = k.KategoriaId inner join Brand b on p.BrandId = b.BrandId
where p.Aktivizimi = 1 and p.Stoku = 1 and k.Aktivizimi = 1


/*Subquery te Thjeshta*/
/*Selekto konsumatoret te cilet jane nga podujeva*/
select *
from Konsumatori k
where k.Qyteti in(select k.Qyteti from Konsumatori k where k.Qyteti like 'Podujeve')

/*Selekto pordoruesit te cilet nuk jane te aktivizuem*/
select *
from Pordoruesi p
where p.Aktivizimi not in(select p.Aktivizimi from Pordoruesi p where p.Aktivizimi = 1)

/*Selekto Kategorit te cilat jane te aktivizuara*/
select *
from Kategoria k
where k.Aktivizimi in(select k.Aktivizimi from Kategoria k where k.Aktivizimi = 1)

/*Selekto Pordoruesit me rolin admin*/
select p.PordoruesiId, p.Emri, p.Mbiemri, py.Pergjigjja, py.Pyetja
from Pordoruesi p, Pyetja py
where p.PordoruesiId in(select py.PordoruesiId where py.KohaPyetjes is null)

/*Selekto Produktet qe nuk jane prej nje date ne nje date tjeter*/
select *
from Produkt p
where p.ProduktId not in(select p.ProduktId from Produkt p where p.KohaEKrijimit between '2021-09-20' and '2021-12-22')

/*Selekto qmimin mesatar te te gjithe produkteteve dhe te shfaqen produktet qe kane qmimin me te larte se mesatarja*/
select *, (select avg(p.Qmimi) from Produkt p) as 'Qmimi Mesatar'
from Produkt p
where p.Qmimi > 723

/*Selekto pytjet te cilat jane bere*/
select *
from Pyetja p
where p.PyetjaId in(select p.PyetjaId from Pyetja p where p.KohaPyetjes is not null)

/*Selekto produktet te cilat nuk jane te aktivizuara*/
select *
from Produkt p
where p.Emri in (select p.Emri from Produkt p where p.Aktivizimi = 0)



/*SubQuery te avansuara*/
/*Selekto porosit te cilat jane bere nga konsumatoret te cilat jane me te larta se mesatarja e totalit te porosive dhe te tregohet produkti*/
select k.Emri, k.Mbiemri, p.Totali, pr.Emri, pr.Pershkrimi
from Porosia p inner join Konsumatori k on p.KonsumatoriId = k.KonsumatoriId inner join Produkt pr on p.ProduktId = pr.ProduktId
where p.Totali >Any(select avg(p.Totali) as 'Mesatarja' from Porosia p inner join Konsumatori k on p.KonsumatoriId = k.KonsumatoriId)

/*Selekto Konsumatoret qe kane sasi me te ulete se mesatarja e artikujve ne shporte*/
select *
from Konsumatori k inner join ArtikujShporte a on k.KonsumatoriId = a.KonsumatoriId
where a.Sasia <Any(select avg(a.Sasia) from Konsumatori k inner join ArtikujShporte a on k.KonsumatoriId = a.KonsumatoriId)


/*Selekto produktin i cili ka maksimumin e sasis ne porosi*/
select *
from Produkt p inner join ArtikujShporte a on p.ProduktId = a.ProduktId
where a.Sasia = (select max(a.Sasia) from ArtikujShporte a)

/*Selekto brandet dhe kategorit te cilat jane te lidhura njera me tjetren mirpo katekorit duhet te jene te aktivizuara*/
select *
from Kategoria k inner join Brand_Kategoria bk on k.KategoriaId = bk.KategoriaId inner join Brand b on bk.BrandId = b.BrandId
where k.Aktivizimi in(select k.Aktivizimi from Kategoria k where k.Aktivizimi = 1)

/*Krijo view ku selektohen produktet qe jane nga brand-i Apple*/
create view ProduktBrandApple
as
select p.Pershkrimi, b.Emri
from Produkt p inner join Brand b on p.BrandId = b.BrandId
where b.BrandId in (select b.BrandId from Brand b where b.Emri = 'Apple')

/*Selekto Pordoruesit te cilet jane admin dhe AdminILodht*/
select p.Emri, r.Emri
from Pordoruesi p inner join Pordorues_Role pr on p.PordoruesiId = pr.PordoruesiId inner join Roli r on r.RoliId = pr.RoliId
where r.RoliId in (select r.RoliId from Roli r where r.Emri in('Admin', 'AdminILodht'))


/*Selekto produktet qe kane pytje dhe data e pytjeve te jete ne kohe te caktuar*/
select *
from Produkt p inner join Pyetja py on p.ProduktId = py.ProduktId
where py.PyetjaId in(select py.PyetjaId from Pyetja py where py.KohaPergjigjes is null and py.KohaPyetjes between '2022-02-28' and '2022-08-22')


/*Selekto mesataren e porosis dhe te shfaqen konsumatoret/produktet qe i kan bere porosit perkatese dhe te jete totali i porosis ma e madhe se mesatarja e porosis*/
select p.Emri, p.Pershkrimi, k.Emri, k.Mbiemri, po.Sasia, po.Totali, (select avg(po.totali) from Porosia po)
from Konsumatori k, Porosia po, Produkt p
where k.KonsumatoriId = po.KonsumatoriId and po.ProduktId = p.ProduktId
group by p.Emri, p.Pershkrimi, k.Emri, k.Mbiemri, po.Sasia, po.Totali
having avg(po.totali) > 1392


/*Query/Subquery Algjebra Relacionare*/
/*Selekto Konsumatoret te cilet jane nga Podujeve dhe Gjilani*/
select k.Emri, k.Qyteti
from Konsumatori k
where k.Qyteti = 'Podujeve'
union
select k.Emri, k.Qyteti
from Konsumatori k
where k.Qyteti = 'Gjilan'
order by k.Qyteti asc


/*Selekto produktet qe nuk jane ne nje qmim te caktuar dhe produkti te jete i aktivizuar*/
select p.Emri, p.Pershkrimi, p.Qmimi
from Produkt p
where p.Aktivizimi = 1
except
select p.Emri, p.Pershkrimi, p.Qmimi
from Produkt p
where p.Qmimi > 1000


/*Selekto pytjet te cilat kane pergjigjjet null*/
select *
from Pyetja p
union
select *
from Pyetja p
where p.Pergjigjja is null


/*Selekto Produkte dhe vlersimet dhe vlersimi te jete ne nje kohe te caktuar*/
select *
from Produkt p inner join Vlersimi v on p.ProduktId = v.ProduktId
except
select *
from Produkt p inner join Vlersimi v on p.ProduktId = v.ProduktId
where v.KohaEVlersimit not between '2022-03-13' and '2022-05-25'


/*Selekto Produktet te cilat jane ne stok*/
select *
from Produkt p
except
select *
from Produkt p
where p.Stoku in (select p.Stoku from Produkt p where p.Stoku = 0)



/*Stored Procedure*/
/*Te krijohet nje procedure e ruajtur e cila kthen Konsumatoret te cilet kane bere porosi ne baze te qytetit dhe sasis*/
create procedure getKonsumatorPorosia(
@qyteti varchar(100),
@sasia int)
as
begin
select k.Emri, k.Qyteti, p.PorosiaId, p.Sasia
from Konsumatori k inner join Porosia p on k.KonsumatoriId = p.KonsumatoriId
where k.Qyteti = @qyteti and p.Sasia = @sasia
end

exec getKonsumatorPorosia 'Podujeve', 1


/*Te krijohet nje procedure e ruajtur me input dhe output e cila kthen Produktet dhe Kategorit dhe Brandet e tij ku id e produktit eshte input ndersa output emarat*/
create procedure getProduktBrandKategori(
@produktid int,
@emriP varchar(100) out,
@emriK varchar(50) out,
@emriB varchar(50) out)
as
begin
select @emriP = p.Emri, @emriB = b.Emri, @emriK = k.Emri
from Produkt p inner join Brand b on p.BrandId = b.BrandId inner join Kategoria k on p.KategoriaId = k.KategoriaId
where @produktid = p.ProduktId
end

declare @emriP varchar(100), @emriK varchar(50), @emriB varchar(50)
exec getProduktBrandKategori 1, @emriP out, @emriK out, @emriB out
print @emriP+ ' Ky produkti i takon Kategoris ' +@emrik+ ' ndersa Brand-it ' +@emriB;


/*Printo Perqindjen e Konsumatorve qe kane blere me pak se 5 dhe me shume se 5*/
create procedure PrintoPerqindjenKlienteve
as
declare @Porosia int = (select count(*) from Porosia p)
declare @Konsumatori int = (select count(*) from Konsumatori k)
declare @MeEMadhe5 int = ((select count(*) from Konsumatori k inner join Porosia p on k.KonsumatoriId = p.KonsumatoriId where p.Sasia > 5)*100)/@Porosia;
declare @MeEVogel5 int = ((select count(*) from Konsumatori k inner join Porosia p on k.KonsumatoriId = p.KonsumatoriId where p.Sasia <= 5)*100)/@Porosia;
print(concat('Numri i Konsumatoreve qe jane: ', @Konsumatori, ' Perqindja e porosive qe eshte bere me sasi me pak ose brabart me 5 eshte: ', 
@MeEVogel5, ' Perqindja e porosive qe eshte bere me sasi me shume se 5 eshte: ', @MeEMadhe5));
go

exec PrintoPerqindjenKlienteve


/*Printo Perqindjen e secilit produkt se sa here eshte porositur dhe te cilat jane ne stok aktualisht*/
create procedure PrintoPerqindejenProduktevePorosituraStok
as
declare @Porosia int = (select count(*) from Porosia p)
declare @Produkt int = (select count(*) from Produkt p)
declare @PerqindjaPorosisProdukti int = ((select count(*) from Porosia p inner join Produkt pr on p.ProduktId = pr.ProduktId where pr.Stoku = 1)*100)/@Porosia;
print(concat('Numri i Produkteve qe jane: ', @Produkt, ' Perqindja e porosive qe jane: ', 
@Porosia, ' Perqindja qe: ', @PerqindjaPorosisProdukti));
go

exec PrintoPerqindejenProduktevePorosituraStok


/*Shto Kategorin ne databaze*/
create procedure shtoKategorin
@emri varchar(50),
@aktivizimi bit
as
declare @egziston int = (select count(*) from Kategoria k where @emri = k.Emri and @aktivizimi = k.Aktivizimi)
if(@egziston = 1)
print('Kategoria qe ju shtuat ekziston')
else
begin
insert into Kategoria values(@emri, @aktivizimi);
print('Kategoria eshte shtuar me sukses');
end
go

exec shtoKategorin @emri='testss', @aktivizimi = 1


/*Te krijohet nje procedure e ruajtur ku nxjerret mesatarja e porosive dhe te behet me if else ne baze te qmimit te produktit*/
create procedure getPorosiaAvg(
@id int,
@emriP varchar(100)out,
@pershkrimiP varchar(500) out,
@mesatarjaPorosive float out)
as
begin
declare @qmimiProduktit int = (select p.Qmimi from Produkt p where p.ProduktId = @id)
select @emriP = pr.Emri, @pershkrimiP = pr.Pershkrimi, @mesatarjaPorosive = avg(p.Totali)
from Produkt pr inner join Porosia p on pr.ProduktId = p.ProduktId
where pr.ProduktId = @id
group by pr.Emri, pr.Pershkrimi

if(@mesatarjaPorosive < @qmimiProduktit)
print 'Produkti ' +@emriP +@pershkrimiP+ ' ka qmimin me te ulet se mesatarja e porosive'
else
print 'Produkti ' +@emriP +@pershkrimiP+ ' ka qmimin me te larte se mesatarja e porosive'
end

declare @emriP varchar(100), @pershkrimiP varchar(255), @mesatarjaPorosive float
exec getPorosiaAvg 1, @emriP out, @pershkrimiP out, @mesatarjaPorosive out


/*Krijo nje procedure te ruajtur me case per produkte ku nese produkti nuk eshte ne stok te tregohet dhe e kunderta*/
create procedure KaStokTeProduktit(
@produktid int)
as
begin
declare @product_stoku bit;
select @product_stoku = p.Stoku from Produkt p where p.ProduktId = @produktid
select case
when @product_stoku = 1 then 'Produkti eshte ne stok'
else 'Produkti nuk eshte ne stok'
end
as ProduktStoku
end

exec KaStokTeProduktit 2
exec KaStokTeProduktit 5


/*te krijohet nje procedure me switch dhe te tregohet se nga cili qytet eshte konsumatori qe selektohet*/
alter procedure KonsumatoriNgaQyteti(
@konsuamtoriId int)
as
begin
declare @konsumatori_qyteti varchar(100);
select @konsumatori_qyteti = k.Qyteti from Konsumatori k where k.KonsumatoriId = @konsuamtoriId
select case
when @konsumatori_qyteti = @konsumatori_qyteti then 'Ky konsumator eshte nga qyteti ' + @konsumatori_qyteti
else 'Nuk ka konsumator nga ky qytet '
end
as KonsumatorQyteti
end


exec KonsumatoriNgaQyteti 10


/*LIstoni vlersimet per secilin produkt*/
select p.ProduktId, p.Emri, count(*) as 'Numri Vlersimeve'
from Produkt p inner join Vlersimi v on p.ProduktId = v.ProduktId
group by p.ProduktId, p.Emri


