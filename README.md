# Semesterarbeit: End-to-End CI/CD-Pipeline mit Terraform, Helm und GH Actions für Nextcloud auf Kubernetes (AWS EKS)

![Header Bild](assets/header.png)

**Student:** Nenad Stevic<br>
**TBZ Lehrgang dipl. Informatiker/in HF - 3. Semester**<br>
**Abgabedatum:** 09.07.2025

# Inhaltsverzeichnis

- [1. Einleitung](#1-einleitung)
    - [1.1 Problemstellung](#11-problemstellung)
    - [1.2 Projektziele](#12-projektziele)
    - [1.3 Vorgehensweise](#13-vorgehensweise)
    - [1.4 Zusammenfassung](#14-zusammenfassung)
    - [1.5 Scope](#15-scope)
- [2. Projektmanagement](#2-projektmanagement)
    - [2.1 Scrum](#21-scrum)
        - [2.1.1 Rollen](#211-rollen)
        - [2.1.2 Artefakte](#212-artefakte)
        - [2.1.3 Zeremonien](#213-zeremonien)
        - [2.1.4 Definition of Done (DoD)](#214-definition-of-done-dod)
        - [2.1.5 Definition of Ready (DoR)](#215-definition-of-ready-dor)
    - [2.2 Projektplanung](#22-projektplanung)
        - [2.2.1 Der Grobplan](#221-der-grobplan)
        - [2.2.2 Strukturierung](#222-strukturierung)
        - [2.2.3 Von Epics zu Sprints: Die iterative Feinplanung](#223-von-epics-zu-sprints-die-iterative-feinplanung)
    - [2.3 Sprint-Durchführung und Dokumentation](#23-sprint-durchführung-und-dokumentation)
    - [2.4 Risiken](#24-risiken)
    - [2.5 Stakeholder und Kommunikation](#25-stakeholder-und-kommunikation)
- [3. Evaluation](#3-evaluation)
    - [3.1 Evaluation von Lösungen](#31-evaluation-von-lösungen)
        - [3.1.1 Cloud Provider (AWS)](#311-cloud-provider-aws)
        - [3.1.2 Container Orchestrierung (Kubernetes - EKS)](#312-container-orchestrierung-kubernetes---eks)
        - [3.1.3 Infrastructure as Code (Terraform)](#313-infrastructure-as-code-terraform)
        - [3.1.4 Application Configuration Management (Helm)](#314-application-configuration-management-helm)
        - [3.1.5 CI/CD Werkzeug (GitHub Actions)](#315-cicd-werkzeug-github-actions)
        - [3.1.6 Entwicklungswerkzeuge und Versionen](#316-entwicklungswerkzeuge-und-versionen)
    - [3.2 Theoretische Grundlagen](#32-theoretische-grundlagen)
        - [3.2.1 Infrastructure as Code (IaC) - Prinzipien](#321-infrastructure-as-code-iac---prinzipien)
        - [3.2.2 CI/CD - Konzepte und Phasen](#322-cicd---konzepte-und-phasen)
        - [3.2.3 Kubernetes - Kernkomponenten](#323-kubernetes---kernkomponenten)
        - [3.2.4 Helm - Charts, Releases, Templates](#324-helm---charts-releases-templates)
        - [3.2.5 Nextcloud auf Kubernetes - Architekturüberlegungen](#325-nextcloud-auf-kubernetes---architekturüberlegungen)
    - [3.3 System-Design / Architektur](#33-system-design--architektur)
        - [3.3.1 Logische Gesamtarchitektur](#331-logische-gesamtarchitektur)
        - [3.3.2 AWS Netzwerkarchitektur (VPC Detail)](#332-aws-netzwerkarchitektur-vpc-detail)
        - [3.3.3 Komponenten und Datenflüsse](#333-komponenten-und-datenflüsse)
        - [3.3.4 AWS EKS Architektur Detail](#334-aws-eks-architektur-detail)
- [4. Implementierung und Technische Umsetzung](#4-implementierung-und-technische-umsetzung)
    - [4.1 Infrastruktur-Provisionierung mit Terraform](#41-infrastruktur-provisionierung-mit-terraform)
        - [4.1.1 Terraform Code-Struktur und Module](#411-terraform-code-struktur-und-module)
        - [4.1.2 Provisionierung des Netzwerks (VPC)](#412-provisionierung-des-netzwerks-vpc)
        - [4.1.3 Provisionierung des EKS Clusters und der ECR](#413-provisionierung-des-eks-clusters-und-der-ecr)
        - [4.1.4 Provisionierung der RDS Datenbank und IAM-Rollen](#414-provisionierung-der-rds-datenbank-und-iam-rollen)
        - [4.1.5 Secrets Management für Terraform](#415-secrets-management-für-terraform)
    - [4.2 Nextcloud Helm Chart Entwicklung](#42-nextcloud-helm-chart-entwicklung)
        - [4.2.1 Helm Chart Struktur](#421-helm-chart-struktur)
        - [4.2.2 Wichtige Templates](#422-wichtige-templates)
        - [4.2.3 Konfigurationsmöglichkeiten über `values.yaml`](#423-konfigurationsmöglichkeiten-über-valuesyaml)
    - [4.3 CI/CD Pipeline mit GitHub Actions](#43-cicd-pipeline-mit-github-actions)
        - [4.3.1 Workflow-Definition](#431-workflow-definition)
        - [4.3.2 Authentifizierung gegenüber AWS (OIDC)](#432-authentifizierung-gegenüber-aws-oidc)
        - [4.3.3 Integrationsschritte (Terraform, Helm)](#433-integrationsschritte-terraform-helm)
        - [4.3.4 Secrets Management in der Pipeline](#434-secrets-management-in-der-pipeline)
    - [4.4 Installation und Inbetriebnahme der Gesamtlösung](#44-installation-und-inbetriebnahme-der-gesamtlösung)
        - [4.4.1 Voraussetzungen](#441-voraussetzungen)
        - [4.4.2 Klonen des Repositorys](#442-klonen-des-repositorys)
        - [4.4.3 Konfiguration von Umgebungsvariablen/Secrets](#443-konfiguration-von-umgebungsvariablensecrets)
        - [4.4.4 Ausführen der Pipeline / Manuelle Schritte](#444-ausführen-der-pipeline--manuelle-schritte)
        - [4.4.5 Zugriff auf die Nextcloud Instanz](#445-zugriff-auf-die-nextcloud-instanz)
    - [4.5 Anpassung von Software / Konfiguration von Geräten](#45-anpassung-von-software--konfiguration-von-geräten)
        - [4.5.1 Nextcloud-spezifische Konfigurationen (via Helm)](#451-nextcloud-spezifische-konfigurationen-via-helm)
        - [4.5.2 Wichtige AWS Service-Konfigurationen](#452-wichtige-aws-service-konfigurationen)
- [5. Testing und Qualitätssicherung](#5-testing-und-qualitätssicherung)
    - [5.1 Teststrategie](#51-teststrategie)
        - [5.1.1 Statische Code-Analyse (Linting)](#511-statische-code-analyse-linting)
        - [5.1.2 Validierung der Infrastruktur-Konfiguration](#512-validierung-der-infrastruktur-konfiguration)
        - [5.1.3 Manuelle Funktionstests der Nextcloud Instanz](#513-manuelle-funktionstests-der-nextcloud-instanz)
        - [5.1.4 End-to-End Tests der CI/CD Pipeline](#514-end-to-end-tests-der-cicd-pipeline)
    - [5.2 Testfälle und Protokolle](#52-testfälle-und-protokolle)
        - [5.2.1 Nachweise der Testergebnisse](#521-nachweise-der-testergebnisse)
- [6. Projektdokumentation (Zusammenfassung)](#6-projektdokumentation-zusammenfassung)
    - [6.1 Verzeichnisse und Zusammenfassungen](#61-verzeichnisse-und-zusammenfassungen)
    - [6.2 Quellenangaben und verwendete Werkzeuge](#62-quellenangaben-und-verwendete-werkzeuge)
- [7. Reflexion und Erkenntnisse](#7-reflexion-und-erkenntnisse)
    - [7.1 Abgleich von Theorie und Praxis](#71-abgleich-von-theorie-und-praxis)
    - [7.2 Eigene Erfahrungen und persönlicher Lernprozess](#72-eigene-erfahrungen-und-persönlicher-lernprozess)
    - [7.3 Bewertung der eigenen Lösung und Verbesserungspotenzial](#73-bewertung-der-eigenen-lösung-und-verbesserungspotenzial)
    - [7.4 Handlungsempfehlungen für das weitere Vorgehen](#74-handlungsempfehlungen-für-das-weitere-vorgehen)
- [8. Anhänge](#8-anhänge)
    - [8.1 Verwendete Scrum-Vorlagen (Templates)](#81-verwendete-scrum-vorlagen-templates)
    - [8.2 Weitere Referenzen](#82-weitere-referenzen)
    - [8.3 Link zum GitHub Repository](#83-link-zum-github-repository)
    - [8.4 Link zum GitHub Project Board](#84-link-zum-github-project-board)

---

## 1. Einleitung

*In diesem Kapitel wird das Projekt, die Kriterien und die Vorgehensweise genauer unter die Lupe genommen. Damit wird
ein Überblick über die geplante Arbeit geschaffen, was die Auswertung der Ergebnisse am Schluss vereinfachen soll.*

### 1.1 Problemstellung

Das Hosten und Verwalten von Webanwendungen mit Datenbankanbindung stellt in der heutigen IT-Welt mehrere
Herausforderungen dar. Mit High-Availability Infrastrukturen, welche heute in der Industrie weit verbreitet sind, muss
man deutlich mehr konfigurieren und beachten, als bei "Bare Metal" Servern vor einem Jahrzehnt. Wie kann man mehrere
Instanzen einer Applikation laufen lassen, und trotzdem Datenintegrität auf allen Replicas gewährleisten? Wie kann man
diese verschiedenen Komponenten und Abhängigkeiten erfolgreich konfigurieren, ohne dass Fehler oder Unachtsamkeiten
unterlaufen?

Diese Fragen oder Probleme sind welche, die wir auch in meinem Betrieb begegnen, besonders wenn es darum geht,
Webanwendungen für unsere Kunden zu hosten. Deswegen ist dieses Thema äusserst interessant und motivierend,
Lösungsansätze zu finden, und Erfahrungen zu sammeln die einen messbaren Beitrag zum Berufsleben bringen werden.

### 1.2 Projektziele

Die Ziele der Arbeit wurden nach dem SMART-Prinzip definiert:

1. **Automatisierte Infrastruktur Verwaltung via IaC (Terraform):**<br>
   Die erforderliche Cloud-Infrastruktur auf AWS – bestehend aus einem Elastic Kubernetes Service (EKS) Cluster, einem
   Relational Database Service (RDS) und einer Elastic Container Registry (ECR) – wird vollständig mittels
   Terraform-Code automatisiert erstellt und versioniert. Das Ergebnis ist eine betriebsbereite, aber initial leere
   Kubernetes- und Datenbankumgebung.<br>
   **Deadline: Ende Sprint 3** *(VPC in Sprint 1, EKS/ECR in Sprint 2, RDS/IAM in Sprint 3)*
2. **Entwicklung eines funktionalen Nextcloud Helm Charts:**<br>
   Ein eigenständiges, funktionales Helm Chart für die Nextcloud-Anwendung entwickeln. Dieses Chart ermöglicht die
   Konfiguration von Kubernetes-Deployments, Services, Persistent Volume Claims (PVCs), Datenbankverbindungs-Secrets und
   weiterer Anwendungsparameter über eine `values.yaml`-Datei. Die Funktionalität wird durch `helm template` und
   `helm install` (lokal oder auf EKS) verifiziert.<br>
   **Deadline: Ende Sprint 4**
3. **Implementierung einer CI/CD-Pipeline mit GitHub Actions:**<br>
   Eine automatisierte Continuous Integration / Continuous Deployment (CI/CD) Pipeline unter Verwendung von GitHub
   Actions einrichten. Diese Pipeline wird bei Änderungen im Git-Repository (z.B. Aktualisierung des Nextcloud-Images
   oder der Helm-Chart-Konfiguration) den vollständigen Deployment-Prozess auslösen. Dies beinhaltet optionale Schritte
   wie Image Build/Push und Helm Linting/Packaging.<br>
   **Deadline: Ende Sprint 5**
4. **Bereitstellung einer funktionalen Nextcloud Instanz (via CI/CD-Pipeline):**<br>
   Eine Nextcloud-Instanz mittels der CI/CD-Pipeline auf dem Kubernetes-Cluster bereitstellen. Die Instanz ist extern
   erreichbar, erfolgreich mit der provisionierten Datenbank verbunden und weist Persistenz für Benutzerdaten auf. Dies
   wird durch einen erfolgreichen Login sowie exemplarische Datei-Upload- und Download-Vorgänge demonstriert.<br>
   **Deadline: Ende Sprint 5** *(Manuelles Test-Deployment in Sprint 3, finales Deployment via Pipeline in Sprint 5)*
5. **Umfassende Dokumentation und Code-Bereitstellung:**<br>
   Bis zum Projektende sind die Systemarchitektur, die Terraform-Module, das Helm Chart, die CI/CD-Pipeline, getroffene
   Sicherheitsüberlegungen sowie der gesamte Setup- und Deployment-Prozess detailliert dokumentiert. Der gesamte
   Quellcode (Terraform, Helm, GitHub Actions Workflows) ist in einem Git-Repository versioniert und für die Experten
   zugänglich.<br>
   **Deadline: Ende Sprint 6 (zur Projektabgabe)**

Was diese Arbeit besonders attraktiv macht, ist die hohe Relevanz der verwendeten Technologien und Prinzipien im
beruflichen Alltag eines DevOps Engineers. Der Zeitrahmen von ca. 50 Stunden ist realistisch, vor allem durch vorhandene
Erfahrung in diesem Bereich.

### 1.3 Vorgehensweise

Die geplante Lösung zielt auf die Erstellung einer vollständigen End-to-End-Automatisierung für das Hosten von Nextcloud
auf einem Kubernetes-Cluster (AWS EKS) ab. Der gesamte Prozess basiert auf dem "Infrastructure as Code" (IaC) Prinzip,
bei dem alle Konfigurationen und Komponenten als Code definiert und versioniert werden.

* **Infrastruktur-Provisionierung:** Die Cloud-Infrastruktur (EKS-Cluster, Datenbank, Container Registry etc.) wird
  mittels **Terraform** deklariert und verwaltet.
* **Anwendungs-Deployment auf Kubernetes:** Die Nextcloud-Anwendung selbst wird mithilfe eines eigens entwickelten *
  *Helm Charts** auf dem Kubernetes-Cluster konfiguriert und bereitgestellt. Helm dient hierbei als Paketmanager für
  Kubernetes-Anwendungen.
* **Automatisierung des Lifecycles:** Der gesamte Prozess von der Code-Änderung bis zum Deployment wird durch eine *
  *CI/CD-Pipeline, implementiert mit GitHub Actions**, automatisiert.
* **Methodisches Vorgehen:** Die Umsetzung erfolgt nach agilen Prinzipien, angelehnt an das **Scrum-Framework** (in
  einer auf die Einzelarbeit angepassten Form). Dies beinhaltet eine iterative Entwicklung, regelmässige Reflexion und
  eventuelle Anpassung der Planung, um Flexibilität sicherzustellen. Eine inhaltlich aktuelle Dokumentation begleitet
  den gesamten Prozess.

### 1.4 Zusammenfassung

Diese Semesterarbeit realisiert eine durchgängig automatisierte Pipeline zur Bereitstellung und Verwaltung der
Webanwendung _Nextcloud_ auf einem Kubernetes-Cluster (AWS EKS). Die Lösung nutzt Terraform für die Definition der
Cloud-Infrastruktur, Helm für die Paketierung und Konfiguration von Nextcloud auf Kubernetes sowie GitHub Actions für
die CI/CD-Automatisierung. Das Ziel ist es, eine robuste, wiederholbare und moderne Bereitstellungsmethode zu
implementieren und dabei Kernkompetenzen im Bereich DevOps und Cloud-native Technologien zu vertiefen.

### 1.5 Scope

Zur Sicherstellung der Realisierbarkeit innerhalb des vorgegebenen Zeitrahmens werden folgende Aspekte klar definiert
und abgegrenzt:

* **Im Projektumfang enthalten (In Scope):**
    * Automatisierte Erstellung der Kern-Infrastrukturkomponenten (EKS, RDS, ECR) mittels Terraform.
    * Entwicklung eines funktionalen Helm Charts für Nextcloud, das grundlegende Konfigurationen, Persistenz und
      Datenbankanbindung abdeckt.
    * Implementierung einer CI/CD-Pipeline mit GitHub Actions für das Deployment des Helm Charts auf dem EKS-Cluster.
    * Sichere Handhabung von Secrets für Datenbankzugangsdaten und Pipeline-Authentifizierung.
    * Bereitstellung einer funktionierenden, extern erreichbaren Nextcloud-Instanz mit Datenpersistenz.
    * Dokumentation der gewählten Architektur, der Konfigurationen und des Inbetriebnahme-Prozesses.
* **Nicht im Projektumfang enthalten (Out of Scope):**
    * Implementierung hochkomplexer oder anwendungsspezifischer Nextcloud-Konfigurationen (z.B. Integration externer
      Authentifizierungssysteme, spezifische Nextcloud-Apps über die Basisinstallation hinaus).
    * Entwicklung und Implementierung automatisierter Backup- und Restore-Strategien für Nextcloud-Daten oder die
      Datenbank.
    * Ausgefeilte Monitoring- und Logging-Lösungen für die Nextcloud-Instanz, die über die Standardfunktionalitäten von
      Kubernetes und AWS hinausgehen.
    * Detaillierte Performance-Optimierungen und umfangreiche Lasttests.
    * Unterstützung für Multi-Cloud-Szenarien oder andere Kubernetes-Distributionen als AWS EKS.
    * Erstellung eines benutzerdefinierten Nextcloud Docker-Images (Verwendung des offiziellen Images, sofern nicht
      zwingend anders erforderlich).
    * Tiefgehende Betrachtung von Compliance-Anforderungen oder rechtlichen Aspekten, die über allgemeine Best Practices
      der IT-Sicherheit hinausgehen.

---

## 2. Projektmanagement

*In diesem Kapitel wird das methodische Vorgehen zur Planung, Durchführung und Steuerung des Projekts detailliert
erläutert. Der Fokus liegt auf der konsequenten Anwendung agiler Prinzipien nach dem Scrum-Framework, um eine iterative
Entwicklung, kontinuierliche Verbesserung und transparente Nachvollziehbarkeit des Projektfortschritts zu
gewährleisten.*

### 2.1 Scrum

Für die Durchführung dieser Semesterarbeit wird das agile Framework **Scrum** angewandt. Scrum ermöglicht eine flexible
Reaktion auf sich ändernde Anforderungen, fördert die konstante Lieferung von Fortschritten und legt einen starken Fokus
auf Transparenz. Obwohl Scrum primär für Teams konzipiert ist, werden die Prinzipien und Praktiken hier konsquent in
einer Einzelarbeit simuliert. Scrum ist heutzutage der Standard im IT-Umfeld, da es eine strukturierte Herangehensweise
an komplexe Projekte bietet und die iterative Entwicklung des Produkts unterstützt.

#### Product Goal

Bis zum 09.07.2025 eine vollautomatisierte End-to-End CI/CD-Pipeline mit Terraform, Helm und GitHub Actions zu
implementieren, die eine funktionale, extern erreichbare und persistent datenspeichernde Nextcloud-Instanz auf einem AWS
EKS Kubernetes-Cluster bereitstellt und verwaltet. Die gesamte Lösung ist als Infrastructure as Code versioniert und der
Entwicklungsprozess folgt konsequent den Scrum-Prinzipien.

#### 2.1.1 Rollen

Im Rahmen dieser Semesterarbeit werden alle Scrum-Rollen durch den Studierenden (Nenad Stevic) wahrgenommen. Die klare
Abgrenzung und Erfüllung der jeweiligen Verantwortlichkeiten ist für die Integrität der Arbeit entscheidend:

* **Product Owner (PO):** Verantwortlich für die Definition der Produktvision (basierend auf dem Einreichungsformular
  und den Projektzielen) sowie der Erstellung und Priorisierung des Product Backlogs. Der PO stellt sicher, dass die
  entwickelten Inkremente den Anforderungen entsprechen.
* **Scrum Master (SM):** Verantwortlich für die Einhaltung und korrekte Anwendung des Scrum-Prozesses. Der SM moderiert
  die Scrum Events, beseitigt Hindernisse (Impediments), coacht den Entwicklungsprozess und stellt sicher, dass das
  Team (in diesem Fall der Studierende als Entwickler) effektiv arbeiten kann.
* **Development Team (Dev-Team):** Verantwortlich für die Umsetzung der im Sprint Backlog ausgewählten Product Backlog
  Items (PBIs) in ein funktionsfähiges Inkrement. Das Dev-Team organisiert sich selbst und ist für die technische
  Qualität der Lieferung zuständig.

#### 2.1.2 Artefakte

Die folgenden Scrum Artefakte werden in diesem Projekt eingesetzt:

* **Product Backlog:** Eine dynamische, geordnete Liste aller bekannten Anforderungen, Funktionalitäten, Verbesserungen
  und Fehlerbehebungen, die für das Produkt erforderlich sind. Das Product Backlog wird
  als [GitHub Project Board]([https://github.com/users/Stevic-Nenad/projects/1]) geführt und kontinuierlich gepflegt.
  Jedes Product Backlog Item (PBI) wird als User Story formuliert und enthält Akzeptanzkriterien.
* **Sprint Backlog:** Eine Auswahl von Product Backlog Items, die für einen spezifischen Sprint committet wurden,
  ergänzt um einen Plan zur Lieferung des Produktinkrements und zur Erreichung des Sprint-Ziels. Das Sprint Backlog wird
  ebenfalls auf dem GitHub Project Board visualisiert (z.B. in einer "Sprint Backlog" oder "To Do" Spalte für den
  aktuellen Sprint).
* **Increment:** Die Summe aller im aktuellen Sprint fertiggestellten Product Backlog Items, integriert mit den
  Inkrementen aller vorherigen Sprints. Jedes Inkrement muss potenziell auslieferbar sein und der Definition of Done
  entsprechen. Das Inkrement besteht aus dem lauffähigen Code (Terraform, Helm, GitHub Actions) und der aktualisierten
  Dokumentation.

#### 2.1.3 Zeremonien

Alle Scrum Zeremonien werden zeitlich begrenzt (Time-boxed) und konsequent durchgeführt, um den Inspektions- und
Adaptionszyklus von Scrum zu leben:

* **Sprint Planning:** Zu Beginn jedes Sprints wird das Sprint Planning durchgeführt. Der Product Owner (PO) präsentiert
  die priorisierten Product Backlog Items. Das Development Team (Dev-Team) wählt die Items aus, die es im Sprint
  umsetzen kann, definiert das Sprint-Ziel und plant die konkreten Aufgaben zur Erreichung dieses Ziels.
* **Daily Scrum:** Ein tägliches, maximal 15-minütiges Meeting des Dev-Teams (und des SM), um den Fortschritt in
  Richtung Sprint-Ziel zu synchronisieren und Impediments zu identifizieren. Es werden die drei Fragen beantwortet: Was
  wurde gestern erreicht? Was wird heute getan? Gibt es Hindernisse?
* **Sprint Review:** Am Ende jedes Sprints wird das Inkrement den Stakeholdern (hier den Fachexperten und dem
  Projektmanagement-Experten, repräsentiert durch den PO in der Vorbereitung) präsentiert. Es wird Feedback eingeholt,
  und das Product Backlog wird bei Bedarf angepasst.
* **Sprint Retrospective:** Nach dem Sprint Review und vor dem nächsten Sprint Planning reflektiert das Scrum Team (PO,
  SM, Dev-Team) den vergangenen Sprint. Ziel ist es, den Prozess kontinuierlich zu verbessern, indem positive Aspekte
  identifiziert und Massnahmen zur Optimierung für den nächsten Sprint abgeleitet werden.
* **Backlog Refinement (Product Backlog Grooming):** Obwohl nicht immer als formale Zeremonie bei Einzelarbeiten
  durchgeführt, wird im Laufe jedes Sprints kontinuierlich Zeit für das Product Backlog Refinement eingeplant. Dies
  beinhaltet das Detaillieren und Schätzen von User Stories für kommende Sprints sowie das ggf. Aufteilen grosser
  Stories, um das Product Backlog stets in einem "ready" Zustand zu halten.
  Die detaillierten Protokolle und Ergebnisse jedes Scrum Events werden im
  Abschnitt [2.3 Sprint-Durchführung und Dokumentation](#23-sprint-durchführung-und-dokumentation) für den jeweiligen
  Sprint dokumentiert. Vorlagen für diese Protokolle finden sich
  im [Anhang 8.1](#81-verwendete-scrum-vorlagen-templates).

#### 2.1.4 Definition of Done (DoD)

Die Definition of Done (DoD) ist ein gemeinsames Verständnis darüber, wann ein Product Backlog Item als "fertig" gilt
und somit Teil des Inkrements werden kann. Für diese Semesterarbeit gilt folgende initiale Definition of Done (diese
kann im Laufe des Projekts angepasst und erweitert werden):

* Der Code für das PBI wurde geschrieben und ist auf einem Feature-Branch committet.
* Ein Pull Request (PR) wurde erstellt, vom Entwickler selbst sorgfältig anhand der Akzeptanzkriterien und Anforderungen
  geprüft (Self-Review) und anschliessend in den `main`-Branch gemerged.
* Alle automatisierten Prüfungen (sofern bereits implementiert, z.B. `terraform validate`, `helm lint`) sind erfolgreich
  durchlaufen.
* Infrastrukturänderungen wurden erfolgreich mittels `terraform apply` angewendet und die Funktionalität wurde
  verifiziert.
* Anwendungs-Deployments mittels `helm upgrade --install` waren erfolgreich und die Kernfunktionalität der Anwendung
  wurde überprüft.
* Alle Akzeptanzkriterien des zugehörigen User Story sind erfüllt.
* Die relevante Dokumentation (dieses README, Diagramme, Setup-Anleitungen) wurde aktualisiert, um die Änderungen
  widerzuspiegeln.
* Das PBI wurde auf dem GitHub Project Board in die Spalte "Done" verschoben.

#### 2.1.5 Definition of Ready (DoR)

Die Definition of Ready (DoR) beschreibt, wann ein Product Backlog Item (PBI) – in diesem Projekt eine User Story –
bereit ist, in ein Sprint Planning Meeting aufgenommen und potenziell für einen Sprint ausgewählt zu werden. Sie stellt
sicher, dass die User Story ausreichend vorbereitet und verstanden ist, um eine effiziente Planung und Umsetzung im
Sprint zu ermöglichen.

Für diese Semesterarbeit gilt folgende initiale Definition of Ready:

* **Klar formuliert:** Das PBI ist als User Story im Format "Als [Rolle] möchte ich [Ziel], damit [Nutzen]" formuliert.
* **Verstanden:** Die User Story ist vom Development Team (Student in Entwicklerrolle) inhaltlich verstanden.
  Unklarheiten wurden im Vorfeld (z.B. im Backlog Refinement) geklärt.
* **Akzeptanzkriterien definiert:** Klare, spezifische und testbare Akzeptanzkriterien sind für die User Story
  formuliert.
* **Abhängigkeiten bekannt:** Mögliche Abhängigkeiten zu anderen User Stories oder externen Faktoren sind identifiziert
  und soweit möglich geklärt.
* **Geschätzt:** Die User Story wurde vom Development Team (Student) mit Story Points (oder einer anderen vereinbarten
  Einheit) geschätzt.
* **Klein genug (INVEST - Small):** Die User Story ist so zugeschnitten, dass sie realistischerweise innerhalb eines
  Sprints vom Development Team (Student) abgeschlossen werden kann. Ist sie zu gross, wurde sie im Backlog Refinement
  bereits in kleinere, handhabbare User Stories aufgeteilt.
* **Wertstiftend (INVEST - Valuable):** Die User Story liefert einen erkennbaren Wert für das Produkt oder das
  Projektziel.
* **Testbar (INVEST - Testable):** Es ist klar, wie die Erfüllung der User Story und ihrer Akzeptanzkriterien überprüft
  werden kann.
* **Priorisiert:** Die User Story wurde vom Product Owner (Student in PO-Rolle) im Product Backlog priorisiert.

### 2.2 Projektplanung

*Eine gute Planung ist das A und O, auch wenn man agil unterwegs ist. In diesem Kapitel wird behandelt, wie die Roadmap
zur fertigen Nextcloud-Pipeline auszusehen hat.*

#### 2.2.1 Der Grobplan

Den zeitlichen Rahmen für das Projekt geben die offiziellen Termine der TBZ vor, insbesondere die Einzelbesprechungen
und der finale Abgabetermin. Basierend darauf und auf einer ersten Schätzung der Arbeitsaufwände für die
Hauptkomponenten des Projekts wurde folgender visueller Zeitplan (Gantt-Diagramm) erstellt. Er zeigt die übergeordneten
Projektphasen und die geplanten Sprints im Überblick:

![gantt](assets/gantt.svg)
Gantt Diagramm
*(Stand: 09.05.2025 – Dieser Plan dient als Orientierung und wird iterativ im Detail verfeinert)*

#### 2.2.2 Strukturierung

Um die in [Kapitel 1.2](#12-projektziele) definierten Projektziele greifbar zu machen und die Arbeit sinnvoll zu
bündeln, wurden grössere thematische Arbeitspakete, sogenannte **Epics**, definiert. Jedes Epic repräsentiert einen
wesentlichen Baustein auf dem Weg zum fertigen Produkt und kann sich über mehrere Sprints erstrecken.

Die folgenden Epics bilden das Rückgrat des Product Backlogs für dieses Projekt:

* **`EPIC-PROJMGMT`: Projektinitialisierung & Durchgängige Scrum-Prozessdokumentation**
    * *Ziel:* Schaffung der organisatorischen und dokumentarischen Grundlagen (Repository, `README.md`, Project Board)
      und Sicherstellung der korrekten, nachvollziehbaren Anwendung des Scrum-Frameworks über die gesamte Projektdauer.
* **`EPIC-TF-NET`: AWS Netzwerk-Infrastruktur mit Terraform**
    * *Ziel:* Aufbau eines sicheren und skalierbaren Fundaments in der AWS Cloud mittels Terraform, inklusive VPC,
      Subnetzen, Routing und Internet-Anbindung.
* **`EPIC-TF-K8S`: Kubernetes (EKS) Cluster & Container Registry (ECR) mit Terraform**
    * *Ziel:* Automatisierte Bereitstellung eines managed Kubernetes-Clusters (AWS EKS) und einer privaten Container
      Registry (AWS ECR) mittels Terraform.
* **`EPIC-TF-DB-IAM`: Datenbank (RDS) & zugehörige IAM-Rollen mit Terraform**
    * *Ziel:* Automatisierte Provisionierung einer managed relationalen Datenbank (AWS RDS) und der notwendigen
      IAM-Rollen für den Zugriff durch Anwendungen und Kubernetes-Komponenten.
* **`EPIC-NC-DEPLOY`: Nextcloud Grundlagen (Manuelles Deployment, Persistenz-Konfiguration)**
    * *Ziel:* Manuelle Installation und Konfiguration von Nextcloud auf dem EKS-Cluster, um die grundlegende
      Funktionalität, Datenbankanbindung und Datenpersistenz zu validieren, bevor die Automatisierung mit Helm erfolgt.
* **`EPIC-HELM`: Nextcloud Helm Chart Entwicklung**
    * *Ziel:* Erstellung eines eigenen, robusten und konfigurierbaren Helm Charts für die Nextcloud-Anwendung zur
      Vereinfachung des Deployments und Managements auf Kubernetes.
* **`EPIC-CICD`: CI/CD Pipeline (GitHub Actions) Implementierung**
    * *Ziel:* Aufbau einer vollautomatisierten CI/CD-Pipeline mit GitHub Actions, die Änderungen am Code oder an der
      Konfiguration erkennt und Nextcloud automatisch auf dem EKS-Cluster bereitstellt oder aktualisiert.
* **`EPIC-ABSCHLUSS`: Testing, Finale Dokumentation & Projektabschluss**
    * *Ziel:* Umfassendes Testen der Gesamtlösung, Finalisierung der Projektdokumentation gemäss den Vorgaben und
      Vorbereitung der Abschlusspräsentation.

Alle Epics sind als Issues mit dem Label `epic` auf
dem [GitHub Project Board]([https://github.com/users/Stevic-Nenad/projects/1]) erfasst.

#### 2.2.3 Von Epics zu Sprints: Die iterative Feinplanung

Mit der groben Roadmap (Gantt) und den thematischen Wegweisern (Epics) erfolgt die detaillierte Planung iterativ für
jeden einzelnen Sprint im **Sprint Planning Meeting**. Für jeden Sprint wird ein klares **Sprint-Ziel** definiert. Aus
den für dieses Ziel relevanten Epics werden dann konkrete **User Stories** abgeleitet oder ausgewählt. Diese User
Stories beschreiben eine kleine, wertstiftende Funktionalität aus Nutzersicht und werden mit spezifischen *
*Akzeptanzkriterien** versehen.

Die User Stories für den jeweils aktuellen Sprint bilden das **Sprint Backlog**. Alle weiteren, noch nicht für einen
spezifischen Sprint eingeplanten User Stories verbleiben im **Product Backlog** und werden kontinuierlich durch den
Product Owner (also mich) gepflegt, priorisiert und verfeinert (Backlog Refinement).

Dieser Ansatz – vom Groben ins Feine – stellt sicher, dass das Projekt einerseits eine klare Richtung hat, andererseits
aber die Flexibilität bewahrt wird, auf Erkenntnisse aus vorherigen Sprints reagieren und die Planung anpassen zu
können. Es wird also **nicht das gesamte Projekt mit allen User Stories für alle sechs Sprints im Voraus bis ins letzte
Detail durchgeplant.** Vielmehr wird der Fokus auf eine exzellente Planung des unmittelbar bevorstehenden Sprints
gelegt, während das Product Backlog eine Vorschau auf mögliche Inhalte der Folgesprints bietet.

Die konkrete Umsetzung und Dokumentation der einzelnen Sprints ist im nachfolgenden
Abschnitt [2.3 Sprint-Durchführung](#23-sprint-durchführung) detailliert beschrieben.

### 2.3 Sprint-Durchführung und Dokumentation

*Dieser Abschnitt fasst die Durchführung und die wesentlichen Ergebnisse jedes Sprints zusammen. Jeder Sprint folgt dem
definierten Scrum-Zyklus (Planning, Daily Scrums, Increment-Erstellung, Review, Retrospektive). Die detaillierte
Ausarbeitung der User Stories, ihrer Akzeptanzkriterien und die tägliche Aufgabenverfolgung erfolgen auf
dem [GitHub Project Board](https://github.com/users/Stevic-Nenad/projects/1/views/1). Die hier skizzierten Inhalte für
Sprints 2-6 sind vorläufig und werden im jeweiligen Sprint Planning Meeting finalisiert und committet.*

---

#### **Sprint 0: Bootstrap & Initialplanung**

* **Dauer:** 05. Mai 2025 - 09. Mai 2025 *(Datum ggf. anpassen, wenn Sprint 0 länger dauerte)*
* **Zugehöriges Epic (primär):** `EPIC-PROJEKT`
* **Sprint Planning (simuliert am 05.05.2025):** Basierend auf den Projektanforderungen und den TBZ-Vorgaben wurden das
  untenstehende Sprint-Ziel und die folgenden User Stories als Sprint Backlog für Sprint 0 committet, um die
  Projektbasis zu schaffen.
* **Sprint-Ziel (committet für Sprint 0):**
    * "Die grundlegende Projektinfrastruktur (Repository, Scrum-Board, initiale Dokumentation) ist etabliert, das
      Scrum-Rahmenwerk für das Projekt ist definiert und dokumentiert, und eine erste Grobplanung (Epics, Roadmap) sowie
      die Detailplanung für Sprint 1 sind vorhanden, um eine solide Basis für die erfolgreiche Durchführung der
      Semesterarbeit zu schaffen."
* **Sprint Backlog (committete User Stories für Sprint 0 – siehe
  auch [Sprint 0 auf GitHub Board](DEIN_LINK_ZUM_GITHUB_PROJECT_BOARD_HIER_ODER_FILTER_S0)):**
    * `Nextcloud#33`: GitHub Repository initialisieren
    * `Nextcloud#34`: Scrum-Rahmenwerk im README definieren
    * `Nextcloud#35`: Initiale Projekt- und Sprintplanung durchführen
    * `Nextcloud#36`: Initiale Risikoanalyse durchführen und dokumentieren
    * `Nextcloud#1`: GitHub Projekt-Board einrichten
    * `Nextcloud#3`: GitHub Issue-Vorlagen konfigurieren
* **Wichtigste Daily Scrum Erkenntnis / Impediment:**
    * Krankheitsbedingter Ausfall am 06. & 07.05. erforderte eine Priorisierung der Kernaufgaben für das Sprint-Ziel.
* **Erreichtes Inkrement / Ergebnisse (Stand 09.05.2025 oder aktuelles Enddatum Sprint 0):**
    * Projekt-Repository (`https://github.com/Stevic-Nenad/Nextcloud`) und `README.md` Grundstruktur mit initialen
      Planungsartefakten (Scrum-Prozess inkl. Product Goal, DoD/DoR; Epics-Liste; Risikomatrix; initiale
      Technologie-Evaluation und Architekturskizze in Kap. 3) sind erstellt und committet.
    * GitHub Project Board (https://github.com/users/Stevic-Nenad/projects/1/views/1) mit Spalten, Product Goal, Links
      zu DoD/DoR, Epic-Labels, User Story Vorlagen und initialen User Stories (für Sprint 0 und Product Backlog) ist
      eingerichtet. (Story Points Feld hinzugefügt und Stories initial geschätzt, falls `Nextcloud#Y` erledigt).
    * Sprint 1 ist detailliert geplant und die entsprechenden User Stories sind im Product Backlog angelegt.
* **Sprint Review (Kurzfazit, Stand 09.05.2025):**
    * Die Projektbasis ist erfolgreich gelegt und dokumentiert. Alle oben im Sprint Backlog für Sprint 0 committeten und
      als erledigt markierten User Stories wurden abgeschlossen. Grundlage für die erste Besprechung mit den Experten
      und den Start von Sprint 1 ist geschaffen.
* **Sprint Retrospektive (Wichtigste Aktion, Stand 09.05.2025 oder aktuelles Enddatum Sprint 0):**
    * Die Notwendigkeit von Puffern für Unvorhergesehenes in der Zeitplanung wurde durch den Ausfall verdeutlicht.
      Zukünftige Sprintplanungen werden versuchen, dies besser zu berücksichtigen. Die detaillierte Vorab-Planung der
      User Stories hat geholfen, trotz Zeitdruck den Überblick zu behalten. Klare Checklisten (wie die
      Akzeptanzkriterien) sind sehr hilfreich.

---

#### **Sprint 1: AWS Account, Lokale Umgebung & Terraform Basis-Netzwerk (VPC)**

* **Dauer:** ca. 10. Mai 2025 - 24. Mai 2025
* **Zugehörige Epics (Labels):** `EPIC-PROJEKT`, `EPIC-NETZ`
* **Sprint Planning (simuliert am 09.05.2025):**
    * **Teilnehmer (simuliert):** Nenad Stevic (als Product Owner, Scrum Master, Development Team).
    * **Kontext & Ziel des Plannings:** Nach erfolgreichem Abschluss von Sprint 0, in dem die Projektgrundlagen und das
      Scrum-Rahmenwerk etabliert wurden, zielt dieses erste "echte" Sprint Planning darauf ab, den ersten operativen
      Sprint zu definieren. Das Hauptziel ist es, ein klares Sprint-Ziel für Sprint 1 zu formulieren und die dafür
      notwendigen User Stories aus dem Product Backlog auszuwählen und zu committen.
    * **Input für das Planning:**
        * **Product Goal:** "Bis zum 09.07.2025 eine vollautomatisierte End-to-End CI/CD-Pipeline [...] bereitzustellen
          und zu verwalten."
        * **Priorisiertes Product Backlog:** Die User Stories aus den Epics `EPIC-PROJEKT` (Restarbeiten zur Umgebung)
          und `EPIC-TF-NET` (Netzwerk-Grundlagen) wurden im Vorfeld als am höchsten priorisiert identifiziert, da sie
          die Basis für alle weiteren technischen Arbeiten legen. Alle für dieses Planning relevanten User Stories
          erfüllten die Definition of Ready (DoR).
        * **Kapazität für Sprint 1:** Geschätzte Arbeitszeit für die kommenden zwei Wochen (ca. 10-12 Stunden effektive
          Projektarbeitszeit, unter Berücksichtigung anderer Verpflichtungen).
        * **Definition of Done (DoD):** Die in Sprint 0 definierte DoD dient als Richtlinie für den Abschluss jeder User
          Story.
        * **Erkenntnisse aus Sprint 0:** Die Notwendigkeit einer soliden Basis und einer klaren Umgebungskonfiguration
          wurde unterstrichen.
    * **Diskussion – Das "Warum" (Sprint-Ziel Formulierung):**
        * Der Product Owner (PO) betonte, dass ohne einen sicheren AWS-Zugang, eine funktionierende lokale
          Entwicklungsumgebung und eine grundlegende Netzwerkstruktur keine weiteren Infrastrukturkomponenten sinnvoll
          aufgesetzt werden können.
        * Das Development Team (Dev) stimmte zu und schlug vor, das Sprint-Ziel so zu formulieren, dass es diese
          fundamentalen Bausteine abdeckt, inklusive der wichtigen Aspekte der Kostenkontrolle (Tagging) und der
          zentralen State-Verwaltung für Terraform, um von Anfang an Best Practices zu folgen.
        * Gemeinsam wurde das folgende Sprint-Ziel formuliert und committet:
            * *"Ein sicherer AWS Account und eine lokale Entwicklungsumgebung sind eingerichtet, das Terraform Remote
              Backend ist konfiguriert, und ein grundlegendes, korrekt getaggtes AWS VPC-Netzwerk ist mittels Terraform
              Code definiert, versioniert und erfolgreich provisioniert."*
    * **Diskussion – Das "Was" (Auswahl der Sprint Backlog Items):**
        * Basierend auf dem Sprint-Ziel wurden die folgenden User Stories aus dem Product Backlog als essentiell für
          dessen Erreichung identifiziert:
            * `Nextcloud#37` (AWS Account sicher konfigurieren): Absolute Grundvoraussetzung.
            * `Nextcloud#38` (Lokale Entwicklungsumgebung einrichten): Notwendig für jegliche Code-Entwicklung und
              Tests.
            * `Nextcloud#7` (Kosten-Tags & initiale TF-Provider-Konfig): Wichtig, um von Beginn an Kostenkontrolle zu
              gewährleisten und eine saubere Terraform-Struktur aufzusetzen.
            * `Nextcloud#6` (Terraform Remote Backend konfigurieren): Kritisch für sichere und kollaborative
              State-Verwaltung, bevor komplexe Ressourcen erstellt werden.
            * `Nextcloud#5` (VPC mit Subnetzen via Terraform erstellen): Das Kernstück der Netzwerkinfrastruktur für
              diesen Sprint.
        * Die Aufwände für diese Stories wurden als realistisch für die Sprint-Kapazität eingeschätzt. Jede Story wurde
          kurz durchgegangen, um sicherzustellen, dass die Akzeptanzkriterien klar sind und keine unmittelbaren Blocker
          bestehen.
    * **Diskussion – Das "Wie" (Grobe Planung der Umsetzung):**
        * Das Dev-Team plant, mit der Einrichtung des AWS Accounts und der lokalen Umgebung zu beginnen, da diese die
          Basis für alle Terraform-Arbeiten bilden.
        * Anschliessend wird die initiale Terraform-Provider-Konfiguration mit den Tags und dem Remote Backend
          angegangen.
        * Zuletzt erfolgt die Implementierung des VPC-Netzwerks.
        * Es wurde beschlossen, die Terraform-Struktur von Anfang an modular im `src/terraform/` Verzeichnis aufzubauen.
        * Die Dokumentation (dieses README) wird parallel zur Umsetzung der User Stories aktualisiert.
    * **Commitment:** Das Development Team committet sich zum Erreichen des Sprint-Ziels und zur Fertigstellung der
      ausgewählten Sprint Backlog Items bis zum Ende des Sprints.
* **Sprint-Ziel (committet für Sprint 1):**
    * "Ein sicherer AWS Account und eine lokale Entwicklungsumgebung sind eingerichtet, das Terraform Remote Backend ist
      konfiguriert, und ein grundlegendes, korrekt getaggtes AWS VPC-Netzwerk ist mittels Terraform Code definiert,
      versioniert und erfolgreich provisioniert."
* **Sprint Backlog (committete User Stories für Sprint 1 – siehe
  auch [Sprint 1 auf GitHub Board](LINK_ZU_SPRINT_1_FILTER_ODER_BOARD)):**
    * `Nextcloud#37`: AWS Account sicher konfigurieren
    * `Nextcloud#38`: Lokale Entwicklungsumgebung einrichten
    * `Nextcloud#6`: Terraform Remote Backend konfigurieren
    * `Nextcloud#5`: VPC mit Subnetzen via Terraform erstellen
    * `Nextcloud#7`: Kosten-Tags für AWS Ressourcen definieren und initiale Terraform-Provider-Konfiguration erstellen
* **Wichtigste Daily Scrum Erkenntnis / Impediment:**
    * AWS Free Tier Limits mussten genau geprüft werden um Kosten zu vermeiden
    * Unterschiedliche Installationsmethoden je nach OS erforderten flexible Dokumentation
* **Erreichtes Inkrement / Ergebnisse:**
    * AWS Root Account mit MFA gesichert
    * IAM User "terraform-admin" mit AdministratorAccess Policy erstellt
    * AWS CLI Profile "nextcloud-project" konfiguriert für lokale Entwicklung
    * Access Keys sicher in ~/.aws/credentials gespeichert
    * AWS Budget von $20/Monat mit Benachrichtigungen bei 80% und 100% eingerichtet
    * AWS Region eu-central-1 als Standard festgelegt und in allen Konfigurationen verwendet
    * **Lokale Entwicklungsumgebung vollständig eingerichtet (User Story #38 ✓):**
      - AWS CLI v2.x mit Profile "nextcloud-project"
      - Terraform v1.9.x
      - kubectl v1.30.x
      - Helm v3.15.x
      - IntelliJ Ultimate mit allen Extensions
    * Alle Tools erfolgreich getestet und verifiziert
    * **Initiale Terraform-Konfiguration mit globaler Tagging-Strategie implementiert:**
        * Grundlegende Terraform-Dateistruktur (`versions.tf`, `provider.tf`, `variables.tf`, `locals.tf`) im
          Verzeichnis `src/terraform/` erstellt.
        * AWS Provider konfiguriert, inklusive der Festlegung einer Standardregion (`var.aws_region`).
        * Standard-Tags (`Projekt: Semesterarbeit-Nextcloud`, `Student: NenadStevic`, `ManagedBy: Terraform`) wurden als
          lokale Terraform-Variable (`local.common_tags`) definiert.
        * Diese Tags werden mittels des `default_tags` Blocks in der AWS Provider-Konfiguration automatisch an alle
          zukünftig erstellten, unterstützten Ressourcen propagiert.
        * `terraform init` erfolgreich ausgeführt, um Provider-Plugins zu laden.
        * Diese Konfiguration stellt die Basis für die nachfolgende Erstellung der VPC (User Story #5) dar, welche dann
          diese Tags automatisch erhalten wird. Die Sichtbarkeit der Tags auf Ressourcen wird im Rahmen der
          VPC-Erstellung verifiziert.
    * **Grundlegendes AWS VPC-Netzwerk via Terraform provisioniert (User Story #5 ✓):**
    * Konfigurierbarer VPC CIDR-Block (`10.0.0.0/16` als Standard).
    * Jeweils mindestens zwei öffentliche und zwei private Subnetze über zwei Availability Zones (`eu-central-1a`,
      `eu-central-1b` als Standard) erstellt.
    * Internet Gateway erstellt und der VPC zugeordnet.
    * Routing-Tabellen für öffentliche Subnetze mit Route zum IGW konfiguriert und mit den öffentlichen Subnetzen
      assoziiert.
    * Für Hochverfügbarkeit wurde **ein NAT Gateway pro Availability Zone** in den jeweiligen öffentlichen Subnetzen
      erstellt, jeweils mit einer zugehörigen Elastic IP.
    * **Dedizierte Routing-Tabellen für private Subnetze pro Availability Zone** konfiguriert. Jede dieser Tabellen
      leitet ausgehenden Internetverkehr (`0.0.0.0/0`) über das NAT Gateway in derselben AZ. Die privaten Subnetze sind
      entsprechend mit ihrer AZ-spezifischen privaten Routing-Tabelle assoziiert.
    * `terraform validate`, `plan` und `apply` erfolgreich ausgeführt und Ressourcen verifiziert.
    * Netzwerkarchitektur-Diagramm in Abschnitt [3.3.2](#332-aws-netzwerkarchitektur-vpc-detail) dokumentiert und
      aktualisiert, um die NAT-Gateway-pro-AZ-Architektur darzustellen.
    * Alle Ressourcen sind korrekt mit den globalen Tags (`Projekt`, `Student`, `ManagedBy`) versehen (verifiziert im
      Rahmen des Testfalls für User Story #7).
* **Terraform Remote Backend konfiguriert (User Story #6 ✓):**
    * Die Terraform-Konfiguration der Hauptanwendung (`src/terraform/`) wurde so eingerichtet, dass sie einen extern
      verwalteten S3 Bucket (`nenad-stevic-nextcloud-tfstate`) für die zentrale und sichere Speicherung des Terraform
      States nutzt. Für diesen Bucket sind Versionierung, serverseitige Verschlüsselung (SSE-S3) und die Blockierung des
      öffentlichen Zugriffs vorausgesetzt (und durch die separate Backend-Infrastruktur-Konfiguration sichergestellt).
    * Ebenso wird eine extern verwaltete DynamoDB-Tabelle (`nenad-stevic-nextcloud-tfstate-lock`) für das State Locking
      verwendet, um konkurrierende State-Änderungen zu verhindern.
    * Die Terraform Backend-Konfiguration (`backend "s3" {}`) wurde in `src/terraform/backend.tf` hinzugefügt und
      committet, um diese externen Ressourcen zu nutzen.
    * `terraform init` wurde erfolgreich ausgeführt, um das Remote Backend für die Hauptanwendung zu initialisieren und
      sich mit dem S3 Bucket zu verbinden. *(Anmerkung: Falls die AWS-Probleme dies verhindert haben, muss hier der
      tatsächliche Stand dokumentiert werden...)*
    * Es wurden keine AWS Keys im Code hardcodiert; die Authentifizierung erfolgt über das konfigurierte AWS CLI Profil.
    * Alle projektspezifischen DoD-Punkte für diese User Story (bezogen auf die Konfiguration des Backends in
      `src/terraform/`) sind erfüllt.
* **Sprint Review (durchgeführt am 24.05.2025 – simuliert):**
    * **Teilnehmer (simuliert):** Nenad Stevic (als Product Owner, Scrum Master, Development Team). Die Fachexperten
      werden als die primären Stakeholder betrachtet, denen das Inkrement präsentiert wird.
    * **Sprint-Ziel von Sprint 1 (rekapituliert):** "Ein sicherer AWS Account und eine lokale Entwicklungsumgebung sind
      eingerichtet, das Terraform Remote Backend ist konfiguriert, und ein grundlegendes, korrekt getaggtes AWS
      VPC-Netzwerk ist mittels Terraform Code definiert, versioniert und erfolgreich provisioniert."
    * **Präsentation des Inkrements:**
        * Alle für Sprint 1 committeten User Stories (`#37`, `#38`, `#6`, `#5`, `#7`) wurden erfolgreich abgeschlossen
          und erfüllen ihre jeweiligen Akzeptanzkriterien sowie die Definition of Done.
        * Die sichere AWS-Account-Konfiguration wurde demonstriert (MFA, IAM User, Budget Alerts).
        * Die eingerichtete lokale Entwicklungsumgebung mit allen notwendigen Tools wurde vorgestellt.
        * Die Implementierung der initialen Terraform-Provider-Konfiguration inklusive der globalen Tagging-Strategie
          wurde gezeigt.
        * Die erfolgreiche Provisionierung des VPC-Netzwerks mit öffentlichen/privaten Subnetzen und der
          NAT-Gateway-pro-AZ-Architektur via Terraform wurde demonstriert und die erstellten Ressourcen in der AWS
          Konsole gezeigt (inkl. Verifizierung der Tags).
        * Die Konfiguration des Terraform Remote Backends (S3 & DynamoDB) für die Hauptanwendung wurde erläutert und die
          erfolgreiche Initialisierung (`terraform init`) bestätigt. *(Anmerkung: Falls AWS-Probleme die volle
          Verifizierung des Remote Backend `apply` verhindert haben, sollte dies hier transparent erwähnt werden.)*
        * Die "Self-Review"-Notizen für jede User Story (siehe "Erreichtes Inkrement / Ergebnisse") dienten als
          detaillierte Nachweise der Erfüllung.
    * **Diskussion & Feedback (simuliert):**
        * Das Sprint-Ziel wurde vollständig erreicht.
        * Die klare Struktur des Terraform-Codes und die detaillierte Dokumentation der Einrichtungsschritte wurden
          positiv hervorgehoben.
        * Die NAT-Gateway-pro-AZ-Strategie wurde als gute Designentscheidung für Hochverfügbarkeit bewertet.
        * Es wurde angemerkt, dass die initiale Nutzung von `AdministratorAccess` für den IAM User zwar für den Start
          praktikabel war, aber für spezifischere Aufgaben in späteren Sprints (z.B. CI/CD Pipeline) feingranularere
          Berechtigungen (Least Privilege) empfohlen werden (bereits in der Retrospektive als Punkt aufgenommen).
    * **Anpassungen am Product Backlog:**
        * Aufgrund des Feedbacks und der Ergebnisse dieses Reviews sind aktuell keine unmittelbaren Änderungen oder
          neuen Items für das Product Backlog erforderlich. Die bestehende Priorisierung bleibt gültig.
    * **Fazit:** Der Sprint war erfolgreich. Das Inkrement bildet eine solide Grundlage für die weiteren Sprints.
* **Sprint Retrospektive (durchgeführt am 24.05.2025 – simuliert):**
    * **Teilnehmer (simuliert):** Nenad Stevic (als Product Owner, Scrum Master, Development Team).
    * **Ziel der Retrospektive:** Den abgelaufenen Sprint 1 reflektieren, um positive Aspekte zu identifizieren,
      Verbesserungspotenziale aufzudecken und konkrete Massnahmen für den nächsten Sprint abzuleiten, um den Prozess und
      die Zusammenarbeit (auch in der Einzelarbeit) kontinuierlich zu optimieren.
    * **Diskussion – Was lief gut in Sprint 1?**
        * **Klare Zielsetzung:** Das Sprint-Ziel war von Anfang an klar und half, den Fokus während des Sprints zu
          behalten.
        * **Strukturierte Planung:** Die detaillierte User Story Aufteilung und die Akzeptanzkriterien aus dem Sprint
          Planning waren sehr hilfreich bei der Umsetzung und dem Self-Review.
        * **Frühe Etablierung von Best Practices:** Die Entscheidung, das Terraform Remote Backend (`Nextcloud#6`) und
          die globale Tagging-Strategie (`Nextcloud#7`) früh im Projekt zu implementieren, wurde als positiv bewertet,
          da dies eine solide und nachvollziehbare Basis schafft.
        * **Problemlösungskompetenz:** Die Herausforderungen bei der Recherche der AWS Free Tier Limits und der
          unterschiedlichen Installationsmethoden für die lokale Umgebung (`Nextcloud#38`) konnten erfolgreich
          gemeistert werden.
        * **Dokumentationsdisziplin:** Die parallele Aktualisierung des `README.md` mit den Fortschritten und
          technischen Details hat sich bewährt.
    * **Diskussion – Was könnte in Sprint 2 verbessert werden?**
        * **Genauigkeit der Aufwandsschätzung:** Obwohl die User Stories für Sprint 1 abgeschlossen wurden, war der
          tatsächliche Zeitaufwand für die Recherche und Implementierung des VPC-Netzwerks (`Nextcloud#5`) mit der
          NAT-Gateway-pro-AZ-Lösung etwas höher als initial grob geschätzt. Hier könnte für zukünftige Sprints eine noch
          detailliertere Vorab-Recherche für komplexere Tasks helfen.
        * **IAM-Berechtigungen (Least Privilege):** Die Nutzung der `AdministratorAccess` Policy für den initialen IAM
          User (`Nextcloud#37`) war zwar pragmatisch für den Start, entspricht aber nicht dem "Least Privilege"-Prinzip.
          Dies birgt unnötige Sicherheitsrisiken, auch wenn es sich um eine Entwicklungsumgebung handelt.
        * **Proaktive Impediment-Dokumentation:** Kleinere "Stolpersteine" (z.B. spezifische Terraform-Provider-Version
          Kompatibilitäten) wurden gelöst, aber nicht immer sofort als potenzielles Impediment im Daily Scrum (
          simuliert) festgehalten. Eine konsequentere Erfassung könnte helfen, Muster zu erkennen.
    * **Abgeleitete Action Items für Sprint 2 (und darüber hinaus):**
        1. **IAM Policy Verfeinerung (Höchste Priorität):** Für alle neu zu erstellenden IAM-Rollen (insbesondere für
           EKS, EBS CSI Driver in Sprint 2 und später die CI/CD-Pipeline) werden von Beginn an spezifische, auf den
           tatsächlichen Bedarf zugeschnittene IAM Policies erstellt und verwendet, anstatt pauschale Admin-Rechte zu
           vergeben. Dies wird das primäre Learning sein, das in Sprint 2 umgesetzt wird.
        2. **Detailliertere Recherche bei komplexen Tasks:** Vor dem Commit zu User Stories, die absehbar hohe
           Komplexität oder viele unbekannte Variablen haben (z.B. EKS Cluster Setup), wird etwas mehr Zeit für eine
           fokussierte Vorab-Recherche eingeplant, um die Schätzgenauigkeit zu verbessern und potenzielle Fallstricke
           früher zu identifizieren.
        3. **Konsequentere Impediment-Erfassung:** Auch kleinere technische Hürden oder unerwartete Verhaltensweisen von
           Tools werden bewusster als (potenzielle) Impediments im (simulierten) Daily Scrum festgehalten, um den
           Lernprozess und die Transparenz zu fördern.

---

#### **Sprint 2: Terraform für EKS Cluster & ECR**

* **Dauer:** ca. 25. Mai 2025 - 01. Juni 2025
* **Zugehörige Epics:** `EPIC-TF-K8S`
* **Sprint Planning (durchgeführt am 24.05.2025 – simuliert):**
    * **Teilnehmer (simuliert):** Nenad Stevic (als Product Owner, Scrum Master, Development Team).
    * **Ziel des Plannings:** Definition des Sprint-Ziels für Sprint 2, Auswahl der User Stories aus dem Product Backlog
      und Planung der Umsetzung.
    * **Input:**
        * Product Backlog (priorisierte User Stories für `EPIC-TF-K8S`).
        * Aktuelles Produktinkrement (Ergebnisse aus Sprint 1, insbesondere das provisionierte VPC).
        * Voraussichtliche Kapazität für Sprint 2 (ca. 6 Stunden).
        * Erkenntnisse aus der Sprint 1 Retrospektive.
* **Sprint-Ziel (committet für Sprint 2):**
    * "Ein funktionsfähiger AWS EKS Kubernetes-Cluster mit konfigurierten Node Groups und einem IAM OIDC Provider ist
      mittels Terraform automatisiert provisioniert. Zusätzlich ist ein AWS ECR Repository für Docker-Images via
      Terraform erstellt und der AWS EBS CSI Driver im EKS Cluster für persistente Volumes installiert und
      konfiguriert."
* **Sprint Backlog (committete User Stories für Sprint 2 – siehe
  auch [Sprint 2 auf GitHub Board]([DEIN_AKTUALISIERTER_LINK_HIER])): **
    * `Nextcloud#8`: EKS Cluster mit Node Groups provisionieren (via Terraform).
    * `Nextcloud#9`: ECR Repository via Terraform erstellen.
    * `Nextcloud#10`: IAM OIDC Provider für EKS konfigurieren (via Terraform).
    * `Nextcloud#11`: AWS EBS CSI Driver im EKS Cluster installieren und konfigurieren.
* **Plan für die Umsetzung (grob):**
    * Priorität 1: EKS Cluster Grundgerüst (#8) und IAM OIDC Provider (#10), da diese fundamental sind und voneinander
      abhängen könnten.
    * Priorität 2: ECR Repository (#9), wichtig für spätere CI/CD und kann parallel vorbereitet werden.
    * Priorität 3: EBS CSI Driver (#11), baut auf dem funktionierenden EKS Cluster und OIDC Provider auf, um
      Persistenz-Tests vorzubereiten.
    * Die Terraform-Konfigurationen werden im bestehenden Verzeichnis `src/terraform/` in logisch getrennten Dateien (
      z.B. `eks.tf`, `ecr.tf`, `iam_oidc.tf`) erweitert.
    * Dokumentation (dieses README, insbesondere Abschnitte 4.1.3 und ggf. relevante Teile von 3.3) wird parallel zur
      Umsetzung jeder User Story aktualisiert.
* **Wichtigste Daily Scrum Erkenntnis / Impediment:**
    * Die korrekte JSON-Syntax für die ECR Lifecycle Policy (`Nextcloud#9`) erforderte eine kurze, aber fokussierte Recherche in der AWS/Terraform-Dokumentation, war aber dank der Beispiele schnell umsetzbar. Ansonsten keine Blocker.
    * Die `sts:AssumeRoleWithWebIdentity`-Aktion und die genaue Struktur der Trust Policy für IRSA (`Nextcloud#10`) waren anfangs komplex. Das Verständnis der `Condition`-Klausel, die die Rolle an einen spezifischen Kubernetes Service Account bindet, war der Schlüssel zum Erfolg.
* **Erreichtes Inkrement / Ergebnisse:**
    * **EKS Cluster und Node Groups provisioniert (User Story #8 ✓):**
        * Die EKS Control Plane wurde mit der Kubernetes-Version `1.29` (konfigurierbar via Terraform-Variable
          `var.eks_cluster_version`) erfolgreich erstellt.
        * Die notwendige IAM Rolle (`${var.project_name}-eks-cluster-role`) für den EKS Cluster mit der angehängten
          `AmazonEKSClusterPolicy` wurde erstellt und korrekt konfiguriert.
        * Mindestens eine EKS Managed Node Group (`${var.project_name}-main-nodes`) wurde erstellt.
            * Instanztyp: `t3.medium` (konfigurierbar via `var.eks_node_instance_types`).
            * Skalierungsparameter: Min: 2, Max: 2, Desired: 2 für grundlegende HA.
        * Die Worker Nodes wurden erfolgreich in den privaten Subnetzen (`aws_subnet.private[*].id`) der in Sprint 1
          erstellten VPC platziert.
        * Die notwendige IAM Rolle (`${var.project_name}-eks-node-role`) für die Node Groups (inkl. der Policies:
          `AmazonEKSWorkerNodePolicy`, `AmazonEC2ContainerRegistryReadOnly`, `AmazonEKS_CNI_Policy`) wurde erstellt und
          korrekt konfiguriert.
        * Der Befehl `terraform apply` provisionierte den Cluster und die Node Groups erfolgreich, nachdem initiale
          Probleme mit der `assume_role_policy` der Cluster-Rolle behoben wurden.
        * Die `kubeconfig`-Datei wurde mittels
          `aws eks update-kubeconfig --region $(terraform output -raw aws_region) --name $(terraform output -raw eks_cluster_name) --profile nextcloud-project`
          aktualisiert.
        * Der Befehl `kubectl get nodes -o wide` zeigte die 2 Worker Nodes im 'Ready'-Status mit privaten IP-Adressen
          an.
        * Die Dokumentation der EKS-Architektur wurde in Abschnitt [3.3.4](#334-aws-eks-architektur-detail) (neu)
          und [4.1.3](#413-provisionierung-des-eks-clusters-und-der-ecr) aktualisiert.
        * Alle Akzeptanzkriterien für User Story #8 sind erfüllt.
    * **Privates ECR Repository via Terraform erstellt (User Story #9 ✓):**
        * Ein privates AWS ECR Repository mit dem konfigurierbaren Namen `nextcloud-app` wurde erfolgreich mittels Terraform provisioniert (`aws_ecr_repository`).
        * Die Funktion "Image-Scanning bei Push" wurde aktiviert, um Images automatisch auf bekannte Sicherheitslücken zu prüfen.
        * Eine Lifecycle Policy (`aws_ecr_lifecycle_policy`) wurde konfiguriert, die ungetaggte Images nach 30 Tagen automatisch löscht, um die Kostenkontrolle zu gewährleisten.
        * Der URI des Repositories (`repository_url`) wird nun als Terraform-Output ausgegeben, um ihn in nachfolgenden CI/CD-Schritten einfach referenzieren zu können.
        * `terraform apply` wurde erfolgreich ausgeführt und das Repository in der AWS Konsole verifiziert.
        * Alle DoD-Punkte für diese User Story sind erfüllt.
    * **IAM OIDC Provider für EKS konfiguriert (User Story #10 ✓):**
        * Der IAM OIDC Identity Provider wurde mittels der Ressource `aws_iam_openid_connect_provider` in AWS IAM erstellt und ist korrekt mit dem OIDC-Issuer des EKS-Clusters verknüpft.
        * Der Root-CA-Thumbprint des OIDC-Endpunkts wurde dynamisch und sicher über die `tls_certificate` Datenquelle ermittelt.
        * Eine beispielhafte IAM-Rolle (`${var.project_name}-ebs-csi-driver-role`) für den AWS EBS CSI Driver wurde erstellt.
        * Die Trust Policy dieser Rolle wurde so konfiguriert, dass sie nur vom Kubernetes Service Account `ebs-csi-controller-sa` im Namespace `kube-system` übernommen werden kann. Dies legt den Grundstein für sichere, anmeldeinformationsfreie AWS-API-Aufrufe aus Pods (IRSA).
        * Die AWS-verwaltete `AmazonEBSCSIDriverPolicy` wurde an die Rolle angehängt.
        * `terraform apply` wurde erfolgreich ausgeführt und die Konfiguration in der AWS Konsole verifiziert.
    * **AWS EBS CSI Driver installiert und konfiguriert (User Story #11 ✓):**
        * Der AWS EBS CSI Driver wurde als EKS-verwaltetes Add-on (`aws_eks_addon`) via Terraform installiert. Diese Methode wurde wegen ihrer einfachen Verwaltung und direkten Integration in EKS und Terraform gewählt.
        * Das Add-on wurde so konfiguriert, dass es die in User Story #10 erstellte IAM-Rolle (`${var.project_name}-ebs-csi-driver-role`) via IRSA verwendet. Dies stellt sicher, dass der Treiber die nötigen Berechtigungen hat, um EBS Volumes zu verwalten.
        * Die erfolgreiche Installation wurde durch die Erstellung einer `StorageClass` und eines Test-`PersistentVolumeClaim` (PVC) verifiziert. Der PVC wurde erfolgreich an ein dynamisch provisioniertes `PersistentVolume` (PV) und ein zugrunde liegendes AWS EBS Volume gebunden.
        * Alle DoD-Punkte für diese User Story sind erfüllt.

*(Sprint 2 ist damit hinsichtlich der technischen Umsetzung vollständig abgeschlossen.)*
* **Sprint Review (durchgeführt am 01.06.2025 – simuliert):**
    * **Teilnehmer (simuliert):** Nenad Stevic (als PO, SM, Dev Team). Die Stakeholder (Fachexperten) werden gedanklich als Publikum einbezogen.
    * **Sprint-Ziel von Sprint 2 (rekapituliert):** "Ein funktionsfähiger AWS EKS Kubernetes-Cluster mit konfigurierten Node Groups und einem IAM OIDC Provider ist mittels Terraform automatisiert provisioniert. Zusätzlich ist ein AWS ECR Repository für Docker-Images via Terraform erstellt und der AWS EBS CSI Driver im EKS Cluster für persistente Volumes installiert und konfiguriert."
    * **Präsentation des Inkrements (Demo-Highlights):**
        * **EKS Cluster:** Es wurde demonstriert, wie `terraform apply` den vollständigen EKS-Cluster mit zwei Worker Nodes in den privaten Subnetzen erstellt. Der erfolgreiche Zugriff via `kubectl get nodes` wurde live gezeigt.
        * **ECR Repository:** Das via Terraform erstellte private ECR-Repository wurde in der AWS-Konsole präsentiert, inklusive der aktivierten Konfiguration für "Scan on push" und der Lifecycle Policy.
        * **IRSA & EBS CSI Driver:** Die Kernfunktionalität wurde durch einen Live-Test nachgewiesen:
            1. Anwenden eines Test-`PersistentVolumeClaim` (PVC) via `kubectl apply`.
            2. Beobachtung des PVC-Status, der in Echtzeit auf `Bound` wechselte (`kubectl get pvc`).
            3. Verifizierung des dynamisch erstellten EBS-Volumes im AWS EC2 Dashboard.
        * Dieses Ergebnis bestätigt, dass der EKS-Cluster, der OIDC Provider, die IRSA-Rolle und der EBS CSI Driver perfekt zusammenspielen.
    * **Feedback & Diskussion (simuliert):** Das Sprint-Ziel wurde vollumfänglich erreicht. Alle User Stories (`#8`, `#9`, `#10`, `#11`) wurden erfolgreich abgeschlossen. Das Inkrement stellt eine robuste und sichere Basis für die Anwendungs-Deployments in den nächsten Sprints dar. Die Wahl des EKS Add-ons für den CSI-Treiber wurde als kluge, stabile Entscheidung gewürdigt.
    * **Product Backlog:** Keine unmittelbaren Änderungen am Backlog erforderlich. Die Priorisierung für Sprint 3 (RDS-Datenbank) bleibt bestehen und ist der logische nächste Schritt.
* **Sprint Retrospektive (durchgeführt am 01.06.2025 – simuliert):**
    * **Teilnehmer (simuliert):** Nenad Stevic (als PO, SM, Dev Team).
    * **Diskussion – Was lief gut in Sprint 2?**
        * **Logische Aufteilung:** Die Aufteilung der komplexen EKS-Einrichtung in separate, fokussierte User Stories (#8, #10, #11) hat sich als äusserst effektiv erwiesen. Jedes Teilproblem konnte isoliert gelöst und verifiziert werden.
        * **Proaktive Problemlösung:** Der `no such host`-Fehler bei `kubectl` wurde schnell als typisches `kubeconfig`-Problem identifiziert und souverän gelöst.
        * **Stabile Basis:** Das Inkrement aus Sprint 1 (VPC) war eine fehlerfreie und solide Grundlage, auf der reibungslos aufgebaut werden konnte.
        * **Dokumentationsdisziplin:** Die proaktive Dokumentation von Architekturentscheidungen (EKS Add-on vs. Helm) im `README.md` wurde als wertvoll für die Nachvollziehbarkeit erachtet.
    * **Diskussion – Was könnte verbessert werden?**
        * **Komplexität von IRSA:** Die Einarbeitung in die genaue Funktionsweise von IRSA und die Syntax der Trust Policy war zeitaufwändiger als erwartet. Ein initialer "Spike" (kurzes Forschungs-Ticket) hätte hier den Aufwand vielleicht genauer vorhersagbar gemacht.
        * **Terraform-Plan-Dauer:** Mit zunehmender Anzahl an Ressourcen dauert `terraform plan` und `apply` länger. Dies ist normal, muss aber in der Zeitplanung für zukünftige Sprints berücksichtigt werden.
    * **Abgeleitete Action Items für Sprint 3:**
        1. **Komplexitätsbewertung beibehalten:** Bei neuen, unbekannten AWS-Diensten (wie RDS in Sprint 3) bewusst eine kurze Recherchephase einplanen, bevor die Implementierung beginnt, um die Aufwandsschätzung zu verbessern.
        2. **Modulare Terraform-Struktur im Auge behalten:** Auch wenn noch keine eigenen Module erstellt werden, wird weiterhin auf saubere, in thematische Dateien aufgeteilte Terraform-Konfigurationen geachtet, um die Übersichtlichkeit zu wahren.

---

#### **Sprint 3: Terraform für RDS/IAM & Manuelles Nextcloud Deployment**

*   **Dauer:** ca. 03. Juni 2025 - 14. Juni 2025
*   **Zugehörige Epics:** `EPIC-TF-DB-IAM`, `EPIC-NC-DEPLOY`
*   **Sprint Planning (durchgeführt am 02.06.2025 – simuliert):**
    *   **Teilnehmer (simuliert):** Nenad Stevic (als PO, SM, Dev Team).
    *   **Kontext & Ziel des Plannings:** Nach Abschluss von Sprint 2, in dem die komplette EKS-Infrastruktur inkl. Persistenz-Fähigkeit bereitgestellt wurde, fokussiert sich dieser Sprint darauf, die letzte grosse Infrastruktur-Abhängigkeit – die Datenbank – zu provisionieren und die Funktionsfähigkeit der Gesamtplattform mit einem manuellen Test-Deployment zu validieren.
    *   **Diskussion – Das "Warum" (Sprint-Ziel Formulierung):**
        *   Der Product Owner betonte, dass vor der Automatisierung des Deployments (Sprint 4 & 5) absolute Sicherheit bestehen muss, dass die Plattform (VPC, EKS, EBS, RDS) eine stateful Anwendung wie Nextcloud überhaupt tragen kann. Ein manuelles Proof-of-Concept-Deployment ist der schnellste Weg, dies zu validieren und unerwartete Integrationsprobleme frühzeitig aufzudecken.
        *   Gemeinsam wurde das folgende, präzisierte Sprint-Ziel formuliert:
            *   *"Eine ausfallsichere AWS RDS PostgreSQL-Instanz ist via Terraform provisioniert und sicher konfiguriert, sodass nur der EKS-Cluster darauf zugreifen kann. Die erfolgreiche Integration der gesamten Infrastruktur wird durch ein manuelles Deployment einer funktionalen, datenbank-angebundenen und persistenten Nextcloud-Instanz nachgewiesen."*
    *   **Diskussion – Das "Was" (Auswahl der Sprint Backlog Items):**
        *   Basierend auf dem Ziel wurden die User Stories `#12` (RDS), `#13` (Security Group), `#14` (Manuelles Deployment) und `#15` (Doku) als Kernbestandteile identifiziert.
        *   Während der Diskussion wurde klar, dass ein kritischer Schritt fehlt: Wie gelangen die Datenbank-Credentials sicher in den Cluster? Das Dev-Team schlug vor, hierfür eine neue User Story zu erstellen (`#16`), die das manuelle Erstellen eines Kubernetes Secrets für die Credentials abdeckt. Dies wurde vom PO akzeptiert und dem Sprint Backlog hinzugefügt.
        *   Es wurde ebenfalls beschlossen, das RDS-Master-Passwort nicht im Terraform-Code zu hardcoden, sondern es im AWS Secrets Manager zu speichern und von Terraform nur zu referenzieren. Diese Anforderung wird Teil von User Story `#12`.
    *   **Diskussion – Das "Wie" (Grobe Planung der Umsetzung):**
        1.  **AWS-Infrastruktur zuerst:** Zuerst wird das RDS-Passwort im AWS Secrets Manager angelegt. Danach werden die Terraform-Konfigurationen für RDS (`#12`) und die Security Group (`#13`) erstellt und angewendet.
        2.  **Kubernetes-Vorbereitung:** Sobald die Datenbank läuft, wird das Kubernetes-Secret mit den Credentials manuell im Cluster erstellt (`#16`).
        3.  **Proof-of-Concept:** Anschliessend wird das manuelle Deployment von Nextcloud mit einfachen YAML-Manifesten (Deployment, Service, PVC) durchgeführt (`#14`).
        4.  **Dokumentation:** Die für das manuelle Deployment notwendigen Schritte und Befehle werden parallel dokumentiert (`#15`).
*   **Sprint-Ziel (committet für Sprint 3):**
    *   "Eine ausfallsichere AWS RDS PostgreSQL-Instanz ist via Terraform provisioniert und sicher konfiguriert, sodass nur der EKS-Cluster darauf zugreifen kann. Die erfolgreiche Integration der gesamten Infrastruktur wird durch ein manuelles Deployment einer funktionalen, datenbank-angebundenen und persistenten Nextcloud-Instanz nachgewiesen."
*   **Sprint Backlog (committete User Stories für Sprint 3):**
    *   `Nextcloud#12`: RDS PostgreSQL Instanz via Terraform provisionieren & Master-Passwort via Secrets Manager verwalten.
    *   `Nextcloud#13`: RDS Security Group konfigurieren, um Zugriff nur vom EKS-Cluster zu erlauben.
    *   `Nextcloud#14`: Nextcloud manuell auf EKS deployen (als Proof-of-Concept).
    *   `Nextcloud#15`: Die Schritte des manuellen Deployments im `README.md` dokumentieren.
    *   `Nextcloud#39`: **(NEU)** Manuell ein Kubernetes Secret für die RDS-Datenbank-Credentials erstellen.
*   **Wichtigste Daily Scrum Erkenntnis / Impediment:**
    *   **Impediment 1 (Blocker):** Nach dem initialen manuellen Deployment blieb der `PersistentVolumeClaim` (PVC) für Nextcloud im Status `Pending`. Die `kubectl describe pod` Ausgabe zeigte keine Events, was auf ein Problem vor dem Scheduling hindeutete.
        *   **Analyse:** Die Logs des `ebs-csi-node` Pods zeigten einen Timeout-Fehler bei der Abfrage des EC2 Instance Metadata Service (IMDS). Dies verhinderte, dass der CSI-Treiber die notwendigen Topologie-Labels auf den Worker-Nodes setzen konnte, wodurch der Scheduler die Nodes für die Volume-Provisionierung ignorierte.
        *   **Lösung 1 (Versuch):** Zuerst wurde eine fehlende IAM-Berechtigung vermutet. Dies stellte sich als falsch heraus.
        *   **Lösung 2 (Erfolgreich):** Die Recherche ergab, dass die Standard-Hop-Limit von `1` für den IMDS in containerisierten Umgebungen nicht ausreicht. Die Lösung war die Erstellung einer dedizierten `aws_launch_template` für die EKS Node Group, in der die `http_put_response_hop_limit` auf `2` gesetzt wurde.
    *   **Impediment 2 (Blocker):** Nachdem das IMDS-Problem gelöst war, schlug die Volume-Provisionierung mit einem `AccessDenied`-Fehler fehl.
        *   **Analyse:** Die PVC-Events zeigten klar, dass der CSI-Treiber nicht berechtigt war, die `sts:AssumeRoleWithWebIdentity`-Aktion auszuführen. Dies deutete auf eine fehlerhafte IAM Trust Policy für die IRSA-Rolle hin.
        *   **Lösung:** Die Trust Policy der `ebs_csi_driver_role` wurde überarbeitet und robuster gestaltet, indem sie explizit das `audience` (`aud`) und `subject` (`sub`) des OIDC-Tokens validiert.
    *   **Erkenntnis:** Die Fehlersuche in einem verteilten System erfordert eine schichtweise Analyse. Ein `Pending`-Status kann von der Anwendung, über Kubernetes-Komponenten, bis hin zu tiefen Cloud-Infrastruktur-Einstellungen (IAM, EC2) verursacht werden. Die `describe`- und `logs`-Befehle sind hierbei die wichtigsten Werkzeuge.
*   **Erreichtes Inkrement / Ergebnisse:**
    *   **Korrektur & Härtung der EKS-Worker-Node-Konfiguration (Ungeplant, aber notwendig):**
        *   Eine dedizierte `aws_launch_template` wurde erstellt und mit der EKS Node Group verknüpft. Diese setzt die IMDS Hop-Limit auf `2`, um Konnektivitätsprobleme von Pods zum EC2 Metadatendienst zu beheben.
        *   Die IAM Trust Policy für die EBS CSI Driver Rolle (`ebs_csi_driver_role`) wurde überarbeitet, um die Sicherheit und Zuverlässigkeit der IRSA-Konfiguration zu erhöhen.
    *   **RDS PostgreSQL-Instanz und zugehörige Ressourcen via Terraform provisioniert (User Story #12 ✓):**
        *   Die RDS-Instanz (`PostgreSQL 16.2`, `db.t3.micro`) wurde erfolgreich in den privaten Subnetzen provisioniert.
        *   Das Master-Passwort wird sicher aus dem AWS Secrets Manager ausgelesen.
    *   **RDS Security Group konfiguriert (User Story #13 ✓):**
        *   Eine dedizierte Security Group für RDS wurde erstellt, die den Zugriff nur von der EKS-Cluster-Security-Group auf Port `5432` erlaubt.
    *   **Manuelles Kubernetes Secret für DB-Credentials erstellt (User Story #39 ✓):**
        *   Ein Kubernetes-Secret (`nextcloud-db-secret`) wurde erfolgreich mit den korrekten, base64-codierten Werten erstellt.
    *   **Nextcloud manuell auf EKS deployt als Proof-of-Concept (User Story #14 ✓):**
        *   Eine funktionale Nextcloud-Instanz wurde mittels manueller Manifeste (Deployment, Service, PVC) auf dem EKS-Cluster bereitgestellt.
        *   Die Instanz ist über einen AWS Load Balancer extern erreichbar. Die Datenbankverbindung und die Datenpersistenz wurden durch einen Pod-Neustart-Test erfolgreich validiert.
    *   **Spezifikation des manuellen Deployments dokumentiert (User Story #15 ✓):**
        *   Eine detaillierte Spezifikation, die alle Konfigurationen, Manifeste und Befehle des manuellen Deployments beschreibt, wurde als dedizierter Abschnitt in diesem `README.md` (Kapitel 4.1.8) erstellt.
*   **Sprint Review (durchgeführt am 14.06.2025 – simuliert):**
    *   **Teilnehmer (simuliert):** Nenad Stevic (als PO, SM, Dev Team), Stakeholder (repräsentiert durch die Fachexperten).
    *   **Präsentation des Sprint-Ziels & Inkrements:** Das committete Sprint-Ziel – die Bereitstellung einer via Terraform provisionierten RDS-Instanz und der Nachweis der Plattform-Funktionalität durch ein manuelles, persistentes Nextcloud-Deployment – wurde vollständig erreicht.
    *   **Live-Demo (Demo-Highlight):** Als Höhepunkt des Reviews wurde die Lauffähigkeit der Gesamtlösung live demonstriert:
        1.  Zuerst wurde der erfolgreiche `terraform apply`-Lauf gezeigt, der die RDS-Instanz und alle zugehörigen Sicherheitskonfigurationen erstellt hat.
        2.  Anschliessend wurde die Nextcloud-Instanz, die zuvor mit manuellen `kubectl apply`-Befehlen bereitgestellt wurde, über ihre öffentliche Load-Balancer-URL im Browser aufgerufen.
        3.  Es wurde ein erfolgreicher Login durchgeführt und eine Test-Datei hochgeladen.
        4.  **Der entscheidende Persistenz-Test:** Der laufende Nextcloud-Pod wurde live mit `kubectl delete pod` terminiert. Die Stakeholder konnten beobachten, wie Kubernetes den Pod automatisch neu startete. Nach dem erneuten Login war die zuvor hochgeladene Test-Datei noch vorhanden, was die korrekte Funktion der Datenbankanbindung und des persistenten EBS-Speichers eindrucksvoll bestätigte.
    *   **Diskussion & Feedback (simuliert):** Die Stakeholder zeigten sich beeindruckt von der Stabilität und Resilienz der demonstrierten Lösung. Besonders positiv wurde hervorgehoben, dass die gesamte zugrundeliegende Infrastruktur nun als validiert gilt, was ein grosses Risiko für die nachfolgenden Sprints eliminiert. Die aufgetretenen technischen Herausforderungen (siehe "Impediments") und deren systematische Lösung wurden als wertvolle Lernerfahrung und Zeichen technischer Tiefe gewertet. Es wurden keine Änderungen am Product Backlog für notwendig erachtet.
    *   **Fazit:** Der Sprint war ein voller Erfolg. Das Inkrement ist robust, die Kernrisiken sind mitigiert und das Projekt ist perfekt positioniert, um nun in die Automatisierungsphase mit Helm überzugehen.
*   **Sprint Retrospektive (durchgeführt am 14.06.2025 – simuliert):**
    *   **Teilnehmer (simuliert):** Nenad Stevic (als PO, SM, Dev Team).
    *   **Ziel der Retrospektive:** Den komplexen Sprint 3 reflektieren, um den methodischen Ansatz zur Problemlösung zu analysieren und den Prozess für zukünftige Sprints weiter zu schärfen.
    *   **Diskussion – Was lief aussergewöhnlich gut?**
        *   **Systematische Fehlersuche:** Trotz unerwarteter und tiefgreifender technischer Probleme wurde ein ruhiger, schichtweiser Debugging-Prozess verfolgt (Pod-Status -> PVC-Events -> CSI-Logs -> IAM-Policies -> EC2-Metadaten). Dieser methodische Ansatz war der Schlüssel zum Erfolg.
        *   **Resilienz & Lernbereitschaft:** Die Bereitschaft, ursprüngliche Annahmen zu verwerfen und die Infrastruktur von Grund auf neu zu provisionieren, um einen sauberen Zustand zu garantieren, war entscheidend.
        *   **Inkrementeller Wert:** Das Sprint-Ziel, ein Proof-of-Concept zu liefern, hat sich als goldrichtig erwiesen. Es hat kritische Infrastruktur-Fehler aufgedeckt, die in einer vollautomatisierten Pipeline nur sehr schwer zu debuggen gewesen wären.
    *   **Diskussion – Was haben wir gelernt (Verbesserungspotenzial)?**
        *   **Komplexität von Cloud-Integrationen:** Dieser Sprint hat eindrücklich gezeigt, dass die Integration von Managed Services (EKS, EC2, IAM) subtile Abhängigkeiten aufweist (z.B. IMDS Hop Limit), die in der offiziellen "Getting Started"-Dokumentation oft nicht im Vordergrund stehen. Eine tiefere Recherche in Best-Practice-Guides und bekannten GitHub-Issues ist unerlässlich.
        *   **Dokumentationsdisziplin:** Das Festhalten der Impediments und deren Lösungen direkt nach Auftreten ist essenziell. Es bildet die Grundlage für eine starke Projektdokumentation und die Reflexion.
    *   **Abgeleitete Action Item für Sprint 4:**
        1.  **Spezifikation als Basis nutzen:** Die Erkenntnisse des manuellen Deployments, die nun detailliert dokumentiert sind, werden als feste Blaupause für die Entwicklung des Helm Charts verwendet. Es wird nicht "from scratch" begonnen, sondern die validierte Konfiguration systematisch in Helm-Templates überführt. Dies minimiert das Risiko, in Sprint 4 erneut auf dieselben Probleme zu stossen.

---

#### **Sprint 4: Nextcloud Helm Chart Entwicklung**

*   **Dauer:** 15. Juni 2025 - 20. Juni 2025
*   **Zugehöriges Epic:** `EPIC-HELM`
*   **Sprint Planning (durchgeführt am 14.06.2025 – simuliert):**
    *   **Teilnehmer (simuliert):** Nenad Stevic (als PO, SM, Dev Team).
    *   **Kontext & Ziel des Plannings:** Nach dem erfolgreichen Proof-of-Concept in Sprint 3 ist die Funktionsfähigkeit der Infrastruktur validiert. Das Ziel dieses Sprints ist es, den manuellen, fehleranfälligen Deployment-Prozess durch ein standardisiertes, wiederverwendbares und konfigurierbares Helm Chart zu ersetzen. Dies ist der erste Schritt zur Automatisierung des Anwendungs-Deployments.
    *   **Diskussion – Das "Warum" (Sprint-Ziel Formulierung):** Der Product Owner betonte, dass manuelle `kubectl apply`-Befehle nicht skalierbar, versionierbar oder für eine CI/CD-Pipeline geeignet sind. Ein Helm Chart ist der Industriestandard, um Kubernetes-Anwendungen zu paketieren und deren Lebenszyklus zu verwalten. Es kapselt die Komplexität und ermöglicht einfache, wiederholbare Installationen und Upgrades.
    *   **Gemeinsam formuliertes Sprint-Ziel:**
        *   *"Ein eigenständiges und funktionales Helm Chart für Nextcloud ist entwickelt, das die manuelle Bereitstellung vollständig ersetzt. Das Chart ist über eine `values.yaml`-Datei konfigurierbar, löst das `localhost`-Redirect-Problem durch eine dedizierte ConfigMap und enthält einen einfachen Helm-Test zur Überprüfung der Erreichbarkeit des Deployments. Die Benutzerfreundlichkeit wird durch eine informative `NOTES.txt`-Datei nach der Installation sichergestellt."*
*   **Sprint Backlog (Committete User Stories für Sprint 4):**
    *   `Nextcloud#16`: **Helm Chart Grundgerüst erstellen:** Ein neues Helm Chart mit `helm create nextcloud-chart` initialisieren und die grundlegende `Chart.yaml` mit Metadaten füllen. Die unnötigen Standard-Templates werden bereinigt, um eine saubere Basis zu schaffen.
    *   `Nextcloud#40`: **Manuelle Manifeste in Helm-Templates überführen:** Das funktionierende Deployment-, Service- und PVC-YAML aus Sprint 3 in den `templates/`-Ordner des Charts überführen und mit Helm-Variablen (`{{ .Values.xyz }}`) parametrisieren (z.B. für Image-Tag, Replica-Anzahl, Storage-Grösse).
    *   `Nextcloud#17`: **Secrets & ConfigMap für dynamische Konfiguration templatzieren:** Ein Template für das Datenbank-Secret erstellen, das seine Werte aus der `values.yaml` bezieht. Zusätzlich ein ConfigMap-Template erstellen, das `trusted_domains` und `overwrite.cli.url` für Nextcloud konfiguriert, um das `localhost`-Redirect-Problem zu lösen.
    *   `Nextcloud#19`: **Einfachen Helm-Test für Deployment-Verfügbarkeit implementieren:** Ein `templates/tests/test-connection.yaml` erstellen. Dieses Template definiert einen Test-Pod, der mittels `wget` oder `curl` versucht, den Nextcloud-Service zu erreichen. Ein erfolgreicher Test verifiziert die grundlegende Netzwerk-Konnektivität und das Service-Routing.
    *   `Nextcloud#18`: **NOTES.txt für Post-Installationshinweise erstellen:** Eine nützliche `NOTES.txt`-Datei schreiben, die dem Benutzer nach einem `helm install` dynamisch generierte Informationen anzeigt, wie z.B. den Befehl zum Abrufen der externen IP des Load Balancers.
*   **Wichtigste Daily Scrum Erkenntnis / Impediment:**
    *   **Erkenntnis:** Bei der Überprüfung der ersten gerenderten Manifeste (`helm template`) wurde eine unschöne, redundante Benennung der Kubernetes-Ressourcen (z.B. `nextcloud-nextcloud-chart`) festgestellt.
    *   **Lösung (Impediment behoben):** Das Problem wurde schnell auf eine suboptimale Logik im `_helpers.tpl`-Template zurückgeführt. Das Template wurde durch die Standard-Helm-Logik ersetzt und der Chart-Name in `Chart.yaml` vereinfacht. Dies führte zu sauberen und vorhersehbaren Ressourcennamen. Dieser schnelle Fix verhinderte technische Schulden und verbesserte die Chart-Qualität sofort.
*   **Erreichtes Inkrement / Ergebnisse:**
    *   **Helm Chart Grundgerüst erstellt (User Story #16 ✓):**
        *   Ein neues Helm Chart wurde im Verzeichnis `charts/nextcloud-chart` angelegt.
        *   `Chart.yaml` wurde mit Metadaten (Name, Version, Beschreibung) befüllt.
        *   Eine `values.yaml`-Datei wurde erstellt, die zentrale Parameter wie Image-Version, Replica-Anzahl, Service-Typ, Port und Persistenz-Einstellungen (Grösse, StorageClass) konfigurierbar macht.
        *   Die validierten manuellen Manifeste aus Sprint 3 für Deployment, Service und PersistentVolumeClaim wurden erfolgreich in Helm-Templates (`templates/`) überführt.
        *   Eine `_helpers.tpl`-Datei wurde für standardisierte Labels und Benennungen implementiert.
        *   Die Befehle `helm lint` und `helm template` laufen erfolgreich durch und bestätigen die syntaktische und strukturelle Korrektheit des Charts.
        *   Die Dokumentation der Chart-Struktur und Konfiguration wurde in den Abschnitten [4.2.1](#421-helm-chart-struktur), [4.2.2](#422-wichtige-templates) und [4.2.3](#423-konfigurationsmöglichkeiten-über-valuesyaml) im Haupt-README ergänzt.
        *   Alle projektspezifischen DoD-Punkte für diese User Story sind erfüllt.
    *   **Secrets & ConfigMap templatisiert (User Story #17 ✓):**
        *   Ein `templates/secret.yaml` wurde erstellt, welches optional ein Kubernetes Secret mit allen Admin- und Datenbank-Credentials basierend auf der `values.yaml` generiert. Die Logik unterstützt auch die Verwendung eines bereits existierenden Secrets, was die Flexibilität erhöht.
        *   Ein `templates/configmap.yaml` wurde hinzugefügt, um das kritische `localhost`-Redirect-Problem zu lösen. Es generiert eine `autoconfig.php`, die dynamisch `trusted_domains` und `overwrite.cli.url` basierend auf einem Hostnamen in `values.yaml` setzt.
        *   Das `deployment.yaml`-Template wurde angepasst, um die neue ConfigMap als Volume zu mounten und die Logik zur Auswahl des korrekten Secrets (entweder das neu generierte oder ein existierendes) zu implementieren.
        *   Ein Sicherheitshinweis bezüglich der Passwortverwaltung wurde direkt in der `values.yaml` und im Haupt-README ergänzt.
    *   **NOTES.txt für Post-Installationshinweise erstellt (User Story #18 ✓):**
        *   Eine `templates/NOTES.txt`-Datei wurde im Helm Chart erstellt, um Benutzern nach der Installation sofortiges Feedback zu geben.
        *   Die Notizen enthalten dynamische Logik, die je nach konfiguriertem `service.type` (LoadBalancer, NodePort, ClusterIP) unterschiedliche, kontext-spezifische Anweisungen zur Erreichbarkeit der Anwendung generiert.
        *   Für den Standardfall (`LoadBalancer`) wird der Benutzer explizit angewiesen, wie er den externen Hostnamen abruft und den entscheidenden `helm upgrade`-Befehl ausführt, um die Konfiguration abzuschliessen.
        *   Informationen zum Abrufen der Admin-Credentials werden ebenfalls dynamisch angezeigt, je nachdem, ob das Chart ein Secret erstellt hat oder ein existierendes verwendet wird.
        *   Die Funktionalität wurde mit `helm install --dry-run` verifiziert.
    *   **Einfachen Helm-Test für Deployment-Verfügbarkeit implementiert (User Story #19 ✓):**
        *   Ein Test-Manifest wurde unter `templates/tests/test-connection.yaml` erstellt.
        *   Der Test definiert einen Pod mit der Annotation `helm.sh/hook: test`, der nach der Installation mit dem Befehl `helm test <release-name>` ausgeführt werden kann.
        *   Der Pod verwendet `wget`, um den internen `/status.php`-Endpunkt des Nextcloud-Services abzufragen und so die grundlegende Erreichbarkeit und Funktionsfähigkeit der Anwendung zu verifizieren.
        *   Der Test wurde erfolgreich auf einer laufenden Installation im EKS-Cluster ausgeführt und hat den Status `Succeeded` zurückgegeben.
    *   **Manuelle Manifeste in Helm-Templates überführt (User Story #40 ✓):**
        *   Die funktionalen Kubernetes-Manifeste (Deployment, Service, PVC) aus dem manuellen Proof-of-Concept (Sprint 3) wurden erfolgreich in die Helm-Chart-Struktur im `templates/`-Verzeichnis migriert.
        *   Grundlegende Werte wie die Replica-Anzahl (`.Values.replicaCount`), das Container-Image (`.Values.image.repository` & `.Values.image.tag`) und die Speichergrösse des PVCs (`.Values.persistence.size`) wurden dabei direkt parametrisiert.
        *   Diese Arbeit wurde implizit als Teil der Erstellung des Chart-Grundgerüsts (Ticket #16) erledigt und bildet die Basis für alle weiteren Chart-Erweiterungen.
*   **Sprint Review (durchgeführt am 20.06.2025 – simuliert):**
    *   **Teilnehmer (simuliert):** Nenad Stevic (als PO, SM, Dev Team), Stakeholder (repräsentiert durch die Fachexperten).
    *   **Präsentation des Sprint-Ziels & Inkrements:** Das committete Sprint-Ziel – *"Ein eigenständiges und funktionales Helm Chart für Nextcloud ist entwickelt..."* – wurde vollständig erreicht. Alle committeten User Stories (`#16`, `#40`, `#17`, `#19`, `#18`) wurden abgeschlossen und erfüllen die Definition of Done.
    *   **Live-Demo (Demo-Highlight):** Der Höhepunkt des Reviews war die Live-Demonstration des gesamten Lebenszyklus des neuen Helm Charts:
        1.  **Installation & Post-Install Notes:** Mit dem Befehl `helm install nextcloud ./charts/nextcloud-chart/ --dry-run` wurde gezeigt, wie das Chart valide Manifeste generiert und die benutzerfreundliche `NOTES.txt` die nächsten Schritte klar kommuniziert.
        2.  **Lösung des Redirect-Problems:** Es wurde demonstriert, wie die `ConfigMap` aus `templates/configmap.yaml` dynamisch die `trusted_domains` setzt. Der Wert wurde mit dem Befehl `helm template . --set nextcloud.host=my-test.com` live gerendert und gezeigt.
        3.  **Automatisierter Test:** Auf einer bereits laufenden Instanz wurde `helm test nextcloud` ausgeführt. Die Stakeholder konnten live sehen, wie der Test-Pod startete, den `/status.php`-Endpunkt erfolgreich abfragte und die Test-Suite den Status `Succeeded` meldete. Dies bestätigte die grundlegende Funktionsfähigkeit des Deployments.
    *   **Diskussion & Feedback (simuliert):** Die Stakeholder zeigten sich sehr zufrieden mit dem Ergebnis. Das Inkrement (das Helm Chart) ist eine massive Verbesserung gegenüber den manuellen Manifesten. Es ist robust, wiederverwendbar und benutzerfreundlich. Besonders die proaktive Lösung des `localhost`-Redirect-Problems und die Implementierung des automatisierten Tests wurden als Zeichen für hohe Qualität und Voraussicht gelobt. Es sind keine Änderungen am Product Backlog erforderlich; der Weg für die CI/CD-Pipeline in Sprint 5 ist frei.
*   **Sprint Retrospektive (durchgeführt am 20.06.2025 – simuliert):**
    *   **Teilnehmer (simuliert):** Nenad Stevic (als PO, SM, Dev Team).
    *   **Ziel der Retrospektive:** Den Entwicklungsprozess des Helm Charts reflektieren, um Best Practices zu identifizieren und den Workflow für zukünftige Automatisierungsaufgaben zu optimieren.
    *   **Diskussion – Was lief aussergewöhnlich gut?**
        *   **Validierungskreislauf:** Der ständige Wechsel zwischen Code-Anpassung, `helm lint` und `helm template` hat sich als extrem effizient erwiesen. Fehler (wie das Naming-Problem) wurden sofort entdeckt und behoben, lange bevor ein `helm install` fehlschlagen konnte.
        *   **Blaupause aus Sprint 3:** Die Nutzung der validierten manuellen Manifeste als Vorlage hat die Entwicklung enorm beschleunigt und das Risiko von Konfigurationsfehlern minimiert. Die Entscheidung, zuerst ein manuelles PoC zu machen, hat sich voll ausgezahlt.
        *   **User-Experience-Fokus:** Die Arbeit an `NOTES.txt` und die klaren Kommentare in `values.yaml` waren keine Nebensächlichkeit, sondern haben die Qualität und Wiederverwendbarkeit des Charts entscheidend verbessert.
    *   **Diskussion – Was haben wir gelernt (Verbesserungspotenzial)?**
        *   **Chicken-and-Egg-Problem:** Die Notwendigkeit, das Chart zuerst zu installieren, um den Load-Balancer-Hostnamen zu erhalten, und dann ein `helm upgrade` durchzuführen, ist ein bekannter Knackpunkt. Dies ist zwar der Standardweg, aber für die CI/CD-Pipeline in Sprint 5 müssen wir uns überlegen, wie wir diesen zweistufigen Prozess am besten automatisieren.
        *   **Implizite Abhängigkeiten:** Ticket `#40` wurde fast vollständig durch `#16` erledigt. Das ist zwar effizient, aber im Sprint Planning hätte man diese Überlappung vielleicht erkennen und die Tickets zu einem zusammenfassen können, um das Backlog klarer zu halten.
    *   **Abgeleitete Action Items für Sprint 5:**
        1.  **Automatisierung des "Upgrade"-Schritts:** Für die CI/CD-Pipeline in Sprint 5 wird ein dedizierter Schritt oder ein Skript eingeplant, das nach dem `helm install` den Load-Balancer-Hostnamen abfragt und automatisch den `helm upgrade`-Befehl ausführt, um den Prozess vollständig zu automatisieren.
        2.  **Wiederverwendung von Konfigurationslogik:** Die Logik zur Parameterübergabe in Helm (`--set`, `-f`) wird als Blaupause für die Konfiguration der Terraform-Schritte in der CI/CD-Pipeline verwendet, um auch dort eine klare Trennung von Code und Konfiguration beizubehalten.


---

#### **Sprint 5: CI/CD Pipeline (GitHub Actions) & Tests**

*   **Dauer:** ca. 21. Juni 2025 - 03. Juli 2025
*   **Zugehörige Epics:** `EPIC-CICD`, Teile von `EPIC-ABSCHLUSS` (Testing)
*   **Sprint Planning (durchgeführt am 20.06.2025 – simuliert):**
    *   **Teilnehmer (simuliert):** Nenad Stevic (als PO, SM, Dev Team).
    *   **Kontext & Ziel des Plannings:** Sprint 4 hat ein robustes und testbares Helm Chart geliefert. Der manuelle Deployment-Prozess ist damit zwar standardisiert, aber noch nicht automatisiert. Das Ziel dieses Sprints ist es, den gesamten Prozess von einer Code-Änderung bis zum verifizierten Deployment im EKS-Cluster zu automatisieren.
    *   **Diskussion – Das "Warum" (Sprint-Ziel Formulierung):**
        *   Der Product Owner betonte, dass der wahre Wert von DevOps in der Geschwindigkeit und Zuverlässigkeit liegt, mit der Änderungen ausgeliefert werden können. Eine manuelle `helm install`-Ausführung ist fehleranfällig und nicht skalierbar. Eine CI/CD-Pipeline ist das letzte Puzzlestück, um eine End-to-End-Automatisierung zu erreichen.
        *   Das Development Team hob hervor, dass eine sichere Authentifizierung (ohne langlebige AWS Keys in GitHub) und eine automatisierte Validierung (mit `helm test`) nicht-funktionale Kernanforderungen sind.
        *   Unter Berücksichtigung der Erkenntnis aus der Sprint-4-Retrospektive (Automatisierung des zweistufigen Upgrade-Prozesses) wurde das folgende, präzisierte Sprint-Ziel formuliert:
            *   *"Eine sichere und voll-automatisierte CI/CD-Pipeline ist etabliert. Sie wird bei einem Push auf den `main`-Branch getriggert, authentifiziert sich sicher via OIDC bei AWS, installiert oder aktualisiert das Nextcloud Helm Chart im EKS-Cluster, löst das "Load Balancer Hostname"-Problem automatisiert und verifiziert das erfolgreiche Deployment durch die Ausführung der Helm-Tests."*
    *   **Diskussion – Das "Was" (Auswahl der Sprint Backlog Items):**
        *   Basierend auf dem Ziel wurden die folgenden User Stories als essentiell identifiziert:
            *   `Nextcloud#20` (OIDC Authentifizierung): Dies ist die Grundvoraussetzung für jede sichere Interaktion zwischen GitHub und AWS und muss als Erstes umgesetzt werden.
            *   `Nextcloud#21` (GitHub Actions Workflow): Dies ist die Kern-User-Story. Es wurde beschlossen, dass diese Story auch die automatische Ausführung der Helm-Tests (`Nextcloud#24`) am Ende des Deployments beinhalten soll, da dies ein integraler Bestandteil eines "guten" Deployments ist.
            *   `Nextcloud#23` (Pipeline Status Badge): Eine kleine, aber sehr nützliche User Story, um die Transparenz zu erhöhen. Passt gut in den Sprint.
        *   **Bewusste Entscheidung (De-Scoping):** Die User Story `Nextcloud#22` (Terraform Plan/Apply in CI/CD) wurde bewusst aus dem Sprint-Ziel und -Backlog herausgenommen. Die Automatisierung von Infrastrukturänderungen ist ein grosses, eigenes Thema. Für diesen Sprint liegt der Fokus klar auf dem **Application Deployment**. `#22` bleibt als wichtige Idee im Product Backlog.
    *   **Diskussion – Das "Wie" (Grobe Planung der Umsetzung):**
        1.  **Terraform-Vorbereitung für OIDC:** Zuerst muss die AWS-Infrastruktur angepasst werden. Eine neue IAM-Rolle für GitHub Actions wird via Terraform erstellt, die dem GitHub-Repository erlaubt, sich via OIDC zu authentifizieren. Dies ist der Hauptteil von `#20`.
        2.  **GitHub-Konfiguration:** Die für das Deployment notwendigen Secrets (z.B. das RDS-Passwort) werden als "Repository Secrets" in GitHub hinterlegt, damit die Pipeline darauf zugreifen kann.
        3.  **Workflow-Implementierung (`.github/workflows/deploy.yml`):** Der Workflow wird schrittweise aufgebaut:
            *   Trigger auf `push` zum `main`-Branch.
            *   Einrichten der OIDC-Berechtigungen im Job (`permissions: id-token: write`).
            *   Nutzung der offiziellen `aws-actions` zum Konfigurieren der AWS-Credentials und der `kubeconfig`.
            *   **Lösung für das "Upgrade"-Problem:** Der Workflow wird ein Skript enthalten, das nach einem initialen `helm upgrade --install` in einer Schleife den Load-Balancer-Hostnamen abfragt (`kubectl get svc...`). Sobald der Hostname verfügbar ist, wird ein zweites, finales `helm upgrade` mit dem korrekten `nextcloud.host`-Wert ausgeführt.
            *   Als letzter Schritt im Job wird `helm test` ausgeführt.
        4.  **Badge-Integration:** Sobald die Pipeline einmal gelaufen ist, wird der Markdown-Code für das Status-Badge aus GitHub kopiert und in die `README.md`-Datei eingefügt (`#23`).
*   **Sprint-Ziel (committet für Sprint 5):**
    *   "Eine sichere und voll-automatisierte CI/CD-Pipeline ist etabliert. Sie wird bei einem Push auf den `main`-Branch getriggert, authentifiziert sich sicher via OIDC bei AWS, installiert oder aktualisiert das Nextcloud Helm Chart im EKS-Cluster, löst das "Load Balancer Hostname"-Problem automatisiert und verifiziert das erfolgreiche Deployment durch die Ausführung der Helm-Tests."
*   **Sprint Backlog (Committete User Stories für Sprint 5):**
    *   `Nextcloud#20`: OIDC Authentifizierung für GitHub Actions zu AWS einrichten (via Terraform).
    *   `Nextcloud#21`: GitHub Actions Workflow für Helm Chart Deployment erstellen (inkl. `helm test` Ausführung).
    *   `Nextcloud#23`: Pipeline Status Badge im README anzeigen.
*   **Wichtigste Daily Scrum Erkenntnis / Impediment:** *(Wird im Sprint ergänzt)*
*   **Erreichtes Inkrement / Ergebnisse:** *(Wird im Sprint ergänzt)*
*   **Sprint Review (Kurzfazit & Demo-Highlight):** *(Wird im Sprint ergänzt)*
*   **Sprint Retrospektive (Wichtigste Aktion):** *(Wird im Sprint ergänzt)*

---

#### **Sprint 6: Finalisierung, Testing & Projektabschluss**

* **Dauer:** ca. 04. Juli 2025 - 09. Juli 2025 *(Beispiel, an dein Gantt anpassen, bis zur Abgabe)*
* **Zugehöriges Epic:** `EPIC-ABSCHLUSS`
* **Vorläufiges Sprint-Ziel:** Abschluss aller Entwicklungsarbeiten, finales Testen der Gesamtlösung, Finalisierung der
  Projektdokumentation (`README.md`) und Vorbereitung der Abschlusspräsentation.
* **Mögliche Themen / User Story Schwerpunkte (Auswahl im Sprint Planning):**
    * `Nextcloud#25`: Checkliste für manuelle Regressionstests erstellen
    * `Nextcloud#26`: Systemarchitektur-Diagramm erstellen und pflegen (Finalisierung)
    * `Nextcloud#27`: Sprint-Zusammenfassungen im README pflegen (laufend)
    * `Nextcloud#28`: Installations- und Inbetriebnahme-Anleitung erstellen (Finalisierung)
    * `Nextcloud#29`: Offene Issues vor Abgabe triagieren
    * `Nextcloud#30`: Präsentation und Demo für Kolloquium vorbereiten
    * `Nextcloud#31`: Codebase finalisieren und kommentieren
    * `Nextcloud#32`: Reflexionskapitel im README vervollständigen
* **Wichtigste Daily Scrum Erkenntnis / Impediment:** *(Wird im Sprint ergänzt)*
* **Erreichtes Inkrement / Ergebnisse:** *(Wird im Sprint ergänzt)*
    *   **OIDC Authentifizierung für GitHub Actions zu AWS eingerichtet (User Story #20 ✓):**
        *   Mittels Terraform wurde ein IAM OIDC Identity Provider in AWS erstellt, der eine Vertrauensstellung zu `token.actions.githubusercontent.com` herstellt.
        *   Eine neue, dedizierte IAM-Rolle (`Nextcloud-cicd-role`) wurde via Terraform provisioniert.
        *   Die Trust Policy dieser Rolle wurde präzise konfiguriert, um nur Workflows aus dem spezifischen Projekt-Repository (`Stevic-Nenad/Nextcloud`) und dem `main`-Branch zu autorisieren, die Rolle zu übernehmen (`sts:AssumeRoleWithWebIdentity`).
        *   Eine granulare IAM-Policy mit den minimal notwendigen Berechtigungen (`eks:DescribeCluster`, `eks:AccessKubernetesApi`) wurde erstellt und an die Rolle angehängt, um das Least-Privilege-Prinzip zu wahren.
        *   Die erfolgreiche Konfiguration wurde durch einen Test-Workflow verifiziert, der die Rolle erfolgreich übernehmen und `aws sts get-caller-identity` ausführen konnte.
        *   Die Dokumentation des Setups wurde in Abschnitt [4.3.2](#432-authentifizierung-gegenüber-aws-oidc) ergänzt.
* **Sprint Review (Kurzfazit & Demo-Highlight):** *(Dies ist quasi die Generalprobe für die Abgabe/Präsentation)*
* **Sprint Retrospektive (Wichtigste Aktion):** *(Abschliessende Reflexion über das gesamte Projekt und den
  Lernprozess)*

---

## 2.4 Risiken

Die Identifikation und das Management potenzieller Risiken sind entscheidend für den Projekterfolg. Folgende Risiken
wurden identifiziert und mit entsprechenden Gegenmassnahmen bewertet:

| ID | Risiko Beschreibung                                                     | Eintritts-Wahrscheinlichkeit (H/M/N) | Auswirkung bei Eintritt (H/M/N) | Risikowert (H/M/N) | Gegenmassnahme(n)                                                                                                                                   | Verantwortlich | Status |
|----|-------------------------------------------------------------------------|--------------------------------------|---------------------------------|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|----------------|--------|
| R1 | Technische Komplexität der Integration (Nextcloud, K8s, DB, IaC, CI/CD) | H                                    | H                               | H                  | Iteratives Vorgehen, Fokus auf Kernfunktionalität, Nutzung von Managed Services, Rückgriff auf CKA-Wissen, sorgfältige Recherche & Dokumentation.   | N. Stevic      | Offen  |
| R2 | Zeitlicher Aufwand für ca. 50h sehr ambitioniert                        | H                                    | H                               | H                  | Striktes Zeit- und Scope-Management, Priorisierung der Kernziele, frühzeitiger Beginn, realistische Aufwandsschätzung pro Task, Pufferzeiten.       | N. Stevic      | Offen  |
| R3 | Cloud-Kosten (Managed Kubernetes & DB-Dienste) | M | M | M | Aktives Kostenmanagement (AWS Dashboard), Nutzung kleinster möglicher Instanzgrössen, regelmässiges `terraform destroy`, **AWS Budget mit $10 Limit und E-Mail-Alerts konfiguriert** | N. Stevic | **Mitigiert** |
| R4 | Hoher Debugging-Aufwand (Terraform, Helm, CI/CD)                        | M                                    | H                               | H                  | Inkrementelles Testen, Nutzung von `terraform plan/validate`, `helm lint/template`, GitHub Actions Debugging-Optionen, systematisches Logging.      | N. Stevic      | Offen  |
| R5 | Komplexität des Secrets Managements über gesamten Workflow              | M                                    | H                               | H                  | Einsatz von GitHub Actions OIDC für Cloud-Authentifizierung, Kubernetes Secrets, Least Privilege Prinzip, Dokumentation des Ansatzes.               | N. Stevic      | Offen  |
| R6 | Inkonsistente Tool-Versionen zwischen Entwicklungsumgebungen | N | M | N | Dokumentierte Versionsanforderungen, Verwendung von Version Managern (tfenv, asdf) empfohlen | N. Stevic | Mitigiert |

*(Diese Risikomatrix wird bei Bedarf im Laufe des Projekts aktualisiert.)*

### 2.5 Stakeholder und Kommunikation

Die primären Stakeholder dieser Semesterarbeit sind:

* **Student (Durchführender):** Nenad Stevic
* **Experte Projektmanagement:** Corrado Parisi (TBZ)
* **Experte Fachliches Modul (IaC):** Armin Dörzbach (TBZ)

Die Kommunikation erfolgt primär über den dafür vorgesehenen MS Teams Kanal. Die im Ablaufplan der TBZ definierten
Einzelbesprechungen dienen als formelle Feedback- und Abstimmungstermine. Darüber hinaus wird bei Bedarf proaktiv der
Kontakt zu den Experten gesucht. Der aktuelle Projektstand ist jederzeit über das GitHub Repository einsehbar. Wichtige
Entscheidungen oder Änderungen am Scope werden mit den Experten abgestimmt und dokumentiert.

---

## 3. Evaluation

*Hier begründe ich meine Technologie-Wahl und erkläre die theoretischen Konzepte dahinter.*

### 3.1 Evaluation von Lösungen

*Warum AWS, EKS, Terraform, Helm und GitHub Actions? Hier steht's, mit kurzen Vergleichen zu Alternativen.*

#### 3.1.1 Cloud Provider (AWS)

Die Wahl fiel auf AWS aufgrund der breiten Verfügbarkeit von Managed Services wie EKS (Elastic Kubernetes Service) und
RDS (Relational Database Service), die für dieses Projekt zentral sind. Zudem bietet AWS umfangreiche Dokumentationen
und eine grosse Community, was die Einarbeitung und Fehlersuche erleichtert. Vorhandene Grunderfahrungen mit AWS
beschleunigen zudem die Umsetzung.

##### Regionale Entscheidung

Für dieses Projekt wurde **eu-central-1 (Frankfurt)** als AWS-Region gewählt aufgrund von:

- Niedrige Latenz für Zugriffe aus der Schweiz
- Vollständige Verfügbarkeit aller benötigten Services (EKS, RDS, ECR)
- DSGVO-konforme Datenhaltung innerhalb der EU
- Gute Dokumentation und Community-Support

#### 3.1.2 Container Orchestrierung (Kubernetes - EKS)

Kubernetes ist der De-facto-Standard für Container-Orchestrierung und ermöglicht skalierbare, resiliente Deployments.
AWS EKS als Managed Service reduziert den administrativen Aufwand für den Betrieb des Kubernetes-Clusters erheblich und
integriert sich gut in das AWS-Ökosystem.

#### 3.1.3 Infrastructure as Code (Terraform)

Terraform wurde gewählt, da es ein Cloud-agnostisches, weit verbreitetes IaC-Werkzeug ist, das die deklarative
Beschreibung und Versionierung der gesamten Infrastruktur ermöglicht. Dies fördert Wiederholbarkeit, Nachvollziehbarkeit
und reduziert manuelle Fehler.

#### 3.1.4 Application Configuration Management (Helm)

Helm ist der Standard-Paketmanager für Kubernetes und vereinfacht das Definieren, Installieren und Verwalten von
Kubernetes-Anwendungen. Für die Bereitstellung von Nextcloud mit seinen verschiedenen Komponenten (Deployment, Service,
PVC, Secrets) ist Helm ideal, um Konfigurationen zu templatzieren und wiederverwendbar zu machen.

#### 3.1.5 CI/CD Werkzeug (GitHub Actions)

GitHub Actions ist direkt in die GitHub-Plattform integriert, wo das Projekt gehostet wird. Dies ermöglicht eine
nahtlose Automatisierung von Build-, Test- und Deployment-Prozessen bei Code-Änderungen und bietet eine gute Integration
mit AWS für sichere Deployments (z.B. via OIDC).

#### 3.1.6 Entwicklungswerkzeuge und Versionen

Für die Konsistenz und Reproduzierbarkeit wurden folgende Tool-Versionen gewählt:

- **Terraform 1.12.x**: Neueste stabile Version mit allen erforderlichen AWS Provider Features
- **kubectl 1.33.x**: Kompatibel mit EKS 1.30 (±1 Minor Version Regel)
- **Helm 3.18.x**: Aktuelle v3 mit stabiler Chart v2 Unterstützung
- **AWS CLI 2.27.x**: Moderne Version mit SSO und erweiterten Features

### 3.2 Theoretische Grundlagen

*Die wichtigsten Konzepte, die für dieses Projekt relevant sind, kurz und knackig erklärt.*

#### 3.2.1 Infrastructure as Code (IaC) - Prinzipien

* Deklarative Definition der Infrastruktur als Code, Versionierung, Automatisierung der Provisionierung, Idempotenz.

#### 3.2.2 CI/CD - Konzepte und Phasen

* Continuous Integration (automatisches Bauen und Testen bei Code-Änderungen), Continuous Deployment/Delivery (
  automatisiertes Ausliefern in Umgebungen). Phasen: Build, Test, Deploy.

#### 3.2.3 Kubernetes - Kernkomponenten (für Nextcloud relevant)

* Pods, Deployments, Services (LoadBalancer/NodePort), PersistentVolumeClaims (PVCs), Secrets, ConfigMaps.

#### 3.2.4 Helm - Charts, Releases, Templates

* Charts als Pakete, Releases als Instanzen eines Charts, Templates zur Generierung von K8s-Manifesten.

#### 3.2.5 Nextcloud auf Kubernetes - Architekturüberlegungen

* Stateful Anwendung, benötigt persistenten Speicher für Daten und Konfiguration, Datenbankanbindung, Zugriff von
  extern.

### 3.3 System-Design / Architektur

*Wie das alles zusammenspielt – visualisiert mit Diagrammen.*

#### 3.3.1 Logische Gesamtarchitektur

* Eine erste Skizze der logischen Gesamtarchitektur ist in Arbeit und wird die Interaktion zwischen GitHub Actions, ECR,
  AWS EKS (mit Nextcloud Pods), AWS RDS und dem Endbenutzer visualisieren.
* *(Platzhalter für Diagramm aus `./assets/images/logical_architecture.png` und Beschreibung)*

### 3.3.2 AWS Netzwerkarchitektur (VPC Detail)

Die Kern-Netzwerkinfrastruktur in AWS wird durch eine Virtual Private Cloud (VPC) gebildet. Für Hochverfügbarkeit und
zur Trennung von Diensten mit direktem Internetzugriff und internen Diensten ist die VPC wie folgt strukturiert:

* **VPC:** Ein logisch isolierter Bereich im AWS-Netzwerk mit dem konfigurierbaren CIDR-Block (Standard: `10.0.0.0/16`).
* **Availability Zones (AZs):** Um Ausfallsicherheit zu gewährleisten, werden Ressourcen über mindestens zwei AZs
  verteilt (Standard: `eu-central-1a` und `eu-central-1b`).
* **Öffentliche Subnetze:** In jeder genutzten AZ gibt es ein öffentliches Subnetz. Diese Subnetze haben eine direkte
  Route zum Internet über ein gemeinsames Internet Gateway (IGW). Hier werden Ressourcen platziert, die direkt aus dem
  Internet erreichbar sein müssen (z.B. Load Balancer) und die NAT Gateways.
* **Private Subnetze:** In jeder genutzten AZ gibt es ein privates Subnetz. Diese Subnetze haben keine direkte Route zum
  Internet.
* **Internet Gateway (IGW):** Ein einzelnes IGW wird an die VPC angehängt und ermöglicht die Kommunikation zwischen
  Ressourcen in den öffentlichen Subnetzen und dem Internet.
* **NAT Gateways (pro AZ):** Um eine hohe Verfügbarkeit für ausgehenden Internetverkehr aus den privaten Subnetzen zu
  gewährleisten, wird **in jeder Availability Zone ein eigenes NAT Gateway** im jeweiligen öffentlichen Subnetz
  platziert. Jedes NAT Gateway erhält eine eigene Elastic IP.
* **Routing-Tabellen:**
    * **Öffentliche Route-Tabelle:** Eine gemeinsame Routing-Tabelle für alle öffentlichen Subnetze, die den gesamten
      externen Traffic (`0.0.0.0/0`) an das IGW leitet.
    * **Private Route-Tabellen (pro AZ):** Für jede Availability Zone existiert eine separate private Routing-Tabelle.
      Jede dieser Tabellen leitet den ausgehenden Traffic (`0.0.0.0/0`) aus den privaten Subnetzen dieser AZ an das NAT
      Gateway, das sich **in derselben AZ** befindet. Diese Strategie stellt sicher, dass der Ausfall eines NAT Gateways
      in einer AZ den ausgehenden Verkehr der anderen AZs nicht beeinträchtigt.

Diese Architektur bietet eine solide Grundlage für hochverfügbare Anwendungen, indem sie sicherstellt, dass Ressourcen
über mehrere AZs verteilt sind und der Netzwerkverkehr entsprechend geleitet wird.

Das folgende Diagramm visualisiert diese Architektur:

[PLATZHALTER]
![AWS VPC Netzwerkarchitektur mit NAT Gateway pro AZ](assets/images/vpc_architecture.png)
*(Diagramm: AWS VPC mit 2 AZs, je ein öffentliches und privates Subnetz. Ein IGW. In jedem öffentlichen Subnetz ein NAT
Gateway. Eine öffentliche Routing-Tabelle. Zwei private Routing-Tabellen, die jeweils auf das NAT GW in ihrer AZ
zeigen.)*

#### 3.3.3 Komponenten und Datenflüsse

* *(Kurze Beschreibung der Hauptkomponenten und wie sie interagieren)*

#### 3.3.4 AWS EKS Architektur Detail

Der AWS Elastic Kubernetes Service (EKS) bildet das Herzstück der Container-Orchestrierungsplattform für die
Nextcloud-Anwendung. Die Architektur ist darauf ausgelegt, die von AWS verwaltete Control Plane zu nutzen und die Worker
Nodes sicher innerhalb der in [Abschnitt 3.3.2](#332-aws-netzwerkarchitektur-vpc-detail) definierten VPC zu betreiben.

* **EKS Control Plane:** Von AWS verwaltet, hochverfügbar über mehrere Availability Zones. Die Kommunikation mit der
  Control Plane erfolgt über einen API-Server-Endpunkt. Für den Zugriff durch `kubectl` und andere Management-Tools wird
  dieser Endpunkt genutzt. Die Control Plane selbst residiert nicht direkt in der User-VPC, sondern interagiert über
  Elastic Network Interfaces (ENIs), die in den angegebenen Subnetzen der VPC platziert werden (typischerweise
  öffentliche Subnetze für den öffentlichen Endpunkt).
* **EKS Managed Node Groups:** Die Worker Nodes, auf denen die Nextcloud-Pods laufen werden, werden als Teil von Managed
  Node Groups in den **privaten Subnetzen** der VPC provisioniert. Dies schützt die Nodes vor direktem Zugriff aus dem
  Internet. Die Nodes benötigen ausgehenden Internetzugriff (über die NAT Gateways in den öffentlichen Subnetzen) für
  das Herunterladen von Images, Updates und die Kommunikation mit AWS-Diensten.
*   **Launch Template für Worker Nodes:** Eine Standard-EKS-Konfiguration führt zu einem subtilen, aber kritischen Problem: Pods auf den Worker Nodes können den EC2 Instance Metadata Service (IMDS) nicht erreichen. Dies ist erforderlich, damit Systemkomponenten wie der EBS CSI Driver ihre eigene Availability Zone ermitteln können. Der Grund ist, dass der Netzwerk-Hop vom Pod zum Node die standardmässige "Hop Limit" des IMDS von `1` überschreitet.
    *   **Lösung:** Um dieses Problem zu beheben, wird eine dedizierte **AWS Launch Template** für die Worker Nodes erstellt. In dieser Vorlage wird die "Metadata response hop limit" explizit auf `2` gesetzt. Die EKS Managed Node Group wird dann so konfiguriert, dass sie diese Launch Template anstelle der Standardeinstellungen verwendet. Dies ist die von AWS empfohlene Best Practice, um die Kompatibilität zwischen der EKS-Netzwerk-Abstraktion und dem zugrundeliegenden EC2-Metadatendienst sicherzustellen.
* **IAM-Rollen:**
    * **EKS Cluster Role:** Ermächtigt den EKS-Service, AWS-Ressourcen im Namen des Clusters zu verwalten (z.B. Load
      Balancer, ENIs).
    * **EKS Node Role:** Wird von den EC2-Instanzen der Worker Nodes übernommen und gewährt ihnen die notwendigen
      Berechtigungen, um sich beim Cluster zu registrieren, Container-Images aus ECR zu ziehen (
      `AmazonEC2ContainerRegistryReadOnly`), Protokolle an CloudWatch zu senden und Netzwerkoperationen durchzuführen (
      `AmazonEKS_CNI_Policy`, `AmazonEKSWorkerNodePolicy`).
* **Netzwerk-Kommunikation:**
    * Der EKS-Cluster benötigt spezifische Security Groups, um die Kommunikation zwischen der Control Plane und den
      Worker Nodes sowie für den Pod-zu-Pod-Verkehr zu ermöglichen. Terraform managt die Erstellung und Konfiguration
      dieser Security Groups.
    * Die Worker Nodes in den privaten Subnetzen kommunizieren mit der Control Plane über deren ENIs und für ausgehenden
      Verkehr mit dem Internet über die NAT Gateways.

Das folgende Diagramm illustriert die EKS-Architektur innerhalb der bestehenden VPC:

[PLATZHALTER]
![AWS EKS Architektur Detail](assets/images/eks_architecture_detail.png)
*(Diagramm: Stellt die VPC mit öffentlichen/privaten Subnetzen dar. Die EKS Control Plane als AWS Managed Service
außerhalb, mit Pfeilen zu ENIs in den (typischerweise öffentlichen) Subnetzen. Worker Nodes (EC2-Instanzen) befinden
sich in den privaten Subnetzen. Pfeile zeigen Kommunikation von Nodes zu Control Plane ENIs und über NAT Gateways nach
außen. Optional: Load Balancer in öffentlichen Subnetzen, der auf Services auf den Worker Nodes zeigt.)*

---

## 4. Implementierung und Technische Umsetzung

*Hier geht's ans Eingemachte: Wie habe ich die Lösung technisch realisiert? Mit Code-Beispielen!*

### 4.1 Infrastruktur-Provisionierung mit Terraform

*Aufbau der AWS-Infrastruktur Schritt für Schritt mit Terraform.*

#### 4.1.0 Terraform Remote State Backend-Konfiguration

Um den Terraform State der Hauptanwendungsinfrastruktur zentral, sicher und versioniert zu verwalten sowie
Kollaborationen zu ermöglichen, wird der State in einem AWS S3 Bucket gespeichert. Für State Locking, um konkurrierende
Änderungen und State Corruption zu verhindern, wird eine AWS DynamoDB-Tabelle verwendet. Dies erfüllt die Anforderungen
der User Story `Nextcloud#6`.

**Management der Backend-Infrastruktur:**
Die für das Remote Backend benötigten AWS-Ressourcen (S3 Bucket, DynamoDB-Tabelle) werden **nicht direkt durch die
Terraform-Konfiguration der Hauptanwendung (`src/terraform/`) erstellt oder verwaltet.** Stattdessen folgen wir der Best
Practice, diese Backend-Infrastruktur in einer **separaten, dedizierten Terraform-Konfiguration** zu provisionieren und
zu managen. Für dieses Projekt befindet sich diese Konfiguration beispielsweise im Verzeichnis
`terraform-backend-setup/` (oder `backend/` wie in der praktischen Umsetzung).

Diese separate Konfiguration ist verantwortlich für:

* **S3 Bucket (`aws_s3_bucket`):**
    * Erstellung eines global eindeutigen S3 Buckets (z.B. `nenad-stevic-nextcloud-tfstate`).
    * Aktivierung der **Versionierung (`aws_s3_bucket_versioning`)**, um frühere Versionen des States wiederherstellen
      zu können.
    * Konfiguration der **Server-Side Encryption (`aws_s3_bucket_server_side_encryption_configuration`)** (z.B. SSE-S3)
      für die Verschlüsselung der State-Datei im Ruhezustand.
    * Implementierung eines **Public Access Blocks (`aws_s3_bucket_public_access_block`)**, um jeglichen öffentlichen
      Zugriff zu unterbinden.
    * Empfehlung: Einsatz von `lifecycle { prevent_destroy = true }` zum Schutz des State Buckets.
* **DynamoDB-Tabelle (`aws_dynamodb_table`):**
    * Erstellung einer DynamoDB-Tabelle (z.B. `nenad-stevic-nextcloud-tfstate-lock`) für das Terraform State Locking.
    * Definition des Primärschlüssels `LockID` (Typ: String).
    * Verwendung des Billing Mode `PAY_PER_REQUEST`.

Die Erstellung und Verwaltung dieser Ressourcen über die separate Konfiguration stellt sicher, dass die
Backend-Infrastruktur unabhängig vom Lebenszyklus der Hauptanwendungsinfrastruktur ist. Somit kann die
Hauptanwendungsinfrastruktur (VPC, EKS, etc.) mittels `terraform destroy` aus `src/terraform/` entfernt werden, ohne den
Remote State selbst zu gefährden.

**Konfiguration des Backends in der Hauptanwendung (`src/terraform/`):**
Die Terraform-Konfiguration der Hauptanwendung in `src/terraform/` enthält dann lediglich die Backend-Definition in
einer Datei (z.B. `backend.tf`), die Terraform anweist, den zuvor separat erstellten S3 Bucket und die DynamoDB-Tabelle
zu verwenden:

```terraform
// src/terraform/backend.tf
terraform {
  backend "s3" {
    bucket = "nenad-stevic-nextcloud-tfstate" // Name des extern erstellten S3 Buckets
    key = "nextcloud-app/main.tfstate"     // Pfad zur State-Datei im Bucket für diese Anwendung
    region = "eu-central-1"                   // AWS Region des Buckets
    dynamodb_table = "nenad-stevic-nextcloud-tfstate-lock" // Name der extern erstellten DynamoDB Tabelle
    encrypt = true
  }
}
```

Nach dieser Konfiguration wird `terraform init` im Verzeichnis `src/terraform/` ausgeführt, wodurch Terraform sich mit
dem spezifizierten S3 Bucket und der DynamoDB-Tabelle verbindet. Alle nachfolgenden Operationen (`plan`, `apply`,
`destroy`) für die Hauptanwendungsinfrastruktur verwenden diesen Remote State.

#### 4.1.1 Terraform Code-Struktur, Module und initiale Provider-Konfiguration

Die Verwaltung der AWS-Infrastruktur erfolgt mittels Terraform. Der Code ist im Verzeichnis `src/terraform/`
strukturiert.
Zum Start des Projekts (im Rahmen von User Story `Nextcloud#7`) wurden folgende initiale Konfigurationsdateien erstellt:

* **`versions.tf`**: Definiert die erforderliche Terraform-Version und die Versionen der benötigten Provider (z.B. AWS
  Provider).
  ```terraform
  // src/terraform/versions.tf
  terraform {
    required_version = ">= 1.12.1"

    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 5.99.1"
      }
    }
  }
  ```
* **`variables.tf`**: Enthält Definitionen für Eingabevariablen, wie z.B. die AWS-Region.
  ```terraform
  // src/terraform/variables.tf
  variable "aws_region" {
    description = "The AWS region to deploy resources in."
    type        = string
    default     = "eu-central-1"
  }
  ```
* **`locals.tf`**: Dient zur Definition lokaler Variablen, insbesondere für die Standard-Tags. (Siehe
  Abschnitt [4.1.1a](#411a-globale-tagging-strategie-für-kostenmanagement)).
* **`provider.tf`**: Konfiguriert den AWS-Provider, einschliesslich der Region und der `default_tags` für das
  Kostenmanagement. (Siehe Abschnitt [4.1.1a](#411a-globale-tagging-strategie-für-kostenmanagement)).

Module werden in diesem Projekt initial nicht verwendet, könnten aber bei wachsender Komplexität zur Strukturierung von
wiederverwendbaren Infrastrukturkomponenten eingeführt werden.

**Backend-Infrastruktur-Code:**
Es ist wichtig zu beachten, dass die AWS-Ressourcen für das Terraform Remote Backend selbst (S3 Bucket, DynamoDB
Tabelle) in einer separaten Terraform-Konfiguration verwaltet werden (z.B. in einem Verzeichnis wie
`terraform-backend-setup/` oder `backend/` auf der Root-Ebene des Projekts). Dies entkoppelt die Verwaltung der
Backend-Infrastruktur vom Lebenszyklus der Anwendungs-Infrastruktur. Die `src/terraform/` Konfiguration enthält
lediglich die `backend.tf`-Datei, um diesen externen Backend zu nutzen.

#### 4.1.1a Globale Tagging-Strategie für Kostenmanagement

Um die Projektkosten im AWS Billing Dashboard klar zuordnen und nachverfolgen zu können, wurde eine einheitliche
Tagging-Strategie für alle via Terraform erstellten AWS-Ressourcen implementiert. Dies erfüllt die Anforderungen der
User Story `Nextcloud#7` und wurde als Teil der initialen Terraform-Provider-Konfiguration eingerichtet.

**Ansatz:**
Die Implementierung nutzt den `default_tags` Block innerhalb der AWS Provider-Konfiguration. Dieser Ansatz stellt
sicher, dass ein definierter Satz von Tags automatisch an alle Ressourcen angehängt wird, die von diesem Provider
erstellt werden und Tagging unterstützen.

**Definition der Standard-Tags:**
Ein Set von Standard-Tags wurde in einer lokalen Variable (`local.common_tags`) in der Datei `src/terraform/locals.tf`
definiert:

```terraform
// src/terraform/locals.tf
locals {
  common_tags = {
    Projekt   = "Nextcloud"
    Student   = "NenadStevic"
    ManagedBy = "Terraform"
  }
}
```

**Anwendung im AWS Provider:**
Diese lokalen Tags werden dann im `provider "aws"` Block in der Datei `src/terraform/provider.tf` referenziert:

```terraform
// src/terraform/provider.tf
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}
```

Durch diese zentrale Konfiguration wird sichergestellt, dass alle kostenverursachenden Ressourcen wie VPC, Subnetze,
EKS-Knoten, RDS-Instanzen etc. konsistent getaggt werden, ohne dass die Tags bei jeder einzelnen Ressourcendefinition
manuell hinzugefügt werden müssen. Ressourcenspezifische Tags können bei Bedarf weiterhin definiert werden und
überschreiben die Default-Tags bei gleichem Schlüssel oder ergänzen sie.

#### 4.1.2 Provisionierung des Netzwerks (VPC)

Das Fundament der AWS-Infrastruktur bildet das Netzwerk, welches mittels Terraform im Verzeichnis `src/terraform/` (z.B.
in `network.tf`) definiert wird. Dieses Modul erstellt eine VPC, öffentliche und private Subnetze über die
konfigurierten Availability Zones, ein Internet Gateway sowie eine hochverfügbare NAT-Gateway-Architektur.

**Design-Entscheidung: NAT Gateway pro Availability Zone**
Für eine erhöhte Ausfallsicherheit wird in jeder Availability Zone (AZ), die Subnetze beherbergt, ein eigenes NAT
Gateway im jeweiligen öffentlichen Subnetz provisioniert. Jedes NAT Gateway erhält eine eigene Elastic IP. Entsprechend
gibt es für jede AZ eine dedizierte private Routing-Tabelle, die den ausgehenden Internetverkehr der privaten Subnetze
dieser AZ über das NAT Gateway derselben AZ leitet. Diese Strategie verhindert, dass der Ausfall eines einzelnen NAT
Gateways die Konnektivität für alle privaten Subnetze beeinträchtigt.

**Kernkomponenten und Terraform-Konfigurationen:**

1. **Variablen (`variables.tf`):**
    * `vpc_cidr_block`: Definiert den CIDR-Bereich für die VPC (Standard: `"10.0.0.0/16"`).
    * `availability_zones`: Liste der zu verwendenden AZs (Standard: `["eu-central-1a", "eu-central-1b"]`).
    * `public_subnet_cidrs`: CIDR-Blöcke für öffentliche Subnetze, korrespondierend zu den AZs.
    * `private_subnet_cidrs`: CIDR-Blöcke für private Subnetze, korrespondierend zu den AZs.
    * `project_name`: Wird für die Benennung und Tagging der Ressourcen verwendet.

2. **VPC (`aws_vpc.main`):**
   Die VPC wird mit dem definierten CIDR-Block erstellt. DNS-Hostnamen und DNS-Unterstützung sind aktiviert.
   ```terraform
   // src/terraform/network.tf
   resource "aws_vpc" "main" {
     cidr_block           = var.vpc_cidr_block
     enable_dns_support   = true
     enable_dns_hostnames = true

     tags = merge(
       local.common_tags,
       { Name = "${var.project_name}-vpc" }
     )
   }
   ```
   *Hinweis: Die `local.common_tags` (`Projekt`, `Student`, `ManagedBy`) werden automatisch durch die
   Provider-Konfiguration oder explizites `merge` hinzugefügt.*

3. **Subnetze (`aws_subnet.public`, `aws_subnet.private`):**
   Öffentliche und private Subnetze werden dynamisch basierend auf den `availability_zones` und den jeweiligen
   CIDR-Listen erstellt. Öffentliche Subnetze erhalten `map_public_ip_on_launch = true`.
   ```terraform
   // Gekürztes Beispiel für öffentliche Subnetze
   resource "aws_subnet" "public" {
     count                   = length(var.public_subnet_cidrs)
     vpc_id                  = aws_vpc.main.id
     cidr_block              = var.public_subnet_cidrs[count.index]
     availability_zone       = var.availability_zones[count.index]
     map_public_ip_on_launch = true
     tags = merge(local.common_tags, {
       Name = "${var.project_name}-public-subnet-${var.availability_zones[count.index]}"
     })
   }
   ```

4. **Internet Gateway (`aws_internet_gateway.main_igw`):**
   Ein IGW wird erstellt und an die VPC angehängt.

5. **NAT Gateways pro AZ (`aws_eip.nat_eip_per_az`, `aws_nat_gateway.nat_gw_per_az`):**
   Für jede in `var.availability_zones` definierte AZ wird eine Elastic IP und ein NAT Gateway im öffentlichen Subnetz
   dieser AZ erstellt.
   ```terraform
   resource "aws_eip" "nat_eip_per_az" {
     count  = length(var.availability_zones)
     domain = "vpc"
     tags = merge(local.common_tags, {
       Name = "${var.project_name}-nat-eip-${var.availability_zones[count.index]}"
     })
   }

   resource "aws_nat_gateway" "nat_gw_per_az" {
     count         = length(var.availability_zones)
     allocation_id = aws_eip.nat_eip_per_az[count.index].id
     subnet_id     = aws_subnet.public[count.index].id
     tags = merge(local.common_tags, {
       Name = "${var.project_name}-nat-gw-${var.availability_zones[count.index]}"
     })
     depends_on = [aws_internet_gateway.main_igw]
   }
   ```

6. **Routing-Tabellen:**
    * **Öffentliche Route-Tabelle (`aws_route_table.public_rt`):** Eine gemeinsame Tabelle, die Traffic (`0.0.0.0/0`)
      zum IGW leitet und mit allen öffentlichen Subnetzen assoziiert wird (
      `aws_route_table_association.public_rt_association`).
    * **Private Route-Tabellen pro AZ (`aws_route_table.private_rt_per_az`):** Für jede AZ wird eine separate private
      Route-Tabelle erstellt. Jede leitet Traffic (`0.0.0.0/0`) zum NAT Gateway in derselben AZ. Die privaten Subnetze
      werden dann mit der jeweiligen AZ-spezifischen privaten Route-Tabelle assoziiert (
      `aws_route_table_association.private_rt_association_per_az`).
      ```terraform
      resource "aws_route_table" "private_rt_per_az" {
        count  = length(var.availability_zones)
        vpc_id = aws_vpc.main.id
        route {
          cidr_block     = "0.0.0.0/0"
          nat_gateway_id = aws_nat_gateway.nat_gw_per_az[count.index].id
        }
        // ... tags ...
      }

      resource "aws_route_table_association" "private_rt_association_per_az" {
        count          = length(aws_subnet.private)
        subnet_id      = aws_subnet.private[count.index].id
        route_table_id = aws_route_table.private_rt_per_az[count.index].id
      }
      ```

Diese Konfiguration stellt ein robustes und hochverfügbares Netzwerkfundament bereit.

#### 4.1.3 Provisionierung des EKS Clusters und der ECR

Der AWS Elastic Kubernetes Service (EKS) Cluster und die zugehörigen Worker Nodes werden mittels Terraform
provisioniert. Dies beinhaltet die Definition der Control Plane, der Node Groups sowie der notwendigen IAM-Rollen und
-Policies. Die Elastic Container Registry (ECR) wird in einem nachfolgenden Schritt (User Story #9) ebenfalls via
Terraform erstellt.

**1. IAM-Rollen für EKS (`iam_eks.tf`)**

Zwei primäre IAM-Rollen sind für den Betrieb von EKS erforderlich:

* **EKS Cluster IAM Role:** Diese Rolle wird vom EKS Control Plane Service übernommen, um AWS-Ressourcen wie Load
  Balancer oder ENIs im Namen des Clusters zu verwalten.
    * **Terraform Ressource:** `aws_iam_role.eks_cluster_role`
    * **Trust Policy:** Erlaubt dem Service `eks.amazonaws.com` die Annahme der Rolle.
      ```terraform
      // src/terraform/iam_eks.tf
      resource "aws_iam_role" "eks_cluster_role" {
        name = "${var.project_name}-eks-cluster-role"

        assume_role_policy = jsonencode({
          Version = "2012-10-17",
          Statement = [
            {
              Effect    = "Allow",
              Action    = "sts:AssumeRole",
              Principal = {
                Service = "eks.amazonaws.com"
              }
            }
          ]
        })
        # ... tags ...
      }
      ```
    * **Angehängte Policy:** `AmazonEKSClusterPolicy`.
      ```terraform
      // src/terraform/iam_eks.tf
      resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
        role       = aws_iam_role.eks_cluster_role.name
      }
      ```

* **EKS Node IAM Role:** Diese Rolle wird von den EC2-Instanzen der Worker Nodes übernommen. Sie gewährt den Nodes die
  Berechtigungen, sich beim Cluster zu registrieren, Container-Images zu pullen, Logs zu schreiben und
  Netzwerkoperationen durchzuführen.
    * **Terraform Ressource:** `aws_iam_role.eks_node_role`
    * **Trust Policy:** Erlaubt dem Service `ec2.amazonaws.com` die Annahme der Rolle.
      ```terraform
      // src/terraform/iam_eks.tf
      resource "aws_iam_role" "eks_node_role" {
        name = "${var.project_name}-eks-node-role"

        assume_role_policy = jsonencode({
          Version = "2012-10-17",
          Statement = [
            {
              Effect    = "Allow",
              Action    = "sts:AssumeRole",
              Principal = {
                Service = "ec2.amazonaws.com"
              }
            }
          ]
        })
        # ... tags ...
      }
      ```
    * **Angehängte Policies:** `AmazonEKSWorkerNodePolicy`, `AmazonEC2ContainerRegistryReadOnly`,
      `AmazonEKS_CNI_Policy`.
      ```terraform
      // src/terraform/iam_eks.tf
      resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKSWorkerNodePolicy" {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        role       = aws_iam_role.eks_node_role.name
      }
      resource "aws_iam_role_policy_attachment" "eks_node_AmazonEC2ContainerRegistryReadOnly" {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        role       = aws_iam_role.eks_node_role.name
      }
      resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKS_CNI_Policy" {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
        role       = aws_iam_role.eks_node_role.name
      }
      ```

**2. EKS Control Plane (`eks_cluster.tf`)**

Die EKS Control Plane wird mit der Ressource `aws_eks_cluster` definiert.

```terraform
// src/terraform/eks_cluster.tf
resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_cluster_version

  vpc_config {
    subnet_ids = concat(aws_subnet.public[*].id, aws_subnet.private[*].id)
    endpoint_private_access = var.eks_endpoint_private_access
    endpoint_public_access  = var.eks_endpoint_public_access
    public_access_cidrs     = var.eks_public_access_cidrs
  }

  tags = merge(
    local.common_tags,
    { Name = "${var.project_name}-eks-cluster" }
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
  ]
}
```

**3. EKS Managed Node Group (`eks_nodegroup.tf`)**

Die Worker Nodes werden in einer `aws_eks_node_group` in den privaten Subnetzen platziert. Um kritische Konnektivitätsprobleme mit dem EC2 Instance Metadata Service (IMDS) zu lösen, wird die Node Group nicht mit Standardeinstellungen, sondern mit einer dedizierten **AWS Launch Template** provisioniert.

```terraform
// src/terraform/launch_template.tf
resource "aws_launch_template" "eks_nodes" {
  name_prefix = "${lower(var.project_name)}-lt-"
  description = "Launch template for EKS worker nodes with custom metadata options"

  metadata_options {
    http_tokens                 = "required" // Enforce IMDSv2
    http_put_response_hop_limit = 2          // Increase hop limit for pods
  }

  lifecycle {
    create_before_destroy = true
  }
}
```

Diese Launch Template wird dann in der Node-Group-Konfiguration referenziert, um sicherzustellen, dass alle erstellten EC2-Instanzen mit der korrekten IMDS-Hop-Limit von `2` konfiguriert sind.

```terraform
// src/terraform/eks_nodegroup.tf
resource "aws_eks_node_group" "main_nodes" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-main-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.private[*].id // Worker Nodes in privaten Subnetzen

  instance_types = var.eks_node_instance_types

  // Verknüpfung mit der dedizierten Launch Template
  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = aws_launch_template.eks_nodes.latest_version
  }

  scaling_config {
    desired_size = var.eks_node_desired_count
    max_size     = var.eks_node_max_count
    min_size     = var.eks_node_min_count
  }

  # ... (rest of the resource) ...
}
```

Die Variablen (z.B. `var.eks_cluster_version`, `var.eks_node_instance_types`, `var.eks_node_desired_count`) sind in
`variables.tf` definiert.

**4. Konfiguration von `kubectl`**

Nach erfolgreichem `terraform apply` wird `kubectl` für den Zugriff auf den neuen Cluster konfiguriert. Dies erfolgt
durch Ausführen des folgenden Befehls in der Kommandozeile, wobei die Platzhalter durch die entsprechenden
Terraform-Outputs oder direkten Werte ersetzt werden:

```bash
aws eks update-kubeconfig --region $(terraform output -raw aws_region) --name $(terraform output -raw eks_cluster_name) --profile nextcloud-project
```

Dieser Befehl aktualisiert die lokale `kubeconfig`-Datei (typischerweise `~/.kube/config`), sodass `kubectl`-Befehle
gegen den neu erstellten EKS-Cluster ausgeführt werden können. Anschliessend kann der Status der Nodes mit
`kubectl get nodes` überprüft werden.

**5. ECR Repository (`ecr.tf`)**

Um die Docker-Images der Nextcloud-Anwendung sicher zu speichern und für den EKS-Cluster bereitzustellen, wird ein privates Amazon Elastic Container Registry (ECR) Repository via Terraform provisioniert.

*   **Repository-Erstellung (`aws_ecr_repository`):** Erstellt das eigentliche Repository. Wichtige Parameter sind:
    *   `name`: Der Name des Repositories, gesteuert über die Variable `var.ecr_repository_name`.
    *   `image_scanning_configuration`: Aktiviert das automatische Scannen von Images beim Hochladen (`scan_on_push = true`), um frühzeitig Sicherheitslücken zu erkennen.

*   **Lifecycle Policy (`aws_ecr_lifecycle_policy`):** Um die Kosten zu kontrollieren und das Repository sauber zu halten, wird eine Lifecycle-Policy definiert. Diese Policy löscht automatisch alle Images, die keinem Tag mehr zugeordnet sind (z.B. nach einem `docker push` mit dem gleichen Tag auf ein neues Image) und älter als 30 Tage sind.

```terraform
// src/terraform/ecr.tf
resource "aws_ecr_repository" "nextcloud_app" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.ecr_repository_name}-repo"
    }
  )
}

resource "aws_ecr_lifecycle_policy" "nextcloud_app_policy" {
  repository = aws_ecr_repository.nextcloud_app.name

  policy = jsonencode({
    rules = [
      # 1. Expire untagged images older than 30 days
      {
        rulePriority = 1,
        description  = "Expire untagged images >30 days",
        selection = {
          tagStatus   = "untagged",
          countType   = "sinceImagePushed",
          countUnit   = "days",
          countNumber = 30
        },
        action = { type = "expire" }
      },
      # 2. Retain only the 10 most-recent tagged images
      {
        rulePriority = 2,
        description  = "Keep last 10 tagged images",
        selection = {
          tagStatus   = "tagged",
          countType   = "imageCountMoreThan",
          countNumber = 10
        },
        action = { type = "expire" }
      }
    ]
  })
}

```

#### 4.1.4 Provisionierung von IAM für Service Accounts (IRSA)

Um Pods im EKS-Cluster den sicheren, passwortlosen Zugriff auf AWS-Dienste zu ermöglichen, wird **IAM Roles for Service Accounts (IRSA)** konfiguriert. Dies ist der von AWS empfohlene Best Practice und vermeidet die Verwendung von langlebigen IAM-Benutzer-Anmeldeinformationen in Pods.

Der Prozess besteht aus zwei Hauptschritten:

1.  **Einmalige Einrichtung eines OIDC Providers:** Es wird eine Vertrauensstellung zwischen dem EKS-Cluster und AWS IAM hergestellt. Der Cluster agiert als OpenID Connect (OIDC) Identity Provider.
2.  **Erstellung von IAM-Rollen pro Anwendung:** Für jede Anwendung (oder jeden AWS-Dienst), die aus dem Cluster heraus auf AWS-Ressourcen zugreifen muss (z.B. der EBS CSI Driver, der AWS Load Balancer Controller), wird eine dedizierte IAM-Rolle mit einer spezifischen Trust Policy erstellt.

Die Terraform-Konfiguration dafür befindet sich in `src/terraform/iam_irsa.tf`.

```terraform
// src/terraform/iam_irsa.tf

# 1. OIDC Provider einrichten
data "tls_certificate" "eks_oidc_thumbprint" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_oidc_thumbprint.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.main.identity[0].oidc[0].issuer

  # ... tags ...
}

# 2. Spezifische IAM-Rolle für den EBS CSI Driver erstellen
resource "aws_iam_role" "ebs_csi_driver_role" {
  name = "${var.project_name}-ebs-csi-driver-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRoleWithWebIdentity",
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks_oidc_provider.arn
        },
        Condition = {
          StringEquals = {
            # Bindet die Rolle an den exakten Service Account
            "${aws_eks_cluster.main.identity[0].oidc[0].issuer}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      }
    ]
  })
  # ... tags ...
}

# Notwendige AWS Policy an die Rolle anhängen
resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.ebs_csi_driver_role.name
}
```
Diese Konfiguration ermöglicht es, einem Kubernetes Service Account (`ebs-csi-controller-sa`) die Annotation `eks.amazonaws.com/role-arn` mit dem ARN der `ebs_csi_driver_role` hinzuzufügen. Der Pod, der diesen Service Account verwendet, erhält dann automatisch temporäre AWS-Anmeldeinformationen mit den Berechtigungen der `AmazonEBSCSIDriverPolicy`.

#### 4.1.4a Korrektur der IRSA Trust Policy

Während der Implementierung des manuellen Deployments (Sprint 3) trat ein `AccessDenied`-Fehler bei der dynamischen Provisionierung von EBS-Volumes auf. Die Events des `PersistentVolumeClaim` zeigten, dass der EBS CSI Driver nicht berechtigt war, die ihm zugewiesene IAM-Rolle via `sts:AssumeRoleWithWebIdentity` zu übernehmen.

*   **Problem:** Die ursprüngliche Trust Policy der IAM-Rolle für den CSI-Treiber war zu restriktiv oder enthielt eine nicht exakt passende Bedingung, was von AWS STS abgelehnt wurde.
*   **Lösung:** Die Trust Policy wurde robuster gestaltet, indem sie nicht nur den `subject` (`sub`) des OIDC-Tokens, sondern auch dessen `audience` (`aud`) validiert. Zudem wurde die Referenz auf den OIDC-Provider-Endpunkt präzisiert, um mögliche Fehlerquellen zu eliminieren.

Die korrigierte und nun funktionale Trust Policy in `iam_irsa.tf` sieht wie folgt aus:

```terraform
// src/terraform/iam_irsa.tf - Korrigierte Trust Policy
resource "aws_iam_role" "ebs_csi_driver_role" {
  name = "${var.project_name}-ebs-csi-driver-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRoleWithWebIdentity",
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks_oidc_provider.arn
        },
        Condition = {
          # Gate 1: Check the 'audience' of the token. It must be 'sts.amazonaws.com'.
          StringEquals = {
            "${replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:aud" = "sts.amazonaws.com"
          },
          # Gate 2: Check the 'subject' of the token. It must match the specific Kubernetes Service Account.
          StringEquals = {
            "${replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      }
    ]
  })
  # ... (restliche Konfiguration) ...
}
```

Diese Anpassung löste das Berechtigungsproblem und ermöglichte dem EBS CSI Driver die erfolgreiche Erstellung von Volumes.

#### 4.1.5 Persistent Storage (EBS CSI Driver)

Für stateful Applikationen wie Nextcloud ist persistenter Speicher unerlässlich. Der **AWS EBS CSI Driver** ist die Brücke zwischen Kubernetes und AWS Elastic Block Store (EBS). Er ermöglicht es Kubernetes, dynamisch EBS Volumes für `PersistentVolumeClaims` (PVCs) zu erstellen und zu verwalten.

**Entscheidungsfindung: EKS Add-on vs. Helm Chart**

Für die Installation des EBS CSI Drivers gibt es zwei gängige Methoden: die Installation via Helm Chart oder die Verwendung des EKS-verwalteten Add-ons. Für dieses Projekt wurde bewusst die Methode des **EKS Add-ons** gewählt.

*   **Begründung:** Der EBS CSI Driver ist keine typische Endanwendung, sondern eine fundamentale Infrastrukturkomponente des Clusters – vergleichbar mit einem Systemtreiber. Die Verwendung des EKS-verwalteten Add-ons ist die von AWS empfohlene Best Practice und bietet entscheidende Vorteile:
    *   **Stabilität und Kompatibilität:** AWS stellt sicher, dass die Add-on-Version stets mit der EKS-Cluster-Version kompatibel ist, was das Risiko von Konflikten minimiert.
    *   **Vereinfachte Verwaltung:** Updates des Drivers können über die EKS-Konsole oder die AWS API/Terraform gesteuert werden, was den Lebenszyklus vereinfacht.
    *   **Klare Trennung:** Diese Wahl unterstreicht die architektonische Trennung zwischen der Basisinfrastruktur des Clusters (verwaltet durch Terraform und Add-ons) und den darauf laufenden Applikationen (verwaltet durch Helm).

Während Helm das primäre Werkzeug für das Deployment der **Nextcloud-Anwendung** sein wird (siehe Sprint 4), wird für diese kritische Basiskomponente der robustere und stärker integrierte Ansatz des EKS Add-ons bevorzugt.

Die Installation erfolgt somit direkt über Terraform in der Datei `src/terraform/eks_addons.tf`.

```terraform
// src/terraform/eks_addons.tf
resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "aws-ebs-csi-driver"

  # Verknüpfung mit der via IRSA erstellten IAM-Rolle
  service_account_role_arn = aws_iam_role.ebs_csi_driver_role.arn

  resolve_conflicts_on_create = "OVERWRITE"

  # ... tags ...
}
```
Die `service_account_role_arn` ist der entscheidende Parameter, der dem Add-on die Berechtigung gibt, über die zuvor in Abschnitt [4.1.4](#414-provisionierung-von-iam-für-service-accounts-irsa) definierte IAM-Rolle zu agieren.

#### 4.1.6 Provisionierung der RDS Datenbank und Security Group

Für die persistente Speicherung der Nextcloud-Anwendungsdaten wird eine AWS Relational Database Service (RDS) Instanz mit PostgreSQL verwendet. Die Provisionierung erfolgt vollständig über Terraform (`rds.tf`, `security_groups.tf`).

*   **Sichere Passwortverwaltung:** Das Master-Passwort wird nicht im Code oder Terraform-State gespeichert. Es wird manuell im **AWS Secrets Manager** hinterlegt. Terraform liest diesen Wert zur Laufzeit über eine `data`-Quelle aus.
    ```terraform
    data "aws_secretsmanager_secret_version" "rds_master_password_version" {
      secret_id = "..." // Referenz zum Secret
    }
    
    resource "aws_db_instance" "nextcloud" {
      // ...
      password = data.aws_secretsmanager_secret_version.rds_master_password_version.secret_string
      // ...
    }
    ```

*   **Netzwerk-Isolation:** Die RDS-Instanz wird mittels einer `aws_db_subnet_group` explizit in den **privaten Subnetzen** der VPC platziert. Sie ist somit nicht direkt aus dem Internet erreichbar.

*   **Kontrollierter Zugriff:** Der Zugriff auf die Datenbank wird durch eine dedizierte Security Group (`aws_security_group.rds`) gesteuert. Eine spezifische Ingress-Regel erlaubt die Verbindung auf Port `5432` (PostgreSQL) ausschliesslich von der Security Group, die den EKS-Worker-Nodes zugeordnet ist. Dies stellt sicher, dass nur die Anwendungspods im Cluster die Datenbank erreichen können.
    ```terraform
    resource "aws_security_group_rule" "eks_to_rds" {
      type                     = "ingress"
      from_port                = 5432
      to_port                  = 5432
      protocol                 = "tcp"
      security_group_id        = aws_security_group.rds.id
      source_security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
    }
    ```

*   **Hochverfügbarkeit:** Durch Setzen der Variable `rds_multi_az_enabled = true` wird eine Standby-Instanz in einer anderen Availability Zone provisioniert, auf die AWS im Falle eines Ausfalls automatisch umschwenkt.

#### 4.1.7 Secrets Management für Terraform (AWS Credentials in CI/CD)

*(Gewählter Ansatz)*

#### 4.1.8 Spezifikation: Manuelles Proof-of-Concept Deployment

Vor der Automatisierung mit Helm wurde ein manuelles Deployment durchgeführt, um die Integration aller Infrastrukturkomponenten zu validieren. Dieser Abschnitt dokumentiert die durchgeführten Schritte und die Konfiguration der Kubernetes-Ressourcen und dient als Blaupause für die Entwicklung des Helm Charts.

##### A. Übersicht und Reihenfolge der Ressourcen

Für das Deployment wurden vier primäre Kubernetes-Ressourcen in einer spezifischen Reihenfolge erstellt:

1.  **Secret:** Zur sicheren Speicherung der Datenbank-Zugangsdaten und des initialen Nextcloud-Admin-Passworts.
2.  **PersistentVolumeClaim (PVC):** Zur Anforderung von persistentem Speicher.
3.  **Deployment:** Zur Definition und Verwaltung des Nextcloud-Anwendungs-Pods.
4.  **Service:** Zur Bereitstellung der Nextcloud-Anwendung über einen externen Load Balancer.

##### B. Detaillierte Konfiguration

Die folgenden Konfigurationen waren für ein erfolgreiches Deployment entscheidend:

**1. Secret (`nextcloud-db-secret`)**
Ein `Opaque`-Secret wurde mit den folgenden, base64-codierten Schlüsseln erstellt. Diese werden direkt von den Umgebungsvariablen des offiziellen Nextcloud Docker-Images verwendet.

*   `POSTGRES_HOST`: Der Endpunkt der AWS RDS-Instanz.
*   `POSTGRES_USER`: Der Master-Benutzername der RDS-Instanz.
*   `POSTGRES_PASSWORD`: Das Master-Passwort der RDS-Instanz.
*   `POSTGRES_DB`: Der Name der Datenbank innerhalb der RDS-Instanz.
*   `NEXTCLOUD_ADMIN_USER`: Der gewünschte Benutzername für den initialen Admin-Account.
*   `NEXTCLOUD_ADMIN_PASSWORD`: Das gewünschte Passwort für den initialen Admin-Account.

**2. PersistentVolumeClaim (`nextcloud-data-pvc`)**
Der PVC ist für die Datenpersistenz der stateful Nextcloud-Anwendung unerlässlich.

*   `accessModes`: `ReadWriteOnce`, wie für AWS EBS-Volumes erforderlich.
*   `storageClassName`: `ebs-sc`, um die benutzerdefinierte StorageClass zu verwenden, die verschlüsselte `gp3`-Volumes provisioniert.
*   `resources.requests.storage`: `10Gi` als initiale Grösse.

**3. Deployment (`nextcloud-deployment`)**
Das Deployment ist das Herzstück der Anwendung.

*   **Image:** `nextcloud:latest` (offizielles Docker Hub Image).
*   **Umgebungsvariablen:** Alle sechs oben genannten Secret-Schlüssel wurden über `valueFrom.secretKeyRef` sicher in den Container injiziert, um die Konfiguration vorzunehmen.
*   **Volume Mounts:** Ein Volume, das auf den `nextcloud-data-pvc` verweist, wurde in den Container am Pfad `/var/www/html` gemountet. Dies ist der von Nextcloud erwartete Pfad für alle Anwendungs-, Konfigurations- und Benutzerdateien.

**4. Service (`nextcloud-service`)**
Der Service macht die Anwendung von aussen erreichbar.

*   **Typ:** `LoadBalancer`. Dies weist den AWS Cloud Controller Manager an, automatisch einen AWS Network Load Balancer (NLB) zu provisionieren.
*   **Selector:** `app: nextcloud`, um den Traffic an die Pods des Deployments zu leiten.
*   **Ports:** Der Service leitet externen Traffic von Port `80` an den `targetPort` `80` des Containers weiter.

##### C. Referenz-Manifeste und Befehle

Die für diesen manuellen Test verwendeten YAML-Manifeste sind im Verzeichnis [`manual-k8s-manifests/`](./manual-k8s-manifests/) im Repository abgelegt. Die wesentlichen Befehle zur Überprüfung waren:

```bash
# Anwenden der Manifeste
kubectl apply -f manual-k8s-manifests/

# Überprüfen des Status der Ressourcen
kubectl get pvc,pods,svc -w

# Überprüfen der Pod-Logs auf Fehler
kubectl logs <pod-name> -f

# Durchführen des Persistenz-Tests
kubectl delete pod <pod-name>
```
Diese manuelle Verifizierung hat die Funktionsfähigkeit der gesamten darunterliegenden Infrastruktur bestätigt und den Weg für die Automatisierung mit Helm geebnet.


### 4.2 Nextcloud Helm Chart Entwicklung

Um das Deployment von Nextcloud zu standardisieren, zu versionieren und wiederholbar zu machen, wurde ein dediziertes Helm Chart entwickelt. Dies ersetzt die manuellen `kubectl apply`-Schritte aus dem Proof-of-Concept und bildet die Grundlage für die CI/CD-Pipeline. Das Chart befindet sich im Verzeichnis `charts/nextcloud-chart`.

#### 4.2.1 Helm Chart Struktur (`Chart.yaml`, `values.yaml`, `templates/`)

Die Struktur des Charts folgt den Helm-Best-Practices und wurde bewusst schlank gehalten:

*   **`Chart.yaml`**: Enthält die Metadaten des Charts wie Name, Beschreibung, Chart-Version (`version`) und die Version der Nextcloud-Anwendung (`appVersion`).
*   **`values.yaml`**: Die zentrale Konfigurationsdatei. Hier können Benutzer alle wichtigen Parameter des Deployments anpassen, ohne die Templates ändern zu müssen.
*   **`templates/`**: Dieses Verzeichnis enthält die Kubernetes-Manifest-Vorlagen.
    *   **`_helpers.tpl`**: Eine Hilfsdatei zur Generierung von standardisierten Namen und Labels, was die Konsistenz und Wartbarkeit erhöht.
    *   **`pvc.yaml`**: Template für den `PersistentVolumeClaim` zur Anforderung von Speicher.
    *   **`deployment.yaml`**: Template für das `Deployment`, das den Nextcloud-Pod verwaltet.
    *   **`service.yaml`**: Template für den `Service`, der die Anwendung im Netzwerk verfügbar macht (z.B. via Load Balancer).

#### 4.2.2 Wichtige Templates (Deployment, Service, PVC)

Die Templates wurden direkt von den validierten manuellen Manifesten aus Sprint 3 abgeleitet.

*   **`deployment.yaml`**: Das Herzstück. Es referenziert Werte aus `values.yaml` für die Image-Version, Replica-Anzahl und bindet die Datenbank-Credentials aus einem extern verwalteten Kubernetes-Secret ein.
    ```yaml
    # Snippet aus templates/deployment.yaml
    spec:
      replicas: {{ .Values.replicaCount }}
      template:
        spec:
          containers:
            - name: {{ .Chart.Name }}
              image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
              env:
                - name: POSTGRES_HOST
                  valueFrom:
                    secretKeyRef:
                      name: {{ .Values.existingSecretName }}
                      key: POSTGRES_HOST
              # ... weitere env-Variablen ...
              volumeMounts:
                - name: nextcloud-data
                  mountPath: /var/www/html
          volumes:
            - name: nextcloud-data
              persistentVolumeClaim:
                claimName: {{ include "nextcloud-chart.fullname" . }}-data
    ```
*   **`pvc.yaml`**: Definiert den `PersistentVolumeClaim`. Die Grösse und die `storageClassName` sind über `values.yaml` steuerbar.
*   **`service.yaml`**: Erstellt den `Service`, dessen Typ (`LoadBalancer`, `ClusterIP`, etc.) und Port in `values.yaml` definiert werden können.
*   **`secret.yaml`**: Dieses Template enthält eine `if/else`-Logik. Standardmässig erstellt es ein Kubernetes Secret, das die initialen Admin-Credentials und die Datenbank-Verbindungsdaten aus der `values.yaml` liest und base64-kodiert. Alternativ kann das Chart so konfiguriert werden, dass es ein extern erstelltes, bereits existierendes Secret verwendet, was in Produktionsumgebungen Best Practice ist.
*   **`configmap.yaml`**: Löst eines der häufigsten Probleme bei Nextcloud-Deployments auf Kubernetes. Es generiert eine `autoconfig.php` und mountet diese in den Pod. Diese Datei konfiguriert `trusted_domains` und `overwrite.cli.url` dynamisch basierend auf dem in `values.yaml` gesetzten Hostnamen. Dadurch wird sichergestellt, dass Nextcloud hinter dem Load Balancer korrekt funktioniert und keine Redirect-Fehler auftreten.

#### 4.2.3 Konfigurationsmöglichkeiten über `values.yaml`

Die `values.yaml` ermöglicht die flexible Anpassung des Deployments. Die wichtigsten Parameter sind:

```yaml
# Konfiguration für die Nextcloud-Anwendung
nextcloud:
  host: "a1b2c3d4.elb.amazonaws.com" # Muss mit dem Load Balancer Hostnamen befüllt werden
  admin:
    user: "admin"
    password: "SuperSecurePassword!" # Sollte via --set überschrieben werden

# Konfiguration der Datenbank-Verbindung
database:
  enabled: true # Auf true setzen, damit das Chart ein Secret erstellt
  existingSecret: "" # Leer lassen, wenn 'enabled' true ist
  user: "nextcloudadmin"
  password: "AnotherSuperSecurePassword!" # Sollte via --set überschrieben werden
  database: "nextclouddb"
  host: "nextcloud-db-instance.rds.amazonaws.com" # Muss mit dem RDS Endpunkt befüllt werden
```

Diese Struktur macht das Chart flexibel genug für verschiedene Umgebungen (Entwicklung, Produktion) und einfach in einer CI/CD-Pipeline zu verwenden.

#### 4.2.4 Sicherheitshinweis zur Passwortverwaltung

Das Helm Chart bietet die Möglichkeit, Passwörter für den Admin-Benutzer und die Datenbank direkt in der `values.yaml`-Datei zu definieren.

**WARNUNG:** Das Speichern von unverschlüsselten Passwörtern in `values.yaml`-Dateien, die in ein Git-Repository eingecheckt werden, ist eine **unsichere Praxis** und sollte in Produktionsumgebungen unbedingt vermieden werden.

Für dieses Projekt wird diese Methode zur Vereinfachung verwendet. Für eine produktive Nutzung werden folgende Ansätze empfohlen:
1.  **`--set` Flag bei der Installation:** Passwörter können zur Laufzeit übergeben werden: `helm install ... --set database.password=MEIN_GEHEIMES_PASSWORT`.
2.  **Externe Secrets-Verwaltung:** Die sicherste Methode ist, das Secret manuell oder über einen anderen Prozess (z.B. mit dem AWS Secrets Manager & CSI Driver) zu erstellen und dem Chart via `database.existingSecret` nur den Namen des Secrets zu übergeben.

#### 4.2.5 Post-Installation Notes (NOTES.txt)

Um dem Benutzer des Charts eine bestmögliche Erfahrung zu bieten, enthält das Chart eine `templates/NOTES.txt`-Datei. Diese wird nach einer erfolgreichen `helm install` oder `helm upgrade` Operation in der Konsole angezeigt und gibt kontext-spezifische Anweisungen.

Die Notizen sind dynamisch und passen sich der Konfiguration in `values.yaml` an. Für den Standardfall mit einem `Service` vom Typ `LoadBalancer` sieht die Ausgabe beispielsweise wie folgt aus:

<pre>
Nextcloud has been deployed. Congratulations!
Your release is named: nextcloud

**IMPORTANT NEXT STEPS:**

1. **Get the Nextcloud URL:**

   The Load Balancer is being created... Run the following command to get the EXTERNAL-IP:

   kubectl get svc --namespace default -w nextcloud

2. **Update Nextcloud Host Configuration:**

   Once you have the external hostname..., you MUST upgrade the Helm release...

   helm upgrade --namespace default nextcloud . \
     --set nextcloud.host=YOUR_LOADBALANCER_HOSTNAME

   ...

**Admin Credentials:**
   Username: admin
   Password: SuperSecurePassword!
</pre>

Dies führt den Benutzer durch die kritischen ersten Schritte, insbesondere das Abrufen des dynamisch erstellten Load-Balancer-Hostnamens und das anschliessende `helm upgrade`, um die Nextcloud-Konfiguration zu finalisieren.

### 4.3 CI/CD Pipeline mit GitHub Actions

*Die Automatisierung des Deployments.*

#### 4.3.1 Workflow-Definition (`*.yml` Datei)

* *(Trigger, Jobs, Steps – mit relevanten YAML-Snippets)*

#### 4.3.2 Authentifizierung gegenüber AWS (OIDC)

Um eine sichere und passwortlose Authentifizierung der CI/CD-Pipeline gegenüber AWS zu gewährleisten, wird der von AWS und GitHub empfohlene Standard **OpenID Connect (OIDC)** verwendet. Dies eliminiert die Notwendigkeit, langlebige AWS Access Keys als GitHub Secrets zu speichern.

Der Prozess wurde via Terraform in der Datei `terraform/iam_cicd.tf` implementiert und besteht aus zwei Hauptkomponenten:

1.  **IAM OIDC Identity Provider:** Eine einmalige Konfiguration in AWS, die eine Vertrauensbeziehung zum OIDC-Provider von GitHub (`token.actions.githubusercontent.com`) herstellt.
2.  **IAM-Rolle für die Pipeline:** Eine dedizierte Rolle (`Nextcloud-cicd-role`) wird erstellt. Die entscheidende Konfiguration ist die **Trust Policy**:
    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Federated": "arn:aws:iam::ACCOUNT_ID:oidc-provider/token.actions.githubusercontent.com"
                },
                "Action": "sts:AssumeRoleWithWebIdentity",
                "Condition": {
                    "StringLike": {
                        "token.actions.githubusercontent.com:sub": "repo:Stevic-Nenad/Nextcloud:ref:refs/heads/main"
                    }
                }
            }
        ]
    }
    ```
    Die `Condition` stellt sicher, dass nur Workflows, die aus dem Repository `Stevic-Nenad/Nextcloud` vom `main`-Branch stammen, diese Rolle übernehmen dürfen.

Im GitHub Actions Workflow wird dann die Action `aws-actions/configure-aws-credentials` verwendet. Diese fordert bei GitHub ein OIDC JWT-Token an, präsentiert es AWS, übernimmt die konfigurierte Rolle und stellt temporäre AWS-Credentials für alle nachfolgenden Schritte im Job zur Verfügung.

#### 4.3.3 Integrationsschritte (Terraform, Helm)

#### 4.3.4 Secrets Management in der Pipeline

### 4.4 Installation und Inbetriebnahme der Gesamtlösung

*Eine Schritt-für-Schritt-Anleitung, um das Projekt von Null aufzusetzen.*

#### 4.4.1 Voraussetzungen

**Erforderliche Tools:**

* **AWS CLI v2.27.7** - Für AWS Service Interaktionen
  ```bash
  aws --version  # AWS CLI 2.x.x
  ```
* **Terraform >= 1.12.1** - Infrastructure as Code Tool
  ```bash
  terraform version  # Terraform v1.9.x
  ```
* **kubectl >= 1.33.0** - Kubernetes CLI (kompatibel mit EKS 1.30)
  ```bash
  kubectl version --client  # v1.30.x
  ```
* **Helm >= 3.18.1** - Kubernetes Package Manager
  ```bash
  helm version  # version.BuildInfo{Version:"v3.15.x"}
  ```
* **Git** - Version Control

**Terraform Backend Infrastruktur:**

* Ein AWS S3 Bucket für Terraform State und eine AWS DynamoDB-Tabelle für State Locking müssen bereits provisioniert
  sein. Dies geschieht typischerweise durch eine separate Terraform-Konfiguration (siehe
  Abschnitt [4.1.0](#410-terraform-remote-state-backend-konfiguration)). Notieren Sie sich die Namen des S3 Buckets und
  der DynamoDB-Tabelle.

**AWS Konfiguration:**

* AWS Account mit aktiviertem MFA
* IAM User mit programmatischem Zugriff
* Konfiguriertes AWS CLI Profile:
  ```bash
  aws configure --profile nextcloud-project
  ```

**Empfohlene IDE:**

* IntelliJ IDEA Ultimate mit Plugins:
    - HashiCorp Terraform/HCL Language Support
    - Kubernetes
    - Docker
    - AWS Toolkit
    - YAML (eingebaut)

#### 4.4.2 Klonen des Repositorys

#### 4.4.3 Konfiguration von Umgebungsvariablen/Secrets

#### 4.4.4 Ausführen der Pipeline / Manuelle Schritte (falls nötig)

#### 4.4.5 Zugriff auf die Nextcloud Instanz

### 4.5 Anpassung von Software / Konfiguration von Geräten

*Spezifische Konfigurationen, die über Standard-Deployments hinausgehen.*

#### 4.5.1 Nextcloud-spezifische Konfigurationen (via Helm)

#### 4.5.2 Wichtige AWS Service-Konfigurationen

---

## 5. Testing und Qualitätssicherung

*Wie wurde sichergestellt, dass die Lösung funktioniert und den Anforderungen entspricht?*

### 5.1 Teststrategie

*Welche Testebenen und -arten wurden angewendet?*

#### 5.1.1 Statische Code-Analyse (Linting)

#### 5.1.2 Validierung der Infrastruktur-Konfiguration (`terraform validate/plan`, `helm template`)

#### 5.1.3 Manuelle Funktionstests der Nextcloud Instanz

#### 5.1.4 End-to-End Tests der CI/CD Pipeline

#### 5.1.5 Automatisierte Post-Deployment-Tests (Helm Test)

Um nach einer Installation oder einem Upgrade schnell zu verifizieren, dass die Anwendung nicht nur deployt wurde, sondern auch tatsächlich läuft und antwortet, wird die `helm test`-Funktionalität genutzt.

Im Verzeichnis `templates/tests/` des Charts wurde ein Test-Pod definiert. Dieser Pod startet nach dem Deployment auf Befehl (`helm test <release-name>`), versucht eine Verbindung zum `/status.php`-Endpunkt des Nextcloud-Services innerhalb des Clusters aufzubauen und beendet sich bei Erfolg mit einem positiven Status. Dies dient als einfacher, aber effektiver "Smoke-Test", um die grundlegende Funktionsfähigkeit der Anwendung automatisiert zu bestätigen.

### 5.2 Testfälle und Protokolle

**Testfall: Überprüfung der Kosten-Tags auf AWS Ressourcen (Vorbereitung)**

* **Zugehörige User Story (Setup):** `Nextcloud#7` - Kosten-Tags für AWS Ressourcen definieren und initiale
  Terraform-Provider-Konfiguration erstellen.
* **Zugehörige User Story (Verifizierung auf Ressourcen):** `Nextcloud#5` - VPC mit Subnetzen via Terraform erstellen.
* **Status:** Abgeschlossen (als Teil der Verifizierung von `Nextcloud#5`).
* **Zielsetzung (für `Nextcloud#5`):** Verifizieren, dass die im Rahmen von `Nextcloud#7` konfigurierten Standard-Tags (
  `Projekt`, `Student`, `ManagedBy`) korrekt auf den via Terraform erstellten Ressourcen (initial VPC, Subnetze) in der
  AWS Management Console angezeigt werden.
* **Testschritte (für `Nextcloud#5`):**
    1. Nach erfolgreichem `terraform apply` (für `Nextcloud#5`) in der AWS Management Console zur VPC-Übersicht
       navigieren.
    2. Die für das Projekt erstellte VPC auswählen und den Tab "Tags" prüfen.
    3. Eines der für das Projekt erstellten Subnetze auswählen und den Tab "Tags" prüfen.
* **Erwartetes Ergebnis (für `Nextcloud#5`):** Alle in `local.common_tags` definierten Standard-Tags sind mit den
  korrekten Werten auf den überprüften Ressourcen vorhanden.
* **Tatsächliches Ergebnis:** Die Standard-Tags (`Projekt: Nextcloud`, `Student: NenadStevic`, `ManagedBy: Terraform`)
  wurden erfolgreich auf der erstellten VPC, den öffentlichen Subnetzen, privaten Subnetzen, dem IGW, den EIPs für NAT
  Gateways, den NAT Gateways und allen Routing-Tabellen in der AWS Management Console verifiziert.
* **Nachweis:** Beispiel-Screenshots der AWS Management Console, die die Tags auf der VPC und einem NAT Gateway zeigen,
  sind in Abschnitt [5.2.1](#521-nachweise-der-testergebnisse-screenshotsgifs) unter `vpc_tags_verification.png` (oder
  ähnlich) abgelegt.

---

**Testfall: VPC-Grundfunktionalität und Hochverfügbarkeit der NAT-Gateways**

* **Zugehörige User Story:** `Nextcloud#5` - VPC mit Subnetzen via Terraform erstellen
* **Status:** Abgeschlossen
* **Zielsetzung:** Verifizieren, dass die VPC-Komponenten korrekt erstellt wurden und die NAT-Gateway-Architektur (ein
  NAT GW pro AZ) wie erwartet funktioniert.
* **Testschritte (Manuelle Überprüfung in AWS Konsole nach `terraform apply`):**
    1. **VPC-Erstellung:**
        * Überprüfen, ob die VPC (`${var.project_name}-vpc`) mit dem korrekten CIDR-Block (`var.vpc_cidr_block`)
          existiert.
        * Überprüfen, ob DNS-Hostnamen und DNS-Support für die VPC aktiviert sind.
    2. **Subnetz-Erstellung:**
        * Überprüfen, ob die erwartete Anzahl öffentlicher Subnetze (gemäß `length(var.public_subnet_cidrs)`) in den
          korrekten AZs (`var.availability_zones`) und mit den korrekten CIDRs (`var.public_subnet_cidrs`) erstellt
          wurden.
        * Überprüfen, ob `map_public_ip_on_launch` für öffentliche Subnetze auf `true` steht.
        * Überprüfen, ob die erwartete Anzahl privater Subnetze (gemäß `length(var.private_subnet_cidrs)`) in den
          korrekten AZs und mit den korrekten CIDRs erstellt wurden.
    3. **Internet Gateway (IGW):**
        * Überprüfen, ob ein IGW (`${var.project_name}-igw`) erstellt und an die VPC angehängt ist.
    4. **NAT Gateways (pro AZ):**
        * Überprüfen, ob für jede AZ in `var.availability_zones` ein NAT Gateway (
          `${var.project_name}-nat-gw-[AZ-Name]`) im öffentlichen Subnetz dieser AZ existiert und den Status "Available"
          hat.
        * Überprüfen, ob jedes NAT Gateway eine zugehörige Elastic IP (`${var.project_name}-nat-eip-[AZ-Name]`) hat.
    5. **Routing - Öffentliche Subnetze:**
        * Überprüfen, ob die öffentliche Routing-Tabelle (`${var.project_name}-public-rt`) eine Default-Route (
          `0.0.0.0/0`) zum IGW hat.
        * Überprüfen, ob alle öffentlichen Subnetze mit dieser öffentlichen Routing-Tabelle assoziiert sind.
    6. **Routing - Private Subnetze (pro AZ):**
        * Für jede AZ: Überprüfen, ob eine private Routing-Tabelle (`${var.project_name}-private-rt-[AZ-Name]`)
          existiert.
        * Für jede dieser privaten Routing-Tabellen: Überprüfen, ob eine Default-Route (`0.0.0.0/0`) zum NAT Gateway in
          derselben AZ existiert.
        * Für jede AZ: Überprüfen, ob die privaten Subnetze dieser AZ mit der korrekten AZ-spezifischen privaten
          Routing-Tabelle assoziiert sind.
    7. **Terraform Outputs:**
        * Überprüfen, ob `terraform output` die korrekten Werte für `vpc_id`, `public_subnet_ids`, `private_subnet_ids`,
          `nat_gateway_public_ips`, etc. anzeigt.
* **Erwartetes Ergebnis:** Alle oben genannten Komponenten sind korrekt konfiguriert und die Routen sind wie beschrieben
  eingerichtet. Die NAT-Gateway-Architektur ist pro AZ implementiert.
* **Tatsächliches Ergebnis:** Alle Komponenten wurden in der AWS Konsole und via Terraform Outputs wie erwartet
  verifiziert. Die NAT-Gateway-pro-AZ-Architektur und das entsprechende Routing sind korrekt implementiert.
* **Nachweis:** Screenshots der AWS Konsole (z.B. VPC Details, Subnetz-Liste, IGW-Status, NAT Gateway Liste,
  Routing-Tabellen-Konfigurationen) können bei Bedarf in
  Abschnitt [5.2.1](#521-nachweise-der-testergebnisse-screenshotsgifs) unter `vpc_functionality_verification.png` (oder
  ähnlich) abgelegt werden. *Für dieses Projekt wird auf detaillierte Screenshots für jeden Schritt verzichtet, sofern
  die `terraform apply` erfolgreich war und die Kernkomponenten stichprobenartig überprüft wurden.*

---

**Testfall: Terraform Remote Backend Initialisierung und Nutzung (Hauptanwendung)**

* **Zugehörige User Story:** `Nextcloud#6` - Terraform Remote Backend konfigurieren (für die Hauptanwendung
  `src/terraform/`)
* **Voraussetzung:** Der S3 Bucket und die DynamoDB-Tabelle für das Backend wurden bereits durch eine separate
  Terraform-Konfiguration (z.B. `terraform-backend-setup/`) provisioniert und ihre Namen sind bekannt.
* **Status:** `Abgeschlossen` / `Teilweise Abgeschlossen (wegen AWS-Problemen)` *(Anpassen!)*
* **Zielsetzung:** Verifizieren, dass die Hauptanwendungs-Terraform-Konfiguration (`src/terraform/`) korrekt mit dem
  extern provisionierten S3 Remote Backend initialisiert wird, den State dort liest/schreibt und Locks über DynamoDB
  funktionieren.
* **Testschritte:**
    1. Sicherstellen, dass die `src/terraform/backend.tf`-Datei korrekt mit den Namen des externen S3 Buckets und der
       DynamoDB-Tabelle konfiguriert ist.
    2. Im Verzeichnis `src/terraform/` den Befehl `terraform init` ausführen.
    3. Überprüfen, ob `terraform init` erfolgreich durchläuft und die Verbindung zum S3-Backend bestätigt.
    4. Eine kleine, harmlose Änderung an der *Anwendungs*-Infrastruktur (z.B. ein Tag zu einer Ressource in
       `src/terraform/network.tf` hinzufügen, nicht die Backend-Konfiguration selbst) vornehmen.
    5. `terraform plan` ausführen. Überprüfen, ob der Plan korrekt erstellt wird und einen Lock-Versuch in DynamoDB
       andeutet (schwer manuell zu sehen, aber der Plan sollte ohne Lock-Fehler erstellt werden).
    6. `terraform apply` ausführen, um die Änderung anzuwenden.
    7. Überprüfen, ob die `terraform.tfstate`-Datei im S3 Bucket unter dem konfigurierten `key` (z.B.
       `nextcloud-app/main.tfstate`) aktualisiert wurde (Zeitstempel, Version).
* **Erwartetes Ergebnis:**
    * `terraform init` in `src/terraform/` läuft fehlerfrei durch und initialisiert das S3-Backend.
    * Die State-Datei für die Hauptanwendung wird im S3-Bucket unter dem korrekten Key verwaltet/aktualisiert.
    * `terraform plan/apply` für die Hauptanwendungsinfrastruktur funktionieren und verwenden den Remote State.
* **Tatsächliches Ergebnis:** `HIER DAS TATSÄCHLICHE ERGEBNIS EINTRAGEN.` *(Wichtig: Wenn AWS-Probleme die Verifizierung
  von `init` oder `apply` für `src/terraform/` verhindert haben, muss das hier klar und ehrlich dokumentiert werden!)*
* **Nachweis:**
    * Screenshot der `src/terraform/backend.tf` Konfiguration.
    * Screenshot des S3 Buckets, der die State-Datei unter dem Key `nextcloud-app/main.tfstate` zeigt.
    * Konsolenausgabe von `terraform init` (aus `src/terraform/`).

---

**Testfall: Provisionierung des EKS Clusters und der Node Groups**

* **Zugehörige User Story:** `Nextcloud#8` - EKS Cluster mit Node Groups provisionieren (via Terraform)
* **Status:** Abgeschlossen
* **Zielsetzung:** Verifizieren, dass der EKS Cluster und mindestens eine Managed Node Group erfolgreich via Terraform
  provisioniert werden, die Nodes im 'Ready'-Status sind und die Konfiguration den Akzeptanzkriterien entspricht.
* **Testschritte:**
    1. Terraform-Konfiguration für EKS Cluster, IAM-Rollen und Managed Node Group erstellen/erweitern.
    2. `terraform validate` ausführen.
    3. `terraform plan` ausführen und den Plan überprüfen.
    4. `terraform apply -auto-approve` ausführen.
    5. Nach erfolgreichem `apply`, `kubeconfig` aktualisieren mit:
       `aws eks update-kubeconfig --region <region> --name <cluster_name> --profile <aws_profile>`
    6. `kubectl get nodes -o wide` ausführen.
    7. In der AWS Management Console überprüfen:
        * EKS Cluster Status (Aktiv, korrekte K8s Version).
        * IAM Rollen für Cluster und Nodes mit den korrekten Policies.
        * Managed Node Group Status (Aktiv, korrekte Instanztypen, Skalierung).
        * EC2-Instanzen der Worker Nodes: Sicherstellen, dass sie in den **privaten Subnetzen** laufen (überprüfen der
          Subnet-ID der Instanzen).
* **Erwartetes Ergebnis:**
    * `terraform apply` läuft erfolgreich durch.
    * `kubectl get nodes` zeigt die konfigurierte Anzahl an Worker Nodes im 'Ready'-Status. Die IP-Adressen der Nodes
      sollten aus den privaten Subnetz-CIDRs stammen.
    * Alle in den Akzeptanzkriterien genannten Punkte sind in der AWS Konsole verifizierbar (IAM Rollen korrekt, Node
      Group Parameter, K8s Version).
* **Tatsächliches Ergebnis:** `terraform apply` war erfolgreich nach Behebung eines `MalformedPolicyDocument`-Fehlers
  bei der `eks_cluster_role` und einer Syntaxkorrektur bei der `eks_node_role`. `kubectl get nodes -o wide` zeigte **2**
  Worker Nodes im 'Ready'-Status mit privaten IP-Adressen an. Alle Konfigurationen (IAM-Rollen, Kubernetes-Version
  `1.33`, Node Group Parameter, Platzierung der Nodes in privaten Subnetzen) wurden in der AWS Konsole wie erwartet
  verifiziert.*
* **Nachweis:** Screenshot von `kubectl get nodes` in
  Abschnitt [5.2.1](#521-nachweise-der-testergebnisse-screenshotsgifs) unter `eks_nodes_ready.png` (oder ähnlich).

---

**Testfall: ECR Repository Provisionierung und Konfiguration**

* **Zugehörige User Story:** `Nextcloud#9` - ECR Repository via Terraform erstellen
* **Status:** Abgeschlossen
* **Zielsetzung:** Verifizieren, dass das ECR Repository mit den korrekten Konfigurationen (Name, Image Scanning, Lifecycle Policy) erstellt wurde und die Terraform Outputs funktionieren.
* **Testschritte:**
    1. Nach erfolgreichem `terraform apply` die Terraform Outputs überprüfen:
       ```bash
       terraform output ecr_repository_url
       terraform output ecr_repository_name
       terraform output ecr_repository_arn
       ```
    2. In der AWS Management Console zu ECR navigieren.
    3. Überprüfen, ob das Repository mit dem Namen `${var.project_name}-app` (z.B. "Nextcloud-app") existiert.
    4. Repository-Details öffnen und folgende Konfigurationen verifizieren:
        * Image scanning: "Scan on push" ist aktiviert
        * Lifecycle policy: Policy ist attached und enthält Regeln für ungetaggte Images (30 Tage) und getaggte Images (max 10)
        * Tag mutability: "MUTABLE" ist gesetzt
    5. Tags auf dem Repository überprüfen (sollten `local.common_tags` enthalten).
    6. Optional: Test-Image Push vorbereiten (Docker login zum Repository testen):
       ```bash
       aws ecr get-login-password --region eu-central-1 --profile nextcloud-project | docker login --username AWS --password-stdin $(terraform output -raw ecr_repository_url)
       ```
* **Erwartetes Ergebnis:**
    * Terraform Outputs liefern korrekte ECR Repository URL, Name und ARN.
    * Repository existiert in AWS Console mit korrektem Namen.
    * Image scanning ist aktiviert.
    * Lifecycle policy ist konfiguriert mit den definierten Regeln.
    * Standard-Tags sind korrekt gesetzt.
    * Docker login zum Repository ist erfolgreich (optional).
* **Tatsächliches Ergebnis:** `[Hier dein Ergebnis nach dem Test eintragen]`
* **Nachweis:** Screenshot der ECR Repository Details aus der AWS Console (optional) in Abschnitt [5.2.1](#521-nachweise-der-testergebnisse-screenshotsgifs) unter `ecr_repository_verification.png`.

---

**Testfall: Konfiguration des IAM OIDC Providers und der IRSA-Rolle**

* **Zugehörige User Story:** `Nextcloud#10` - IAM OIDC Provider für EKS konfigurieren
* **Status:** Abgeschlossen
* **Zielsetzung:** Verifizieren, dass der OIDC Provider in AWS IAM korrekt erstellt wurde und dass die Beispiel-IAM-Rolle für den EBS CSI Driver die richtige Trust Policy hat.
* **Testschritte:**
    1. Nach erfolgreichem `terraform apply` in der AWS Management Console zu **IAM -> Identity providers** navigieren.
    2. Überprüfen, ob ein Provider mit der URL des EKS-Clusters existiert (z.B. `oidc.eks.eu-central-1.amazonaws.com/id/...`).
    3. Den Provider auswählen und sicherstellen, dass unter "Audience" der Wert `sts.amazonaws.com` eingetragen ist.
    4. Zu **IAM -> Roles** navigieren.
    5. Nach der Rolle `${var.project_name}-ebs-csi-driver-role` suchen und sie auswählen.
    6. Den Tab **"Trust relationships"** auswählen und auf "Edit trust policy" klicken.
    7. Überprüfen, ob die JSON-Richtlinie exakt der in Terraform definierten entspricht, insbesondere der `Principal.Federated` ARN und die `Condition`, die auf den Service Account `system:serviceaccount:kube-system:ebs-csi-controller-sa` verweist.
    8. Im Tab **"Permissions"** überprüfen, ob die `AmazonEBSCSIDriverPolicy` angehängt ist.
* **Erwartetes Ergebnis:** Alle Komponenten (OIDC Provider, IAM Rolle, Trust Policy, Permissions) sind in der AWS Konsole exakt so konfiguriert, wie in Terraform definiert. Die Trust Policy ist das kritischste Element und muss korrekt sein.
* **Tatsächliches Ergebnis:** Alle Überprüfungsschritte waren erfolgreich. Der OIDC Provider wurde korrekt erstellt und die Trust Policy der IAM-Rolle wurde exakt wie erwartet in der AWS Konsole verifiziert.
* **Nachweis:** Screenshot der Trust Policy der IAM-Rolle in Abschnitt [5.2.1](#521-nachweise-der-testergebnisse-screenshotsgifs) unter `irsa_trust_policy_verification.png` (Platzhalter).

---

**Testfall: Verifizierung des EBS CSI Drivers und der dynamischen Provisionierung**

* **Zugehörige User Story:** `Nextcloud#11` - AWS EBS CSI Driver im EKS Cluster installieren und konfigurieren
* **Status:** Abgeschlossen
* **Zielsetzung:** Sicherstellen, dass der EBS CSI Driver korrekt installiert ist und in der Lage ist, auf eine PVC-Anfrage hin dynamisch ein EBS Volume zu provisionieren.
* **Testschritte:**
    1. Nach erfolgreichem `terraform apply` (welches das EKS-Add-on installiert), die Test-Manifeste anwenden:
       `kubectl apply -f kubernetes-manifests/01-storage-class.yaml`
       `kubectl apply -f kubernetes-manifests/02-test-pvc.yaml`
    2. Den Status des PVC überprüfen. Er sollte nach kurzer Zeit von `Pending` auf `Bound` wechseln.
       `kubectl get pvc ebs-test-claim`
    3. Überprüfen, ob ein entsprechendes PersistentVolume (PV) erstellt wurde und ebenfalls den Status `Bound` hat.
       `kubectl get pv`
    4. In der AWS Management Console zu **EC2 -> Elastic Block Store -> Volumes** navigieren.
    5. Überprüfen, ob ein neues EBS Volume (Größe 4 GiB, Typ gp3) mit dem Status `in-use` erstellt wurde. Die Tags des Volumes sollten den Namen des PVs enthalten.
    6. (Aufräumen) Die Test-Ressourcen wieder löschen:
       `kubectl delete -f kubernetes-manifests/02-test-pvc.yaml`
       `kubectl delete -f kubernetes-manifests/01-storage-class.yaml`
       *Nach dem Löschen des PVCs sollte das PV und das zugrunde liegende EBS Volume automatisch gelöscht werden.*
* **Erwartetes Ergebnis:** Ein PVC wird erstellt und erfolgreich an ein dynamisch provisioniertes EBS Volume gebunden. Der Status von PVC und PV ist `Bound`.
* **Tatsächliches Ergebnis:** Alle Schritte wurden erfolgreich ausgeführt. Der PVC wechselte innerhalb von Sekunden zu `Bound` und ein entsprechendes 4-GiB-EBS-Volume wurde in der AWS-Konsole verifiziert.
* **Nachweis:** Screenshot der `kubectl get pvc,pv` Ausgabe in Abschnitt [5.2.1](#521-nachweise-der-testergebnisse-screenshotsgifs) unter `ebs_pvc_bound_verification.png` (Platzhalter).

---

**Testfall: Provisionierung und Netzwerkkonnektivität der RDS-Instanz**

*   **Zugehörige User Story:** `Nextcloud#12`, `Nextcloud#13`
*   **Status:** *(Nach dem Apply ausfüllen)*
*   **Zielsetzung:** Verifizieren, dass die RDS-Instanz korrekt in den privaten Subnetzen erstellt wird, die Security Group den Zugriff nur vom EKS-Cluster erlaubt und die Verbindungsdaten als Outputs verfügbar sind.
*   **Testschritte:**
    1.  Nach erfolgreichem `terraform apply` in der AWS Management Console zu **RDS -> Databases** navigieren.
    2.  Überprüfen, ob die Instanz `${var.project_name}-db-instance` mit Status "Available" existiert.
    3.  Die Instanzdetails öffnen und unter **"Connectivity & security"** überprüfen:
        *   Die VPC ist die korrekte Projekt-VPC.
        *   Die Subnetze in der Subnet Group sind die privaten Subnetze des Projekts.
        *   "Public access" ist auf "No" gesetzt.
        *   Die angehängte Security Group (`${var.project_name}-rds-sg`) ist korrekt.
    4.  Zur **VPC -> Security Groups** navigieren und die RDS-Security-Group auswählen.
    5.  Die "Inbound rules" überprüfen. Es sollte eine Regel für Port `5432` existieren, deren Quelle die Security Group ID des EKS-Clusters ist.
    6.  `terraform output` in der Konsole ausführen und überprüfen, ob die Outputs `rds_instance_endpoint`, `rds_instance_port`, `rds_db_name` und `rds_master_username` korrekte Werte anzeigen.
*   **Erwartetes Ergebnis:** Alle Komponenten sind wie beschrieben konfiguriert. Die Datenbank ist sicher im privaten Netzwerk platziert und nur für den EKS-Cluster erreichbar.
*   **Tatsächliches Ergebnis:** *(Nach dem Apply ausfüllen)*
*   **Nachweis:** *(Optional) Screenshot der Inbound-Regeln der RDS-Security-Group.*

---

**Testfall: Verifizierung der EKS-Node-Konfiguration (IMDS & Topologie)**

*   **Zugehörige User Story:** Indirekt mit `#11` und `#14` verbunden. Entstanden aus der Fehleranalyse in Sprint 3.
*   **Status:** Abgeschlossen
*   **Zielsetzung:** Sicherstellen, dass die EKS-Worker-Nodes korrekt konfiguriert sind, um Konnektivitätsprobleme mit dem EC2 Metadata Service (IMDS) zu vermeiden und die dynamische Volume-Provisionierung zu ermöglichen.
*   **Testschritte:**
    1.  Nach erfolgreichem `terraform apply` und dem Start der Worker Nodes den Namen eines Nodes ermitteln: `kubectl get nodes`.
    2.  Überprüfen, ob die IMDS Hop-Limit auf dem EC2-Level korrekt gesetzt ist (erfordert AWS CLI):
        `aws ec2 describe-instances --instance-ids <instance-id> --query "Reservations[*].Instances[*].MetadataOptions"`
        *Erwartetes Ergebnis: `http_put_response_hop_limit` sollte `2` sein.*
    3.  Überprüfen, ob der EBS CSI-Treiber die Topologie-Informationen auf dem Kubernetes-Node-Objekt korrekt setzen konnte:
        `kubectl describe node <node-name> | findstr "topology.ebs.csi.aws.com/zone"`
        *Erwartetes Ergebnis: Der Befehl sollte eine Zeile ausgeben, z.B. `topology.ebs.csi.aws.com/zone=eu-central-1a`.*
    4.  Die Logs des `ebs-csi-node`-Pods auf dem jeweiligen Node überprüfen:
        `kubectl logs <ebs-csi-node-pod-name> -n kube-system -c ebs-plugin`
        *Erwartetes Ergebnis: Die Logs dürfen **keine** Timeout-Fehler (`context deadline exceeded`) bei der IMDS-Abfrage enthalten.*
*   **Tatsächliches Ergebnis:** Alle Überprüfungsschritte waren nach der Implementierung der `aws_launch_template` erfolgreich. Die IMDS-Konnektivität wurde hergestellt und die Topologie-Labels wurden korrekt gesetzt, was die `Pending`-PVC-Probleme löste.
*   **Nachweis:** Die erfolgreiche Bereitstellung des Nextcloud-PVC dient als finaler, funktionierender Nachweis für diesen Testfall.

---

**Testfall: Validierung der OIDC-Authentifizierung von GitHub Actions zu AWS**

*   **Zugehörige User Story:** `Nextcloud#20` - OIDC Authentifizierung für GitHub Actions zu AWS einrichten
*   **Status:** Abgeschlossen
*   **Zielsetzung:** Verifizieren, dass die via Terraform erstellte OIDC-Konfiguration es einem GitHub Actions Workflow erlaubt, die dedizierte IAM-Rolle sicher zu übernehmen und AWS-API-Aufrufe auszuführen.
*   **Testschritte:**
    1.  **Infrastruktur-Provisionierung:** Ausführen von `terraform apply` im `terraform/`-Verzeichnis, um den `aws_iam_openid_connect_provider` und die `aws_iam_role` (`Nextcloud-cicd-role`) zu erstellen.
    2.  **Manuelle Überprüfung in AWS IAM:**
        *   Navigieren zu **IAM -> Identity providers**. Verifizieren, dass der Provider für `token.actions.githubusercontent.com` mit der korrekten `Audience` (`sts.amazonaws.com`) existiert.
        *   Navigieren zu **IAM -> Roles** und die Rolle `Nextcloud-cicd-role` auswählen.
        *   Den Tab **"Trust relationships"** prüfen. Die Policy muss die `Federated`-Principal-ARN des OIDC-Providers und die `Condition` enthalten, die den Zugriff auf das korrekte GitHub-Repository (`repo:Stevic-Nenad/Nextcloud:ref:refs/heads/main`) beschränkt.
    3.  **Funktionale Verifizierung via GitHub Actions:**
        *   Erstellen eines temporären Workflows (`.github/workflows/test-auth.yml`), der manuell getriggert werden kann.
        *   Der Workflow-Job muss die `permissions: id-token: write` besitzen.
        *   Der Workflow verwendet die Action `aws-actions/configure-aws-credentials@v4`, um die Übernahme der `Nextcloud-cicd-role` zu versuchen.
        *   Als nachfolgenden Schritt führt der Workflow `aws sts get-caller-identity` aus.
        *   Den Workflow manuell über die GitHub-UI starten.
*   **Erwartetes Ergebnis:**
    *   Die Terraform-Ressourcen werden ohne Fehler erstellt.
    *   Die manuelle Überprüfung in der AWS-Konsole bestätigt die korrekte Konfiguration der Trust Policy.
    *   Der Test-Workflow in GitHub Actions läuft erfolgreich durch.
    *   Die Ausgabe des `aws sts get-caller-identity`-Befehls im Workflow-Log zeigt die `Arn` der übernommenen Rolle (`...:assumed-role/Nextcloud-cicd-role/...`), nicht die eines IAM-Users.
*   **Tatsächliches Ergebnis:** Alle Schritte waren erfolgreich. Die manuelle Überprüfung der IAM-Konfiguration war korrekt. Der `test-auth.yml`-Workflow wurde erfolgreich ausgeführt und die Ausgabe von `get-caller-identity` bestätigte, dass die Pipeline-Rolle wie erwartet übernommen wurde.
*   **Nachweis:** Ein Screenshot der erfolgreichen `test-auth.yml`-Workflow-Ausgabe in GitHub, der die `aws sts get-caller-identity`-Antwort zeigt, dient als primärer Nachweis.

---

#### 5.2.1 Nachweise der Testergebnisse (Screenshots/GIFs)

[PLATZHALTER]

* **Überprüfung der Kosten-Tags auf VPC-Ressourcen (User Story #7 & #5):**
    * ![Nachweis Kosten-Tags auf VPC](assets/images/tests/vpc_tags_verification.png)
      *(Beschreibung: Beispiel-Screenshot aus der AWS Management Console, der die Tags "Projekt: Nextcloud", "Student:
      NenadStevic", "ManagedBy: Terraform" auf der erstellten VPC und/oder einem NAT Gateway zeigt.)*

[PLATZHALTER]

* **Überprüfung der VPC-Grundfunktionalität (User Story #5):**
    * Die erfolgreiche Ausführung von `terraform apply` und die stichprobenartige Überprüfung der Kernkomponenten (VPC,
      Subnetze, IGW, NAT Gateways, Routen) in der AWS Konsole dienen als Nachweis für die korrekte Provisionierung.
      Detaillierte Screenshots für jeden einzelnen Verifizierungsschritt werden nicht beigefügt, um die Dokumentation
      schlank zu halten, können aber bei Bedarf nachgereicht werden. Die Terraform Outputs bestätigen ebenfalls die
      Erstellung der Ressourcen-IDs.

[PLATZHALTER]

* **Überprüfung der EKS Worker Nodes (User Story #8):**
    * ![Nachweis EKS Nodes Ready](assets/images/tests/eks_nodes_ready.png)
      *(Beschreibung: Screenshot der Ausgabe von `kubectl get nodes -o wide`, der die Worker Nodes im Status "Ready" mit
      ihren privaten IP-Adressen zeigt.)*

---

## 6. Projektdokumentation (Zusammenfassung)

*Diese `README.md` dient als zentrale Projektdokumentation. Alle relevanten Informationen, Entscheidungen und Ergebnisse
sind hier festgehalten oder direkt verlinkt.*

### 6.1 Verzeichnisse und Zusammenfassungen

*Das Inhaltsverzeichnis am Anfang dieser Datei bietet eine schnelle Navigation. Die wesentlichen Zusammenfassungen
finden sich in den jeweiligen Kapiteln und Sprint-Abschnitten.*

### 6.2 Quellenangaben und verwendete Werkzeuge

*Auflistung externer Quellen, wichtiger Tutorials oder Dokumentationen, die herangezogen wurden (sofern nicht direkt im
Text erwähnt). Sowie eine Liste der Kernwerkzeuge.*

### 6.3 Lizenz

Der **gesamte Quellcode** dieses Projekts (Terraform, Helm-Charts, GitHub-Actions-Workflows usw.) steht unter
der [MIT-Lizenz](LICENSE).  
Die **Dokumentation** dieses Repositories ist, sofern nicht anders gekennzeichnet, ebenfalls unter MIT veröffentlicht.  
Das verwendete Nextcloud-Docker-Image unterliegt der AGPL-3.0 (→
siehe [Nextcloud-Projekt](https://github.com/nextcloud/docker)).
---

## 7. Reflexion und Erkenntnisse

*Ein kritischer Rückblick auf das Projekt, den Prozess und die persönlichen Lernerfahrungen.*

### 7.1 Abgleich von Theorie und Praxis

*Wie gut liessen sich die im Studium erlernten Theorien in diesem praktischen Projekt anwenden? Welche Diskrepanzen oder
Herausforderungen traten auf?*

### 7.2 Eigene Erfahrungen und persönlicher Lernprozess

*Was waren die grössten persönlichen Lernerfolge? Welche technischen oder methodischen Hürden mussten überwunden
werden?*

### 7.3 Bewertung der eigenen Lösung und Verbesserungspotenzial

*Eine kritische Einschätzung der entwickelten Lösung: Stärken, Schwächen, Limitationen. Welche Aspekte wurden bewusst
vereinfacht oder weggelassen (Scope)?*

### 7.4 Handlungsempfehlungen für das weitere Vorgehen

*Welche nächsten Schritte wären sinnvoll, um das Projekt weiterzuentwickeln oder die Lösung zu verbessern (z.B. für
einen produktiven Einsatz)?*

---

## 8. Anhänge

*Zusätzliche Materialien, die das Verständnis unterstützen oder für die Nachvollziehbarkeit relevant sind.*

### 8.1 Verwendete Scrum-Vorlagen (Templates)

*Die hier aufgeführten Markdown-Vorlagen dienten als Grundlage und Inspiration für die Dokumentation der
Scrum-Zeremonien und Artefakte.*

* [Sprint Planning Vorlage](docs/templates/sprint_planning.md)
* [Daily Scrum Log Vorlage](docs/templates/daily_scrum.md)
* [Sprint Review Vorlage](docs/templates/sprint_review.md)
* [Sprint Retrospektive Vorlage](docs/templates/sprint_retro.md)
* [User Story Vorlage](docs/templates/user_story.md)

### 8.2 Weitere Referenzen (Optional)

*Platz für zusätzliche Links, interessante Artikel oder Dokumente, die im Projektkontext relevant waren.*

### 8.3 Link zum GitHub Repository

*Der vollständige Quellcode und diese Dokumentation sind öffentlich zugänglich
unter: https://github.com/Stevic-Nenad/Nextcloud*

### 8.4 Link zum GitHub Project Board (Kanban/Scrum Board)

*Der aktuelle Stand der Aufgaben und das Product/Sprint Backlog sind einsehbar
unter: https://github.com/users/Stevic-Nenad/projects/1/views/1*

---

**Selbstständigkeitserklärung**

Ich erkläre hiermit, dass ich die vorliegende Semesterarbeit selbstständig und ohne fremde Hilfe verfasst und keine
anderen als die angegebenen Quellen und Hilfsmittel benutzt habe. Alle Stellen, die dem Wortlaut oder dem Sinn nach
anderen Werken entnommen sind, wurden unter Angabe der Quelle kenntlich gemacht.

Ort, Datum Nenad Stevic

---