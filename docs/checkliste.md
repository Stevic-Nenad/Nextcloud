# Checkliste für iterative Projektarbeit (Semesterarbeit)

## Vor Beginn einer Arbeitssitzung / Zu Beginn eines Sprints

*   **[ ] GitHub Project Board prüfen:**
    *   [ ] Ist das Product Backlog priorisiert? (PO-Hut aufsetzen)
    *   [ ] Sind die User Stories für den aktuellen Sprint klar und haben Akzeptanzkriterien?
    *   [ ] Sind alle vorherigen Sprint-Items korrekt auf "Done" (oder ggf. zurück ins Backlog)?
*   **[ ] `README.md` (Sprint-Abschnitt):**
    *   [ ] Ist das Sprint-Ziel für den aktuellen Sprint klar formuliert?
    *   [ ] Sind die geplanten Items (User Story IDs/Titel) für den aktuellen Sprint im `README.md` Abschnitt korrekt referenziert?
*   **[ ] (Nur bei Sprint Start) Sprint Planning dokumentiert?**
    *   [ ] Zusammenfassung des Sprint Plannings (Ziel, ausgewählte Items, kurze Diskussion) im `README.md` unter dem aktuellen Sprint-Abschnitt eingetragen?

## Während der Arbeit an einer User Story / einem Task

*   **[ ] GitHub Project Board:**
    *   [ ] Das bearbeitete Item von "To Do" auf "In Progress" verschieben.
*   **[ ] Git Workflow:**
    *   [ ] Für neue Features/grössere Änderungen: `git checkout -b feature/ISSUE-ID-kurzbeschreibung` (vom `main` Branch).
    *   [ ] Regelmässig kleine, atomare Commits machen (`git commit -m "Feat/Fix/Docs: Klare Commit Message"`).
    *   [ ] Regelmässig auf den Remote-Branch pushen (`git push origin feature/...`).
*   **[ ] Code-Entwicklung & Konfiguration:**
    *   [ ] Code schreiben / Konfigurationen erstellen.
    *   [ ] Code kommentieren, wo nötig.
    *   [ ] Im Code ggf. TODOs für spätere Refactorings/Verbesserungen markieren.
*   **[ ] Lokales Testen:**
    *   [ ] `terraform validate` / `terraform plan` regelmässig ausführen.
    *   [ ] `helm lint` / `helm template` verwenden.
    *   [ ] Funktionalität lokal oder in einer Testumgebung prüfen.
*   **[ ] Dokumentation (laufend!):**
    *   [ ] `README.md` (Abschnitt 4 - Implementierung): Entsprechende Abschnitte mit Erklärungen, wichtigen Code-Snippets, getroffenen Entscheidungen aktualisieren.
    *   [ ] `README.md` (Abschnitt 3 - System-Design): Ggf. Architekturdiagramme aktualisieren oder erstellen, in `assets/images/` speichern und im README einbetten/referenzieren.
    *   [ ] `README.md` (Abschnitt 5 - Testing): Ggf. Testfälle formulieren oder Testergebnisse (Screenshots) sammeln.
    *   [ ] Ggf. neue Risiken in der Risikomatrix (README Abschnitt 2.4) ergänzen oder Status anpassen.

## Am Ende der Arbeit an einer User Story / einem Task (Bevor PR erstellt wird)

*   **[ ] Definition of Done (DoD) prüfen:**
    *   [ ] Alle Akzeptanzkriterien der User Story erfüllt?
    *   [ ] Code ist committet und gepusht.
    *   [ ] Automatisierte Checks (Linting etc.) laufen durch.
    *   [ ] Manuelle Tests erfolgreich.
    *   [ ] Relevante Doku im `README.md` ist aktuell.
    *   [ ] (Simulierte) Peer-Review/Self-Review durchgeführt.
*   **[ ] Pull Request (PR) erstellen:**
    *   [ ] PR vom Feature-Branch zum `main`-Branch erstellen.
    *   [ ] Im PR eine klare Beschreibung der Änderungen und Link zum Issue auf dem Project Board.
*   **[ ] PR mergen (nach Self-Review):**
    *   [ ] PR sorgfältig selbst reviewen.
    *   [ ] PR mergen (Squash & Merge oder Rebase & Merge bevorzugt für saubere History).
    *   [ ] Feature-Branch nach dem Merge löschen.
*   **[ ] GitHub Project Board:**
    *   [ ] Das bearbeitete Item von "In Progress" auf "In Review / QA" (wenn du einen separaten Review-Schritt für dich simulieren willst) oder direkt auf "Done" verschieben.

## Am Ende eines Arbeitstages (für Daily Scrum Log)

*   **[ ] `README.md` (Aktueller Sprint-Abschnitt -> "Wichtigste Daily Scrum Erkenntnis"):**
    *   [ ] Kurze Notiz: Was wurde heute erreicht? Gab es Hindernisse? Was ist der Plan für morgen? *(1-2 Sätze genügen)*
*   **[ ] GitHub Project Board:**
    *   [ ] Sicherstellen, dass der Status der Items korrekt ist.

## Am Ende eines Sprints

*   **[ ] `README.md` (Aktueller Sprint-Abschnitt):**
    *   [ ] Abschnitt "Erreichtes Inkrement / Ergebnisse" finalisieren: Alle abgeschlossenen User Stories auflisten, Highlights, Code-Snippets, Links zu Diagrammen/Screenshots.
    *   [ ] Abschnitt "Sprint Review (Kurzfazit & Demo-Highlight)" vorbereiten/ausfüllen: Was wird/wurde gezeigt? Wichtigstes Feedback?
    *   [ ] Abschnitt "Sprint Retrospektive (Wichtigste Aktion)" ausfüllen: Was lief gut? Was schlecht? Konkrete Verbesserungsmassnahme für den nächsten Sprint.
*   **[ ] GitHub Project Board:**
    *   [ ] Alle abgeschlossenen Items des Sprints sind auf "Done".
    *   [ ] Nicht abgeschlossene Items werden bewertet: Zurück ins Product Backlog oder in den nächsten Sprint übernehmen (Entscheidung dokumentieren!).
*   **[ ] Vorbereitung auf Einzelbesprechung (falls zutreffend):**
    *   [ ] Demo vorbereiten.
    *   [ ] Fragen an Experten sammeln.
*   **[ ] (Nach der Besprechung) Feedback der Experten dokumentieren:**
    *   [ ] Im `README.md` (z.B. im Sprint Review Abschnitt oder separater Notiz) oder als Kommentar im relevanten Issue auf dem Board.
    *   [ ] Ggf. neue PBIs aus dem Feedback erstellen.

## Laufend während des gesamten Projekts

*   **[ ] Risikomatrix aktuell halten** (README Abschnitt 2.4).
*   **[ ] Product Backlog pflegen** (GitHub Project Board): Neue Ideen/Anforderungen als User Stories erfassen, priorisieren, verfeinern (PO-Hut).
*   **[ ] Kommunikation mit Experten** (MS Teams) bei Bedarf und wichtige Punkte/Entscheidungen festhalten.
*   **[ ] Regelmässig `git push`** auf den `main` Branch (nach Merges).

Diese Checkliste soll dir helfen, nichts zu vergessen und den Prozess für die Examinatoren transparent und nachvollziehbar zu gestalten. Du kannst sie natürlich an deine Bedürfnisse anpassen!