# Semesterarbeit: End-to-End CI/CD-Pipeline mit Terraform, Helm und GH Actions für Nextcloud auf Kubernetes (AWS EKS)

![Header Bild](assets\header.png)

**Student:** Nenad Stevic<br>
**TBZ Lehrgang dipl. Informatiker/in HF - 3. Semester**<br>
**Abgabedatum:** 09.07.2025

[[_TOC_]]

---
## 1. Einleitung
*In diesem Kapitel wird das Projekt, die Kriterien und die Vorgehensweise genauer unter die Lupe genommen. Damit wird ein Überblick über die geplante Arbeit geschaffen, was die Auswertung der Ergebnisse am Schluss vereinfachen soll.*

### 1.1 Problemstellung
Das Hosten und Verwalten von Webanwendungen mit Datenbankanbindung stellt in der heutigen IT-Welt mehrere Herausforderungen dar. Mit High-Availability Infrastrukturen, welche heute in der Industrie weit verbreitet sind, muss man deutlich mehr konfigurieren und beachten, als bei "Bare Metal" Servern vor einem Jahrzehnt. Wie kann man mehrere Instanzen einer Applikation laufen lassen, und trotzdem Datenintegrität auf allen Replicas gewährleisten? Wie kann man diese verschiedenen Komponenten und Abhängigkeiten erfolgreich konfigurieren, ohne dass Fehler oder Unachtsamkeiten unterlaufen?

Diese Fragen oder Probleme sind welche, die wir auch in meinem Betrieb begegnen, besonders wenn es darum geht, Webanwendungen für unsere Kunden zu hosten. Deswegen ist dieses Thema äusserst interessant und motivierend, Lösungsansätze zu finden, und Erfahrungen zu sammeln die einen messbaren Beitrag zum Berufsleben bringen werden.

### 1.2 Projektziele
Die Ziele der Arbeit wurden nach dem SMART-Prinzip definiert:

1.  **Automatisierte Infrastruktur Verwaltung via IaC (Terraform):**<br>
    Die erforderliche Cloud-Infrastruktur auf AWS – bestehend aus einem Elastic Kubernetes Service (EKS) Cluster, einem Relational Database Service (RDS) und einer Elastic Container Registry (ECR) – wird vollständig mittels Terraform-Code automatisiert erstellt und versioniert. Das Ergebnis ist eine betriebsbereite, aber initial leere Kubernetes- und Datenbankumgebung.<br>
    **Deadline: Ende Sprint 3** *(VPC in Sprint 1, EKS/ECR in Sprint 2, RDS/IAM in Sprint 3)*
2.  **Entwicklung eines funktionalen Nextcloud Helm Charts:**<br>
    Ein eigenständiges, funktionales Helm Chart für die Nextcloud-Anwendung entwickeln. Dieses Chart ermöglicht die Konfiguration von Kubernetes-Deployments, Services, Persistent Volume Claims (PVCs), Datenbankverbindungs-Secrets und weiterer Anwendungsparameter über eine `values.yaml`-Datei. Die Funktionalität wird durch `helm template` und `helm install` (lokal oder auf EKS) verifiziert.<br>
    **Deadline: Ende Sprint 4**
3.  **Implementierung einer CI/CD-Pipeline mit GitHub Actions:**<br>
    Eine automatisierte Continuous Integration / Continuous Deployment (CI/CD) Pipeline unter Verwendung von GitHub Actions einrichten. Diese Pipeline wird bei Änderungen im Git-Repository (z.B. Aktualisierung des Nextcloud-Images oder der Helm-Chart-Konfiguration) den vollständigen Deployment-Prozess auslösen. Dies beinhaltet optionale Schritte wie Image Build/Push und Helm Linting/Packaging.<br>
    **Deadline: Ende Sprint 5**
4.  **Bereitstellung einer funktionalen Nextcloud Instanz (via CI/CD-Pipeline):**<br>
    Eine Nextcloud-Instanz mittels der CI/CD-Pipeline auf dem Kubernetes-Cluster bereitstellen. Die Instanz ist extern erreichbar, erfolgreich mit der provisionierten Datenbank verbunden und weist Persistenz für Benutzerdaten auf. Dies wird durch einen erfolgreichen Login sowie exemplarische Datei-Upload- und Download-Vorgänge demonstriert.<br>
    **Deadline: Ende Sprint 5** *(Manuelles Test-Deployment in Sprint 3, finales Deployment via Pipeline in Sprint 5)*
5.  **Umfassende Dokumentation und Code-Bereitstellung:**<br>
    Bis zum Projektende sind die Systemarchitektur, die Terraform-Module, das Helm Chart, die CI/CD-Pipeline, getroffene Sicherheitsüberlegungen sowie der gesamte Setup- und Deployment-Prozess detailliert dokumentiert. Der gesamte Quellcode (Terraform, Helm, GitHub Actions Workflows) ist in einem Git-Repository versioniert und für die Experten zugänglich.<br>
    **Deadline: Ende Sprint 6 (zur Projektabgabe)**

Was diese Arbeit besonders attraktiv macht, ist die hohe Relevanz der verwendeten Technologien und Prinzipien im beruflichen Alltag eines DevOps Engineers. Der Zeitrahmen von ca. 50 Stunden ist realistisch, vor allem durch vorhandene Erfahrung in diesem Bereich.

### 1.3 Vorgehensweise
Die geplante Lösung zielt auf die Erstellung einer vollständigen End-to-End-Automatisierung für das Hosten von Nextcloud auf einem Kubernetes-Cluster (AWS EKS) ab. Der gesamte Prozess basiert auf dem "Infrastructure as Code" (IaC) Prinzip, bei dem alle Konfigurationen und Komponenten als Code definiert und versioniert werden.
*   **Infrastruktur-Provisionierung:** Die Cloud-Infrastruktur (EKS-Cluster, Datenbank, Container Registry etc.) wird mittels **Terraform** deklariert und verwaltet.
*   **Anwendungs-Deployment auf Kubernetes:** Die Nextcloud-Anwendung selbst wird mithilfe eines eigens entwickelten **Helm Charts** auf dem Kubernetes-Cluster konfiguriert und bereitgestellt. Helm dient hierbei als Paketmanager für Kubernetes-Anwendungen.
*   **Automatisierung des Lifecycles:** Der gesamte Prozess von der Code-Änderung bis zum Deployment wird durch eine **CI/CD-Pipeline, implementiert mit GitHub Actions**, automatisiert.
*   **Methodisches Vorgehen:** Die Umsetzung erfolgt nach agilen Prinzipien, angelehnt an das **Scrum-Framework** (in einer auf die Einzelarbeit angepassten Form). Dies beinhaltet eine iterative Entwicklung, regelmässige Reflexion und eventuelle Anpassung der Planung, um Flexibilität sicherzustellen. Eine inhaltlich aktuelle Dokumentation begleitet den gesamten Prozess.

### 1.4 Zusammenfassung
Diese Semesterarbeit realisiert eine durchgängig automatisierte Pipeline zur Bereitstellung und Verwaltung der Webanwendung _Nextcloud_ auf einem Kubernetes-Cluster (AWS EKS). Die Lösung nutzt Terraform für die Definition der Cloud-Infrastruktur, Helm für die Paketierung und Konfiguration von Nextcloud auf Kubernetes sowie GitHub Actions für die CI/CD-Automatisierung. Das Ziel ist es, eine robuste, wiederholbare und moderne Bereitstellungsmethode zu implementieren und dabei Kernkompetenzen im Bereich DevOps und Cloud-native Technologien zu vertiefen.

### 1.5 Scope
Zur Sicherstellung der Realisierbarkeit innerhalb des vorgegebenen Zeitrahmens werden folgende Aspekte klar definiert und abgegrenzt:

*   **Im Projektumfang enthalten (In Scope):**
    *   Automatisierte Erstellung der Kern-Infrastrukturkomponenten (EKS, RDS, ECR) mittels Terraform.
    *   Entwicklung eines funktionalen Helm Charts für Nextcloud, das grundlegende Konfigurationen, Persistenz und Datenbankanbindung abdeckt.
    *   Implementierung einer CI/CD-Pipeline mit GitHub Actions für das Deployment des Helm Charts auf dem EKS-Cluster.
    *   Sichere Handhabung von Secrets für Datenbankzugangsdaten und Pipeline-Authentifizierung.
    *   Bereitstellung einer funktionierenden, extern erreichbaren Nextcloud-Instanz mit Datenpersistenz.
    *   Dokumentation der gewählten Architektur, der Konfigurationen und des Inbetriebnahme-Prozesses.
*   **Nicht im Projektumfang enthalten (Out of Scope):**
    *   Implementierung hochkomplexer oder anwendungsspezifischer Nextcloud-Konfigurationen (z.B. Integration externer Authentifizierungssysteme, spezifische Nextcloud-Apps über die Basisinstallation hinaus).
    *   Entwicklung und Implementierung automatisierter Backup- und Restore-Strategien für Nextcloud-Daten oder die Datenbank.
    *   Ausgefeilte Monitoring- und Logging-Lösungen für die Nextcloud-Instanz, die über die Standardfunktionalitäten von Kubernetes und AWS hinausgehen.
    *   Detaillierte Performance-Optimierungen und umfangreiche Lasttests.
    *   Unterstützung für Multi-Cloud-Szenarien oder andere Kubernetes-Distributionen als AWS EKS.
    *   Erstellung eines benutzerdefinierten Nextcloud Docker-Images (Verwendung des offiziellen Images, sofern nicht zwingend anders erforderlich).
    *   Tiefgehende Betrachtung von Compliance-Anforderungen oder rechtlichen Aspekten, die über allgemeine Best Practices der IT-Sicherheit hinausgehen.
---
## 2. Projektmanagement
*In diesem Kapitel wird das methodische Vorgehen zur Planung, Durchführung und Steuerung des Projekts detailliert erläutert. Der Fokus liegt auf der konsequenten Anwendung agiler Prinzipien nach dem Scrum-Framework, um eine iterative Entwicklung, kontinuierliche Verbesserung und transparente Nachvollziehbarkeit des Projektfortschritts zu gewährleisten.*

### 2.1 Scrum
Für die Durchführung dieser Semesterarbeit wird das agile Framework **Scrum** angewandt. Scrum ermöglicht eine flexible Reaktion auf sich ändernde Anforderungen, fördert die konstante Lieferung von Fortschritten und legt einen starken Fokus auf Transparenz. Obwohl Scrum primär für Teams konzipiert ist, werden die Prinzipien und Praktiken hier konsquent in einer Einzelarbeit simuliert. Scrum ist heutzutage der Standard im IT-Umfeld, da es eine strukturierte Herangehensweise an komplexe Projekte bietet und die iterative Entwicklung des Produkts unterstützt.

#### 2.1.1 Rollen
Im Rahmen dieser Semesterarbeit werden alle Scrum-Rollen durch den Studierenden (Nenad Stevic) wahrgenommen. Die klare Abgrenzung und Erfüllung der jeweiligen Verantwortlichkeiten ist für die Integrität der Arbeit entscheidend:

*   **Product Owner (PO):** Verantwortlich für die Definition der Produktvision (basierend auf dem Einreichungsformular und den Projektzielen) sowie der Erstellung und Priorisierung des Product Backlogs. Der PO stellt sicher, dass die entwickelten Inkremente den Anforderungen entsprechen.
*   **Scrum Master (SM):** Verantwortlich für die Einhaltung und korrekte Anwendung des Scrum-Prozesses. Der SM moderiert die Scrum Events, beseitigt Hindernisse (Impediments), coacht den Entwicklungsprozess und stellt sicher, dass das Team (in diesem Fall der Studierende als Entwickler) effektiv arbeiten kann.
*   **Development Team (Dev-Team):** Verantwortlich für die Umsetzung der im Sprint Backlog ausgewählten Product Backlog Items (PBIs) in ein funktionsfähiges Inkrement. Das Dev-Team organisiert sich selbst und ist für die technische Qualität der Lieferung zuständig.

#### 2.1.2 Artefakte
Die folgenden Scrum Artefakte werden in diesem Projekt eingesetzt:

*   **Product Backlog:** Eine dynamische, geordnete Liste aller bekannten Anforderungen, Funktionalitäten, Verbesserungen und Fehlerbehebungen, die für das Produkt erforderlich sind. Das Product Backlog wird als [GitHub Project Board]([https://github.com/users/Stevic-Nenad/projects/1]) geführt und kontinuierlich gepflegt. Jedes Product Backlog Item (PBI) wird als User Story formuliert und enthält Akzeptanzkriterien.
*   **Sprint Backlog:** Eine Auswahl von Product Backlog Items, die für einen spezifischen Sprint committet wurden, ergänzt um einen Plan zur Lieferung des Produktinkrements und zur Erreichung des Sprint-Ziels. Das Sprint Backlog wird ebenfalls auf dem GitHub Project Board visualisiert (z.B. in einer "Sprint Backlog" oder "To Do" Spalte für den aktuellen Sprint).
*   **Increment:** Die Summe aller im aktuellen Sprint fertiggestellten Product Backlog Items, integriert mit den Inkrementen aller vorherigen Sprints. Jedes Inkrement muss potenziell auslieferbar sein und der Definition of Done entsprechen. Das Inkrement besteht aus dem lauffähigen Code (Terraform, Helm, GitHub Actions) und der aktualisierten Dokumentation.

#### 2.1.3 Zeremonien
Alle Scrum Zeremonien werden zeitlich begrenzt (Time-boxed) und konsequent durchgeführt, um den Inspektions- und Adaptionszyklus von Scrum zu leben:

*   **Sprint Planning:** Zu Beginn jedes Sprints wird das Sprint Planning durchgeführt. Der Product Owner (PO) präsentiert die priorisierten Product Backlog Items. Das Development Team (Dev-Team) wählt die Items aus, die es im Sprint umsetzen kann, definiert das Sprint-Ziel und plant die konkreten Aufgaben zur Erreichung dieses Ziels.
*   **Daily Scrum:** Ein tägliches, maximal 15-minütiges Meeting des Dev-Teams (und des SM), um den Fortschritt in Richtung Sprint-Ziel zu synchronisieren und Impediments zu identifizieren. Es werden die drei Fragen beantwortet: Was wurde gestern erreicht? Was wird heute getan? Gibt es Hindernisse?
*   **Sprint Review:** Am Ende jedes Sprints wird das Inkrement den Stakeholdern (hier den Fachexperten und dem Projektmanagement-Experten, repräsentiert durch den PO in der Vorbereitung) präsentiert. Es wird Feedback eingeholt, und das Product Backlog wird bei Bedarf angepasst.
*   **Sprint Retrospective:** Nach dem Sprint Review und vor dem nächsten Sprint Planning reflektiert das Scrum Team (PO, SM, Dev-Team) den vergangenen Sprint. Ziel ist es, den Prozess kontinuierlich zu verbessern, indem positive Aspekte identifiziert und Massnahmen zur Optimierung für den nächsten Sprint abgeleitet werden.

Die detaillierten Protokolle und Ergebnisse jedes Scrum Events werden im Abschnitt [2.3 Sprint-Durchführung und Dokumentation](#23-sprint-durchführung-und-dokumentation) für den jeweiligen Sprint dokumentiert. Vorlagen für diese Protokolle finden sich im [Anhang 8.1](#81-verwendete-scrum-vorlagen-templates).

#### 2.1.4 Definition of Done (DoD)
Die Definition of Done (DoD) ist ein gemeinsames Verständnis darüber, wann ein Product Backlog Item als "fertig" gilt und somit Teil des Inkrements werden kann. Für diese Semesterarbeit gilt folgende initiale Definition of Done (diese kann im Laufe des Projekts angepasst und erweitert werden):

*   Der Code für das PBI wurde geschrieben und ist auf einem Feature-Branch committet.
*   Ein Pull Request (PR) wurde erstellt, vom Entwickler selbst sorgfältig anhand der Akzeptanzkriterien und Anforderungen geprüft (Self-Review) und anschliessend in den `main`-Branch gemerged.
*   Alle automatisierten Prüfungen (sofern bereits implementiert, z.B. `terraform validate`, `helm lint`) sind erfolgreich durchlaufen.
*   Infrastrukturänderungen wurden erfolgreich mittels `terraform apply` angewendet und die Funktionalität wurde verifiziert.
*   Anwendungs-Deployments mittels `helm upgrade --install` waren erfolgreich und die Kernfunktionalität der Anwendung wurde überprüft.
*   Alle Akzeptanzkriterien des zugehörigen User Story sind erfüllt.
*   Die relevante Dokumentation (dieses README, Diagramme, Setup-Anleitungen) wurde aktualisiert, um die Änderungen widerzuspiegeln.
*   Das PBI wurde auf dem GitHub Project Board in die Spalte "Done" verschoben.

### 2.2 Projektplanung
*Eine gute Planung ist das A und O, auch wenn man agil unterwegs ist. In diesem Kapitel wird behandelt, wie die Roadmap zur fertigen Nextcloud-Pipeline auszusehen hat.*

#### 2.2.1 Der Grobplan
Den zeitlichen Rahmen für das Projekt geben die offiziellen Termine der TBZ vor, insbesondere die Einzelbesprechungen und der finale Abgabetermin. Basierend darauf und auf einer ersten Schätzung der Arbeitsaufwände für die Hauptkomponenten des Projekts wurde folgender visueller Zeitplan (Gantt-Diagramm) erstellt. Er zeigt die übergeordneten Projektphasen und die geplanten Sprints im Überblick:

![gantt](assets/gantt.svg)
Gantt Diagramm
*(Stand: 09.05.2025 – Dieser Plan dient als Orientierung und wird iterativ im Detail verfeinert)*

#### 2.2.2 Strukturierung
Um die in [Kapitel 1.2](#12-projektziele) definierten Projektziele greifbar zu machen und die Arbeit sinnvoll zu bündeln, wurden grössere thematische Arbeitspakete, sogenannte **Epics**, definiert. Jedes Epic repräsentiert einen wesentlichen Baustein auf dem Weg zum fertigen Produkt und kann sich über mehrere Sprints erstrecken.

Die folgenden Epics bilden das Rückgrat des Product Backlogs für dieses Projekt:

*   **`EPIC-PROJMGMT`: Projektinitialisierung & Durchgängige Scrum-Prozessdokumentation**
    *   *Ziel:* Schaffung der organisatorischen und dokumentarischen Grundlagen (Repository, `README.md`, Project Board) und Sicherstellung der korrekten, nachvollziehbaren Anwendung des Scrum-Frameworks über die gesamte Projektdauer.
*   **`EPIC-TF-NET`: AWS Netzwerk-Infrastruktur mit Terraform**
    *   *Ziel:* Aufbau eines sicheren und skalierbaren Fundaments in der AWS Cloud mittels Terraform, inklusive VPC, Subnetzen, Routing und Internet-Anbindung.
*   **`EPIC-TF-K8S`: Kubernetes (EKS) Cluster & Container Registry (ECR) mit Terraform**
    *   *Ziel:* Automatisierte Bereitstellung eines managed Kubernetes-Clusters (AWS EKS) und einer privaten Container Registry (AWS ECR) mittels Terraform.
*   **`EPIC-TF-DB-IAM`: Datenbank (RDS) & zugehörige IAM-Rollen mit Terraform**
    *   *Ziel:* Automatisierte Provisionierung einer managed relationalen Datenbank (AWS RDS) und der notwendigen IAM-Rollen für den Zugriff durch Anwendungen und Kubernetes-Komponenten.
*   **`EPIC-NC-DEPLOY`: Nextcloud Grundlagen (Manuelles Deployment, Persistenz-Konfiguration)**
    *   *Ziel:* Manuelle Installation und Konfiguration von Nextcloud auf dem EKS-Cluster, um die grundlegende Funktionalität, Datenbankanbindung und Datenpersistenz zu validieren, bevor die Automatisierung mit Helm erfolgt.
*   **`EPIC-HELM`: Nextcloud Helm Chart Entwicklung**
    *   *Ziel:* Erstellung eines eigenen, robusten und konfigurierbaren Helm Charts für die Nextcloud-Anwendung zur Vereinfachung des Deployments und Managements auf Kubernetes.
*   **`EPIC-CICD`: CI/CD Pipeline (GitHub Actions) Implementierung**
    *   *Ziel:* Aufbau einer vollautomatisierten CI/CD-Pipeline mit GitHub Actions, die Änderungen am Code oder an der Konfiguration erkennt und Nextcloud automatisch auf dem EKS-Cluster bereitstellt oder aktualisiert.
*   **`EPIC-ABSCHLUSS`: Testing, Finale Dokumentation & Projektabschluss**
    *   *Ziel:* Umfassendes Testen der Gesamtlösung, Finalisierung der Projektdokumentation gemäss den Vorgaben und Vorbereitung der Abschlusspräsentation.

Alle Epics sind als Issues mit dem Label `epic` auf dem [GitHub Project Board]([https://github.com/users/Stevic-Nenad/projects/1]) erfasst.

#### 2.2.3 Von Epics zu Sprints: Die iterative Feinplanung
Mit der groben Roadmap (Gantt) und den thematischen Wegweisern (Epics) erfolgt die detaillierte Planung iterativ für jeden einzelnen Sprint im **Sprint Planning Meeting**. Für jeden Sprint wird ein klares **Sprint-Ziel** definiert. Aus den für dieses Ziel relevanten Epics werden dann konkrete **User Stories** abgeleitet oder ausgewählt. Diese User Stories beschreiben eine kleine, wertstiftende Funktionalität aus Nutzersicht und werden mit spezifischen **Akzeptanzkriterien** versehen.

Die User Stories für den jeweils aktuellen Sprint bilden das **Sprint Backlog**. Alle weiteren, noch nicht für einen spezifischen Sprint eingeplanten User Stories verbleiben im **Product Backlog** und werden kontinuierlich durch den Product Owner (also mich) gepflegt, priorisiert und verfeinert (Backlog Refinement).

Dieser Ansatz – vom Groben ins Feine – stellt sicher, dass das Projekt einerseits eine klare Richtung hat, andererseits aber die Flexibilität bewahrt wird, auf Erkenntnisse aus vorherigen Sprints reagieren und die Planung anpassen zu können. Es wird also **nicht das gesamte Projekt mit allen User Stories für alle sechs Sprints im Voraus bis ins letzte Detail durchgeplant.** Vielmehr wird der Fokus auf eine exzellente Planung des unmittelbar bevorstehenden Sprints gelegt, während das Product Backlog eine Vorschau auf mögliche Inhalte der Folgesprints bietet.

Die konkrete Umsetzung und Dokumentation der einzelnen Sprints ist im nachfolgenden Abschnitt [2.3 Sprint-Durchführung](#23-sprint-durchführung) detailliert beschrieben.

### 2.3 Sprint-Durchführung und Dokumentation
*Dieser Abschnitt fasst die Durchführung und die wesentlichen Ergebnisse jedes Sprints zusammen. Jeder Sprint folgt dem definierten Scrum-Zyklus (Planning, Daily Scrums, Increment-Erstellung, Review, Retrospektive). Die detaillierte Ausarbeitung der User Stories, ihrer Akzeptanzkriterien und die tägliche Aufgabenverfolgung erfolgen auf dem [GitHub Project Board]([DEIN PROJEKT BOARD LINK HIER]). Die hier skizzierten Inhalte für Sprints 2-6 sind vorläufig und werden im jeweiligen Sprint Planning Meeting finalisiert und committet.*

---
#### **Sprint 0: Bootstrap & Initialplanung**
*   **Dauer:** 05. Mai 2025 - 09. Mai 2025
*   **Zugehöriges Epic:** `EPIC-PROJMGMT` (primär)
*   **Sprint-Ziel:** Etablierung der Projektinfrastruktur (Repository, `README.md`, Project Board), Definition des Scrum-Frameworks und Planung von Sprint 1.
*   **Geplante Items (auf GitHub Board als `S0-US1` bis `S0-US3`, `S0-T1`):**
    1.  GitHub Repository Initialisierung.
    2.  GitHub Project Board Setup.
    3.  Scrum-Framework in `README.md` definieren.
    4.  Sprint 1 planen.
*   **Wichtigste Daily Scrum Erkenntnis / Impediment:**
    *   Krankheitsbedingter Ausfall am 06. & 07.05. erforderte eine Priorisierung der Kernaufgaben für das Sprint-Ziel.
*   **Erreichtes Inkrement / Ergebnisse:**
    *   Projekt-Repository (`[https://github.com/Stevic-Nenad/Nextcloud]`) und `README.md` Grundstruktur erstellt.
    *   GitHub Project Board (`[https://github.com/users/Stevic-Nenad/projects/1/views/1]`) mit Epics und Sprint 0/1 Backlog Items eingerichtet.
    *   Scrum-Prozess (Abschnitt 2.1) definiert.
    *   Sprint 1 detailliert geplant.
*   **Sprint Review (Kurzfazit):** Projektbasis erfolgreich gelegt, alle Sprint-0-Ziele erreicht. Grundlage für Besprechung 1 geschaffen.
*   **Sprint Retrospektive (Wichtigste Aktion):** Notwendigkeit von Puffern für Unvorhergesehenes in der Zeitplanung erkannt.

---
#### **Sprint 1: AWS Account, Lokale Umgebung & Terraform Basis-Netzwerk (VPC)**
*   **Dauer:** 10. Mai 2025 - 24. Mai 2025 *(Beispiel, an dein Gantt anpassen, endet vor Sprint 2)*
*   **Zugehörige Epics:** `EPIC-PROJMGMT` (AWS Account), `EPIC-TF-NET` (VPC, TF Backend)
*   **Sprint-Ziel:** AWS Account sicher vorbereiten, lokale Entwicklungsumgebung einrichten, Terraform Remote Backend konfigurieren und ein grundlegendes AWS VPC-Netzwerk mittels Terraform Code definieren und versionieren.
*   **Geplante Items (Details & AK auf [GitHub Project Board] als `S1-US1` bis `S1-US4`):**
    1.  `S1-US1`: AWS Account sicher konfigurieren.
    2.  `S1-US2`: Lokale Entwicklungsumgebung einrichten.
    3.  `S1-US3`: Terraform Remote Backend (S3, DynamoDB) konfigurieren.
    4.  `S1-US4`: AWS VPC-Netzwerk mit Terraform definieren.
*   **Wichtigste Daily Scrum Erkenntnis / Impediment:** *(Wird während des Sprints hier kurz ergänzt)*
*   **Erreichtes Inkrement / Ergebnisse:** *(Wird am Ende des Sprints hier mit den Highlights gefüllt)*
*   **Sprint Review (Kurzfazit & Demo-Highlight):** *(Wird am Ende des Sprints hier ergänzt)*
*   **Sprint Retrospektive (Wichtigste Aktion):** *(Wird am Ende des Sprints hier ergänzt)*

---
#### **Sprint 2: Terraform für EKS Cluster & ECR**
*   **Dauer:** ca. 25. Mai 2025 - 01. Juni 2025 *(Beispiel, an dein Gantt anpassen, endet vor Besprechung 2 am 02.06.)*
*   **Zugehörige Epics:** `EPIC-TF-K8S`
*   **Vorläufiges Sprint-Ziel:** Den AWS EKS Kubernetes-Cluster und die AWS ECR Container Registry mittels Terraform Code automatisiert provisionieren und grundlegend konfigurieren.
*   **Mögliche Themen / User Story Schwerpunkte (Auswahl im Sprint Planning):**
    *   Terraform-Modul für EKS Cluster erstellen/verwenden.
    *   Node Groups definieren.
    *   `kubectl` Zugriff auf den Cluster konfigurieren und testen.
    *   Terraform für ECR Repository erstellen.
    *   IAM-Rollen für EKS (Cluster Role, Node Role) definieren.
*   **Wichtigste Daily Scrum Erkenntnis / Impediment:** *(Wird im Sprint ergänzt)*
*   **Erreichtes Inkrement / Ergebnisse:** *(Wird im Sprint ergänzt)*
*   **Sprint Review (Kurzfazit & Demo-Highlight):** *(Wird im Sprint ergänzt, Fokus auf funktionierendem EKS/ECR für Besprechung 2)*
*   **Sprint Retrospektive (Wichtigste Aktion):** *(Wird im Sprint ergänzt)*

---
#### **Sprint 3: Terraform für RDS/IAM & Manuelles Nextcloud Deployment**
*   **Dauer:** ca. 03. Juni 2025 - 14. Juni 2025 *(Beispiel, an dein Gantt anpassen, zwischen Besprechung 2 & vor Sprint 4)*
*   **Zugehörige Epics:** `EPIC-TF-DB-IAM`, `EPIC-NC-DEPLOY`
*   **Vorläufiges Sprint-Ziel:** Eine AWS RDS Datenbank-Instanz und die notwendigen IAM-Rollen für den Nextcloud-Zugriff mittels Terraform provisionieren. Anschliessend Nextcloud manuell auf dem EKS-Cluster bereitstellen, um die Datenbankanbindung und Datenpersistenz zu validieren.
*   **Mögliche Themen / User Story Schwerpunkte (Auswahl im Sprint Planning):**
    *   Terraform für RDS (PostgreSQL/MySQL) erstellen (inkl. Security Groups, Parameter Groups).
    *   Terraform für IAM-Rollen/Policies (z.B. für K8s Service Account zur DB-Authentifizierung oder EBS CSI Driver).
    *   Manuelles Erstellen von Kubernetes Manifesten (Deployment, Service, PVC, Secrets) für Nextcloud.
    *   Testen der Nextcloud-Installation: Login, Datei-Upload/Download, Persistenz über Pod-Neustart.
    *   Dokumentation der manuellen Schritte als Basis für das Helm Chart.
*   **Wichtigste Daily Scrum Erkenntnis / Impediment:** *(Wird im Sprint ergänzt)*
*   **Erreichtes Inkrement / Ergebnisse:** *(Wird im Sprint ergänzt)*
*   **Sprint Review (Kurzfazit & Demo-Highlight):** *(Wird im Sprint ergänzt)*
*   **Sprint Retrospektive (Wichtigste Aktion):** *(Wird im Sprint ergänzt)*

---
#### **Sprint 4: Nextcloud Helm Chart Entwicklung**
*   **Dauer:** ca. 15. Juni 2025 - 19. Juni 2025 *(Beispiel, an dein Gantt anpassen, endet vor Besprechung 3 am 20.06.)*
*   **Zugehöriges Epic:** `EPIC-HELM`
*   **Vorläufiges Sprint-Ziel:** Entwicklung eines grundlegend funktionalen Helm Charts für die Nextcloud-Anwendung, das die Konfiguration der wichtigsten Parameter (Image, Replicas, Service Typ, DB-Verbindung, Persistenz) über `values.yaml` ermöglicht.
*   **Mögliche Themen / User Story Schwerpunkte (Auswahl im Sprint Planning):**
    *   Helm Chart Struktur anlegen (`Chart.yaml`, `values.yaml`, `templates/`).
    *   Templates für Deployment, Service, PersistentVolumeClaim erstellen.
    *   Templates für ConfigMap (Nextcloud Konfig) und Secrets (DB Credentials) erstellen.
    *   Nutzung von Helm Helpers und Best Practices.
    *   Testen des Charts mit `helm lint`, `helm template` und `helm install` auf dem EKS Cluster.
*   **Wichtigste Daily Scrum Erkenntnis / Impediment:** *(Wird im Sprint ergänzt)*
*   **Erreichtes Inkrement / Ergebnisse:** *(Wird im Sprint ergänzt)*
*   **Sprint Review (Kurzfazit & Demo-Highlight):** *(Wird im Sprint ergänzt, Fokus auf funktionierendem Helm Chart für Besprechung 3)*
*   **Sprint Retrospektive (Wichtigste Aktion):** *(Wird im Sprint ergänzt)*

---
#### **Sprint 5: CI/CD Pipeline (GitHub Actions) & Tests**
*   **Dauer:** ca. 21. Juni 2025 - 03. Juli 2025 *(Beispiel, an dein Gantt anpassen)*
*   **Zugehörige Epics:** `EPIC-CICD`, Teile von `EPIC-ABSCHLUSS` (Testing)
*   **Vorläufiges Sprint-Ziel:** Implementierung einer GitHub Actions CI/CD-Pipeline, die bei Änderungen im Repository automatisch das Nextcloud Helm Chart auf dem EKS-Cluster bereitstellt oder aktualisiert. Durchführung erster End-to-End-Tests.
*   **Mögliche Themen / User Story Schwerpunkte (Auswahl im Sprint Planning):**
    *   GitHub Actions Workflow definieren (Trigger, Jobs, Steps).
    *   Authentifizierung der Pipeline gegenüber AWS (z.B. OIDC).
    *   Integration von Terraform `apply` (falls Infra-Änderungen Teil der Pipeline sein sollen, optional).
    *   Integration von `helm lint`, `helm package`, `helm upgrade --install`.
    *   Sichere Handhabung von Secrets in der Pipeline.
    *   Automatisierte Tests (z.B. Erreichbarkeit der Nextcloud URL nach Deployment).
    *   Manuelle End-to-End Tests (Login, Upload/Download).
*   **Wichtigste Daily Scrum Erkenntnis / Impediment:** *(Wird im Sprint ergänzt)*
*   **Erreichtes Inkrement / Ergebnisse:** *(Wird im Sprint ergänzt)*
*   **Sprint Review (Kurzfazit & Demo-Highlight):** *(Wird im Sprint ergänzt)*
*   **Sprint Retrospektive (Wichtigste Aktion):** *(Wird im Sprint ergänzt)*

---
#### **Sprint 6: Finalisierung, Testing & Projektabschluss**
*   **Dauer:** ca. 04. Juli 2025 - 09. Juli 2025 *(Beispiel, an dein Gantt anpassen, bis zur Abgabe)*
*   **Zugehöriges Epic:** `EPIC-ABSCHLUSS`
*   **Vorläufiges Sprint-Ziel:** Abschluss aller Entwicklungsarbeiten, finales Testen der Gesamtlösung, Finalisierung der Projektdokumentation (`README.md`) und Vorbereitung der Abschlusspräsentation.
*   **Mögliche Themen / User Story Schwerpunkte (Auswahl im Sprint Planning):**
    *   Behebung letzter Bugs oder Probleme.
    *   Durchführung aller definierten Testfälle und Dokumentation der Ergebnisse.
    *   Überprüfung und Vervollständigung aller Abschnitte der `README.md` (Reflexion, Anhang etc.).
    *   Code-Aufräumarbeiten und Kommentierung.
    *   Erstellung der Präsentationsfolien für das Kolloquium.
    *   Üben der Präsentation/Demo.
*   **Wichtigste Daily Scrum Erkenntnis / Impediment:** *(Wird im Sprint ergänzt)*
*   **Erreichtes Inkrement / Ergebnisse:** *(Wird im Sprint ergänzt)*
*   **Sprint Review (Kurzfazit & Demo-Highlight):** *(Dies ist quasi die Generalprobe für die Abgabe/Präsentation)*
*   **Sprint Retrospektive (Wichtigste Aktion):** *(Abschliessende Reflexion über das gesamte Projekt und den Lernprozess)*

---

## 2.4 Risiken
Die Identifikation und das Management potenzieller Risiken sind entscheidend für den Projekterfolg. Folgende Risiken wurden identifiziert und mit entsprechenden Gegenmassnahmen bewertet:

| ID | Risiko Beschreibung                                      | Eintritts-Wahrscheinlichkeit (H/M/N) | Auswirkung bei Eintritt (H/M/N) | Risikowert (H/M/N) | Gegenmassnahme(n)                                                                                                                               | Verantwortlich | Status |
|----|----------------------------------------------------------|------------------------------------|---------------------------------|--------------------|------------------------------------------------------------------------------------------------------------------------------------------------|----------------|--------|
| R1 | Technische Komplexität der Integration (Nextcloud, K8s, DB, IaC, CI/CD) | H                                  | H                               | H                  | Iteratives Vorgehen, Fokus auf Kernfunktionalität, Nutzung von Managed Services, Rückgriff auf CKA-Wissen, sorgfältige Recherche & Dokumentation. | N. Stevic      | Offen  |
| R2 | Zeitlicher Aufwand für ca. 50h sehr ambitioniert         | H                                  | H                               | H                  | Striktes Zeit- und Scope-Management, Priorisierung der Kernziele, frühzeitiger Beginn, realistische Aufwandsschätzung pro Task, Pufferzeiten.      | N. Stevic      | Offen  |
| R3 | Cloud-Kosten (Managed Kubernetes & DB-Dienste)           | M                                  | M                               | M                  | Aktives Kostenmanagement (AWS Dashboard), Nutzung kleinster möglicher Instanzgrössen, regelmässiges `terraform destroy`, Prüfung Studenten-Credits. | N. Stevic      | Offen  |
| R4 | Hoher Debugging-Aufwand (Terraform, Helm, CI/CD)         | M                                  | H                               | H                  | Inkrementelles Testen, Nutzung von `terraform plan/validate`, `helm lint/template`, GitHub Actions Debugging-Optionen, systematisches Logging. | N. Stevic      | Offen  |
| R5 | Komplexität des Secrets Managements über gesamten Workflow | M                                  | H                               | H                  | Einsatz von GitHub Actions OIDC für Cloud-Authentifizierung, Kubernetes Secrets, Least Privilege Prinzip, Dokumentation des Ansatzes.              | N. Stevic      | Offen  |
*(Diese Risikomatrix wird bei Bedarf im Laufe des Projekts aktualisiert.)*

### 2.5 Stakeholder und Kommunikation
Die primären Stakeholder dieser Semesterarbeit sind:

*   **Student (Durchführender):** Nenad Stevic
*   **Experte Projektmanagement:** Corrado Parisi (TBZ)
*   **Experte Fachliches Modul (IaC):** Armin Dörzbach (TBZ)

Die Kommunikation erfolgt primär über den dafür vorgesehenen MS Teams Kanal. Die im Ablaufplan der TBZ definierten Einzelbesprechungen dienen als formelle Feedback- und Abstimmungstermine. Darüber hinaus wird bei Bedarf proaktiv der Kontakt zu den Experten gesucht. Der aktuelle Projektstand ist jederzeit über das GitHub Repository einsehbar. Wichtige Entscheidungen oder Änderungen am Scope werden mit den Experten abgestimmt und dokumentiert.
