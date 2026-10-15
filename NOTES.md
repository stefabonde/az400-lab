# Appunti di ripasso AZ-400

Una scheda per esercizio: dove si trova, cosa fa, che errore ho visto, i trabocchetti, la domanda tipo.
Compilala subito dopo aver fatto l'esercizio (fai, rompi, annota).

## Regole d'oro per il lab d'esame

1. Leggi le istruzioni per intero: cerca URL e nome organizzazione/progetto.
2. Usa solo le credenziali del lab, in InPrivate se il browser propone altri profili.
3. Controlla chi sei (avatar) e in che **directory** sei (Entra tenant).
4. Apri `dev.azure.com/<org>` direttamente; se non vedi il progetto: Switch directory, poi *Organization settings → Projects*.
5. Prima di cliccare: dove (ADO/GitHub), ambito (repo/progetto/org), verbo (limitare/abilitare).
6. Dopo ogni modifica, prova a violarla: se non ti blocca, è configurata male.

## Concetti fondamentali (glossario)

### Azure: la gerarchia

```
Directory (tenant Entra ID)   -> chi esiste (utenti, app, gruppi)
  └─ Sottoscrizione           -> chi paga, quote, fatturazione
       └─ Resource group      -> contenitore con un ciclo di vita
            └─ Risorse        -> web app, storage, Key Vault, VM...
```

| Concetto | Cos'è | A cosa serve | Da ricordare |
|---|---|---|---|
| **Directory / tenant (Entra ID)** | l'anagrafica di utenti, gruppi e app di un'organizzazione | decide **chi può entrare** | un account può stare in più directory: si cambia con *Switch directory* |
| **Sottoscrizione** | l'accordo di fatturazione con Azure | contiene le risorse e ne raccoglie i costi | appartiene a **una** directory |
| **Resource group** | contenitore **vero** di risorse | organizzare, dare permessi mirati, vedere i costi, **eliminare in blocco** | una risorsa sta in **un solo** gruppo (si può spostare); eliminare il gruppo elimina tutto dentro |
| **Tag** | etichetta chiave/valore (`ambiente=dev`) | filtrare e raggruppare i costi anche tra gruppi diversi | non cancella e non raggruppa fisicamente; una risorsa ne ha molti; non ereditano da soli |
| **Risorsa** | il servizio concreto (web app, storage...) | fa il lavoro | vive in un gruppo e in una regione |

### Identità in Azure

| Concetto | Cos'è | Credenziale | Quando |
|---|---|---|---|
| **Utente** | una persona | password + MFA | accesso umano |
| **Service principal** | identità di un'**app/servizio** in Entra | segreto, certificato o federation | pipeline, script, automazioni |
| **App registration** | la *definizione* dell'app; il service principal è la sua *istanza* nella directory | - | creata in automatico dalla service connection |
| **Managed identity** | service principal le cui credenziali gestisce **Azure** | nessuna da custodire | codice che gira *dentro* una risorsa Azure (VM, web app, agent self-hosted su VM Azure) |
| **Workload identity federation (OIDC)** | Entra si fida dei token firmati da Azure DevOps/GitHub | **nessun segreto** | metodo raccomandato per le pipeline |

Ruoli (RBAC): si assegnano a un'identità su un **ambito** (sottoscrizione, resource group, risorsa). Regola: **privilegio minimo**, ambito il più stretto possibile.

### Service connection (Azure DevOps)

| Domanda | Risposta |
|---|---|
| Cos'è | il collegamento autorizzato tra Azure DevOps e un servizio esterno (qui Azure) |
| Cosa contiene | quale **identità** usare e **dove** vale (sottoscrizione / resource group) |
| Dove si crea | Project settings → Service connections |
| Come la usi | nel YAML per nome, es. `azureSubscription: 'azure-lab'` |
| Come si autentica | con federation: token generato per quella run, nessuna password |
| Cosa controllare | scheda *Usage history*; in Entra la *federated credential*; in IAM il ruolo |
| Va autorizzata | **Permit** alla prima esecuzione (come gli environment e i variable group) |

Flusso con federation:

```
Run della pipeline
  1. Azure DevOps genera un token per (org, progetto, connection)
  2. la pipeline lo presenta a Entra (az login --federated-token)
  3. Entra controlla issuer + subject della federated credential
  4. la pipeline lavora con i permessi (ruolo) di quel service principal
```

### Azure DevOps: la gerarchia

```
Organizzazione  -> account, utenti, billing, parallel jobs
  └─ Progetto   -> contenitore di lavoro
       ├─ Repos      (Git, branch policy, repository policy)
       ├─ Pipelines  (YAML, environment, library, service connection)
       ├─ Boards     (work item, dashboard)
       └─ Artifacts  (feed di pacchetti)
```

Azure DevOps (`dev.azure.com`) e portale Azure (`portal.azure.com`) sono **prodotti diversi**: il resource group sta nel secondo.

### Pipeline: i pezzi

| Concetto | Cos'è | Trabocchetto |
|---|---|---|
| **trigger** (CI) | avvia la pipeline su push, con filtri `branches` e `paths` | parte solo se il commit tocca i `paths` |
| **Build validation** | policy di branch che esegue la pipeline sulle PR (Azure Repos) | `pr:` nel YAML vale solo per GitHub/Bitbucket; esegue **anche i deploy** → serve `condition` sul branch |
| **Environment** | risorsa protetta con controlli (approvals, branch control...) | richiede *Permit* + approvazione |
| **Variable group** | variabili riusabili, con segreti (lucchetto) | va autorizzato alla pipeline |
| **Template** | pezzo di YAML riusabile con `parameters` | `${{ }}` in compilazione, `$(var)` a runtime |
| **Permit** vs **Approval** | permesso della *pipeline* su una risorsa vs consenso *umano* | sono due cose distinte |

### Git: file grandi e dati sensibili

| Concetto | Cos'è | Da ricordare |
|---|---|---|
| **Git LFS** | nel repo resta un puntatore, il contenuto sta in uno store separato | non retroattivo (serve `git lfs migrate`) |
| **git revert** | aggiunge un commit che annulla | il segreto **resta nella storia** |
| **git filter-repo / BFG** | riscrive la storia rimuovendo file o testo | cambiano gli hash, serve force push; il segreto va comunque **ruotato** |

### GitHub e Azure DevOps: gli equivalenti

| Esigenza | GitHub | Azure DevOps |
|---|---|---|
| proteggere `main` | ruleset / branch protection rule | branch policy |
| revisori per percorso | file `CODEOWNERS` + *Require review from Code Owners* | *Automatically included reviewers* (con filtro percorso) |
| limitare file | push ruleset (size, extension, path) | repository policy (*Maximum file size*, path length) |
| validare PR con la pipeline | `on: pull_request` nel workflow / `pr:` nel YAML | *Build validation* |
| segreti | repository / environment secrets | variable group con lucchetto, Key Vault |
| accesso ad Azure senza segreto | OIDC con `azure/login` | service connection con federation |
| collegare lavoro e PR | `Closes #12`, pannello Development | work item collegato (policy *Check for linked work items*) |

## Confronti rapidi (dai quiz)

### Tempo e metriche

| Concetto | Parte da | Finisce a |
|---|---|---|
| **Lead Time** | creazione del work item | completamento (≥ Cycle Time) |
| **Cycle Time** | inizio lavoro (stato attivo) | completamento |

- Velocità: Lead/Cycle Time, Deployment Frequency · Qualità: **MTTR**, MTTD, Change Failure Rate · Efficienza: Server to Admin Ratio.

### Processi di Azure Boards

| Processo | Work item di richiesta |
|---|---|
| Basic | Epic, Issue, Task |
| Agile | Epic, Feature, **User Story**, Task, Bug |
| Scrum | Epic, Feature, **PBI**, Task, Bug |
| CMMI | Epic, Feature, **Requirement**, Task, Bug, Change Request, Risk, Review |

### Rilascio progressivo

| Tecnica | Come | Progressivo? |
|---|---|---|
| Deployment rings | anelli di utenti sempre più larghi | sì |
| Feature flags | funzione attivata per segmenti | sì |
| Canary | piccola % di traffico | sì |
| Blue/Green | due ambienti, switch completo | no (zero downtime) |

### Configurare o creare una VM

| Il testo dice… | Scegli |
|---|---|
| deployare / creare / provisioning | **ARM / Bicep** |
| configurare, configurazione uniforme | **DSC** (+ Custom Script Extension) |
| anti-drift nel tempo | DSC / Azure Machine Configuration |
| installare software / lanciare uno script | Custom Script Extension |

### Token e autenticazione

| Cosa | Per |
|---|---|
| **PAT** | Azure DevOps (registrare agent, API, Git, GHES → ADO Server) |
| **SAS** | accesso delegato, limitato e a scadenza a Azure Storage (sempre HTTPS) |
| GitHub App / OAuth | github.com → Azure Pipelines |
| Workload identity federation | pipeline → Azure senza segreti |

### Application Insights e KQL

| Tabella | Contiene |
|---|---|
| `requests` | richieste HTTP in ingresso, `success`, `resultCode` |
| `exceptions` | eccezioni e stack trace |
| `dependencies` | chiamate in uscita (DB, API) |
| Smart Detection | alert automatico su anomalie di failure/performance |
| Profiler | dove il codice è lento |

`dcount(user_Id)` = utenti distinti colpiti.

### Branch: policy, security, lock

| | Cosa governa |
|---|---|
| **Policies** | il *processo* (PR, revisori, build) |
| Security | *chi* può fare cosa (anche Bypass policies) |
| Lock | branch di sola lettura |

### Probe dei container

| Probe | Se fallisce |
|---|---|
| **Liveness** | il container viene **riavviato** |
| **Readiness** | non riceve traffico, **non** viene riavviato |

### Strumenti di analisi

| Obiettivo | Strumento |
|---|---|
| Qualità del codice proprio | SonarQube / SonarCloud, CodeQL, PMD/Checkstyle/SpotBugs |
| Licenze e vulnerabilità delle dipendenze (SCA) | Black Duck, Mend, Dependabot, OWASP Dependency-Check |
| Scansione solo produzione (npm) | `npm install --omit=dev` (storico `--production`) |

## 1. Branch policy Azure DevOps su `main`

- **Dove**: Repos → Branches → `⋯` su `main` → Branch policies.
- **Cosa fa**: impone PR, reviewer minimi, work item collegato, commenti risolti, build validation, metodi di merge consentiti.
- **Errore visto**: `TF402455: Pushes to this branch are not permitted; you must use a pull request`.
- **Flusso corretto**: nuovo branch → PR → work item collegato (anche dopo, dalla colonna destra della PR) → approvazione → *Complete* con squash merge e *Delete source branch*.
- **Trabocchetti**: con un solo utente "2 reviewer" non si raggiunge mai; serve *Allow requestors to approve their own changes* oppure abbassare a 1. L'approvazione dell'autore **non conta** finché quell'opzione è spenta. Il *bypass* (permesso sul branch) ignora le regole: da evitare di default.
- **Domanda tipo**: "come impedisci il push diretto su main?" → branch policy / PR obbligatoria.

## 2. Branch protection / ruleset GitHub su `main`

- **Dove**: GitHub repo → Settings → Rules → Rulesets (non *Branches*, che è la vecchia branch protection rule).
- **Cosa fa**: protegge `main` (PR obbligatoria, no force push, no delete, status check, approvazioni minime, review dei code owner, risoluzione conversazioni).
- **Errore visto**: dall'editor web "You can't commit to `main` because it is a protected branch" + proposta di nuovo branch e PR. Sulla PR: *Review required* e *Merging is blocked*.
- **Bypass**: nei ruleset è una **lista esplicita** (Bypass list → Add bypass → Repository admins, *For pull requests only*). Un admin **non ha il bypass automatico**. Con il bypass compare *Merge without waiting for requirements to be met*.
- **Trabocchetti**: *Enforcement status* deve essere Active (non Evaluate/Disabled). L'autore non può approvare la propria PR. *Restrict creations* riguarda solo i ref che corrispondono al target (qui `main`), non gli altri branch.
- **Domanda tipo**: "come blocchi i push diretti su main in GitHub?" → ruleset o branch protection rule.

## 3. Ruleset su path, estensioni e dimensione file

- **Dove (Azure DevOps)**: Project settings → Repos → Repositories → **All Repositories** (tutti i repo del progetto) o un repo singolo → scheda **Policies** → *Maximum file size*, *Maximum path length*, *Reserved names*, *Commit author email validation*.
- **Dove (GitHub)**: Settings → Rules → Rulesets → **push ruleset**: *Restrict file size*, *Restrict file extensions*, *Restrict file paths*, *Restrict file path length*. A livello organizzazione: stessi ruleset, applicati a tutti i repo scelti.
- **Visto nel mio lab**: su un repo personale (piano free) il menu *New ruleset* mostra solo **branch** e **tag** ruleset: le push rules non erano disponibili. Parte ADO verificata con upload di un file da 2 MB (rifiutato) e di uno piccolo (accettato).
- **Trabocchetti**: il limite hard GitHub è 100 MB (avviso a 50) e non si alza; i ruleset lo abbassano. Le regole sui file stanno nelle **push rules**, non nelle *Branch rules*. Prima di cliccare: dove (ADO/GitHub), ambito (repo/progetto/org), verbo (limitare/abilitare LFS).
- **Domanda tipo**: "limita la dimensione dei file su tutti i repo del progetto" → ADO: All Repositories → Policies → Maximum file size.

## 4. CODEOWNERS

- **Dove**: file `.github/CODEOWNERS` (o root, o `docs/`) **più** l'opzione *Require review from Code Owners* dentro *Require a pull request before merging* del ruleset (Show additional settings).
- **Cosa fa**: il file dice **chi** è owner di **quali percorsi**; la regola del ruleset rende **obbligatoria** la review di quegli owner.
- **Sintassi**: `* @utente`, `/src/ @utente`, `*.js @utente`, `/docs/ @org/team`. Vale l'**ultima riga** che corrisponde; il file è letto dal branch di **destinazione**.
- **Trabocchetti**: solo file senza regola = review richiesta ma non obbligatoria; solo regola senza file = non blocca nulla. Gli owner devono avere permesso di scrittura. L'autore non può approvare la propria PR; i team esistono solo in un'organizzazione.
- **Equivalente Azure DevOps**: non c'è CODEOWNERS; si usa la branch policy **Automatically included reviewers** con filtro per percorso.
- **Domanda tipo**: "obbliga la review del team X sulla cartella Y" → CODEOWNERS + Require review from Code Owners (GitHub) / Automatically included reviewers (ADO).

## 5. Git LFS e pulizia storia

- **Dove**: `git lfs track "*.zip"` (scrive la regola in `.gitattributes`) per LFS; `git filter-repo --path <file> --invert-paths` per rimuovere dati dalla storia.
- **Cosa fa**: LFS (Large File Storage) tiene nel repo solo un **puntatore** (`version`, `oid sha256`, `size`) e il contenuto vero in uno store separato, scaricato quando serve. `filter-repo` **riscrive la storia** togliendo file o testo.
- **Verifiche viste**: `git lfs ls-files` (`*` = contenuto presente in locale, `-` = solo puntatore); `git show HEAD:file.zip` mostra il puntatore; `git log --all -- file` vuoto dopo la pulizia; hash dei commit cambiati; `git remote -v` vuoto (filter-repo scollega il remote).
- **Trabocchetti**: LFS **non è retroattivo** (i file già committati restano normali, serve `git lfs migrate`). `git revert` aggiunge un commit ma il segreto resta nella storia (`git log -S` lo trova). Dopo la riscrittura serve `push --force`, che un ruleset con *Block force pushes* impedisce. Il segreto già pubblicato va comunque **ruotato**. Per togliere un testo da un file: `--replace-text`.
- **Alternative citate nella study guide**: `git-fat` (file grandi), BFG (pulizia storia). Scalar per repo molto grandi.
- **Domanda tipo**: "un segreto è stato committato, come lo rimuovi dalla storia?" → filter-repo / BFG, non revert; "gestire file grandi" → Git LFS.

## 6. Pipeline YAML base (build + test)

- **Dove**: Pipelines → Create Pipeline → Azure Repos Git → file `azure-pipelines.yml` nel repo. Build validation: Repos → Branches → `⋯` su `main` → Branch policies → Build validation.
- **Cosa fa**: `trigger:` avvia la pipeline sui push (CI) ai branch elencati, con filtri `paths`; `pool: vmImage` sceglie l'agent Microsoft-hosted; `steps` sono i passi (`NodeTool@0`, `script: npm test`).
- **Due meccanismi distinti**: CI trigger (YAML, push su `main`) e **Build validation** (policy, PR). Ciascuno ha i **suoi** filtri percorsi: un README-only può non far partire il CI ma far partire comunque la validation se il path filter della policy è vuoto.
- **`pr:` nel YAML**: vale solo per repo GitHub/Bitbucket; su Azure Repos le PR si validano con la Build validation.
- **Errori visti**: "Could not find valid pipeline YAML file for this branch/tag" = il YAML non esiste in quel branch (era solo su `feature/pipeline`, PR non completata). Passo *Esegui test* rosso con test modificato, PR bloccata finché non torna verde.
- **Trabocchetti**: la pipeline non è legata a un branch, è un puntatore al file YAML letto dal branch scelto al run. Il motivo di una run si legge sotto il titolo ("PR automated for…" / "Individual CI for…"). Un "Override the YAML trigger" in *Triggers* comanda sul YAML. Il run manuale permette di scegliere il branch.
- **Free tier**: 1800 min/mese Microsoft-hosted, 1 job parallelo (la richiesta via modulo è dismessa).
- **Domanda tipo**: "esegui i test a ogni PR verso main e blocca il merge se falliscono" → Build validation (Required) sulla branch policy.

## 7. Multi-stage con approvazione environment

- **Dove**: Pipelines → Environments → New environment → `⋯` → *Approvals and checks*. Nel YAML: `stages:` con `deployment:` job, `environment: <nome>`, `strategy: runOnce: deploy: steps:`.
- **Cosa fa**: gli **environment** sono risorse protette su cui agganciare controlli (approval, branch control, business hours, ecc.). Uno stage che punta a un environment si ferma finché i check non sono soddisfatti. `dependsOn` stabilisce l'ordine degli stage.
- **Errori visti**: "Environment dev could not be found. The environment does not exist or has not been authorized for use" (due cause: non esiste / pipeline non autorizzata). Stage in *Waiting — Permission needed* = serve **Permit** (alla prima volta per ogni environment); poi l'**approvazione** configurata sull'environment.
- **Trabocchetti**: la **Build validation** esegue la pipeline intera, deploy compresi: serve una `condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))` sugli stage di deploy (su PR risultano *skipped*). Pre-autorizzare tutte le pipeline: Environment → `⋯` → Security → Pipeline permissions. Opzione *Allow approvers to approve their own runs* se sei l'unico utente.
- **Differenze**: `job` normale contro `deployment` job (storia dei deployment sull'environment, strategie runOnce/rolling/canary). Permit (accesso alla risorsa) contro Approval (consenso umano).
- **Deprecazioni**: `NodeTool@0` → `UseNode@1`.
- **Dopo il merge**: la CI su `main` parte solo se il commit tocca percorsi inclusi nei `paths` del trigger; una PR che modifica solo il YAML o il README non la fa partire (serve run manuale o includere il file nei `paths`).
- **Domanda tipo**: "il deploy in produzione deve richiedere l'approvazione di un responsabile" → environment `prod` con check di tipo Approvals.

## 8. Variable group, secure variable, template

- **Dove**: Pipelines → Library → + Variable group. Nel YAML: `variables: - group: app-config`. Template: file in `templates/` richiamato con `- template: templates/test-steps.yml` e `parameters:`.
- **Cosa fa**: il **variable group** raccoglie variabili riusabili da più pipeline; il **lucchetto** rende un valore segreto (non leggibile, mascherato nei log). Il **template** evita di ripetere gli stessi passi e accetta `parameters` con tipo e valore di default.
- **Visto nei log**: variabile normale stampata; variabile segreta stampata come `***`.
- **Trabocchetti**: il gruppo va **autorizzato** alla pipeline (*Permit* alla prima esecuzione, o Library → gruppo → Security → Pipeline permissions). `${{ parameters.x }}` è valutato in **compilazione**, `$(var)` a **runtime**. Il mascheramento non è una protezione completa: se trasformi il valore (`rev`, `base64`) non viene più riconosciuto. I segreti non arrivano come variabili d'ambiente ai passi se non li mappi con `env:`. Togliendo `- group:` il `$(VAR)` resta testo letterale, senza errore.
- **Alternative**: variable group collegato ad **Azure Key Vault** (esercizio 16); *secure files* per file sensibili (27).
- **Domanda tipo**: "evita di duplicare i passi in più pipeline" → template; "rendi la chiave non visibile ai membri del team" → variabile segreta nel group / Key Vault.

## 9. Service connection (workload identity federation)

- **Dove**: portale Azure → Resource groups (contenitore); Azure DevOps → Project settings → Service connections → New → Azure Resource Manager → *Workload identity federation (automatic)*. Verifica: Entra ID → App registrations → Federated credentials; resource group → Access control (IAM) → Role assignments.
- **Cosa fa**: crea un'identità (service principal) senza segreti, con ruolo **Contributor** limitato al resource group, e il collegamento che la pipeline usa per nome (`azureSubscription: 'azure-lab'`). Vedi il glossario sopra.
- **Cosa ha fatto il run**: solo **letture** (`az account show`, `az group show`); il gruppo è vuoto, quindi nessuna risorsa toccata. Ha dimostrato login federato, permessi sul gruppo e *Permit* sulla connection.
- **Verifiche**: nel log `az login --service-principal … --federated-token ***` (nessuna password); *Usage history* della connection; sign-in dei service principal in Entra.
- **Trabocchetti**: scegliere lo scope **resource group** e non la sottoscrizione (privilegio minimo); la creazione automatica può richiedere di collegare l'organizzazione a Entra; il nome nel YAML deve coincidere con la connection; serve *Permit* alla prima esecuzione.
- **Domanda tipo**: "pipeline che accede ad Azure senza gestire segreti" → workload identity federation (o managed identity con agent su VM Azure); "service principal con segreto" → scade e va ruotato.

## 10. Agent self-hosted

- **Dove**: Organization settings → Pipelines → Agent pools → *Default* → New agent (scarica lo zip per l'OS). Registrazione: `./config.sh` (URL org, auth PAT, pool, nome), avvio `./run.sh` (oppure servizio con `./svc.sh install`). Pipeline: `pool: name: Default` + `demands: - Agent.Name -equals mac-mini`.
- **Cosa fa**: esegue i job sulla **tua** macchina invece che su una VM Microsoft. L'agent apre una connessione **in uscita** verso Azure DevOps e chiede lavoro: nessuna porta in ingresso da aprire.
- **PAT**: serve solo per registrare l'agent. Scope minimo **Agent Pools → Read & manage**, scadenza breve, revocabile dopo (l'agent resta registrato).
- **Errori visti**: `Killed: 9` all'avvio di `config.sh` → quarantena macOS (`xattr -dr com.apple.quarantine`); `Azure CLI 2.x is not installed on this machine` → sull'agent self-hosted i tool li installi tu (`brew install azure-cli`); job **in coda** con agent offline o demand non soddisfatta.
- **Hosted vs self-hosted**:

  | | Microsoft-hosted | Self-hosted |
  |---|---|---|
  | Tool | preinstallati dall'immagine | solo quelli che installi |
  | Macchina | nuova a ogni job | sempre la stessa (stato persistente) |
  | Rete | internet pubblico | raggiunge reti private / on-prem |
  | Manutenzione | Microsoft | tu (aggiornamenti, sicurezza) |
  | Free tier | 1800 min/mese | 1 job parallelo gratis |

- **Trabocchetti**: l'agent eredita il `PATH` della shell che lo avvia (tool nuovi → riavvia l'agent); `vmImage` e `name` nel `pool` sono alternativi; le *demands* sono capability richieste, non il nome del pool; un agent su una macchina condivisa può lasciare file/segreti tra un job e l'altro.
- **Domanda tipo**: "build che deve raggiungere un database on-prem / usare una licenza o hardware specifico" → agent self-hosted; "job in attesa indefinita" → nessun agent online che soddisfi le demands; "ridurre la manutenzione degli agent" → Microsoft-hosted o Virtual Machine Scale Set agents.

## 11. Azure Artifacts

- **Dove**: Azure DevOps → Artifacts → Create Feed (`lab-feed`, upstream sources attivo); Feed settings → Permissions / Views / Upstream sources; Connect to feed → npm per l'URL del registry. Nel repo: `.npmrc` con `registry=…/_packaging/lab-feed/npm/registry/`.
- **Cosa fa**: il **feed** è il magazzino privato di pacchetti (npm, NuGet, Maven, Python, Universal) con permessi propri. La pipeline pubblica con `npmAuthenticate@0` + `npm publish`; il task inserisce nel `.npmrc` un token temporaneo del Build Service (nessun segreto salvato).
- **Ruoli del feed**:

  | Ruolo | Può |
  |---|---|
  | Feed Reader | scaricare pacchetti |
  | Feed and Upstream Reader (Collaborator) | leggere + usare/salvare pacchetti da upstream |
  | Feed Publisher (Contributor) | pubblicare |
  | Feed Owner | gestire feed, permessi, views |

- **Concetti**:
  - **Upstream source**: il feed fa da proxy/cache verso registri pubblici (npmjs); i pacchetti usati vengono salvati nel feed.
  - **View** (`@Local`, `@Prerelease`, `@Release`): sottoinsiemi del feed; si **promuove** una versione già pubblicata, non si ripubblica. I consumatori puntano a `@Release`.
  - **Immutabilità**: una versione pubblicata non si sovrascrive; si incrementa `version` (SemVer `MAJOR.MINOR.PATCH`, pre-release `1.1.0-beta.1`; CalVer = per data).
  - **Scope**: feed di progetto o di organizzazione (cambia l'URL e quale Build Service abilitare).
- **Errori visti**: Build Service solo *Collaborator* → il publish dà 403 (serve *Contributor*); publish **saltato** nella PR per la condition su `main` (voluto); secondo publish stessa versione → **409**; job in coda con pool `Default` e agent spento.
- **Trabocchetti**: `npmAuthenticate` richiede il `.npmrc` nel `workingFile`; il Build Service giusto è quello di **progetto** (`<progetto> Build Service`) o `Project Collection Build Service` se lo scope del job è collection; `.npmrc` con URL sbagliato → 401/404; non usare `npmAuthenticate` insieme al task `Npm@1` con service connection.
- **Domanda tipo**: "403 nel publish" → ruolo Contributor al Build Service; "pubblicare senza password" → `npmAuthenticate`/`NuGetAuthenticate`; "mostrare solo pacchetti validati" → view `@Release` + promozione; "non dipendere da npmjs se il pacchetto sparisce" → upstream con salvataggio nel feed; "versione già pubblicata" → 409, nuova versione.

## 12. GitHub Actions (matrix, secret, environment, OIDC)

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 13. Deployment strategies

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 14. Container (Dockerfile + GHCR)

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 15. IaC con Bicep

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 16. Key Vault nella pipeline

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 17. Dependabot, secret scanning, CodeQL

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 18. Permessi Azure DevOps

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 19. Application Insights, alert, KQL

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 20. Azure Boards e integrazione GitHub

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 21. Feed con views e upstream, versioning SemVer/CalVer, GitHub Packages

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 22. Test in pipeline: test task, risultati e code coverage, quality gate

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 23. `dependsOn`, parallelismo, ordine dei job, trigger complessi, GitHub repo -> Azure Pipelines

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 24. Deployment slot e swap su App Service, feature flag con Azure App Configuration

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 25. Retention artifact, migrazione classic -> YAML, pipeline analytics

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 26. Service principal vs managed identity; `GITHUB_TOKEN`, GitHub App, PAT

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 27. Secure files, prevenzione leak di segreti nei log, access level (Stakeholder / outside collaborator)

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 28. Dashboard (cycle time, lead time), query Boards, wiki con Mermaid, webhook, integrazione Teams

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 29. Alert su GitHub Actions / Azure Pipelines, VM Insights, Container Insights, KQL

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 30. Tag, recupero dati (`reflog`, `revert`, `cherry-pick`), rimozione dati dalla storia

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 
