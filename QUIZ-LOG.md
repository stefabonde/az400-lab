# Registro quiz AZ-400

Non è una copia delle domande: è il **registro degli errori**. Si annotano solo le domande sbagliate, dubbie o su cose mai viste in lab. Testo riassunto in una riga, mai incollato per intero.

## Come si usa

1. Fai un test su SkillCertPro (meglio per argomento, subito dopo un esercizio).
2. Per ogni domanda **sbagliata**, **indovinata a caso** o **sospetta** (risposta che sembra errata o obsoleta) aggiungi una riga nella tabella.
3. Se non è mai stata in lab, segnala "lab?" e finisce nella lista in fondo.
4. Prima di una simulazione, rileggi solo questo file e `NOTES.md`.

Esito: `X` sbagliata · `?` indovinata / incerta · `!` sospetta (risposta del banco probabilmente errata o obsoleta) · `ok` giusta ma da ricordare.

## Test svolti

| Data | Test SkillCertPro | Punteggio | Note |
|---|---|---|---|
| | | | |

## Domande da ricordare

| # | Tema | Domanda in breve | Esito | Regola da ricordare | Lab |
|---|---|---|---|---|---|
| 1 | Container / ACI | Riavviare ACI quando l'app non risponde | ok | **Liveness** probe = riavvia; **readiness** = toglie dal traffico, non riavvia | es. 14 |

## Da portare in laboratorio

- [ ] Liveness vs readiness probe su Azure Container Instances (aggiunto a es. 14)

## Domande sospette (da verificare su documentazione Microsoft)

| Domanda in breve | Risposta del banco | Dubbio | Esito verifica |
|---|---|---|---|
| Tool di analisi statica Java con Azure DevOps (Bamboo/Jenkins/FindBugs/PMD) | PMD | anche FindBugs è corretta; doc di riferimento TFS 2017 (obsoleta) | Maven@3 supporta Checkstyle, PMD, FindBugs (SpotBugs nelle versioni recenti). Oggi: SonarQube/SonarCloud, CodeQL. Domanda datata, ricordare il concetto |
