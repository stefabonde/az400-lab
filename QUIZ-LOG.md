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
| 60 | GitHub environments | `environment:` con nome sbagliato (refuso) | X | GitHub **crea** un environment nuovo **senza protezioni**: il job parte senza approvazione | es. 12 |
| 61 | OIDC | ordine dei passi (app, credential, ruolo, secret, workflow) | X | **2-4-3-5-1**: il workflow va per ultimo, consuma tutto; ruolo e credential scambiabili | es. 12 |
| 62 | Build Java | dipendenze on-prem con agent Hosted VS 2017 + Java Tool Installer | ? | **No**: serve **self-hosted agent** in rete; il tool installer sceglie solo il JDK. Serie "stessa domanda": hosted = sempre No | es. 10 |
| 63 | Key Vault | service connection per leggere i secret senza credenziali salvate | ? `!` | tipo **Azure Resource Manager**; auth **managed identity** (banco) / **workload identity federation** (oggi). Testo tagliato (2º menu) | es. 12 |
| 64 | Key Vault | impedire l'eliminazione del vault (least privilege) | ? `!` | **RBAC** = management plane (elimina la risorsa); access policy = data plane (secret). Testo tagliato | es. 16 |
| 65 | Logic Apps | riepilogo giornaliero delle eccezioni su Teams | ? | **Logic Apps** (ricorrenza + query KQL + connettore Teams) + **Application Insights**; App Center = distrattore (ritirato) | es. 19 |
| 66 | Release | approvazione oltre 2 ore fa fallire il deploy, policy 8 ore | ? | **Pre-deployment conditions → approvals → Timeout** = Yes. Timeout approvals ≠ timeout gates ≠ deployment queue | es. 13 |
| 67 | Log Analytics | metriche app + DB, query ad-hoc, alert, archivio centrale | ? | **Log Analytics** (workspace + diagnostic settings); App Insights = solo APM; Event Hubs = streaming | es. 19 |
| 68 | Deploy on-prem | Docker build sul server + Download Build Artifacts | ? | **No**: manca il **self-hosted agent** sul target. Copy and Publish Build Artifacts (deprecato) = No | es. 10 |
| 69 | Access level | Pilot users con Test & Feedback (least privilege) | ? | **Stakeholder** (risponde al feedback); **Basic** per chi lo richiede. Testo tagliato (riga Developers) | es. 20 |
| 70 | Auth CI esterno | come ADO autentica verso un CI di terze parti | `!` | banco: **PAT**; verso ambiguo (di solito è il tool a usare il PAT su ADO). Revocare i PAT | es. 18 |
| 71 | Analisi statica | in quale fase / dopo una pull request | ok | **build** (shift left); dopo PR = **static code analysis**; CD = pen test/DAST | es. 22 |
| 72 | Release | più build in attesa, distribuire solo l'ultima | ? | **Deployment queue settings** ("latest and cancel the others"); YAML: `lockBehavior: runLatest` | es. 13 |
| 73 | Azure Artifacts | feed centrale per pacchetto custom in Visual Studio | ? | ordine: **create feed → publish → aggiungi URL in NuGet Package Manager (Package Sources)**; Git non è un feed | es. 11 |
| 74 | Build | build incrementali senza ripulire l'ambiente | ? | **self-hosted agent** (+ `clean: false`); hosted = macchina nuova a ogni job | es. 10 |
| 75 | Azure Artifacts | un solo feed per pacchetti interni e remoti (anche autenticati) | ? | **upstream sources**; views = livelli di qualità | es. 11 |
| 76 | ServiceNow | change request prima del deploy in produzione | ? `!` | banco: **post-deployment gate dopo QA + pre-deployment gate prima di Prod**; "deployment control" SOAP/REST = distrattore | es. 13 |
| 77 | Version control | file/cartelle con permessi → ? / YAML / branch visibile ai lead | `!` | ProjectA **TFVC** (path-based); Project1 YAML → **Azure Repos Git** (ambigua, anche GitHub Ent./Bitbucket); Project2 on-prem → GitHub Enterprise; Project3 centralizzato → Subversion | es. 1 |
| 78 | Agent | pool hosted per app iOS | ok | **macOS** (`macos-latest`); Ubuntu/Windows non compilano iOS | es. 10 |
| 79 | Git permessi | merge su master anche con build fallita (least privilege) | ? | **security del branch** → *Bypass policies when completing pull requests*; repo = troppo ampio | es. 1 |
| 80 | ARM + Key Vault | impedire a chi deploya di vedere le connection string | ok (2 volte) | **Key Vault** (reference nel parameter file); parameter file/Web.config = in chiaro | es. 16 |
| 81 | ARM | slot `templateLink` in un deployment linked | `!` | risposta confermata da Stefano: **`templateLink`** (`uri`); `templateURI`/`keyVaultlink` non esistono. Snippet non incollato | es. 15 |
| 82 | Git | `git gc` per minimizzare il repo (hotspot) | ? | Dropdown 1 **`--aggressive`**; con `git reflog expire --expire=now --all` e `--prune=now`. Hotspot: Dropdown 2 non visto | es. 1 |
| 83 | ACI | `restartCount` sale con evento "platform initiated", `exitCode: 0`: cosa controlli | X | **liveness probe** (percorso/porta); la readiness non riavvia mai, toglie solo dal traffico. Visto nel lab: 67 → 80 con liveness, fermo con readiness | es. 14 |
| 84 | ARM / Bicep | deployment fallito con `InvalidTemplateDeployment`: dove cerchi la causa | X | negli **inner errors** (o *Resource group → Deployments*): l'errore esterno è generico. Visto nel lab: `AccountNameInvalid` dentro `PreflightValidationCheckFailed` | es. 15 |
| 85 | Feature flag | rilascio graduale con interruttore a runtime | ? | **Azure App Configuration** (Feature Manager); rings / blue-green / canary = strategie, non flag | es. 24 |
| 86 | Rete ibrida | ExpressRoute vs VPN Gateway | ? | **ExpressRoute** = connessione privata dedicata; **VPN Gateway** = tunnel cifrato su Internet | |
| 87 | Pipeline | publish artifacts: App Center distribute / App Service Deploy (2 screenshot) | ? `!` | entrambe **No**; App Center **ritirato** | es. 6 |
| 88 | Alert | regola + action group (domanda del 5/11, dettaglio non riportato) | ? | rule = **quando**; action group = **cosa fa** | es. 19 |
| 89 | Jenkins + ACR | cosa creare per l'accesso al registry / cosa creare **in** Jenkins (2 domande) | ? `!` | Azure/Entra: **service principal** + ruolo `AcrPull`; in Jenkins: **credential**. Oggi: **managed identity** su VM Azure | es. 26 |
| 90 | Release classica | il fulmine sull'artifact: la release parte dopo la build? | ? `!` | banco **No** (trigger CD non abilitato); fulmine artifact = CD, fulmine stage = pre-deployment. Dipende dall'immagine | es. 13 |
| 91 | Build trigger | CI a ogni check-in / `include` / `batch` (3 domande) | ? | **Enable CI** = avvia; **batch** = una build per i commit accumulati (da solo non abilita il CI); **`include`** = quale branch. Leggi l'ultima riga | es. 6 |
| 92 | Git | macchina nuova: clone o fork? / pull request o merge request? | ok | **clone** (copia locale; fork = server); **pull request** (merge request = GitLab) | es. 1 |
| 93 | Monitor | salute di cluster AKS (Linux + Windows) e VM sottostanti | ok | **Azure Monitor** (Container Insights); Advisor = raccomandazioni | es. 29 |
| 94 | Agent pool | gestire più server self-hosted insieme | ok | **agent pool**; resource group/Policy no; deployment pool = release classiche | es. 10 |
| 95 | Slack | notifiche di build completata | ok | **`/azpipelines subscribe`** (prima `signin`); login/register non esistono | es. 28 |
| 96 | Boards | scenario a più parti: sprint, avanzamento, pipeline, test, licenze | ? | iterazioni = divisione in sprint; **widget in dashboard** (burndown, velocity) = avanzamento; Mend = SCA; ZAP = DAST | es. 28 |
| 97 | Jenkins + Azure | output del CI Jenkins su Storage | ? `!` | **plugin Azure Storage in Jenkins**; service connection Jenkins si crea in Azure DevOps. Datata | |
| 98 | SonarQube | ordine dei task in pipeline .NET (Task3) | ? | **Prepare → VSBuild → Analyze → Publish**; Prepare prima della build | es. 22 |
| 99 | Azure Repos | portare un repo GitHub: clonare è sufficiente? | ? | **No**: **Import repository**; clone = solo copia locale | es. 1 |
| 100 | CLI | `az group create` / `az group deployment create` / `--template-file` e `az acr create` / `az acr build` (2 hotspot) | ? `!` | RG prima; file locale = `--template-file`, URL = `--template-uri`. Oggi: `az deployment group create`. `az acr build` = build + push in Azure | es. 14, 15 |
| 101 | Container job | requisiti immagine (2 domande) e host dell'agent | ? | immagine: **Bash**, **nessun ENTRYPOINT**; host self-hosted: **Docker + permesso sul daemon**; root no | es. 14 |
| 102 | App Center | SDK `AppCenter.Start` con `typeof(Analytics)` | ? `!` | servizio **ritirato**: non studiare, nessun lab | |
| 103 | Config management | coerenza delle VM nel ciclo di vita: Custom Script / Puppet | ? | Custom Script = una tantum (**No**); **Puppet/Chef/DSC** = stato desiderato continuo (**Sì**) | es. 15 |
| 104 | Release classica | secret visibile solo nello stage Release (2 domande) | ? | sezione **Variables** + **scope** = stage; lucchetto = secret | es. 8 |
| 105 | MS PA, branching | PR che deve deployare in produzione prima del merge (2 volte) | X | **GitHub Flow** (non centralized/forking/trunk-based) | es. 1 |
| 106 | MS PA, Azure Repos | policy che condensa i commit in uno | ? | **Limit allowed merge types** (squash) | es. 1 |
| 107 | MS PA, source | team che passa a Git: workflow semplice e controllato | ? | **PR + branch policy** (build, revisori, commenti); scarta complesso/senza controlli | es. 1 |
| 108 | MS PA, Boards | lavoro bloccato in "In Progress": causa | ? | **Cumulative Flow Diagram** (diagnosi); poi WIP limit | es. 28 |
| 109 | MS PA, Boards | work item per classi di servizio sulla Kanban | ? | **Swimlanes** | es. 20 |
| 110 | MS PA, pipeline | aggiornare work item da una pipeline YAML | ? `!` | **Settings** della pipeline (link automatico dei work item): non verificato sul portale | es. 20 |
| 111 | MS PA, KPI | tempo per completare un work item | X | **Lead Time** (ricorrente 9, 30: punto debole) | es. 28 |
| 112 | MS PA, wiki | inizio di un diagramma | ? | **`::: mermaid`** (non i tre apici di GitHub) | es. 28 |
| 113 | MS PA, Boards | tracciare il CVSS in una user story | ? | **campo** personalizzato nel processo ereditato | es. 20 |
| 114 | MS PA, auth Git | clone con PAT e Git Credential Manager vietati, massima sicurezza | ? | **SSH** (Kerberos solo Server) | es. 18 |
| 115 | MS PA, PAT | durata massima dei PAT con Entra ID | ? | policy **lifespan of a PAT** | es. 18 |
| 116 | MS PA, GitHub | dove si crea un secret (2 risposte) | X | **organization** e **repository** (+ environment) | es. 12 |
| 117 | MS PA, iOS | condividere un provisioning profile tra pipeline con permessi | X | **secure files** (variable group = solo valori) | es. 27 |
| 118 | MS PA, ZAP | ridurre i falsi positivi di ZAP | X | **context file**; estensione = solo esecuzione, baseline = scansione passiva | es. 17 |
| 119 | MS PA, CodeQL | eseguire la scansione ogni giorno lavorativo alle 8:00 | ? | sezione **schedule** (cron, UTC) | es. 12 |
| 120 | MS PA, ZAP | cosa fa ZAP in pipeline | X | **penetration test passivi** (DAST); SAST/SCA = altri | es. 17 |
| 121 | MS PA, release | bloccare il deploy in prod per alert su dev | ? | gate **Azure Monitor** (query alerts) | es. 13 |
| 122 | MS PA, KQL | aggregare righe per valore di una colonna | ? | **summarize** (ricorrente 34) | es. 19 |
| 123 | MS PA, App Insights | requisito per vedere le dipendenze nella Application Map | X `!` | scelta **chiamate HTTP di dipendenza**; non confermata | es. 19 |
| 124 | MS PA, KQL | scegliere le colonne | ? | **project** (where = righe, summarize = aggrega) | es. 19 |
| 125 | MS PA, Artifacts | gestore per codice .NET | ? | **NuGet** (ricorrente 4) | es. 11 |
| 126 | MS PA, Artifacts | garanzia di retrocompatibilita' (SemVer) | X | **patch** (lettura Microsoft); mia risposta major sbagliata | es. 21 |
| 127 | MS PA, Artifacts | gruppi pubblici/privati npm senza collisioni | X | **scopes** (`@org/pkg`) | es. 21 |
| 128 | MS PA, Artifacts | feed che usa pacchetti originali, non copie | X `!` | **upstream sources**; non confermata | es. 21 |
| 129 | MS PA, agent | UI test su agent Windows self-hosted | X | **Enable Autologon** (agent interattivo) | es. 10 |
| 130 | MS PA, test | prestazioni prima del lancio | ? | **Azure Load Testing** (Azure DevOps load testing = nome vecchio) | es. 22 |
| 131 | MS PA, release | 3 azioni di quality gate (qualita' e sicurezza) | X | **vulnerabilita' + code coverage + work item aperti**; sintassi (build) e manual intervention no | es. 13 |
| 132 | MS PA, test | test con esiti diversi senza modifiche | ? | **flaky test detection** (ricorrente 8) | es. 22 |
| 133 | MS PA, Azure | service principal che accede a storage1, minimo privilegio | ? `!` | scelto **Reader su storage1**; non confermata (manca ruolo dati) | es. 26 |
| 134 | MS PA, test | problemi di esperienza sotto vari schemi d'uso, minimo sforzo | X | **load testing** in pipeline (non user tracking, stress, chaos) | es. 22 |
| 135 | MS PA, YAML | URI che riferiscono un branch `features/tools` (2 risposte) | X `!` | scelte le due **`git://`**; non confermate | es. 23 |
| 136 | MS PA, test | scaricare i file `.coverage` dal riepilogo della run | X | sezione **Related** (non Tests and Coverage) | es. 22 |
| 137 | MS PA, agent | dove si aggiungono i parallel jobs | X | livello **organization** (non project) | es. 10 |
| 138 | MS PA, YAML | raccolta di risorse con approval check | X | **environment** (gate = release classiche) | es. 7, 13 |
| 139 | MS PA, microservizi | build a cascata tra repository | ? | **pipeline triggers + repository resources** | es. 23 |
| 140 | MS PA, pipeline | build lunga di ore: cosa raccomandi | ? `!` | scelto **agent pool + parallel jobs**; non confermata | es. 23 |
| 141 | MS PA, deploy | blue-green con staging e minimo sforzo | X | **App Service** (deployment slot e swap) | es. 24 |
| 142 | MS PA, Traffic Manager | metodo che accetta endpoint IPv6 | X | **MultiValue** | |
| 143 | MS PA, Traffic Manager | endpoint piu' vicino per latenza | ? | **Performance** (Geographic = posizione) | |
| 144 | MS PA, release | disponibile a tutti insieme (individuare presto i problemi) | ? `!` | scelto **blue-green**; non confermata | es. 13 |
| 145 | MS PA, release | attivare/disattivare una funzione senza redeploy | ? | **feature flags** | es. 24 |
| 146 | MS PA, release | transizione incrementale (2 strategie) | ? `!` | scelte **canary + rolling**; non confermata | es. 13 |
| 147 | MS PA, DSC | formato per pull server | X | **MOF** | es. 15 |
| 148 | MS PA, IaC | ambienti coerenti e sicuri | ? | **template ARM dichiarativi** (oggi anche Bicep) | es. 15 |
| 149 | MS PA, agent | durata massima di un job Microsoft-hosted | ? | **6 ore (360 min)**; gratuito privato 60 min | es. 10 |
| 150 | MS PA, pipeline | pipeline lenta che blocca le altre: impostazione | ? `!` | scelta **multi-job configuration**; non confermata | es. 23 |
| 151 | MS PA, trunk-based | passo dopo la creazione del feature branch | X | **adding commits** | es. 1 |
| 152 | MS PA, source | molti contributori, stabilita' e indipendenza | ? | **rebase + policy con build e test** | es. 1 |
| 153 | MS PA, source | sperimentazione isolata (2 elementi) | X | **naming dei feature branch + PR con revisori** | es. 1 |
| 154 | MS PA, Git | eliminare file > 50 MB dalla storia | ? | **BFG** (aggiorna commit e tag) | es. 5 |
| 155 | MS PA, LFS | oggetti LFS mancanti negli archivi di release | ? | impostazione **Include Git LFS objects in archives** | es. 5 |

## Da portare in laboratorio

- [x] es. 14: liveness vs readiness probe su ACI, container che si riavvia (`restartCount`) (fatto 2026-11-03)
- [x] es. 15: deployment annidato ARM / `module` Bicep, `mode` Incremental vs Complete (fatto 2026-11-03)
- [ ] es. 15: VM extension DSC e Custom Script (non fatto: solo teoria)
- [ ] es. 19: stessa query KQL su `requests` ed `exceptions`
- [ ] es. 27: generare un SAS con scadenza breve, usarlo, farlo scadere
- [ ] es. 28: widget Lead Time e Cycle Time
- [ ] es. 18: gruppi di sicurezza e permessi su wiki
- [ ] es. 15: flusso DSC in Automation: `.ps1` → Import → Compile → registrare nodi
- [ ] es. 22: dove compaiono i risultati dei test (tab Tests vs Test Plans)
- [ ] es. 13: gate/approval sull'environment; manual validation
- [ ] es. 13: timeout delle approvals e `lockBehavior: runLatest` su environment
- [ ] es. 11: feed Azure Artifacts + upstream sources + pubblicare un pacchetto e usarlo come package source
- [ ] es. 10: self-hosted agent con `clean: false` (build incrementale) e agent su rete on-prem
- [ ] es. 16: ruolo RBAC senza `delete` sul Key Vault vs access policy
- [ ] es. 14: `az acr create` + `az acr build` (build e push in Azure, senza Docker locale)
- [ ] es. 14: container job con `container:` in pipeline (requisiti immagine: Bash, niente ENTRYPOINT)
- [ ] es. 22: pipeline SonarQube/SonarCloud: Prepare → Build → Analyze → Publish
- [ ] es. 28: widget Sprint Burndown / Velocity in dashboard; processi Agile / Scrum / CMMI / Basic
- [ ] es. 8: variabile secret con scope di stage (release classica)
- [ ] es. 1: Import repository da GitHub verso Azure Repos
- [ ] es. 10: agent Windows interattivo con autologon; parallel jobs a livello di organizzazione (Billing)
- [ ] es. 22: scaricare `.coverage` (sezione Related); Azure Load Testing in pipeline con criteri di fallimento
- [ ] es. 17: ZAP con context file; secret scanning con push protection
- [ ] es. 20: campo personalizzato (CVSS) su un processo ereditato; swimlanes; Settings della pipeline per i work item
- [ ] es. 18: policy PAT (lifespan) e SSH key per clone
- [ ] es. 13: gate Azure Monitor e quality gate (vulnerabilita', coverage, work item aperti)

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
| Cmdlet `AzureRm` (`Register-AzureRmAutomationDscNode`) | modulo **`Az`** (`Register-AzAutomationDscNode`) | AzureRm obsoleto |
| Hosted VS 2017 (`vs2017-win2016`) | `windows-latest` / `ubuntu-latest` | immagine ritirata |
| Copy and Publish Build Artifacts | `Publish Build Artifacts` / `Publish Pipeline Artifacts` | task deprecato |
| `az group deployment create` | `az deployment group create` | sintassi vecchia deprecata |
| Jenkins su VM Azure con service principal | **managed identity** (`AcrPull`) | Jenkins fuori dalla guida |
| Azure Pipelines per Slack | `/azpipelines subscribe` | invariato; Teams: `@azure pipelines subscribe` |
| SonarQube Cloud | ex **SonarCloud** | task `SonarQubePrepare@5` / `Analyze@5` / `Publish@5` |

## Test svolti

| Data | Test SkillCertPro | Punteggio | Note |
|---|---|---|---|
| 2026-10-15 | (primo giro) | ~85% su ~88 domande distinte | 13 sbagliate, ~10 ambigue/datate; voci 1-48 sopra |
| 2026-10-19 | (secondo blocco) | 50 domande nuove (schede 101-150) | 4 sbagliate (49-52), 5 ambigue (53-56); voci 49-58 |
| 2026-10-19 | mini-quiz es. 12A | 4/5 | errata la 3 (doppio trigger push + pull_request) |
| 2026-10-21 | mini-quiz es. 12B | 3/5 (6 non risposta) | errate 2 (nome environment) e 4 (ordine OIDC) |
| 2026-10-22 | mini-quiz es. 13 | 4/5 | errata la 1 (hook `on: failure` scambiato con `preDeploy`) |
| 2026-11-03 | mini-quiz es. 14 | 4/5 | errata la 4 (liveness vs readiness: scelta la readiness) |
| 2026-11-03 | mini-quiz es. 15 | 4/5 | errata la 3 (causa di `InvalidTemplateDeployment`: inner errors) |
| 2026-11-09 | **Practice assessment ufficiale Microsoft Learn** (50 domande, 42 min) | **60%** (obiettivo 80%) | Per sezione (stime dallo screenshot): processi ~83%, strumentazione ~75%, source ~67%, **pipeline ~54%**, **sicurezza ~50%**. Voci 105-155. Sbagliate (confermate da Stefano, 22 voci): 105, 111, 116, 117, 118, 120, 123, 126, 127, 128, 129, 131, 134, 135, 136, 137, 138, 141, 142, 147, 151, 153 (oltre i ~20 attesi: probabile credito parziale sulle risposte multiple). Altre da confermare. Rifare dopo 2-3 settimane di studio |
| 2026-11-05/06 | sessione di test (domande incollate in chat) | 36 domande, esiti non ancora registrati | voci 85-104; `?` = da confermare con Stefano. Ricorrenti (non riscritte): az keyvault hotspot (13), feed NuGet (4, 73), TFVC vs Git (77), self-hosted agent (43, 62, 74), processo CMMI (7), Teams/Slack subscribe (47), custom script (14) |
| 2026-11-02 | sessione di test (domande incollate in chat) | esiti non ancora registrati | voci 62-82; esito `?` = da confermare con Stefano. Ricorrenti (non riscritte): DSC ConfigurationMode (29, 36), Lead/Cycle Time (9, 30), flaky (8), availability test (25), deployment groups (55), PMD/CheckStyle (2), analisi statica (33) |
