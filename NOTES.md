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

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 7. Multi-stage con approvazione environment

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 8. Variable group, secure variable, template

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 9. Service connection (workload identity federation)

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 10. Agent self-hosted

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 11. Azure Artifacts

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

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
