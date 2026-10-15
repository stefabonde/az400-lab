# Registro quiz AZ-400

Non è una copia delle domande: è il **registro degli errori**. Si annotano solo le domande sbagliate, dubbie o su cose mai viste in lab. Testo riassunto in una riga, mai incollato per intero.

Esito: `X` sbagliata · `?` indovinata / incerta · `!` sospetta (risposta del banco ambigua, errata o datata) · `ok` giusta ma da ricordare.

## Come si usa

1. Fai un test SkillCertPro (meglio per argomento, subito dopo un esercizio).
2. Per ogni domanda **sbagliata**, **indovinata** o **sospetta** aggiungi una riga.
3. Se non è mai stata in lab, finisce nella lista "Da portare in laboratorio".
4. Prima di una simulazione rileggi solo questo file e `NOTES.md`.

## Regole per le domande d'esame

- **Segui il verbo**: *creare/deployare* → ARM/Bicep; *configurare* → DSC / Custom Script Extension.
- **Domanda datata**: il concetto non cambia, cambia il nome. Se nelle opzioni ci sono vecchio e nuovo nome, vale il nuovo; se c'è solo il vecchio, usa quello.
- **Spiegazioni del banco**: anche loro possono essere inesatte. Se una spiegazione sembra generica, verifica sulla documentazione Microsoft.
- **Hotspot**: ogni campo vale un punto, rispondi a tutti.
- **Ordinamento / drag & drop**: parti dalle dipendenze, individua primo e ultimo passo, scarta i passi di troppo.
- **"No adjustment required"**: l'errore sta nel soggetto della frase.

## Domande da ricordare

| # | Tema | Domanda in breve | Esito | Regola da ricordare | Lab |
|---|---|---|---|---|---|
| 1 | Container / ACI | Riavviare ACI quando l'app non risponde | ok | **Liveness** = riavvia; **readiness** = toglie dal traffico | es. 14 |
| 2 | Analisi statica Java | PMD / FindBugs | `!` | più risposte valide, doc TFS 2017 obsoleta; oggi SonarQube/SonarCloud, CodeQL | |
| 3 | AKS e Azure | identità del cluster verso risorse Azure | ok `!` | banco: service principal; oggi **managed identity** | es. 26 |
| 4 | Artifacts | upstream per pacchetti .NET | ok | **NuGet** (Chocolatey è distrattore) | es. 11 |
| 5 | App Insights | alert su picco di errori | ok | **Smart Detection** | es. 19 |
| 6 | Agent | registrazione di un self-hosted | ok | **PAT**, scope Agent Pools (Read & manage) | es. 10 |
| 7 | Boards | processo per user stories | ok | user story → Agile; PBI → Scrum; requirement/risk → CMMI | es. 20 |
| 8 | Test | esiti diversi senza modifiche | ok | **flaky test** | es. 22 |
| 9 | Boards | tempo da creazione a completamento | `X` | **Lead Time** (Cycle = dall'inizio lavoro) | es. 28 |
| 10 | ARM | tipo di risorsa per un template annidato | `?` | `Microsoft.Resources/deployments` + `mode` + `template`/`templateLink`; Bicep = `module` | es. 15 |
| 11 | Git | evitare update diretti su main | ok | **Branch policies** (lock = sola lettura, security = permessi) | es. 1 |
| 12 | Agent | costo minimo per 2 job/giorno | ok | **ACI** (paghi i secondi di esecuzione) | es. 14 |
| 13 | Key Vault | `az keyvault create` / `secret set` | ok | gruppo `keyvault`, sottogruppo `secret` | es. 16 |
| 14 | VM | configurazione uniforme | `X` `!` | verbo configurare → DSC + Custom Script Extension (ARM per creare) | es. 15 |
| 15 | Agent | cosa si sacrifica con MS-hosted | `X` | software custom preinstallato + velocità da cache persistente | es. 10 |
| 16 | Wiki | chi modifica la project page | `X` `!` | pagine wiki → Contributors; project page → Project Administrators; Team Administrators non è un gruppo di sicurezza | es. 18 |
| 17 | KPI | KPI di qualità | ok | **MTTR** | es. 28 |
| 18 | Storage | segreto per accedere a Storage | `X` | **SAS** per Storage, **PAT** per Azure DevOps; sempre HTTPS | es. 27 |
| 19 | Rilascio | progressive exposure | `X` | **rings + feature flags** (+ canary); blue/green no | es. 13, 24 |
| 20 | Mend/npm | scansione solo produzione | ok | `npm install --production` (oggi `--omit=dev`) | |
| 21 | KQL | tabella per errori di pagina e utenti | ok `!` | banco: `requests` (success == false); `exceptions` per stack trace | es. 19 |
| 22 | SCA | licenze open source | ok | **Black Duck** (SCA), non Maven/CMake/Bamboo | |
| 23 | GHES | auth con Azure DevOps Server | ok | **PAT** per Enterprise Server; GitHub App per github.com | es. 12 |

## Da portare in laboratorio

- [ ] es. 14: liveness vs readiness probe su ACI, container che si riavvia (`restartCount`)
- [ ] es. 15: deployment annidato ARM / `module` Bicep, `mode` Incremental vs Complete; VM extension DSC e Custom Script
- [ ] es. 19: stessa query KQL su `requests` ed `exceptions`
- [ ] es. 27: generare un SAS con scadenza breve, usarlo, farlo scadere
- [ ] es. 28: widget Lead Time e Cycle Time
- [ ] es. 18: gruppi di sicurezza e permessi su wiki

## Nomi cambiati (vecchio → attuale)

| Vecchio nome | Nome attuale | Nota |
|---|---|---|
| PowerShell DSC / Automation State Configuration | **Azure Machine Configuration** | Automation State Configuration in dismissione |
| Azure Active Directory | **Microsoft Entra ID** | 2023 |
| VSTS | **Azure DevOps Services** | |
| TFS | **Azure DevOps Server** | on-premises |
| WhiteSource / Bolt | **Mend** | |
| FindBugs | **SpotBugs** | |
| Azure Security Center / Azure Defender | **Microsoft Defender for Cloud** | |
| Log Analytics agent (MMA/OMS) | **Azure Monitor Agent (AMA)** | MMA ritirato |
| Release pipelines classic | **YAML multi-stage pipelines** | |
| Deployment groups | **Environments** con risorse VM | |
| Service principal con secret | **Managed identity / workload identity federation** | |
| AKS pod identity | **Microsoft Entra Workload ID** | |
| Instrumentation key | **Connection string** | |
| Azure DevOps load testing | **Azure Load Testing** | |
| Visual Studio App Center | ritirato (2025) | |
| GitHub Advanced Security | **Secret Protection** + **Code Security** | separati dal 2025 |

## Test svolti

| Data | Test SkillCertPro | Punteggio | Note |
|---|---|---|---|
| 2026-10-15 | (primo giro) | | domande 1-23 sopra |
