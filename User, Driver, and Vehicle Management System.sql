PROMPT 1. CREAREA TABELOR (minim 5 tabele) ?i IMPLEMENTAREA RESTRIC?IILOR DE INTEGRITATE (minim 3 tipuri de restric?ii pentru fiecare tabel?)

PROMPT STERGERE TABELA Utilizatori_AMO
DROP TABLE Utilizatori_AMO PURGE;

PROMPT CREARE TABELA Utilizatori_AMO
CREATE TABLE Utilizatori_AMO(
   UtilizatorID NUMBER(4),
   Nume VARCHAR2(50),
   Prenume VARCHAR2(50),
   NumeUtilizator VARCHAR2(50) CONSTRAINT uq_NumeUtilizator_AMO UNIQUE,
   Email VARCHAR2(100) CONSTRAINT uq_EmailUtilizator_AMO UNIQUE,
   Telefon VARCHAR2(15) CONSTRAINT uq_TelefonUtilizator_AMO UNIQUE,
   Parola VARCHAR2(100),
      CONSTRAINT pk_UtilizatorID PRIMARY KEY(UtilizatorID)
);

PROMPT VIZUALIZARE STRUCTURA TABELA Utilizatori_AMO
DESCRIBE Utilizatori_AMO;

--------------------------------------------------------------------------------

PROMPT STERGERE TABELA Soferi_AMO
DROP TABLE Soferi_AMO PURGE;

PROMPT CREARE TABELA Soferi_AMO
CREATE TABLE Soferi_AMO(
   SoferID NUMBER(4),
   Nume VARCHAR2(50),
   Prenume VARCHAR2(50),
   DataNasterii DATE CONSTRAINT nn_DataNasterii NOT NULL,
   DataAngajarii DATE,
   DataSalariu DATE,
   Telefon VARCHAR2(15) CONSTRAINT uq_TelefonSofer_AMO UNIQUE,
   Email VARCHAR2(100) CONSTRAINT uq_EmailSofer_AMO UNIQUE,
   DataEmiterePermis DATE,
   DataExpirarePermis DATE,
   DataInceputConcediu DATE,
   DataSfarsitConcediu DATE,
   UtilizatorID NUMBER(4),
      CONSTRAINT pk_SoferID PRIMARY KEY(SoferID),
      CONSTRAINT fk_UtilizatorID_Soferi_AMO FOREIGN KEY(UtilizatorID) REFERENCES Utilizatori_AMO(UtilizatorID)
);

PROMPT VIZUALIZARE STRUCTURA TABELA Soferi_AMO
DESCRIBE Soferi_AMO;

--------------------------------------------------------------------------------

PROMPT STERGERE TABELA Documente_AMO
DROP TABLE Documente_AMO PURGE;

PROMPT CREARE TABELA Documente_AMO
CREATE TABLE Documente_AMO(
   DocumentID NUMBER(4),
   NumeDocument VARCHAR2(100) CONSTRAINT nn_NumeDocument NOT NULL,
   TipDocument VARCHAR2(50) CONSTRAINT nn_TipDocument NOT NULL,
   DataIncarcareDocument DATE CONSTRAINT nn_DataIncarcareDocument NOT NULL,
   CaleFisierDocument VARCHAR2(255),
   UtilizatorID NUMBER(4),
      CONSTRAINT pk_DocumentID PRIMARY KEY(DocumentID),
      CONSTRAINT fk_UtilizatorID_Documente_AMO FOREIGN KEY(UtilizatorID) REFERENCES Utilizatori_AMO(UtilizatorID)
);

PROMPT VIZUALIZARE STRUCTURA TABELA Documente_AMO
DESCRIBE Documente_AMO;

--------------------------------------------------------------------------------

PROMPT STERGERE TABELA Contracte_AMO
DROP TABLE Contracte_AMO PURGE;

PROMPT CREARE TABELA Contracte_AMO
CREATE TABLE Contracte_AMO(
   ContractID NUMBER(4),
   NumeContract VARCHAR2(100) CONSTRAINT nn_NumeContract NOT NULL,
   TipContract VARCHAR2(50) CONSTRAINT nn_TipContract NOT NULL,
   DataInceputContract DATE CONSTRAINT nn_DataInceputContract NOT NULL,
   DataSfarsitContract DATE CONSTRAINT nn_DataSfarsitContract NOT NULL,
   UtilizatorID NUMBER(4),
      CONSTRAINT pk_ContractID PRIMARY KEY(ContractID),
      CONSTRAINT fk_UtilizatorID_Contracte_AMO FOREIGN KEY(UtilizatorID) REFERENCES Utilizatori_AMO(UtilizatorID)
);

PROMPT VIZUALIZARE STRUCTURA TABELA Contracte_AMO
DESCRIBE Contracte_AMO;

--------------------------------------------------------------------------------

PROMPT STERGERE TABELA Vehicule_AMO
DROP TABLE Vehicule_AMO PURGE;

PROMPT CREARE TABELA Vehicule_AMO
CREATE TABLE Vehicule_AMO(
   VehiculID NUMBER(4),
   NumarInmatriculare VARCHAR2(20) CONSTRAINT uq_NumarInmatriculare UNIQUE,
   MarcaModel VARCHAR2(50) CONSTRAINT nn_MarcaModel NOT NULL,
   AnFabricatie DATE,
   Culoare VARCHAR2(30),
   TipCombustibil VARCHAR2(30),
   DataInceputITP DATE CONSTRAINT nn_DataInceputITP NOT NULL,
   DataSfarsitITP DATE CONSTRAINT nn_DataSfarsitITP NOT NULL,
   DataInceputAsigurare DATE,
   DataSfarsitAsigurare DATE,
   SoferID NUMBER(4),
   UtilizatorID NUMBER(4),
      CONSTRAINT pk_VehiculID PRIMARY KEY(VehiculID),
      CONSTRAINT fk_SoferID FOREIGN KEY(SoferID) REFERENCES Soferi_AMO(SoferID),
      CONSTRAINT fk_UtilizatorID_Vehicule_AMO FOREIGN KEY(UtilizatorID) REFERENCES Utilizatori_AMO(UtilizatorID)
);

PROMPT VIZUALIZARE STRUCTURA TABELA Vehicule_AMO
DESCRIBE Vehicule_AMO;

--------------------------------------------------------------------------------

PROMPT STERGERE TABELA Sarcini_AMO
DROP TABLE Sarcini_AMO PURGE;

PROMPT CREARE TABELA Sarcini_AMO
CREATE TABLE Sarcini_AMO(
   SarcinaID NUMBER(4),
   NumeSarcina VARCHAR2(100) CONSTRAINT nn_NumeSarcina NOT NULL,
   DescriereSarcina VARCHAR2(150) CONSTRAINT nn_DescriereSarcina NOT NULL,
   TermenLimitaSarcina DATE CONSTRAINT nn_TermenLimitaSarcina NOT NULL,
   UtilizatorID NUMBER(4),
      CONSTRAINT pk_SarcinaID PRIMARY KEY(SarcinaID),
      CONSTRAINT fk_UtilizatorID_Sarcini_AMO FOREIGN KEY(UtilizatorID) REFERENCES Utilizatori_AMO(UtilizatorID)
);

PROMPT VIZUALIZARE STRUCTURA TABELA Sarcini_AMO
DESCRIBE Sarcini_AMO;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROMPT 2. ACTUALIZAREA STRUCTURII TABELELOR ?i MODIFICAREA RESTRIC?IILOR DE INTEGRITATE

ALTER TABLE Utilizatori_AMO
ADD Adresa VARCHAR2(100);

ALTER TABLE Utilizatori_AMO
MODIFY Email VARCHAR2(100) CONSTRAINT ck_EmailFormat_AMO CHECK (REGEXP_LIKE(Email, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'));

ALTER TABLE Utilizatori_AMO
DROP CONSTRAINT uq_EmailUtilizator_AMO;

ALTER TABLE Utilizatori_AMO
DROP CONSTRAINT uq_TelefonUtilizator_AMO;

--------------------------------------------------------------------------------

ALTER TABLE Soferi_AMO
ADD CONSTRAINT ck_DataAngajarii CHECK (DataAngajarii < DataSalariu);

--------------------------------------------------------------------------------

ALTER TABLE Documente_AMO
ADD DescriereDocument VARCHAR2(255);

--------------------------------------------------------------------------------

ALTER TABLE Vehicule_AMO
MODIFY MarcaModel VARCHAR2(100);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROMPT 3. ADAUGAREA DE ÎNREGISTR?RI

INSERT INTO Utilizatori_AMO (UtilizatorID, Nume, Prenume, NumeUtilizator, Email, Telefon, Parola, Adresa) 
VALUES (1, 'Popescu', 'Ion', 'popescu_ion', 'popescu.ion@example.com', '0721123456', 'parola123', 'Str. Libert??ii, Nr.10');

INSERT INTO Utilizatori_AMO (UtilizatorID, Nume, Prenume, NumeUtilizator, Email, Telefon, Parola, Adresa)
VALUES (2, 'Ionescu', 'Maria', 'maria_ionescu', 'mionescu@example.com', '0732123456', 'parola456', 'Bd. Independen?ei, Nr. 25');

INSERT INTO Utilizatori_AMO (UtilizatorID, Nume, Prenume, NumeUtilizator, Email, Telefon, Parola, Adresa)
VALUES (3, 'Radu', 'Andrei', 'radu_andrei', 'aradu@example.com', '0743123456', 'parola789', 'Str. Victoriei, Nr. 15');

INSERT INTO Utilizatori_AMO (UtilizatorID, Nume, Prenume, NumeUtilizator, Email, Telefon, Parola, Adresa)
VALUES (4, 'Georgescu', 'Ana', 'ana_georgescu', 'ana.georgescu@example.com', '0754123456', 'parola321', 'Bd. Unirii, Nr. 30');

INSERT INTO Utilizatori_AMO (UtilizatorID, Nume, Prenume, NumeUtilizator, Email, Telefon, Parola, Adresa)
VALUES (5, 'Popa', 'Diana', 'diana_popa', 'diana.popa@example.com', '0765123456', 'parola654', 'Str. Mihai Eminescu, Nr. 5');

SELECT * FROM Utilizatori_AMO;


--------------------------------------------------------------------------------

INSERT INTO Soferi_AMO (SoferID, Nume, Prenume, DataNasterii, DataAngajarii, DataSalariu, Telefon, Email, DataEmiterePermis, DataExpirarePermis, DataInceputConcediu, DataSfarsitConcediu, UtilizatorID)
VALUES (1, 'Popescu', 'Ion', TO_DATE('1985-05-15', 'YYYY-MM-DD'), TO_DATE('2022-01-10', 'YYYY-MM-DD'), TO_DATE('2022-02-01', 'YYYY-MM-DD'), '0721123456', 'popescu_ion@example.com', TO_DATE('2022-01-15', 'YYYY-MM-DD'), TO_DATE('2025-01-15', 'YYYY-MM-DD'), NULL, NULL, 1);

INSERT INTO Soferi_AMO (SoferID, Nume, Prenume, DataNasterii, DataAngajarii, DataSalariu, Telefon, Email, DataEmiterePermis, DataExpirarePermis, DataInceputConcediu, DataSfarsitConcediu, UtilizatorID)
VALUES (2, 'Ionescu', 'Maria', TO_DATE('1990-07-20', 'YYYY-MM-DD'), TO_DATE('2022-03-01', 'YYYY-MM-DD'), TO_DATE('2022-04-01', 'YYYY-MM-DD'), '0732123456', 'mionescu@example.com', TO_DATE('2022-02-15', 'YYYY-MM-DD'), TO_DATE('2025-02-15', 'YYYY-MM-DD'), NULL, NULL, 1);

INSERT INTO Soferi_AMO (SoferID, Nume, Prenume, DataNasterii, DataAngajarii, DataSalariu, Telefon, Email, DataEmiterePermis, DataExpirarePermis, DataInceputConcediu, DataSfarsitConcediu, UtilizatorID)
VALUES (3, 'Radu', 'Andrei', TO_DATE('1988-11-10', 'YYYY-MM-DD'), TO_DATE('2022-02-20', 'YYYY-MM-DD'), TO_DATE('2022-03-20', 'YYYY-MM-DD'), '0743123456', 'aradu@example.com', TO_DATE('2022-02-25', 'YYYY-MM-DD'), TO_DATE('2025-02-25', 'YYYY-MM-DD'), NULL, NULL, 1);

INSERT INTO Soferi_AMO (SoferID, Nume, Prenume, DataNasterii, DataAngajarii, DataSalariu, Telefon, Email, DataEmiterePermis, DataExpirarePermis, DataInceputConcediu, DataSfarsitConcediu, UtilizatorID)
VALUES (4, 'Georgescu', 'Ana', TO_DATE('1995-03-25', 'YYYY-MM-DD'), TO_DATE('2022-04-05', 'YYYY-MM-DD'), TO_DATE('2022-05-05', 'YYYY-MM-DD'), '0754123456', 'ana.georgescu@example.com', TO_DATE('2022-04-10', 'YYYY-MM-DD'), TO_DATE('2025-04-10', 'YYYY-MM-DD'), NULL, NULL, 2);

INSERT INTO Soferi_AMO (SoferID, Nume, Prenume, DataNasterii, DataAngajarii, DataSalariu, Telefon, Email, DataEmiterePermis, DataExpirarePermis, DataInceputConcediu, DataSfarsitConcediu, UtilizatorID)
VALUES (5, 'Popa', 'Diana', TO_DATE('1993-09-12', 'YYYY-MM-DD'), TO_DATE('2022-05-10', 'YYYY-MM-DD'), TO_DATE('2022-06-10', 'YYYY-MM-DD'), '0765123456', 'diana.popa@example.com', TO_DATE('2022-05-15', 'YYYY-MM-DD'), TO_DATE('2025-05-15', 'YYYY-MM-DD'), NULL, NULL, 3);

--------------------------------------------------------------------------------

INSERT INTO Documente_AMO (DocumentID, NumeDocument, TipDocument, DataIncarcareDocument, CaleFisierDocument, UtilizatorID)
VALUES (1, 'Contract de munc?', 'Contract', TO_DATE('2022-01-10', 'YYYY-MM-DD'), '/cale/documente/contract_munca.pdf', 1);

INSERT INTO Documente_AMO (DocumentID, NumeDocument, TipDocument, DataIncarcareDocument, CaleFisierDocument, UtilizatorID)
VALUES (2, 'Permis de conducere', 'Licen??', TO_DATE('2022-01-15', 'YYYY-MM-DD'), '/cale/documente/permis_conducere.pdf', 2);

INSERT INTO Documente_AMO (DocumentID, NumeDocument, TipDocument, DataIncarcareDocument, CaleFisierDocument, UtilizatorID)
VALUES (3, 'Asigurare auto', 'Asigurare', TO_DATE('2022-02-10', 'YYYY-MM-DD'), '/cale/documente/asigurare_auto.pdf', 3);

INSERT INTO Documente_AMO (DocumentID, NumeDocument, TipDocument, DataIncarcareDocument, CaleFisierDocument, UtilizatorID)
VALUES (4, 'Certificat de na?tere', 'Act de identitate', TO_DATE('2022-03-05', 'YYYY-MM-DD'), '/cale/documente/certificat_nastere.pdf', 3);

INSERT INTO Documente_AMO (DocumentID, NumeDocument, TipDocument, DataIncarcareDocument, CaleFisierDocument, UtilizatorID)
VALUES (5, 'Diplom? de absolvire', 'Diplom?', TO_DATE('2022-04-20', 'YYYY-MM-DD'), '/cale/documente/diploma_absolvire.pdf', 3);

--------------------------------------------------------------------------------

INSERT INTO Contracte_AMO (ContractID, NumeContract, TipContract, DataInceputContract, DataSfarsitContract, UtilizatorID)
VALUES (1, 'Contract de munc?', 'Munc?', TO_DATE('2022-01-10', 'YYYY-MM-DD'), TO_DATE('2023-01-10', 'YYYY-MM-DD'), 1);

INSERT INTO Contracte_AMO (ContractID, NumeContract, TipContract, DataInceputContract, DataSfarsitContract, UtilizatorID)
VALUES (2, 'Contract de închiriere', 'Închiriere', TO_DATE('2022-02-15', 'YYYY-MM-DD'), TO_DATE('2023-02-15', 'YYYY-MM-DD'), 2);

INSERT INTO Contracte_AMO (ContractID, NumeContract, TipContract, DataInceputContract, DataSfarsitContract, UtilizatorID)
VALUES (3, 'Contract de asigurare', 'Asigurare', TO_DATE('2022-03-20', 'YYYY-MM-DD'), TO_DATE('2023-03-20', 'YYYY-MM-DD'), 2);

INSERT INTO Contracte_AMO (ContractID, NumeContract, TipContract, DataInceputContract, DataSfarsitContract, UtilizatorID)
VALUES (4, 'Contract de consultan??', 'Consultan??', TO_DATE('2022-04-25', 'YYYY-MM-DD'), TO_DATE('2023-04-25', 'YYYY-MM-DD'), 3);

INSERT INTO Contracte_AMO (ContractID, NumeContract, TipContract, DataInceputContract, DataSfarsitContract, UtilizatorID)
VALUES (5, 'Contract de vânzare-cump?rare', 'Vânzare-Cump?rare', TO_DATE('2022-05-30', 'YYYY-MM-DD'), TO_DATE('2023-05-30', 'YYYY-MM-DD'), 4);

--------------------------------------------------------------------------------

INSERT INTO Vehicule_AMO (VehiculID, NumarInmatriculare, MarcaModel, AnFabricatie, Culoare, TipCombustibil, DataInceputITP, DataSfarsitITP, DataInceputAsigurare, DataSfarsitAsigurare, SoferID, UtilizatorID)
VALUES (1, 'B-123-ABC', 'Ford Focus', TO_DATE('2018-01-01', 'YYYY-MM-DD'), 'Ro?u', 'Benzin?', TO_DATE('2022-01-10', 'YYYY-MM-DD'), TO_DATE('2023-01-10', 'YYYY-MM-DD'), TO_DATE('2022-02-15', 'YYYY-MM-DD'), TO_DATE('2023-02-15', 'YYYY-MM-DD'), 1, 1);

INSERT INTO Vehicule_AMO (VehiculID, NumarInmatriculare, MarcaModel, AnFabricatie, Culoare, TipCombustibil, DataInceputITP, DataSfarsitITP, DataInceputAsigurare, DataSfarsitAsigurare, SoferID, UtilizatorID)
VALUES (2, 'B-456-DEF', 'Volkswagen Golf', TO_DATE('2019-01-01', 'YYYY-MM-DD'), 'Alb', 'Motorin?', TO_DATE('2022-02-20', 'YYYY-MM-DD'), TO_DATE('2023-02-20', 'YYYY-MM-DD'), TO_DATE('2022-03-25', 'YYYY-MM-DD'), TO_DATE('2023-03-25', 'YYYY-MM-DD'), 2, 2);

INSERT INTO Vehicule_AMO (VehiculID, NumarInmatriculare, MarcaModel, AnFabricatie, Culoare, TipCombustibil, DataInceputITP, DataSfarsitITP, DataInceputAsigurare, DataSfarsitAsigurare, SoferID, UtilizatorID)
VALUES (3, 'B-789-GHI', 'Audi A4', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 'Negru', 'Benzin?', TO_DATE('2022-03-30', 'YYYY-MM-DD'), TO_DATE('2023-03-30', 'YYYY-MM-DD'), TO_DATE('2022-04-25', 'YYYY-MM-DD'), TO_DATE('2023-04-25', 'YYYY-MM-DD'), 3, 2);

INSERT INTO Vehicule_AMO (VehiculID, NumarInmatriculare, MarcaModel, AnFabricatie, Culoare, TipCombustibil, DataInceputITP, DataSfarsitITP, DataInceputAsigurare, DataSfarsitAsigurare, SoferID, UtilizatorID)
VALUES (4, 'B-987-JKL', 'BMW 3 Series', TO_DATE('2021-01-01', 'YYYY-MM-DD'), 'Albastru', 'Motorin?', TO_DATE('2022-04-10', 'YYYY-MM-DD'), TO_DATE('2023-04-10', 'YYYY-MM-DD'), TO_DATE('2022-05-15', 'YYYY-MM-DD'), TO_DATE('2023-05-15', 'YYYY-MM-DD'), 4, 3);

INSERT INTO Vehicule_AMO (VehiculID, NumarInmatriculare, MarcaModel, AnFabricatie, Culoare, TipCombustibil, DataInceputITP, DataSfarsitITP, DataInceputAsigurare, DataSfarsitAsigurare, SoferID, UtilizatorID)
VALUES (5, 'B-654-MNO', 'Mercedes-Benz C-Class', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'Argintiu', 'Benzin?', TO_DATE('2022-05-20', 'YYYY-MM-DD'), TO_DATE('2023-05-20', 'YYYY-MM-DD'), TO_DATE('2022-06-25', 'YYYY-MM-DD'), TO_DATE('2023-06-25', 'YYYY-MM-DD'), 5, 3);

--------------------------------------------------------------------------------

INSERT INTO Sarcini_AMO (SarcinaID, NumeSarcina, DescriereSarcina, TermenLimitaSarcina, UtilizatorID)
VALUES (1, 'Implementare func?ionalitate', 'Implementarea unei noi func?ionalit??i în aplica?ie', TO_DATE('2022-01-20', 'YYYY-MM-DD'), 1);

INSERT INTO Sarcini_AMO (SarcinaID, NumeSarcina, DescriereSarcina, TermenLimitaSarcina, UtilizatorID)
VALUES (2, 'Testare software', 'Testarea ?i depanarea erorilor în aplica?ie', TO_DATE('2022-02-25', 'YYYY-MM-DD'), 1);

INSERT INTO Sarcini_AMO (SarcinaID, NumeSarcina, DescriereSarcina, TermenLimitaSarcina, UtilizatorID)
VALUES (3, 'Raport lunar', 'Generarea rapoartelor de activitate lunar?', TO_DATE('2022-03-15', 'YYYY-MM-DD'), 2);

INSERT INTO Sarcini_AMO (SarcinaID, NumeSarcina, DescriereSarcina, TermenLimitaSarcina, UtilizatorID)
VALUES (4, 'Întâlnire cu clien?ii', 'Organizarea unei întâlniri pentru discutarea cerin?elor clien?ilor', TO_DATE('2022-04-05', 'YYYY-MM-DD'), 3);

INSERT INTO Sarcini_AMO (SarcinaID, NumeSarcina, DescriereSarcina, TermenLimitaSarcina, UtilizatorID)
VALUES (5, 'Optimizare baz? de date', 'Optimizarea performan?ei bazei de date', TO_DATE('2022-05-10', 'YYYY-MM-DD'), 3);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROMPT 4. DEFINIREA SECVEN?ELOR

CREATE SEQUENCE seq_UtilizatorID
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

--------------------------------------------------------------------------------

CREATE SEQUENCE seq_SoferID
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
--------------------------------------------------------------------------------

CREATE SEQUENCE seq_DocumentID
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

--------------------------------------------------------------------------------

CREATE SEQUENCE seq_ContractID
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

--------------------------------------------------------------------------------

CREATE SEQUENCE seq_VehiculID
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
--------------------------------------------------------------------------------

CREATE SEQUENCE seq_SarcinaID
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
--------------------------------------------------------------------------------

INSERT INTO Utilizatori_AMO (UtilizatorID, Nume, Prenume, NumeUtilizator, Email, Telefon, Parola, Adresa) 
VALUES (seq_UtilizatorID.NEXTVAL, 'Popescu', 'Ion', 'popescu_ion', 'popescu.ion@example.com', '0721123456', 'parola123', 'Str. Libert??ii, Nr.10');

INSERT INTO Utilizatori_AMO (UtilizatorID, Nume, Prenume, NumeUtilizator, Email, Telefon, Parola, Adresa)
VALUES (seq_UtilizatorID.NEXTVAL, 'Ionescu', 'Maria', 'maria_ionescu', 'mionescu@example.com', '0732123456', 'parola456', 'Bd. Independen?ei, Nr. 25');

INSERT INTO Utilizatori_AMO (UtilizatorID, Nume, Prenume, NumeUtilizator, Email, Telefon, Parola, Adresa)
VALUES (seq_UtilizatorID.NEXTVAL, 'Radu', 'Andrei', 'radu_andrei', 'aradu@example.com', '0743123456', 'parola789', 'Str. Victoriei, Nr. 15');

--------------------------------------------------------------------------------

INSERT INTO Soferi_AMO (SoferID, Nume, Prenume, DataNasterii, DataAngajarii, DataSalariu, Telefon, Email, DataEmiterePermis, DataExpirarePermis, DataInceputConcediu, DataSfarsitConcediu, UtilizatorID)
VALUES (seq_SoferID.NEXTVAL, 'Popescu', 'Ion', TO_DATE('1985-05-15', 'YYYY-MM-DD'), TO_DATE('2022-01-10', 'YYYY-MM-DD'), TO_DATE('2022-02-01', 'YYYY-MM-DD'), '0721123456', 'popescu_ion@example.com', TO_DATE('2022-01-15', 'YYYY-MM-DD'), TO_DATE('2025-01-15', 'YYYY-MM-DD'), NULL, NULL, 1);

INSERT INTO Soferi_AMO (SoferID, Nume, Prenume, DataNasterii, DataAngajarii, DataSalariu, Telefon, Email, DataEmiterePermis, DataExpirarePermis, DataInceputConcediu, DataSfarsitConcediu, UtilizatorID)
VALUES (seq_SoferID.NEXTVAL, 'Ionescu', 'Maria', TO_DATE('1990-07-20', 'YYYY-MM-DD'), TO_DATE('2022-03-01', 'YYYY-MM-DD'), TO_DATE('2022-04-01', 'YYYY-MM-DD'), '0732123456', 'mionescu@example.com', TO_DATE('2022-02-15', 'YYYY-MM-DD'), TO_DATE('2025-02-15', 'YYYY-MM-DD'), NULL, NULL, 1);

INSERT INTO Soferi_AMO (SoferID, Nume, Prenume, DataNasterii, DataAngajarii, DataSalariu, Telefon, Email, DataEmiterePermis, DataExpirarePermis, DataInceputConcediu, DataSfarsitConcediu, UtilizatorID)
VALUES (seq_SoferID.NEXTVAL, 'Radu', 'Andrei', TO_DATE('1988-11-10', 'YYYY-MM-DD'), TO_DATE('2022-02-20', 'YYYY-MM-DD'), TO_DATE('2022-03-20', 'YYYY-MM-DD'), '0743123456', 'aradu@example.com', TO_DATE('2022-02-25', 'YYYY-MM-DD'), TO_DATE('2025-02-25', 'YYYY-MM-DD'), NULL, NULL, 1);

--------------------------------------------------------------------------------

INSERT INTO Documente_AMO (DocumentID, NumeDocument, TipDocument, DataIncarcareDocument, CaleFisierDocument, UtilizatorID)
VALUES (seq_DocumentID.NEXTVAL, 'Contract de munc?', 'Contract', TO_DATE('2022-01-10', 'YYYY-MM-DD'), '/cale/documente/contract_munca.pdf', 1);

INSERT INTO Documente_AMO (DocumentID, NumeDocument, TipDocument, DataIncarcareDocument, CaleFisierDocument, UtilizatorID)
VALUES (seq_DocumentID.NEXTVAL, 'Permis de conducere', 'Licen??', TO_DATE('2022-01-15', 'YYYY-MM-DD'), '/cale/documente/permis_conducere.pdf', 2);

INSERT INTO Documente_AMO (DocumentID, NumeDocument, TipDocument, DataIncarcareDocument, CaleFisierDocument, UtilizatorID)
VALUES (seq_DocumentID.NEXTVAL, 'Asigurare auto', 'Asigurare', TO_DATE('2022-02-10', 'YYYY-MM-DD'), '/cale/documente/asigurare_auto.pdf', 3);

--------------------------------------------------------------------------------

INSERT INTO Contracte_AMO (ContractID, NumeContract, TipContract, DataInceputContract, DataSfarsitContract, UtilizatorID)
VALUES (seq_ContractID.NEXTVAL, 'Contract de munc?', 'Munc?', TO_DATE('2022-01-10', 'YYYY-MM-DD'), TO_DATE('2023-01-10', 'YYYY-MM-DD'), 1);

INSERT INTO Contracte_AMO (ContractID, NumeContract, TipContract, DataInceputContract, DataSfarsitContract, UtilizatorID)
VALUES (seq_ContractID.NEXTVAL, 'Contract de închiriere', 'Închiriere', TO_DATE('2022-02-15', 'YYYY-MM-DD'), TO_DATE('2023-02-15', 'YYYY-MM-DD'), 2);

INSERT INTO Contracte_AMO (ContractID, NumeContract, TipContract, DataInceputContract, DataSfarsitContract, UtilizatorID)
VALUES (seq_ContractID.NEXTVAL, 'Contract de asigurare', 'Asigurare', TO_DATE('2022-03-20', 'YYYY-MM-DD'), TO_DATE('2023-03-20', 'YYYY-MM-DD'), 2);

--------------------------------------------------------------------------------

INSERT INTO Vehicule_AMO (VehiculID, NumarInmatriculare, MarcaModel, AnFabricatie, Culoare, TipCombustibil, DataInceputITP, DataSfarsitITP, DataInceputAsigurare, DataSfarsitAsigurare, SoferID, UtilizatorID)
VALUES (seq_VehiculID.NEXTVAL, 'B-123-ABC', 'Ford Focus', TO_DATE('2018', 'YYYY'), 'Ro?u', 'Benzin?', TO_DATE('2022-01-10', 'YYYY-MM-DD'), TO_DATE('2023-01-10', 'YYYY-MM-DD'), TO_DATE('2022-02-15', 'YYYY-MM-DD'), TO_DATE('2023-02-15', 'YYYY-MM-DD'), 1, 1);

INSERT INTO Vehicule_AMO (VehiculID, NumarInmatriculare, MarcaModel, AnFabricatie, Culoare, TipCombustibil, DataInceputITP, DataSfarsitITP, DataInceputAsigurare, DataSfarsitAsigurare, SoferID, UtilizatorID)
VALUES (seq_VehiculID.NEXTVAL, 'B-456-DEF', 'Volkswagen Golf', TO_DATE('2019', 'YYYY'), 'Alb', 'Motorin?', TO_DATE('2022-02-20', 'YYYY-MM-DD'), TO_DATE('2023-02-20', 'YYYY-MM-DD'), TO_DATE('2022-03-25', 'YYYY-MM-DD'), TO_DATE('2023-03-25', 'YYYY-MM-DD'), 2, 2);

INSERT INTO Vehicule_AMO (VehiculID, NumarInmatriculare, MarcaModel, AnFabricatie, Culoare, TipCombustibil, DataInceputITP, DataSfarsitITP, DataInceputAsigurare, DataSfarsitAsigurare, SoferID, UtilizatorID)
VALUES (seq_VehiculID.NEXTVAL, 'B-789-GHI', 'Audi A4', TO_DATE('2020', 'YYYY'), 'Negru', 'Benzin?', TO_DATE('2022-03-30', 'YYYY-MM-DD'), TO_DATE('2023-03-30', 'YYYY-MM-DD'), TO_DATE('2022-04-25', 'YYYY-MM-DD'), TO_DATE('2023-04-25', 'YYYY-MM-DD'), 3, 2);

--------------------------------------------------------------------------------

INSERT INTO Sarcini_AMO (SarcinaID, NumeSarcina, DescriereSarcina, TermenLimitaSarcina, UtilizatorID)
VALUES (seq_SarcinaID.NEXTVAL, 'Implementare func?ionalitate', 'Implementarea unei noi func?ionalit??i în aplica?ie', TO_DATE('2022-01-20', 'YYYY-MM-DD'), 1);

INSERT INTO Sarcini_AMO (SarcinaID, NumeSarcina, DescriereSarcina, TermenLimitaSarcina, UtilizatorID)
VALUES (seq_SarcinaID.NEXTVAL, 'Testare software', 'Testarea ?i depanarea erorilor în aplica?ie', TO_DATE('2022-02-25', 'YYYY-MM-DD'), 1);

INSERT INTO Sarcini_AMO (SarcinaID, NumeSarcina, DescriereSarcina, TermenLimitaSarcina, UtilizatorID)
VALUES (seq_SarcinaID.NEXTVAL, 'Raport lunar', 'Generarea rapoartelor de activitate lunar?', TO_DATE('2022-03-15', 'YYYY-MM-DD'), 2);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROMPT 5. ACTUALIZAREA ÎNREGISTR?RILOR din tabele

UPDATE Utilizatori_AMO
SET Telefon = '0722334455'
WHERE UtilizatorID = 1;

UPDATE Soferi_AMO
SET DataSalariu = TO_DATE('2022-03-01', 'YYYY-MM-DD')
WHERE SoferID = 1;

--------------------------------------------------------------------------------

UPDATE Documente_AMO
SET TipDocument = 'Act de identitate'
WHERE DocumentID = 4;

--------------------------------------------------------------------------------

UPDATE Contracte_AMO
SET DataSfarsitContract = TO_DATE('2023-02-10', 'YYYY-MM-DD')
WHERE ContractID = 3;

--------------------------------------------------------------------------------

UPDATE Vehicule_AMO
SET Culoare = 'Albastru'
WHERE VehiculID = 3;

--------------------------------------------------------------------------------

UPDATE Sarcini_AMO
SET TermenLimitaSarcina = TO_DATE('2022-04-01', 'YYYY-MM-DD')   
WHERE SarcinaID = 4;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROMPT 6. Utilizarea OPERATORILOR DE COMPARA?IE

PROMPT Operatorul EQUALS(=):

SELECT * FROM Utilizatori_AMO WHERE Nume = 'Popescu';
SELECT * FROM Soferi_AMO WHERE Nume = 'Radu';
SELECT * FROM Documente_AMO WHERE NumeDocument = 'Permis de conducere';
SELECT * FROM Contracte_AMO WHERE NumeContract = 'Contract de munc?';
SELECT * FROM Vehicule_AMO WHERE NumarInmatriculare = 'B-123-ABC';
SELECT * FROM Sarcini_AMO WHERE NumeSarcina = 'Raport lunar';

--------------------------------------------------------------------------------

PROMPT Operatorul GREATER THAN(>):

SELECT * FROM Utilizatori_AMO WHERE UtilizatorID > 3;
SELECT * FROM Soferi_AMO WHERE SoferID > 2;
SELECT * FROM Documente_AMO WHERE DocumentID > 2;
SELECT * FROM Contracte_AMO WHERE ContractID > 3;
SELECT * FROM Vehicule_AMO WHERE VehiculID > 2;
SELECT * FROM Sarcini_AMO WHERE SarcinaID > 3;

--------------------------------------------------------------------------------

PROMPT Operatorul LESS THAN(<):

SELECT * FROM Utilizatori_AMO WHERE UtilizatorID < 3;
SELECT * FROM Soferi_AMO WHERE SoferID < 3;
SELECT * FROM Documente_AMO WHERE DocumentID < 3;
SELECT * FROM Contracte_AMO WHERE ContractID < 3;
SELECT * FROM Vehicule_AMO WHERE VehiculID < 4;
SELECT * FROM Sarcini_AMO WHERE SarcinaID < 3;

--------------------------------------------------------------------------------

PROMPT Operatorul LIKE:

SELECT * FROM Utilizatori_AMO WHERE Nume LIKE '%Popescu%';
SELECT * FROM Soferi_AMO WHERE Prenume LIKE 'A%';
SELECT * FROM Documente_AMO WHERE NumeDocument LIKE '%asigurare%';
SELECT * FROM Contracte_AMO WHERE NumeContract LIKE 'C%';
SELECT * FROM Vehicule_AMO WHERE MarcaModel LIKE '%BMW%';
SELECT * FROM Sarcini_AMO WHERE DescriereSarcina LIKE '%testare%';

--------------------------------------------------------------------------------

PROMPT Operatorul LESS THAN OR EQUAL TO(<=):

SELECT * FROM Utilizatori_AMO WHERE UtilizatorID <= 3;
SELECT * FROM Soferi_AMO WHERE SoferID <= 2;
SELECT * FROM Documente_AMO WHERE DocumentID <= 2;
SELECT * FROM Contracte_AMO WHERE ContractID <= 3;
SELECT * FROM Vehicule_AMO WHERE VehiculID <= 4;
SELECT * FROM Sarcini_AMO WHERE SarcinaID <= 4;

--------------------------------------------------------------------------------

PROMPT Operatorul GREATER THAN OR EQUAL TO(>=):

SELECT * FROM Utilizatori_AMO WHERE UtilizatorID >= 3;
SELECT * FROM Soferi_AMO WHERE SoferID >= 2;
SELECT * FROM Documente_AMO WHERE DocumentID >= 2;
SELECT * FROM Contracte_AMO WHERE ContractID >= 3;
SELECT * FROM Vehicule_AMO WHERE VehiculID >= 4;
SELECT * FROM Sarcini_AMO WHERE SarcinaID >= 4;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROMPT 7. Utilizarea func?iilor NUMERICE, de tip CARACTER, pentru DAT? ?I TIMP

PROMPT Func?ii numerice:

PROMPT - ABS():

SELECT ABS(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DataNasterii)) AS Diferenta_Absoluta FROM Soferi_AMO;

PROMPT - ROUND():

SELECT ROUND(MONTHS_BETWEEN(SYSDATE, DataAngajarii) / 12) AS Vechime_Apropiata FROM Soferi_AMO;

PROMPT - CEIL():

SELECT CEIL(MONTHS_BETWEEN(SYSDATE, DataAngajarii) / 12) AS Ani_Angajare FROM Soferi_AMO;

--------------------------------------------------------------------------------

PROMPT Func?ii de tip caracter:

PROMPT - UPPER():

SELECT UPPER(NumeUtilizator) AS NumeUtilizator_Majuscule FROM Utilizatori_AMO;

PROMPT - LOWER():

SELECT LOWER(Email) AS Email_Minuscule FROM Soferi_AMO;

PROMPT - INITCAP():

SELECT INITCAP(Nume) AS Nume_InitCap FROM Soferi_AMO;

--------------------------------------------------------------------------------

PROMPT Func?ii pentru dat? ?i timp:

PROMPT - SYSDATE:

SELECT SYSDATE FROM dual;

PROMPT - MONTHS_BETWEEN():


SELECT ROUND(MONTHS_BETWEEN(SYSDATE, DataInceputITP)) AS Vechime_Luni FROM Vehicule_AMO;

PROMPT - ADD_MONTHS():

SELECT ADD_MONTHS(DataInceputContract, 6) AS Data_Sfarsit_Extenstie FROM Contracte_AMO;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROMPT 8. JOIN-uri între tabele, utilizarea FUNC?IILOR DE GRUP ?i a CONDI?IILOR asupra acestora/HAVING

SELECT Utilizatori_AMO.Nume, Utilizatori_AMO.Prenume, COUNT(Soferi_AMO.SoferID) AS Numar_Soferi
FROM Utilizatori_AMO
LEFT JOIN Soferi_AMO ON Utilizatori_AMO.UtilizatorID = Soferi_AMO.UtilizatorID
GROUP BY Utilizatori_AMO.Nume, Utilizatori_AMO.Prenume
HAVING COUNT(Soferi_AMO.SoferID) > 1;



PROMPT Acest exemplu afi?eaz? numele ?i prenumele utilizatorilor care sunt ?oferi ?i au mai mult de un înregistrare în tabelul ?oferi.

--------------------------------------------------------------------------------


SELECT Utilizatori_AMO.Nume, Utilizatori_AMO.Prenume, MAX(Documente_AMO.DataIncarcareDocument) AS Ultimul_Document_Incarcat
FROM Utilizatori_AMO
LEFT JOIN Documente_AMO ON Utilizatori_AMO.UtilizatorID = Documente_AMO.UtilizatorID
GROUP BY Utilizatori_AMO.Nume, Utilizatori_AMO.Prenume;


PROMPT Acest exemplu afi?eaz? numele ?i prenumele utilizatorilor, împreun? cu data ultimului document înc?rcat pentru fiecare utilizator, indiferent dac? au documente înc?rcate sau nu.

--------------------------------------------------------------------------------


SELECT Utilizatori_AMO.Nume, Utilizatori_AMO.Prenume, Utilizatori_AMO.NumeUtilizator, COUNT(Vehicule_AMO.VehiculID) AS NumarVehicule
FROM Utilizatori_AMO
JOIN Soferi_AMO ON Utilizatori_AMO.UtilizatorID = Soferi_AMO.UtilizatorID
LEFT JOIN Vehicule_AMO ON Soferi_AMO.SoferID = Vehicule_AMO.SoferID
GROUP BY Utilizatori_AMO.Nume, Utilizatori_AMO.Prenume, Utilizatori_AMO.NumeUtilizator;



PROMPT Acest exemplu afi?eaz? numele ?i prenumele ?oferilor împreun? cu numele de utilizator ?i num?rul de vehicule pe care le conduc.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROMPT 9. Construirea de expresii cu DECODE ?i CASE

SELECT Soferi_AMO.Nume, Soferi_AMO.Prenume, 
       DECODE((SELECT COUNT(*) FROM Vehicule_AMO WHERE Soferi_AMO.SoferID = Vehicule_AMO.SoferID),
              0, 'Fara vehicul',
              1, 'Un singur vehicul',
              'Mai mult de un vehicul') AS StatusVehicule
FROM Soferi_AMO;

--------------------------------------------------------------------------------

SELECT Nume, Prenume,
       DECODE(SYSDATE - DataAngajarii,
              0, 'Angajat azi',
              1, 'Angajat ieri',
              7, 'Angajat saptamâna trecut?',
              30, 'Angajat acum o luna',
              'Mai mult de o luna în urma') AS Vechime
FROM Soferi_AMO;



--------------------------------------------------------------------------------

SELECT Nume, Prenume,
       DECODE(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DataEmiterePermis),
              0, 'Încep?tor',
              1, 'Experienta de un an',
              2, 'Experienta de doi ani',
              'Experienta de peste doi ani') AS Experienta
FROM Soferi_AMO;


--------------------------------------------------------------------------------

SELECT Nume, Prenume,
       CASE 
           WHEN SYSDATE - DataAngajarii = 0 THEN 'Angajat azi'
           WHEN SYSDATE - DataAngajarii = 1 THEN 'Angajat ieri'
           WHEN SYSDATE - DataAngajarii = 7 THEN 'Angajat saptamâna trecuta'
           WHEN SYSDATE - DataAngajarii = 30 THEN 'Angajat acum o luna'
           ELSE 'Mai mult de o luna în urma'
       END AS Vechime
FROM Soferi_AMO;

--------------------------------------------------------------------------------

SELECT Nume, Prenume,
       CASE 
           WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DataEmiterePermis) = 0 THEN 'Începator'
           WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DataEmiterePermis) = 1 THEN 'Experienta de un an'
           WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DataEmiterePermis) = 2 THEN 'Experienta de doi ani'
           ELSE 'Experienta de peste doi ani'
       END AS Experienta
FROM Soferi_AMO;


--------------------------------------------------------------------------------

SELECT Nume, Prenume,
       CASE 
           WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DataNasterii) < 30 THEN 'Sub 30 de ani'
           WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DataNasterii) >= 30 AND EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DataNasterii) < 40 THEN '30-39 ani'
           WHEN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DataNasterii) >= 40 AND EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DataNasterii) < 50 THEN '40-49 ani'
           ELSE '50+ ani'
       END AS CategorieVarsta
FROM Soferi_AMO;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROMPT 10. Utilizarea operatorilor UNION, MINUS ?i INTERSECT

SELECT Email FROM Utilizatori_AMO
UNION
SELECT Email FROM Soferi_AMO;


SELECT Nume, Prenume FROM Utilizatori_AMO
UNION
SELECT Nume, Prenume FROM Soferi_AMO;

--------------------------------------------------------------------------------


SELECT Email FROM Utilizatori_AMO
MINUS
SELECT Email FROM Soferi_AMO;

SELECT Nume, Prenume FROM Utilizatori_AMO
MINUS
SELECT Nume, Prenume FROM Soferi_AMO;



--------------------------------------------------------------------------------

SELECT Email FROM Utilizatori_AMO
INTERSECT
SELECT Email FROM Soferi_AMO;

SELECT Nume, Prenume FROM Utilizatori_AMO
INTERSECT
SELECT Nume, Prenume FROM Soferi_AMO;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROMPT 11. SUBCERERI (CERERI IMBRICATE sau clauze de tip “SELECT în SELECT”)

PROMPT Afi?area detaliilor vehiculelor care au fost asignate ?oferilor cu experien?? de peste un an:

SELECT *
FROM Vehicule_AMO
WHERE SoferID IN (
    SELECT SoferID
    FROM Soferi_AMO
    WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DataEmiterePermis) > 1
);

--------------------------------------------------------------------------------



PROMPT Afi?area numelui ?i prenumelui ?oferilor care conduc vehicule care au culoarea "Ro?u":

SELECT Nume, Prenume
FROM Soferi_AMO
WHERE UtilizatorID IN (
    SELECT UtilizatorID
    FROM Soferi_AMO
    WHERE SoferID IN (
        SELECT SoferID
        FROM Vehicule_AMO
        WHERE Culoare = 'Ro?u'
    )
);

--------------------------------------------------------------------------------

PROMPT Afi?area informa?iilor despre vehicule care necesit? inspec?ie tehnic? periodic?(ITP) în urm?toarele 30 de zile:

SELECT *
FROM Vehicule_AMO
WHERE VehiculID IN (
    SELECT VehiculID
    FROM Vehicule_AMO
    WHERE DataSfarsitITP BETWEEN SYSDATE AND SYSDATE + 30
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROMPT 12. FORMATAREA PAGINILOR ?i CREAREA RAPOARTELOR SQL.




CREATE GLOBAL TEMPORARY TABLE Temp_Results (
    Row_Num NUMBER,
    Nume VARCHAR2(50),
    Prenume VARCHAR2(50)
);

INSERT INTO Temp_Results (Row_Num, Nume, Prenume)
SELECT ROWNUM, Nume, Prenume
FROM Utilizatori_AMO
ORDER BY Nume, Prenume;

SELECT Nume, Prenume
FROM Temp_Results
WHERE Row_Num BETWEEN 1 AND 4;

TRUNCATE TABLE Temp_Results;





--------------------------------------------------------------------------------

CREATE GLOBAL TEMPORARY TABLE Temp_Results (
    Row_Num NUMBER,
    Nume VARCHAR2(50),
    Prenume VARCHAR2(50)
);

INSERT INTO Temp_Results (Row_Num, Nume, Prenume)
SELECT ROWNUM, Nume, Prenume
FROM Utilizatori_AMO
ORDER BY Nume, Prenume;

SELECT Utilizatori_AMO.Nume, Utilizatori_AMO.Prenume, COUNT(Sarcini_AMO.SarcinaID) AS NumarSarcini
FROM Utilizatori_AMO
LEFT JOIN Sarcini_AMO ON Utilizatori_AMO.UtilizatorID = Sarcini_AMO.UtilizatorID
GROUP BY Utilizatori_AMO.Nume, Utilizatori_AMO.Prenume;

TRUNCATE TABLE Temp_Results;
        
--------------------------------------------------------------------------------

CREATE GLOBAL TEMPORARY TABLE Temp_Results (
    MarcaModel VARCHAR2(50),
    DataNasterii DATE
);

INSERT INTO Temp_Results (MarcaModel, DataNasterii)
SELECT Vehicule_AMO.MarcaModel, Soferi_AMO.DataNasterii
FROM Vehicule_AMO
JOIN Soferi_AMO ON Vehicule_AMO.SoferID = Soferi_AMO.SoferID;

SELECT Vehicule_AMO.MarcaModel, AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM Soferi_AMO.DataNasterii)) AS MediaVarstei
FROM Vehicule_AMO
JOIN Soferi_AMO ON Vehicule_AMO.SoferID = Soferi_AMO.SoferID
GROUP BY Vehicule_AMO.MarcaModel;

TRUNCATE TABLE Temp_Results;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
