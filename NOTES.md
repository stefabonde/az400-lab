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
- **Cosa fa**: impone PR, reviewer minimi, work item collegato, commenti risolti, build validation.
- **Errore visto**: `TF402455: Pushes to this branch are not permitted; you must use a pull request`.
- **Trabocchetti**: con un solo utente "2 reviewer" non si raggiunge mai; serve *Allow requestors to approve their own changes* oppure abbassare a 1. L'approvazione dell'autore non conta finché l'opzione è spenta. Il *bypass* (permesso sul branch) ignora le regole: da evitare.
- **Domanda tipo**: "come impedisci il push diretto su main?" -> branch policy / PR obbligatoria.

## 2. Branch protection / ruleset GitHub su `main`

- **Dove**: GitHub repo → Settings → Rules → Rulesets (non *Branches*, che è la vecchia branch protection).
- **Cosa fa**: protegge `main` (PR obbligatoria, no force push, no delete, status check).
- **Errore visto**: dall'editor web "You can't commit to `main` because it is a protected branch" + proposta di nuovo branch e PR.
- **Trabocchetti**: il bypass è una lista di attori nel ruleset; *Enforcement status* deve essere Active (non Evaluate/Disabled).
- **Domanda tipo**: "come blocchi i push diretti su main in GitHub?" -> ruleset o branch protection rule.

## 3. Ruleset su path, estensioni e dimensione file

- **Dove (GitHub)**: Settings → Rules → Rulesets → push ruleset: *Restrict file size*, *Restrict file extensions*, *Restrict file paths*, *Restrict file path length*. A livello organizzazione: stessi ruleset, applicati a tutti i repo.
- **Dove (Azure DevOps)**: Project settings → Repos → Repositories → *All Repositories* (o un repo) → Policies → *Maximum file size*, *Maximum path length*, *Reserved names*.
- **Trabocchetti**: il limite hard GitHub è 100 MB (avviso a 50), non si alza; i ruleset lo abbassano. Chiarire sempre: dove (ADO/GitHub), ambito (repo/progetto/org), verbo (limitare/abilitare LFS).
- **Da verificare con il lab**: nomi esatti delle voci nella tua interfaccia.

## 4. CODEOWNERS

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

## 5. Git LFS e pulizia storia

- **Dove**: 
- **Cosa fa**: 
- **Errore visto**: 
- **Trabocchetti**: 
- **Domanda tipo**: 

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
