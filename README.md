# az400-lab

Mini app Node.js (zero dipendenze) usata per gli esercizi di laboratorio AZ-400.

```bash
npm test      # esegue i test (node:test)
npm start     # avvia il server su :3000
```

Endpoint: `/` (saluto), `/health` (JSON `{"status":"ok"}`).

## Esercizi

Spunta man mano. Per ognuno: fai, rompi, annota.

- [x] 1. Branch policy Azure DevOps su `main`
- [x] 2. Branch protection / ruleset GitHub su `main`
- [ ] 3. Ruleset su path, estensioni e dimensione file
- [ ] 4. CODEOWNERS
- [ ] 5. Git LFS e pulizia storia
- [ ] 6. Pipeline YAML base (build + test)
- [ ] 7. Multi-stage con approvazione environment
- [ ] 8. Variable group, secure variable, template
- [ ] 9. Service connection (workload identity federation)
- [ ] 10. Agent self-hosted
- [ ] 11. Azure Artifacts
- [ ] 12. GitHub Actions (matrix, secret, environment, OIDC)
- [ ] 13. Deployment strategies
- [ ] 14. Container (Dockerfile + GHCR)
- [ ] 15. IaC con Bicep
- [ ] 16. Key Vault nella pipeline
- [ ] 17. Dependabot, secret scanning, CodeQL
- [ ] 18. Permessi Azure DevOps
- [ ] 19. Application Insights, alert, KQL
- [ ] 20. Azure Boards e integrazione GitHub

### Aggiunti dopo il confronto con la study guide (skills measured al 27/07/2026)

Priorità alta (area pipeline, 50-55%): 21-25.

- [ ] 21. Feed con views e upstream, versioning SemVer/CalVer, GitHub Packages
- [ ] 22. Test in pipeline: test task, risultati e code coverage, quality gate
- [ ] 23. `dependsOn`, parallelismo, ordine dei job, trigger complessi, GitHub repo -> Azure Pipelines
- [ ] 24. Deployment slot e swap su App Service, feature flag con Azure App Configuration
- [ ] 25. Retention artifact, migrazione classic -> YAML, pipeline analytics
- [ ] 26. Service principal vs managed identity; `GITHUB_TOKEN`, GitHub App, PAT
- [ ] 27. Secure files, prevenzione leak di segreti nei log, access level (Stakeholder / outside collaborator)
- [ ] 28. Dashboard (cycle time, lead time), query Boards, wiki con Mermaid, webhook, integrazione Teams
- [ ] 29. Alert su GitHub Actions / Azure Pipelines, VM Insights, Container Insights, KQL
- [ ] 30. Tag, recupero dati (`reflog`, `revert`, `cherry-pick`), rimozione dati dalla storia

Solo teoria: Scalar e cross-repo sharing, Azure Deployment Environments, DSC / Azure Machine Configuration, Defender for Cloud DevOps Security.
