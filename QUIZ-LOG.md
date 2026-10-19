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
| 24 | Git | ordine del flusso trunk-based | ok | feature branch → commit/push → PR → merge | es. 1 |
| 25 | App Insights | ping test da più regioni con alert | `X` | **availability test** esegue il ping; la metrica è il risultato; Service Health = piattaforma; URL ping classici in dismissione | es. 19 |
| 26 | Release | verificare work item aperti prima del deploy | ok | **pre-deployment gate** (automatico); approval = persona | es. 13 |
| 27 | DSC | completare configurazione (Node, WindowsFeatureSet) | ok | `WindowsFeatureSet` per più feature, `Ensure = Present`, `Node` = macchina | es. 15 |
| 28 | App Service | blue-green con slot | ok | slot staging → deploy → **swap**; rollback = nuovo swap | es. 24 |
| 29 | DSC | `-ConfigurationMode` | ok | ApplyOnly = una volta; ApplyAndMonitor = segnala; **ApplyAndAutoCorrect** = ripara | es. 15 |
| 30 | Boards | Lead / Cycle / Burnup / Burndown / Velocity | `X` (5 varianti) | Lead = dalla creazione; Cycle = dall'attivazione; Velocity = pianificato vs completato per sprint; Burndown = lavoro rimasto | es. 28 |
| 31 | Alert | aumentare il log quando l'uso è anomalo | `X` | **dynamic threshold** + **runbook** (action group); l'email notifica soltanto | es. 19 |
| 32 | Service connection | deploy su sottoscrizione esterna | `X` | service connection **manuale**; service hook = notifica, non credenziali | es. 9 |
| 33 | Sicurezza | scansione dinamica | `X` | **OWASP ZAP** (DAST); SonarQube = statica; Mend/Black Duck = SCA | es. 17 |
| 34 | KQL | `summarize make_set(...) by` | `X` | `summarize` = operatore; `count/dcount/make_set` = funzioni dentro | es. 19 |
| 35 | Log | dove vedere/archiviare i log di test | `X` `!` | build + test → **Pipelines**; solo test automatici → **Test Plans** (banco); Storage = archivio | es. 22 |
| 36 | DSC | nodi gestiti: Register vs ConfigurationMode | `X` `!` | Register = onboarding; ConfigurationMode = come applica; RefreshMode = push/pull | es. 15 |
| 37 | Jenkins | commit su Azure Repos avvia build Jenkins | ok `!` | **service hook** in Azure DevOps = Yes; trigger solo in Jenkins = No (ambigua) | es. 28 |
| 38 | Alert → Teams | notifica in Teams da Azure Monitor | ok (2 volte) | action group → Logic App con trigger **HTTP request** → Teams | es. 19 |
| 39 | Feed | unlist/deprecate = ruolo minimo | ok (2 volte) | **Contributor** (Collaborator no; Owner eccede) | es. 11 |
| 40 | Merge | storia compatta / singolo commit | ok (3 volte) | **squash merge**; rebase riscrive la storia | es. 1 |
| 41 | VM | scalare / datacenter / rack | ok | VMSS = autoscaling; **Availability Zones** = guasto datacenter; Availability Sets = rack | |
| 42 | Release | approvatori esterni all'organizzazione | ok | **Logic App + Teams**; approval nativa e manual intervention richiedono utenti dell'org | es. 13 |
| 43 | Self-hosted | Bitbucket on-prem dietro firewall | ok | **self-hosted agent** + **External Git service connection** | es. 10 |
| 44 | ARM | modalità | ok (2 volte) | **Incremental** = lascia; **Complete** = elimina il resto | es. 15 |
| 45 | SonarQube | cosa si crea a livello progetto | ok | **service connection** (progetto); estensione = organizzazione | es. 22 |
| 46 | Container | test inline | ok | **multi-stage Dockerfile** | es. 14 |
| 47 | Teams | `@azure pipelines subscribe <URL _build?definitionId=…>` | ok | signin → subscribe; subscriptions = elenco | es. 28 |
| 48 | Policy | `supportsHttpsTrafficOnly` + deny | ok | impone HTTPS in transito sui **nuovi** account; non retroattivo | |
| 49 | AKS CLI | `az group create` vs `az aks create` (hotspot) | X | guarda i **parametri**: `--node-count`/`--generate-ssh-keys` = `az aks create`; `--location` senza RG = `az group create` | es. 14 |
| 50 | PowerShell ARM | cmdlet per deployare un template | X | scelto `Set-`; un deployment non si modifica: **`New-AzResourceGroupDeployment`** (`-TemplateFile` locale, `-TemplateUri` URL) | es. 15 |
| 51 | Activity Log alert | quale azione scatta (Administrative + **failed**) | X | leggi **Category, Signal name, Status**; ignorato lo Status. Opzione "scale up fallito" ambigua | es. 19 |
| 52 | Boards | widget "completare il lavoro allocato agli sprint" | X `!` | chiave banco **Velocity** (pianificato vs completato); Burndown = lavoro rimanente | es. 28 |
| 53 | Logic App | trigger chiamato da action group/availability test | `!` | io: **Request**; banco: HTTP Webhook (spiegazione confusa). Ragiona sul requisito | es. 19 |
| 54 | Auth Git | PAT vs Entra ID con Git Credential Manager | `!` | chiave probabile **PAT**; ambigua | es. 18 |
| 55 | Deployment groups | "preparare le VM" | `!` | estensione **Azure Pipelines Agent**; "indirizzare il rilascio" = deployment group | es. 13 |
| 56 | VMSS | idoneita' upgrade per istanza | `!` | **Application Health Extension**; ambigua con la probe del LB | es. 24 |
| 57 | Load Balancer | probe HTTPS, costo minimo | ok | **Standard** (Basic: solo TCP/HTTP, ritirato 09/2025) | es. 24 |
| 58 | Defender / agent | vuln assessment e agent processi VM | ok | datate: Defender for Cloud, **Azure Monitor Agent** al posto del Log Analytics agent | |
| 59 | GitHub Actions | `on: push` (tutti i branch) + `pull_request` su un push con PR aperta | X | partono **entrambi** i run (doppione); filtrare `push` su `main` | es. 12 |

## Da portare in laboratorio

- [ ] es. 14: liveness vs readiness probe su ACI, container che si riavvia (`restartCount`)
- [ ] es. 15: deployment annidato ARM / `module` Bicep, `mode` Incremental vs Complete; VM extension DSC e Custom Script
- [ ] es. 19: stessa query KQL su `requests` ed `exceptions`
- [ ] es. 27: generare un SAS con scadenza breve, usarlo, farlo scadere
- [ ] es. 28: widget Lead Time e Cycle Time
- [ ] es. 18: gruppi di sicurezza e permessi su wiki
- [ ] es. 15: flusso DSC in Automation: `.ps1` → Import → Compile → registrare nodi
- [ ] es. 22: dove compaiono i risultati dei test (tab Tests vs Test Plans)
- [ ] es. 13: gate/approval sull'environment; manual validation

## Nomi cambiati (vecchio → attuale)

| Vecchio nome | Nome attuale | Nota |
|---|---|---|
| PowerShell DSC / Automation State Configuration | **Azure Machine Configuration** | Automation State Configuration in dismissione |
| Azure Active Directory | **Microsoft Entra ID** | 2023 |
| Azure AD Identity Protection | **Microsoft Entra ID Protection** | |
| Azure Pipelines URL ping test (availability) | **Standard test** | |
| Basic Load Balancer | ritirato 30/09/2025 | usare Standard |
| Key Vault access policy | **Azure RBAC** (Key Vault Secrets User) | |
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
| 2026-10-15 | (primo giro) | ~85% su ~88 domande distinte | 13 sbagliate, ~10 ambigue/datate; voci 1-48 sopra |
| 2026-10-19 | (secondo blocco) | 50 domande nuove (schede 101-150) | 4 sbagliate (49-52), 5 ambigue (53-56); voci 49-58 |
| 2026-10-19 | mini-quiz es. 12A | 4/5 | errata la 3 (doppio trigger push + pull_request) |
