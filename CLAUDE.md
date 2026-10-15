# az400-lab: studio AZ-400 (Stefano)

Repo personale di studio per ripetere l'esame AZ-400 (parte lab fallita, ripetizione entro ~2 mesi). Rispondere in italiano, in forma schematizzata (tabelle, elenchi), senza fronzoli.

## Metodo

- Un esercizio al giorno (1 ora), guidato passo passo: **fai, rompi, annota**.
- Dopo ogni esercizio: scheda in `NOTES.md` (Dove / Cosa fa / Errore visto / Trabocchetti / Domanda tipo / Ordine dei passi), spunta in `README.md`, mini-quiz.
- Le note vanno in un branch `notes-esNN` + PR (il `main` GitHub e' protetto da ruleset; Stefano mergia con bypass admin).
- Stefano lavora dal browser (portali), come all'esame. Il repo GitHub e il repo Azure DevOps (org `stefabonde-lab`, progetto `az400-lab`) sono **due copie indipendenti**: le modifiche per gli esercizi ADO vanno fatte con l'editor web di ADO.
- Aggiornare la memoria (`~/.claude/projects/-Users-stefanobondesani/memory/az400-lab.md`) a fine esercizio.

## File

- `README.md`: checklist dei 30 esercizi (avanzamento).
- `NOTES.md`: regole d'oro, glossario concetti, confronti rapidi (dai quiz), schede 1-30.
- `QUIZ-LOG.md`: registro di domande sbagliate/sospette, nomi cambiati, lista "da portare in lab".
- `src/`, `package.json`: app Node di esempio (`npm test`).
- Piattaforma di quiz locale (NON in questo repo): `~/develop/personali/az400-quiz`.

## Regole

- Mai mescolare con l'ambiente Jakala (identita' personale: account Microsoft hotmail, org ADO `stefabonde-lab`).
- Ricordare di cancellare il resource group `az400-lab-rg` a fine sessione e di revocare i PAT.
- Non copiare domande SkillCertPro nel repo (testo riassunto in una riga) e non cercare contenuti reali dell'esame (NDA). Se una risposta del banco sembra errata o datata, verificare sulla documentazione Microsoft.
- Se compaiono nomi di servizi rinominati (DSC -> Azure Machine Configuration, AAD -> Entra ID, WhiteSource -> Mend), segnalarlo.
- Non promettere che i lab dell'esame siano identici agli esercizi.
