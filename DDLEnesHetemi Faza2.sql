create database Teknologji_Kosova

use Teknologji_Kosova

create table Pordoruesi(
     PordoruesiId int identity(1,1) not null,
	 Emri varchar(40) not null,
	 Mbiemri varchar(50) not null,
	 Password varchar(256) not null,
	 Aktivizimi bit default '1',
	 constraint PordoruesiPK primary key (PordoruesiId)
)

create table Roli(
     RoliId int identity(1,1) not null,
	 Emri varchar(40) not null,
	 Pershkrimi varchar(100),
	 constraint RoliPK primary key (RoliId)
)

create table Pordorues_Role(
     PordoruesiId int not null,
	 RoliId int not null,
	 constraint Pordorues_RolePK primary key (PordoruesiId, RoliId),
	 constraint PordoruesiFK foreign key (PordoruesiId) references Pordoruesi(PordoruesiId),
	 constraint RoliFK foreign key (RoliId) references Roli(RoliId)
)

create table Kategoria(
     KategoriaId int primary key identity(1,1) not null,
	 Emri varchar(50) not null,
	 Aktivizimi bit default '1',
)

create table Brand(
     BrandId int identity(1,1) not null,
	 Emri varchar(50) not null,
	 constraint BrandPK primary key (BrandId)
)

create table Brand_Kategoria(
     KategoriaId int not null,
	 BrandId int not null,
	 constraint Brand_KategoriaPK primary key (KategoriaId, BrandId),
	 constraint KategoriasFK foreign key (KategoriaId) references Kategoria(KategoriaId),
	 constraint BrandFK foreign key (BrandId) references Brand(BrandId)
)

create table Produkt(
     ProduktId int identity(1,1) not null,
	 Emri varchar(100) not null,
	 Pershkrimi varchar(500),
	 FotoK varchar(50),
	 KohaEKrijimit date,
	 Stoku bit default '1',
	 Aktivizimi bit default '1',
	 Qmimi float not null default '0',
	 KategoriaId int not null,
	 BrandId int not null,
	 Pesha varchar(10),
	 Lartesia varchar(10),
	 Gjatesia varchar(10),
	 Gjersia varchar(10)
	 constraint ProduktPK primary key (ProduktId),
	 constraint KategoriapFK foreign key (KategoriaId) references Kategoria(KategoriaId),
)

Alter table Produkt
ADD constraint BrandpFK foreign key (BrandId) references Brand(BrandId);


create table Konsumatori(
     KonsumatoriId int identity(1,1) not null,
	 Emri varchar(50) not null,
	 Mbiemri varchar(50) not null,
	 Email varchar(100) not null,
	 Password varchar(100) not null,
	 Vendbanimi varchar(100),
	 Qyteti varchar(100) not null,
	 Datelindja date,
	 Nr_Telefonit varchar(100)
	 constraint KonsumatoriPK primary key (KonsumatoriId)
)

create table ArtikujShporte(
     ArtikujShporteId int identity(1,1) not null,
	 Sasia int not null,
	 KonsumatoriId int not null,
	 ProduktId int not null,
	 constraint ArtikujShportePK primary key (ArtikujShporteId),
	 constraint KonsumatoriFK foreign key (KonsumatoriId) references Konsumatori(KonsumatoriId),
	 constraint ProduktsFK foreign key (ProduktId) references Produkt(ProduktId)
)

create table Porosia(
     PorosiaId int identity(1,1) not null,
	 Sasia int not null,
	 QmimiPerNjesi float not null,
	 Totali float not null,
	 KonsumatoriId int not null,
	 ProduktId int not null,
	 constraint PorosiaPK primary key (PorosiaId),
	 constraint KonsumatoripFK foreign key (KonsumatoriId) references Konsumatori(KonsumatoriId),
	 constraint ProduktspFK foreign key (ProduktId) references Produkt(ProduktId)
)

create table Pyetja(
     PyetjaId int identity(1,1) not null,
	 Pyetja varchar(4096),
	 Pergjigjja varchar(4096),
	 KohaPergjigjes date,
	 KohaPyetjes date,
	 Aprovimi bit default '0',
	 KonsumatoriId int,
	 PordoruesiId int,
	 ProduktId int not null,
	 constraint PyetjaPK primary key (PyetjaId),
	 constraint KonsumatoripyetjaFK foreign key (KonsumatoriId) references Konsumatori(KonsumatoriId),
	 constraint PordoruesiPersgjigjjaFK foreign key (PordoruesiId) references Pordoruesi(PordoruesiId),
	 constraint ProduktpyetjaFK foreign key (ProduktId) references Produkt(ProduktId)
)

create table Vlersimi(
     VlersimiId int identity(1,1) not null,
	 Komenti varchar(1024),
	 Vlersimi int not null,
	 Titulli varchar(100),
	 KohaEVlersimit date,
	 KonsumatoriId int not null,
	 ProduktId int not null,
	 constraint VlersimiPK primary key (VlersimiId),
	 constraint KonsumatoriVlersimiFK foreign key (KonsumatoriId) references Konsumatori(KonsumatoriId),
	 constraint ProduktVlersimiFK foreign key (ProduktId) references Produkt(ProduktId)
)

create table Seksion(
     SeksionId int identity(1,1) not null,
	 Pershkrimi varchar(100),
	 Titulli varchar(50) not null,
	 Aktivizimi bit default '1',
	 constraint SeksionPK primary key (SeksionId)
)

create table SeksionBrand(
     SeksionBrandId int identity(1,1) not null,
	 SeksionId int not null,
	 BrandId int not null,
	 constraint SeksionBrandPK primary key (SeksionBrandId),
	 constraint SeksionSeksionBrandFK foreign key (SeksionId) references Seksion(SeksionId),
	 constraint SekBrandFK foreign key (BrandId) references Brand(BrandId)
)

create table SeksionKategoria(
     SeksionKategoriaId int identity(1,1) not null,
	 SeksionId int not null,
	 KategoriaId int not null,
	 constraint SeksionKategoriaPK primary key (SeksionKategoriaId),
	 constraint SeksionSeksionKategoriaFK foreign key (SeksionId) references Seksion(SeksionId),
	 constraint SekKategoriaFK foreign key (KategoriaId) references Kategoria(KategoriaId)
)

create table SeksionProdukt(
     SeksionProduktId int identity(1,1) not null,
	 SeksionId int not null,
	 ProduktId int not null,
	 constraint SeksionProduktPK primary key (SeksionProduktId),
	 constraint SeksionSeksionProduktFK foreign key (SeksionId) references Seksion(SeksionId),
	 constraint SekProduktFK foreign key (ProduktId) references Produkt(ProduktId)
)

/*Insertimi i Pordoruesi*/
insert into Pordoruesi values ('Enes', 'Hetemi', '123456', 1)
insert into Pordoruesi values ('Edon', 'Pajaziti', '654321', 0)
insert into Pordoruesi values ('Eljesa', 'Jashari', '987654', 1)
insert into Pordoruesi values ('Diellza', 'Xhaferi', '456789', 1)
insert into Pordoruesi values ('Lum', 'Ademi', '589348', 0)
insert into Pordoruesi values ('Alba', 'Haradinaj', '554182', 1)
insert into Pordoruesi values ('Albin', 'Boletini', '418501', 1)
insert into Pordoruesi values ('Alma', 'Qemajli', '716214', 0)
insert into Pordoruesi values ('Enes', 'Qemajli', '7821482', 1)
insert into Pordoruesi values ('Filan', 'Fisteku', '795256', 0)



/*Inserimi i rolit*/
insert into Roli values ('SuperAdmin', 'Kontrollon Gjithqka')
insert into Roli values ('Admin', 'Kontrollon Gjithqka perpos Pordorusve')
insert into Roli values ('AdminILodht', 'Kontrollon Gjithqka perpos Pordoruesve dhe Konsumatorve')
insert into Roli values ('Shites', 'Menaxhon Qmimet e produkteve, Klientet, Porosit')
insert into Roli values ('Editor', 'Menaxhon Produktet, Kategorit, Brand-et')
insert into Roli values ('Dergues', 'Shikon Produktet, Shikon Porosit')
insert into Roli values ('Asistent', 'Menaxhon Pytjet dhe Vlersimet')
insert into Roli values ('Tjeter Rol', 'Kontrollon Porosit')
insert into Roli values ('MenaxhuesAdminav', 'Kontrollon vetem adminat')
insert into Roli values ('Rol', 'Kontrollon Konsumatoret')


/*Insertimi i Pordorues_Role*/
insert into Pordorues_Role values(1,1)
insert into Pordorues_Role values(2,3)
insert into Pordorues_Role values(2,5)
insert into Pordorues_Role values(2,8)
insert into Pordorues_Role values(2,10)
insert into Pordorues_Role values(3,4)
insert into Pordorues_Role values(3,7)
insert into Pordorues_Role values(3,2)
insert into Pordorues_Role values(4,2)
insert into Pordorues_Role values(4,5)
insert into Pordorues_Role values(4,4)
insert into Pordorues_Role values(5,3)
insert into Pordorues_Role values(5,9)
insert into Pordorues_Role values(5,6)
insert into Pordorues_Role values(6,6)
insert into Pordorues_Role values(6,8)
insert into Pordorues_Role values(6,10)
insert into Pordorues_Role values(7,7)
insert into Pordorues_Role values(7,8)
insert into Pordorues_Role values(7,3)
insert into Pordorues_Role values(8,8)
insert into Pordorues_Role values(8,2)
insert into Pordorues_Role values(9,1)
insert into Pordorues_Role values(10,10)
insert into Pordorues_Role values(10,9)


/*Insertimi i Kategoris*/
insert into Kategoria values ('Elektronika', 1)
insert into Kategoria values ('Kamera', 1)
insert into Kategoria values ('Kamera Dixhitale', 0)
insert into Kategoria values ('Telefon', 1)
insert into Kategoria values ('Mbushes Telefoni', 1)
insert into Kategoria values ('Mrojtese Telefoni', 0)
insert into Kategoria values ('Kompjuter', 1)
insert into Kategoria values ('Desktop', 1)
insert into Kategoria values ('Llaptop', 1)
insert into Kategoria values ('Komponent Kompjuteri', 0)


/*Insertimi i Brand-it*/
insert into Brand values ('Panasonic')
insert into Brand values ('Apple')
insert into Brand values ('Bosch')
insert into Brand values ('LG')
insert into Brand values ('Samsung')
insert into Brand values ('Lenovo')
insert into Brand values ('Microsoft')
insert into Brand values ('Xiaomi')
insert into Brand values ('Canon')
insert into Brand values ('Asus')


/*Insertimi Brand_Kategoria*/
insert into Brand_Kategoria values (1,1)
insert into Brand_Kategoria values (1,2)
insert into Brand_Kategoria values (2,1)
insert into Brand_Kategoria values (2,2)
insert into Brand_Kategoria values (3,3)
insert into Brand_Kategoria values (3,4)
insert into Brand_Kategoria values (4,3)
insert into Brand_Kategoria values (4,4)
insert into Brand_Kategoria values (5,4)
insert into Brand_Kategoria values (5,5)
insert into Brand_Kategoria values (6,5)
insert into Brand_Kategoria values (6,6)
insert into Brand_Kategoria values (7,6)
insert into Brand_Kategoria values (7,7)
insert into Brand_Kategoria values (8,7)
insert into Brand_Kategoria values (8,8)
insert into Brand_Kategoria values (9,8)
insert into Brand_Kategoria values (9,9)
insert into Brand_Kategoria values (10,9)
insert into Brand_Kategoria values (10,10)
insert into Brand_Kategoria values (10,1)
insert into Brand_Kategoria values (9,2)
insert into Brand_Kategoria values (8,3)
insert into Brand_Kategoria values (7,4)
insert into Brand_Kategoria values (6,2)


/*Insertimi i produktit*/
insert into Produkt values('Iphone 13', 'iPhone 13 Technical Specifications · HDR display]', 'iphone13.png', '2022-10-22', 1, 1, 799, 4, 2, '141Gram', '131.5mm', '100mm', '64.2mm')
insert into Produkt values('Canon EOS', 'EOS M50 camera helps you capture the world in vibrant images', 'canon.png', '2022-9-20', 1, 0, 880.5, 2, 9, '2KG', '450mm', '300', '350mm')
insert into Produkt values('Samsung s10', 'Discover Samsung Galaxy S10e, S10 and S10+s cutting-edge performance', 's10.png', '2021-12-22', 0, 1, 550, 4, 5, '141Gram', '131.5mm', '100mm', '64.2mm')
insert into Produkt values('ASUS ROG Strix G10DK', 'ASUS ROG Strix G10DK Gaming Desktop Computer', 'asus.png', '2020-9-20', 1, 1, 980.5, 8, 10, '6KG', '600mm', '3003m', '350mm')
insert into Produkt values('Iphone 12', 'iPhone 12 Technical Specifications · HDR display]', 'iphone12.png', '2022-7-10', 1, 0, 599, 4, 2, '135Gram', '121.5mm', '95mm', '54.2mm')
insert into Produkt values('Xiaomi Mi 65W Fast Charger', 'Xiaomi Mi 65W Fast Charger with GaN Tech, Charger for Smartphones and Notebooks', 'xiamoic.png', '2021-3-13', 0, 1, 55, 5, 8, '2KG', '450mm', '300', '350mm')
insert into Produkt values('Lenovo NVIDIA GeForce', 'Lenovo NVIDIA GeForce RTX 3070 Laptop GPU, Discrete, 8GB GDDR6, 1560 MHz', 'lenovo.png', '2022-5-25', 1, 1, 1600, 9, 6, '1KG', '900mm', '700mm', '650mm')
insert into Produkt values('Samsung S12', 'Samsung Galaxy S12 phone comes with 8GB Ram & 128GB storage', 'samsung1.png', '2020-7-7', 1, 0, 745.5, 4, 5, '141Gram', '131.5mm', '100mm', '64.2mm')
insert into Produkt values('Screen Protector for LG', 'Ailun Screen Protector for LG stylo 6 3Pack 0.33mm 2.5D Edge Tempered Glass', 'screenlg.png', '2021-10-12', 0, 1, 14.99, 6, 4, '141Gram', '131.5mm', '100mm', '64.2mm')
insert into Produkt values('Canon super', 'super M50 camera helps you capture the world in vibrant images', 'canons.png', '2021-9-20', 1, 1, 1000.5, 2, 5, '2KG', '450mm', '300', '350mm')


/*Insertimi Konsumatori*/
insert into Konsumatori values ('Enes', 'Hetemi', 'enes@gmail.com', '123456', '5 deshmoret', 'Podujeve', '2000-04-15', '+38344521542')
insert into Konsumatori values ('Edon', 'Hetemi', 'edon@gmail.com', '18552785', '5 deshmoret', 'Prishtine', '2002-07-13', '+38345879544')
insert into Konsumatori values ('Albin', 'Jashari', 'albin@gmail.com', '14525624', 'Adem Jashari', 'Skenderaj', '1984-07-06', '+38349123456')
insert into Konsumatori values ('Diellza', 'Tahiri', 'diellza@gmail.com', '78965887', 'Zahir pajaziti', 'Gjilan', '1986-07-10', '+38348741852')
insert into Konsumatori values ('Eljesa', 'Jashari', 'eljesa@gmail.com', '447523', 'Adem Jashari', 'Prishtine', '1989-04-16', '+38344258963')
insert into Konsumatori values ('Kushtrim', 'Tasholli', 'kushtrim@gmail.com', '789123', 'Hamez Jashari', 'Peje', '1995-08-16', '+38349639874')
insert into Konsumatori values ('Filan', 'Fisteku', 'filan@gmail.com', '7854858', 'Luan Haradinaj', 'Podujeve', '1979-09-26', '+38349154524')
insert into Konsumatori values ('Erblin', 'Selmani', 'erblin@gmail.com', '7416215', 'Skenderbeu', 'Podujeve', '1984-07-06', '+38349123456')
insert into Konsumatori values ('Filan1', 'Selmani', 'filan1@gmail.com', '879687', 'Shote Galica', 'Prishtine', '2001-02-22', '+38345147657')
insert into Konsumatori values ('Filan2', 'Hetemi', 'Filan2@gmail.com', '78445215', 'Azem Galica', 'Gjilan', '1994-08-14', '+38344857624')


/*Inserimi Artikujshporte*/
insert into ArtikujShporte values(1, 1, 1)
insert into ArtikujShporte values(2, 2, 2)
insert into ArtikujShporte values(3, 3, 3)
insert into ArtikujShporte values(4, 4, 4)
insert into ArtikujShporte values(5, 5, 5)
insert into ArtikujShporte values(6, 6, 6)
insert into ArtikujShporte values(7, 7, 7)
insert into ArtikujShporte values(8, 8, 8)
insert into ArtikujShporte values(9, 9, 9)
insert into ArtikujShporte values(10, 10, 10)
insert into ArtikujShporte values(1, 2, 1)
insert into ArtikujShporte values(2, 3, 2)
insert into ArtikujShporte values(3, 4, 3)
insert into ArtikujShporte values(4, 5, 4)
insert into ArtikujShporte values(5, 6, 5)
insert into ArtikujShporte values(6, 7, 6)
insert into ArtikujShporte values(7, 8, 7)
insert into ArtikujShporte values(8, 9, 8)
insert into ArtikujShporte values(9, 10, 9)
insert into ArtikujShporte values(10, 1, 10)
insert into ArtikujShporte values(1, 1, 8)
insert into ArtikujShporte values(2, 10, 4)
insert into ArtikujShporte values(3, 2, 7)
insert into ArtikujShporte values(4, 9, 5)
insert into ArtikujShporte values(5, 3, 6)


/*Insertimi i Porosis*/
insert into Porosia values(1, 300, 300, 1, 1)
insert into Porosia values(2, 700, 1400, 2, 2)
insert into Porosia values(3, 600, 1800, 3, 3)
insert into Porosia values(4, 500, 2000, 4, 4)
insert into Porosia values(5, 400, 2000, 5, 5)
insert into Porosia values(6, 250, 1500, 6, 6)
insert into Porosia values(7, 200, 1400, 7, 7)
insert into Porosia values(8, 90, 720, 8, 8)
insert into Porosia values(9, 60, 540, 9, 9)
insert into Porosia values(10, 30, 300, 10, 10)
insert into Porosia values(4, 300, 1200, 10, 1)
insert into Porosia values(5, 700, 3500, 9, 2)
insert into Porosia values(6, 600, 3600, 8, 3)
insert into Porosia values(3, 500, 1500, 7, 4)
insert into Porosia values(7, 400, 2800, 6, 5)
insert into Porosia values(2, 250, 500, 1, 6)
insert into Porosia values(10, 200, 2000, 2, 7)
insert into Porosia values(1, 90, 90, 3, 8)
insert into Porosia values(8, 60, 480, 4, 9)
insert into Porosia values(9, 30, 210, 5, 10)
insert into Porosia values(1, 250, 500, 1, 6)
insert into Porosia values(2, 200, 2000, 2, 7)
insert into Porosia values(3, 90, 90, 3, 8)
insert into Porosia values(4, 60, 480, 4, 9)
insert into Porosia values(5, 30, 210, 5, 10)


/*Insertimi i Pyetjeve*/
insert into Pyetja values('Lorem Ipsum is simply dummy text of the printing and typesetting industry', NULL, NULL, '2022-08-22', 1, 1, NULL, 1)
insert into Pyetja values(NULL, 'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s', '2022-08-22', NULL, 1, NULL, 1, 1)
insert into Pyetja values('when an unknown printer took a galley of type and scrambled it to make a type specimen book.', NULL, NULL, '2022-06-13', 0, 3, NULL, 2)
insert into Pyetja values('It has survived not only five centuries, but also the leap into electronic typesetting', NULL, NULL, '2022-04-13', 1, 5, NULL, 4)
insert into Pyetja values(NULL, 'remaining essentially unchanged. It was popularised in the 1960s with the release', '2022-04-15', NULL, 1, NULL, 3, 4)
insert into Pyetja values('of Letraset sheets containing Lorem Ipsum passages, and more recently', NULL, NULL, '2021-07-11', 1, 5, NULL, 8)
insert into Pyetja values(NULL, 'with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '2021-07-13', NULL, 1, NULL, 7, 8)
insert into Pyetja values('It is a long established fact that a reader will be distracted', NULL, NULL, '2022-09-07', 0, 10, NULL, 5)
insert into Pyetja values('by the readable content of a page when looking at its layout.', NULL, NULL, '2022-02-28', 1, 5, NULL, 3)
insert into Pyetja values(NULL, 'The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.', '2022-03-02', NULL, 1, NULL, 7, 3)

/*Insertimi i Vlersimeve*/
insert into Vlersimi values('Contrary to popular belief, Lorem Ipsum is not simply random text.', 5, 'Vlersimi 1', '2022-03-13', 3, 1)
insert into Vlersimi values('It has roots in a piece of classical Latin literature from 45 BC', 4, 'Vlersimi 2', '2022-06-22', 4, 2)
insert into Vlersimi values('Lorem Ipsum comes from sections 1.10.32 and 1.10.33', 5, 'Vlersimi 3', '2021-07-13', 1, 6)
insert into Vlersimi values('This book is a treatise on the theory of ethics, very popular during the Renaissance.', 5, 'Vlersimi 4', '2022-08-18', 10, 9)
insert into Vlersimi values('The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..', 3, 'Vlersimi 5', '2022-02-25', 8, 7)
insert into Vlersimi values('There are many variations of passages of Lorem Ipsum available', 5, 'Vlersimi 6', '2022-01-09', 5, 6)
insert into Vlersimi values('If you are going to use a passage of Lorem Ipsum, you need.', 5, 'Vlersimi 7', '2022-08-18', 9, 2)
insert into Vlersimi values('All the Lorem Ipsum generators on the Internet tend to repeat.', 4, 'Vlersimi 8', '2022-04-14', 8, 9)
insert into Vlersimi values('It uses a dictionary of over 200 Latin words.', 3, 'Vlersimi 9', '2022-05-25', 1, 8)
insert into Vlersimi values('The generated Lorem Ipsum is therefore always free.', 5, 'Vlersimi 10', '2022-12-21', 3, 7)

/*Insertimi i Seksion*/
insert into Seksion values('Shiko produktet me te shitura', 'Produktet me te shitura', 1)
insert into Seksion values('Shiko brand-et me te Klikuara', 'Brand-et me te klikuara', 1)
insert into Seksion values('Shiko Kategorit me te Klikuara', 'Kategorit me te klikuara', 0)
insert into Seksion values('Shiko Produktet me te Klikuara', 'Produktet me te klikuara', 1)
insert into Seksion values('Shiko Kategorit Kryesore ne platforme', 'Kategorit Kryesore', 0)
insert into Seksion values('Shiko Brand-et Kryesore ne platforme', 'Brand-et Kryesore', 1)
insert into Seksion values('Shiko Produktet Kryesore ne platforme', 'Produktet Kryesore', 0)
insert into Seksion values('Shiko Kategorit me te shitura prej dates 20-02-2021 deri 20-02-2022', 'Kategorit me te shitura ne date te caktuar', 1)
insert into Seksion values('Shiko Brand-et me te shitura prej dates 20-02-2021 deri 20-02-2022', 'Brand-et me te shitura ne date te caktuar', 0)
insert into Seksion values('Shiko Produktet me te shitura prej dates 20-02-2021 deri 20-02-2022', 'Produktet me te shitura ne date te caktuar', 1)


/*Insertimi i SeksionBrand*/
insert into SeksionBrand values(2, 1)
insert into SeksionBrand values(6, 2)
insert into SeksionBrand values(9, 3)
insert into SeksionBrand values(2, 4)
insert into SeksionBrand values(6, 5)
insert into SeksionBrand values(9, 6)
insert into SeksionBrand values(2, 7)
insert into SeksionBrand values(6, 8)
insert into SeksionBrand values(9, 9)
insert into SeksionBrand values(2, 10)
insert into SeksionBrand values(6, 1)
insert into SeksionBrand values(9, 2)
insert into SeksionBrand values(2, 3)
insert into SeksionBrand values(6, 4)
insert into SeksionBrand values(9, 5)
insert into SeksionBrand values(2, 6)
insert into SeksionBrand values(6, 7)
insert into SeksionBrand values(9, 8)
insert into SeksionBrand values(2, 9)
insert into SeksionBrand values(6, 10)
insert into SeksionBrand values(6, 6)
insert into SeksionBrand values(9, 7)
insert into SeksionBrand values(2, 8)
insert into SeksionBrand values(6, 9)
insert into SeksionBrand values(9, 10)


/*Insertimi i SeksionKategoria*/
insert into SeksionKategoria values(3, 1)
insert into SeksionKategoria values(5, 2)
insert into SeksionKategoria values(8, 3)
insert into SeksionKategoria values(3, 4)
insert into SeksionKategoria values(5, 5)
insert into SeksionKategoria values(8, 6)
insert into SeksionKategoria values(3, 7)
insert into SeksionKategoria values(5, 8)
insert into SeksionKategoria values(8, 9)
insert into SeksionKategoria values(3, 10)
insert into SeksionKategoria values(8, 1)
insert into SeksionKategoria values(3, 2)
insert into SeksionKategoria values(5, 3)
insert into SeksionKategoria values(8, 4)
insert into SeksionKategoria values(3, 5)
insert into SeksionKategoria values(5, 6)
insert into SeksionKategoria values(8, 7)
insert into SeksionKategoria values(3, 8)
insert into SeksionKategoria values(5, 9)
insert into SeksionKategoria values(8, 10)
insert into SeksionKategoria values(3, 6)
insert into SeksionKategoria values(5, 7)
insert into SeksionKategoria values(8, 8)
insert into SeksionKategoria values(3, 9)
insert into SeksionKategoria values(5, 10)


/*Inserimi i SeksionProduktet*/
insert into SeksionProdukt values(1, 1)
insert into SeksionProdukt values(4, 2)
insert into SeksionProdukt values(7, 3)
insert into SeksionProdukt values(10, 4)
insert into SeksionProdukt values(1, 5)
insert into SeksionProdukt values(4, 6)
insert into SeksionProdukt values(7, 7)
insert into SeksionProdukt values(10, 8)
insert into SeksionProdukt values(1, 9)
insert into SeksionProdukt values(4, 10)
insert into SeksionProdukt values(10, 1)
insert into SeksionProdukt values(7, 2)
insert into SeksionProdukt values(4, 3)
insert into SeksionProdukt values(1, 4)
insert into SeksionProdukt values(10, 5)
insert into SeksionProdukt values(7, 6)
insert into SeksionProdukt values(4, 7)
insert into SeksionProdukt values(1, 8)
insert into SeksionProdukt values(10, 9)
insert into SeksionProdukt values(7, 10)
insert into SeksionProdukt values(1, 6)
insert into SeksionProdukt values(10, 7)
insert into SeksionProdukt values(4, 8)
insert into SeksionProdukt values(7, 9)
insert into SeksionProdukt values(1, 10)



/*Update*/
update Pordoruesi
set Emri = 'Enes2'
where PordoruesiId = 2

update Roli
set Pershkrimi = 'Kontrollon shume gjera'
where RoliId = 10

update Pordorues_Role
set RoliId = 2
where PordoruesiId = 9

update Kategoria
set Aktivizimi = 0
where KategoriaId = 8

update Brand
set Emri = 'HP'
where BrandId = 1

update Produkt
set Emri = 'iphone 12 pro'
where ProduktId = 1

update Produkt
set Aktivizimi = 1
where ProduktId = 8

update Produkt
set Stoku = 0
where ProduktId = 5

update Konsumatori
set Nr_Telefonit = '+38344612878'
where KonsumatoriId = 7

update Konsumatori
set Qyteti = 'Ferizaj'
where KonsumatoriId = 5

update Produkt
set Emri = 'Lenovo NVIDIA'
where ProduktId = 7


update ArtikujShporte
set Sasia = 5
where ProduktId = 4

update ArtikujShporte
set Sasia = 6
where ArtikujShporteId = 10

update Porosia
set ProduktId = 7
where PorosiaId = 9

update Porosia
set KonsumatoriId = 6
where PorosiaId = 6

update Pyetja
set Aprovimi = 1
where PyetjaId = 8

update Pyetja
set Aprovimi = 0
where PyetjaId = 4

update SeksionBrand
set BrandId = 6
where SeksionBrandId = 7

update SeksionKategoria
set KategoriaId = 5
where SeksionKategoriaId = 10

update SeksionProdukt
set ProduktId = 7
where SeksionProduktId = 8



/*Delete*/
delete from Pordorues_Role
where PordoruesiId = 10

delete from Brand_Kategoria
where BrandId = 10

delete from Porosia
where PorosiaId = 10

delete from Porosia
where Totali < 100

delete from Pyetja
where PyetjaId = 7

delete from Vlersimi
where VlersimiId = 8

delete from SeksionKategoria
where SeksionKategoriaId = 6

delete from SeksionBrand
where SeksionBrandId = 5

delete from SeksionProdukt
where SeksionProduktId = 4

delete from Pyetja
where PyetjaId = 3