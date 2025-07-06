# Semesterarbeit: End-to-End CI/CD-Pipeline mit Terraform, Helm und GH Actions für Nextcloud auf Kubernetes (AWS EKS)

![Header Bild](assets/header.png)

[![Deploy Nextcloud to EKS](https://github.com/Stevic-Nenad/Nextcloud/actions/workflows/deploy.yml/badge.svg?branch=master)](https://github.com/Stevic-Nenad/Nextcloud/actions/workflows/deploy.yml)

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
    - [2.2 Projektplanung](#22-projektplanung)
        - [2.2.1 Der Grobplan](#221-der-grobplan)
        - [2.2.2 Strukturierung](#222-strukturierung)
        - [2.2.3 Von Epics zu Sprints: Die iterative Feinplanung](#223-von-epics-zu-sprints-die-iterative-feinplanung)
    - [2.3 Sprint-Durchführung und Dokumentation](#23-sprint-durchführung-und-dokumentation)
        - [2.3.1 Sprint Overview Dashboard](#231-sprint-overview-dashboard)
        - [2.3.2 Sprint 0: Bootstrap & Initialplanung](#232-sprint-0-bootstrap--initialplanung)
        - [2.3.3 Sprint 1: AWS Account, Lokale Umgebung & Terraform Basis-Netzwerk (VPC)](#233-sprint-1-aws-account-lokale-umgebung--terraform-basis-netzwerk-vpc)
        - [2.3.4 Sprint 2: Terraform für EKS Cluster & ECR](#234-sprint-2-terraform-für-eks-cluster--ecr)
        - [2.3.5 Sprint 3: Terraform für RDS/IAM & Manuelles Nextcloud Deployment](#235-sprint-3-terraform-für-rdsiam--manuelles-nextcloud-deployment)
        - [2.3.6 Sprint 4: Nextcloud Helm Chart Entwicklung](#236-sprint-4-nextcloud-helm-chart-entwicklung)
        - [2.3.7 Sprint 5: CI/CD Pipeline (GitHub Actions) & Tests](#237-sprint-5-cicd-pipeline-github-actions--tests)
        - [2.3.8 Sprint 6: Finalisierung & Vollständiges Lifecycle-Management](#238-sprint-6-finalisierung--vollständiges-lifecycle-management)
    - [2.4 Risikomanagement](#24-risikomanagement)
    - [2.5 Stakeholder & Kommunikation](#25-stakeholder--kommunikation)
- [3. Evaluation](#3-evaluation)
    - [3.1 Evaluation von Lösungen](#31-evaluation-von-lösungen)
        - [3.1.1 Cloud Provider Evaluation](#311-cloud-provider-evaluation)
        - [3.1.2 Container Orchestrierung](#312-container-orchestrierung)
        - [3.1.3 Infrastructure as Code](#313-infrastructure-as-code)
        - [3.1.4 Application Configuration Management](#314-application-configuration-management)
        - [3.1.5 CI/CD Pipeline](#315-cicd-pipeline)
        - [3.1.6 Tool-Versioning & Reproduzierbarkeit](#316-tool-versioning--reproduzierbarkeit)
    - [3.2 Theoretische Grundlagen](#32-theoretische-grundlagen)
        - [3.2.1 Infrastructure as Code - Der Paradigmenwechsel](#321-infrastructure-as-code---der-paradigmenwechsel)
        - [3.2.2 CI/CD Pipeline - Code trifft Automation](#322-cicd-pipeline---code-trifft-automation)
        - [3.2.3 Kubernetes - Das Nextcloud Ökosystem](#323-kubernetes---das-nextcloud-ökosystem)
        - [3.2.4 Helm - Templates werden zu Realität](#324-helm---templates-werden-zu-realität)
        - [3.2.5 Stateful Architecture - Persistenz in der Container-Welt](#325-stateful-architecture---persistenz-in-der-container-welt)
    - [3.3 System-Design / Architektur](#33-system-design--architektur)
        - [3.3.1 Logische Gesamtarchitektur](#331-logische-gesamtarchitektur)
        - [3.3.2 AWS Netzwerkarchitektur](#332-aws-netzwerkarchitektur)
        - [3.3.3 Komponenten-Matrix](#333-komponenten-matrix)
        - [3.3.4 EKS Deep-Dive - Security by Design](#334-eks-deep-dive---security-by-design)
- [4. Implementierung und Technische Umsetzung](#4-implementierung-und-technische-umsetzung)
    - [4.1 Infrastruktur-Provisionierung mit Terraform](#41-infrastruktur-provisionierung-mit-terraform)
        - [4.1.1 Terraform State Backend - Foundation für Kollaboration](#411-terraform-state-backend---foundation-für-kollaboration)
        - [4.1.2 Netzwerk-Architektur - Defense in Depth](#412-netzwerk-architektur---defense-in-depth)
        - [4.1.3 EKS Cluster - Managed Kubernetes mit Custom Tuning](#413-eks-cluster---managed-kubernetes-mit-custom-tuning)
        - [4.1.4 IAM Roles for Service Accounts (IRSA) - Sichere Pod-Authentifizierung](#414-iam-roles-for-service-accounts-irsa---sichere-pod-authentifizierung)
        - [4.1.5 Persistenter Speicher - EBS CSI Driver](#415-persistenter-speicher---ebs-csi-driver)
        - [4.1.6 RDS Datenbank - Managed PostgreSQL](#416-rds-datenbank---managed-postgresql)
    - [4.2 Nextcloud Helm Chart - Anwendungs-Paketierung](#42-nextcloud-helm-chart---anwendungs-paketierung)
        - [4.2.1 Chart-Architektur](#421-chart-architektur)
        - [4.2.2 Kritische Template-Komponenten](#422-kritische-template-komponenten)
        - [4.2.3 Flexible Konfiguration](#423-flexible-konfiguration)
    - [4.3 CI/CD Pipeline - Automatisierte Deployments](#43-cicd-pipeline---automatisierte-deployments)
        - [4.3.1 GitHub Actions Architektur](#431-github-actions-architektur)
        - [4.3.2 OIDC-Authentifizierung - Keine Passwörter](#432-oidc-authentifizierung---keine-passwörter)
        - [4.3.3 Lifecycle-Management](#433-lifecycle-management)
    - [4.4 Kritische Konfigurationsanpassungen](#44-kritische-konfigurationsanpassungen)
        - [4.4.1 EKS Node IMDS-Konfiguration](#441-eks-node-imds-konfiguration)
        - [4.4.2 Nextcloud Load Balancer Integration](#442-nextcloud-load-balancer-integration)
        - [4.4.3 RDS Security Group Isolation](#443-rds-security-group-isolation)
    - [4.5 Deployment und Validierung](#45-deployment-und-validierung)
- [5. Testing und Qualitätssicherung](#5-testing-und-qualitätssicherung)
    - [5.1 Mehrstufige Qualitätssicherung](#51-mehrstufige-qualitätssicherung)
    - [5.2 Automatisierte Tests](#52-automatisierte-tests)
    - [5.3 Manuelle Validierung](#53-manuelle-validierung)
    - [5.4 End-to-End Pipeline Tests](#54-end-to-end-pipeline-tests)
    - [5.5 Qualitätssicherungs-Erkenntnisse](#55-qualitätssicherungs-erkenntnisse)
    - [5.6 Testprotokolle](#56-testprotokolle)
        - [5.6.1 Nachweise der Testergebnisse (Screenshots / GIFs)](#561-nachweise-der-testergebnisse-screenshots--gifs)
- [6. Projektdokumentation (Zusammenfassung)](#6-projektdokumentation-zusammenfassung)
    - [6.1 Verzeichnisse und Zusammenfassungen](#61-verzeichnisse-und-zusammenfassungen)
    - [6.2 Quellenangaben und verwendete Werkzeuge](#62-quellenangaben-und-verwendete-werkzeuge)
    - [6.3 Lizenz](#63-lizenz)
- [7. Reflexion und Erkenntnisse](#7-reflexion-und-erkenntnisse)
    - [7.1 Scrum für eine Person - schwieriger als gedacht](#71-scrum-für-eine-person---schwieriger-als-gedacht)
    - [7.2 Die Faszination für Komplexität](#72-die-faszination-für-komplexität)
    - [7.3 Tool-Chaos und Realitäts-Check](#73-tool-chaos-und-realitäts-check)
    - [7.4 Was bleibt - trotz allem](#74-was-bleibt---trotz-allem)
- [8. Anhänge](#8-anhänge)
    - [8.1 Verwendete Scrum-Vorlagen (Templates)](#81-verwendete-scrum-vorlagen-templates)
    - [8.2 Weitere Referenzen (Optional)](#82-weitere-referenzen-optional)
    - [8.3 Link zum GitHub Repository](#83-link-zum-github-repository)
    - [8.4 Link zum GitHub Project Board (Kanban/Scrum Board)](#84-link-zum-github-project-board-kanbanscrum-board)

---

## 1. Einleitung

*In diesem Kapitel wird das Projekt, die Kriterien und die Vorgehensweise genauer unter die Lupe genommen. Damit wird
ein Überblick über die geplante Arbeit geschaffen, was die Auswertung der Ergebnisse am Schluss vereinfachen soll.*

## 1.1 Problemstellung

Das Hosten von Webanwendungen mit High-Availability Infrastrukturen bringt komplexe Herausforderungen mit sich: Wie
laufen mehrere Instanzen einer Applikation parallel, ohne die Datenintegrität auf der DB zu gefährden? Wie konfiguriert
man die verschiedenen Komponenten fehlerfrei?

Diese Probleme begegnen uns täglich beim Hosting von Kundenanwendungen, auch im aktuellen Betrieb. Da ich schon
Erfahrungen in diesem Bereich sammeln konnte, aber bisher nie von Grund auf so eine Architektur beim Aufbau begleitet
habe, schien mir dies eine Packende und interessante Aufgabe.

## 1.2 Projektziele

Die Ziele folgen dem SMART-Prinzip (**S**pezifisch, **M**essbar, **A**ttraktiv, **R**elevant, **T**erminiert):

1. **Automatisierte Infrastruktur via Terraform**  
   AWS-Infrastruktur (EKS, RDS, ECR) vollständig als Code erstellen.

2. **Funktionales Nextcloud Helm Chart**  
   Eigenständiges Chart für Kubernetes-Deployments, Services, PVCs und Datenbankverbindungen.

3. **CI/CD-Pipeline mit GitHub Actions**  
   Automatisierte Pipeline für kompletten Deployment-Prozess bei Code-Änderungen.

4. **Funktionale Nextcloud Instanz**  
   Extern erreichbare, datenbankverbundene Instanz mit Datenpersistenz.

5. **Vollständige Dokumentation**  
   Systemarchitektur, Code und Setup-Prozess dokumentiert.

*Warum SMART?* Jedes Ziel ist **spezifisch** definiert, hat **messbare** Erfolgskriterien, ist **attraktiv** für
DevOps-Entwicklung, **relevant** für die Berufspraxis und **terminiert**.

## 1.3 Vorgehensweise

Die Lösung basiert vollständig auf "Infrastructure as Code" (IaC):

- **Infrastruktur-Provisionierung:** Cloud-Infrastruktur via **Terraform**
- **Anwendungs-Deployment:** Nextcloud via eigenem **Helm Chart** auf Kubernetes
- **Automatisierung:** Kompletter Lifecycle via **GitHub Actions CI/CD-Pipeline**
- **Methodisches Vorgehen:** Agile Entwicklung nach **Scrum-Framework** mit iterativer Entwicklung und begleitender
  Dokumentation

Dabei wird bei der Entwicklung des Projekts auf SCRUM basiertes, Agiles Entwickeln gesetzt.

## 1.4 Zusammenfassung

Diese Semesterarbeit implementiert eine durchgängig automatisierte Pipeline zur Bereitstellung von Nextcloud auf AWS
EKS. Die Lösung nutzt Terraform für Cloud-Infrastruktur, Helm für Kubernetes-Paketierung und GitHub Actions für
CI/CD-Automatisierung. Ziel ist eine robuste, wiederholbare Deployment-Methode und die Vertiefung von DevOps- und
Cloud-native-Kompetenzen.

## 1.5 Scope

Zur Sicherstellung der Realisierbarkeit innerhalb des vorgegebenen Zeitrahmens werden folgende Aspekte klar definiert
und abgegrenzt:

**Im Projektumfang (In Scope):**

- Automatisierte Kern-Infrastruktur (EKS, RDS, ECR) via Terraform
- Funktionales Nextcloud Helm Chart mit Persistenz und Datenbankanbindung
- CI/CD-Pipeline mit GitHub Actions für EKS-Deployment
- Sichere Secret-Handhabung für Datenbank und Pipeline-Authentifizierung
- Extern erreichbare Nextcloud-Instanz mit Datenpersistenz
- Architektur- und Setup-Dokumentation

**Nicht im Projektumfang (Out of Scope):**

- Erstellung einer eigenen Applikation/Eigener Fork von Nextcloud
- Komplexe Nextcloud-Konfigurationen oder externe Authentifizierungssysteme
- Automatisierte Backup/Restore-Strategien
- Advanced Monitoring/Logging über Kubernetes/AWS-Standards hinaus
- Performance-Optimierung und Lasttests
- Multi-Cloud-Support oder andere Kubernetes-Distributionen
- Custom Nextcloud Docker-Images
- Compliance-Anforderungen über IT-Security Best Practices hinaus

---

## 2. Projektmanagement

*Dieses Projekt folgt dem Scrum-Framework, um eine iterative Entwicklung und transparente Nachvollziehbarkeit zu
gewährleisten. Alle Rollen werden durch mich, den Studierenden, wahrgenommen, die Prinzipien aber konsequent
eingehalten. (So gut wie's ging)*

## 2.1 Scrum

**Product Goal:** Bis zum 09.07.2025 eine vollautomatisierte CI/CD-Pipeline mit Terraform, Helm und GitHub Actions
implementieren, die eine funktionale Nextcloud-Instanz auf AWS EKS bereitstellt und verwaltet.

### 2.1.1 Rollen

Alle Scrum-Rollen werden durch mich, Nenad Stevic, wahrgenommen:

- **Product Owner:** Definition der Produktvision und Priorisierung des Backlogs
- **Scrum Master:** Prozesseinhaltung und Beseitigung von Hindernissen
- **Developer:** Technische Umsetzung der Sprint-Ziele

### 2.1.2 Artefakte

- **Product Backlog:** Dynamische Liste aller Anforderungen, geführt
  als [GitHub Project Board](https://github.com/users/Stevic-Nenad/projects/1)
- **Sprint Backlog:** Ausgewählte Items für den aktuellen Sprint mit konkretem Umsetzungsplan
- **Increment:** Lauffähiger Code und aktualisierte Dokumentation nach jedem Sprint

### 2.1.3 Zeremonien

Um Scrum auch als Einzelperson konsequent zu leben, werden alle Zeremonien mehr oder weniger durchgeführt - wenn auch in
angepasster Form:

**Sprint Planning** findet zu Beginn jedes Sprints statt. Als Product Owner präsentiere ich mir die priorisierten
Backlog Items, wechsle dann in die Developer-Rolle und wähle realistisch umsetzbare Items aus. Das Sprint-Ziel wird klar
definiert und die konkreten Aufgaben geplant.

**Daily Scrum** wird als tägliche 5-10 Minuten Reflexion durchgeführt. Die drei klassischen Fragen - Was wurde gestern
erreicht? Was wird heute getan? Gibt es Hindernisse? - werden beantwortet. Diese Routine sollte helfen, den Fokus zu
behalten und nicht in Rabbit Holes zu verschwinden.

**Sprint Review** erfolgt am Sprint-Ende durch Demonstration des Inkrements. Auch wenn keine externen Stakeholder
anwesend sind, wird das Erreichte kritisch begutachtet und das Product Backlog entsprechend angepasst.

**Sprint Retrospective** ist besonders wertvoll für kontinuierliche Verbesserung. Was lief gut? Was kann optimiert
werden? Konkrete Massnahmen für den nächsten Sprint werden abgeleitet.

**Backlog Refinement** passiert kontinuierlich während des Sprints. User Stories werden detailliert, geschätzt und bei
Bedarf aufgeteilt, um das Product Backlog stets in einem "ready" Zustand zu halten.

### 2.1.4 Definition of Done

Was bedeutet "fertig" in diesem Projekt? Ein Backlog Item durchläuft mehrere Qualitätsstufen: Der Code wird direkt auf
dem `main`-Branch entwickelt und committet (trunk-based development). Automatisierte Prüfungen wie `terraform validate`
und `helm lint` müssen grün sein. Die Infrastruktur wird erfolgreich deployed und die Funktionalität verifiziert. Alle
Akzeptanzkriterien sind erfüllt, die Dokumentation aktualisiert und das Item wandert im Project Board in die "Done"
-Spalte. Erst dann gilt ein Feature als wirklich abgeschlossen und bereit für den produktiven Einsatz.

## 2.2 Projektplanung

*Eine gute Planung ist das A und O, auch wenn man agil unterwegs ist. In diesem Kapitel wird behandelt, wie die Roadmap
zur fertigen Nextcloud-Pipeline auszusehen hat.*

### 2.2.1 Der Grobplan

Der zeitliche Rahmen orientiert sich an den offiziellen TBZ-Terminen, insbesondere den Einzelbesprechungen und dem
finalen Abgabetermin am 09.07.2025. Basierend auf ersten Aufwandsschätzungen für die Hauptkomponenten wurde ein
visueller Zeitplan erstellt, der die übergeordneten Projektphasen und geplanten Sprints im Überblick zeigt:

![gantt](assets/gantt.svg)
***Bild:** Gantt-Diagramm*

Dieser Plan dient als Orientierung und wird iterativ verfeinert. Die sechs geplanten Sprints à zwei Wochen (plus/minus)
ermöglichen eine strukturierte Herangehensweise, während genügend Flexibilität für Anpassungen bleibt.

### 2.2.2 Strukturierung

Das Projekt gliedert sich in acht thematische Arbeitspakete (Epics), die den Weg von der Projektinitialisierung bis zur
fertigen CI/CD-Pipeline strukturieren. Diese Epics bauen logisch aufeinander auf und können sich über mehrere Sprints
erstrecken:

| Epic        | Fokus         | Beschreibung                                                                                                    | Abhängigkeiten    |
|-------------|---------------|-----------------------------------------------------------------------------------------------------------------|-------------------|
| `PROJMGMT`  | Setup         | Schaffung der organisatorischen Grundlagen: Repository-Setup, initiale Dokumentation und GitHub Project Board   | -                 |
| `TF-NET`    | Infrastruktur | Aufbau des Cloud-Fundaments mit VPC, Subnetze, Internet Gateway, Routing-Tabellen und Security Groups           | PROJMGMT          |
| `TF-K8S`    | Platform      | Automatisierte Bereitstellung eines managed EKS-Clusters und einer privaten ECR-Registry                        | TF-NET            |
| `TF-DB-IAM` | Services      | Provisionierung einer managed RDS-Datenbank und aller notwendigen IAM-Rollen für sichere Service-Kommunikation  | TF-NET            |
| `NC-DEPLOY` | Application   | Manuelle Installation und Konfiguration von Nextcloud zur Validierung der Datenbankanbindung und Persistenz     | TF-K8S, TF-DB-IAM |
| `HELM`      | Automation    | Entwicklung eines robusten, konfigurierbaren Helm Charts für konsistente, reproduzierbare Nextcloud-Deployments | NC-DEPLOY         |
| `CICD`      | Pipeline      | Implementierung der vollautomatisierten CI/CD-Pipeline mit GitHub Actions für kontinuierliche Deployments       | HELM              |
| `ABSCHLUSS` | Delivery      | Umfassendes End-to-End-Testing der Gesamtlösung und Finalisierung der Projektdokumentation                      | CICD              |
***Tabelle:** Epic Issues*

### 2.2.3 Von Epics zu Sprints: Die iterative Feinplanung

Die Detailplanung erfolgt Sprint für Sprint. Jeder Sprint hat ein klares Ziel, aus dem konkrete User Stories mit
Akzeptanzkriterien abgeleitet werden. Das Product Backlog wird kontinuierlich gepflegt und priorisiert, ohne das gesamte
Projekt vorab bis ins Detail zu planen.

Diese Flexibilität ermöglicht es, auf Erkenntnisse aus vorherigen Sprints zu reagieren und die Planung entsprechend
anzupassen.

## 2.3 Sprint-Durchführung und Dokumentation

*Dieser Abschnitt dokumentiert die Durchführung aller sechs Sprints mit ihren wichtigsten Ergebnissen, Herausforderungen
und Lernerfahrungen. Jeder Sprint folgt dem definierten Scrum-Zyklus mit Planning, Daily Scrums, Review und
Retrospektive.*

### 2.3.1 Sprint Overview Dashboard

| Sprint | Ziel                | Status     | Stories | Impediments | Schlüsselelement        |
|--------|---------------------|------------|---------|-------------|-------------------------|
| 0      | Bootstrap & Setup   | ✅ Complete | 6/6     | 1           | Project foundation      |
| 1      | AWS Foundation      | ✅ Complete | 5/5     | 2           | VPC + Tools setup       |
| 2      | EKS & ECR           | ✅ Complete | 4/4     | 1           | K8s platform ready      |
| 3      | RDS & Manual Deploy | ✅ Complete | 5/5     | 2           | **Proof-of-concept**    |
| 4      | Helm Chart          | ✅ Complete | 5/5     | 1           | Standardized deployment |
| 5      | CI/CD Pipeline      | ✅ Complete | 3/3     | 1           | **Full automation**     |
| 6      | Lifecycle & Polish  | ✅ Complete | 6/6     | 1           | Complete solution       |
***Tabelle:** Sprint-Übersicht*

---

### 2.3.2 Sprint 0: Bootstrap & Initialplanung

**Dauer:** 05. Mai - 09. Mai 2025 (Erledigt 9. Mai 2025)
**Zugehöriges Epic:** `EPIC-PROJMGMT`  
**Sprint Planning:** 05.05.2025 (simuliert)

Basierend auf den Projektanforderungen und den TBZ-Vorgaben wurde dieser Sprint darauf ausgerichtet, die Projektbasis zu
schaffen (D.h. Setup de Repo, Grundgerüst des Dokuments usw.).

### 2.3.2.1 Sprint-Ziel

"Die grundlegende Projektinfrastruktur (Repository, Scrum-Board, initiale Dokumentation) ist etabliert, das
Scrum-Rahmenwerk für das Projekt ist definiert und dokumentiert, und eine erste Grobplanung (Epics, Roadmap) sowie die
Detailplanung für Sprint 1 sind vorhanden, um eine solide Basis für die erfolgreiche Durchführung der Semesterarbeit zu
schaffen."

### 2.3.2.2 Sprint Backlog

| User Story     | Was wurde umgesetzt                                                       | Interessante Erkenntnisse/Herausforderungen                                                                      | Abgeschlossen |
|----------------|---------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|---------------|
| `Nextcloud#33` | Repository-Initialisierung mit Grundstruktur (`src/`, `charts/`, `docs/`) | Entscheidung für monorepo-Ansatz statt separate Repos für Terraform/Helm                                         | 05.05.2025    |
| `Nextcloud#34` | Scrum-Framework Definition: DoD, DoR, Product Goal, Epic-Struktur         | Anpassung der Standard-Scrum-Rollen für Einzelperson erwies sich als knifflig                                    | 06.05.2025    |
| `Nextcloud#35` | 6-Sprint-Roadmap mit Gantt-Diagramm und Sprint 1 Detailplanung            | Aufwandsschätzung ohne Referenzwerte sehr schwierig - erste Schätzungen erwiesen sich später als zu optimistisch | 07.05.2025    |
| `Nextcloud#36` | Risikomatrix für AWS-Kosten, Technologie-Komplexität, Zeitrisiken         | AWS Free Tier Limits als kritisches Risiko identifiziert - führte zu kostenoptimierten Architekturentscheidungen | 08.05.2025    |
| `Nextcloud#1`  | GitHub Project Board mit Kanban-Workflow, Epic-Labels, Automation         | Board-Automation (Auto-move to "In Progress") funktionierte nicht wie erwartet - manueller Workflow notwendig    | 08.05.2025    |
| `Nextcloud#3`  | Issue-Templates für User Stories, Bugs, Epics mit Akzeptanzkriterien      | Template-Syntax anfangs verwirrend - mehrere Iterationen bis zufriedenstellende Form erreicht                    | 09.05.2025    |
***Tabelle:** Sprint 0 - User Stories*

### 2.3.2.3 Erreichtes Inkrement

| Komponente           | Deliverable                    | Wichtigste Features                                                           | Nachweis                                                                         |
|----------------------|--------------------------------|-------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
| **Repository**       | GitHub Repo initialisiert      | Verzeichnisstruktur (`src/`, `charts/`, `docs/`), README-Template, MIT-Lizenz | [github.com/Stevic-Nenad/Nextcloud](https://github.com/Stevic-Nenad/Nextcloud)   |
| **Scrum-Framework**  | Vollständige Prozessdefinition | Product Goal, 8-Punkte DoD, Epic-Struktur, User Story Format                  | Kapitel 2.1                                                                      |
| **Project Board**    | Funktionales Kanban-Board      | 4 Spalten, Epic-Labels, Issue-Templates, Workflow-Automation                  | [GitHub Project Board](https://github.com/users/Stevic-Nenad/projects/1/views/1) |
| **Sprint 1 Planung** | Detailliertes Backlog          | 5 User Stories mit Akzeptanzkriterien, Abhängigkeiten identifiziert           | Issues #37, #38, #6, #5, #7                                                      |
| **Risikoanalyse**    | Risikomatrix erstellt          | 12 Risiken bewertet, AWS-Kosten als kritisch identifiziert                    | Kapitel 2.4                                                                      |
| **Roadmap**          | 6-Sprint-Zeitplan              | Gantt-Diagramm, Meilensteine, Epic-zu-Sprint-Zuordnung                        | Kapitel 2.2.1                                                                    |
***Tabelle:** Sprint 0 - Inkremente*

### 2.3.2.4 Screenshots

![Planning Board](assets/sprint0-planning-board.png)  
***Bild:** Sprint 0 - GitHub Project Board nach Sprint Planning - 6 User Stories committet mit Epic-Labels*

![User Story Details](assets/sprint0-backlog-items.png)  
***Bild:** Sprint 0 - Detailansicht User Story mit vollständigen Akzeptanzkriterien*

![Sprint Complete](assets/sprint0-complete.png)  
***Bild:** Sprint 0 - Alle 6 User Stories erfolgreich in "Done" Spalte - Sprint-Ziel erreicht*

![Repository Structure](assets/sprint0-repo-structure.png)  
***Bild:** Sprint 0 - Finale Repository-Struktur mit professioneller Verzeichnisorganisation*

### 2.3.2.4 Impediments & Lösungen

> **Hauptimpediment:** Krankheitsbedingter Ausfall (06.–07. 05. 2025)  
> **Auswirkung:** Reduzierte verfügbare Arbeitszeit  
> **Ergebnis:** Sprint-Ziel trotzdem erreicht

**Lösungsschritte**

- 🚀 Mehr Freizeit investiert
- 🎯 Kernaufgaben priorisiert

### 2.3.2.6 Sprint Review

**Demo-Highlights:** Funktionales GitHub Project Board mit automatisierten Workflows präsentiert  
**Stakeholder-Feedback:** Solide Projektbasis geschaffen, bereit für technische Sprints  
**Sprint-Ziel Status:** ✅ Vollständig erreicht (6/6 User Stories abgeschlossen)  
**Nächste Schritte:** Sprint 1 kann planmässig starten mit AWS-Account-Setup

### 2.3.2.7 Sprint Retrospektive

| 😊 Was lief gut                    | 😕 Was lief schlecht                      | 💡 Lessons Learned                     | ⚡ Action Items                             |
|------------------------------------|-------------------------------------------|----------------------------------------|--------------------------------------------|
| Priorisierung half bei Zeitdruck   | GitHub Automation komplexer als erwartet  | Scrum für 1 Person braucht Anpassungen | Zeitpuffer in zukünftige Sprints einplanen |
| Akzeptanzkriterien als Checklisten | Aufwandsschätzung ohne Referenz schwierig | Detailplanung reduziert Stress         | Risikobewertung kontinuierlich machen      |
| Klare Epic-Struktur etabliert      | Issue-Template-Syntax verwirrend          | GitHub Features haben Lernkurve        | Template-Dokumentation erstellen           |
***Tabelle:** Sprint 0 - Retro*

---

### 2.3.3 Sprint 1: AWS Account, Lokale Umgebung & Terraform Basis-Netzwerk (VPC)

**Dauer:** 10. Mai - 24. Mai 2025 (Erledigt 24. Mai 2025)
**Zugehöriges Epic:** `EPIC-PROJEKT`, `EPIC-NETZ`  
**Sprint Planning:** 09.05.2025 (simuliert)

Nach erfolgreichem Abschluss von Sprint 0 zielte dieser erste operative Sprint darauf ab, die fundamentalen technischen
Grundlagen für alle weiteren Infrastrukturarbeiten zu schaffen. Ohne sicheren AWS-Zugang, lokale Entwicklungsumgebung
und grundlegende Netzwerkstruktur wären keine weiteren Komponenten sinnvoll umsetzbar.

### 2.3.3.1 Sprint-Ziel

"Ein sicherer AWS Account und eine lokale Entwicklungsumgebung sind eingerichtet, das Terraform Remote Backend ist
konfiguriert, und ein grundlegendes, korrekt getaggtes AWS VPC-Netzwerk ist mittels Terraform Code definiert,
versioniert und erfolgreich provisioniert."

### 2.3.3.2 Sprint Backlog

| User Story     | Was wurde umgesetzt                                                                                         | Interessante Erkenntnisse/Herausforderungen                                                                    | Abgeschlossen |
|----------------|-------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------|---------------|
| `Nextcloud#37` | AWS Root Account mit MFA, IAM User "terraform-admin", AWS CLI Profile "nextcloud-project", Budget $20/Monat | AWS Free Tier Limits mussten genau geprüft werden - AdministratorAccess pragmatisch aber nicht Least Privilege | 24.05.2025    |
| `Nextcloud#38` | Lokale Tools: AWS CLI v2.x, Terraform v1.9.x, kubectl v1.30.x, Helm v3.15.x, IntelliJ Ultimate              | Unterschiedliche Installationsmethoden je nach OS erforderten flexible Dokumentation                           | 24.05.2025    |
| `Nextcloud#7`  | Globale Tagging-Strategie implementiert, AWS Provider mit default_tags konfiguriert                         | Standard-Tags automatisch auf alle Ressourcen propagiert - wichtige Basis für Kostenkontrolle                  | 24.05.2025    |
| `Nextcloud#6`  | S3 Backend und DynamoDB State Locking für Terraform Remote Backend konfiguriert                             | Backend-Konfiguration extern verwaltet, keine AWS Keys im Code hardcodiert                                     | 24.05.2025    |
| `Nextcloud#5`  | VPC mit öffentlichen/privaten Subnetzen, NAT Gateway pro AZ für Hochverfügbarkeit                           | NAT-Gateway-pro-AZ-Architektur komplexer als initial geschätzt aber bessere HA-Lösung                          | 24.05.2025    |
***Tabelle:** Sprint 1 - User Stories*

### 2.3.3.3 Erreichtes Inkrement

| Komponente           | Deliverable                                  | Wichtigste Features                                                               | Nachweis                                            |
|----------------------|----------------------------------------------|-----------------------------------------------------------------------------------|-----------------------------------------------------|
| **AWS Account**      | Sichere Produktionsreife Konfiguration       | MFA aktiviert, IAM User, Budget Alerts, eu-central-1 als Standard-Region          | AWS Console, ~/.aws/credentials                     |
| **Lokale Umgebung**  | Vollständig eingerichtetes Development Setup | AWS CLI, Terraform, kubectl, Helm, IntelliJ - alle Tools getestet und verifiziert | Terminal-Ausgaben der Versionsprüfungen             |
| **Terraform Basis**  | Modulare Provider-Konfiguration              | Globale Tags, AWS Provider v5.x, Standardregion konfiguriert                      | `src/terraform/provider.tf`, `locals.tf`            |
| **Remote Backend**   | Zentrale State-Verwaltung                    | S3 Bucket mit Versionierung, DynamoDB Locking, Verschlüsselung                    | `src/terraform/backend.tf`, `terraform init` Erfolg |
| **VPC Netzwerk**     | Hochverfügbare Netzwerkarchitektur           | 2 AZ, öffentliche/private Subnetze, NAT Gateway pro AZ, IGW, Route Tables         | AWS VPC Console, `terraform plan/apply`             |
| **Kostenmanagement** | Automatisches Tagging & Budget               | Alle Ressourcen mit Projekt-Tags, $20 Budget mit 80%/100% Alerts                  | AWS Billing Dashboard, Resource Tags                |
***Tabelle:** Sprint 01 - Inkremente*

### 2.3.3.4 Screenshots

![AWS Account Setup](assets/sprint1-aws-account.png)
***Bild:** Sprint 1 - Sicherer AWS Account mit aktiviertem MFA und konfiguriertem IAM User "terraform-admin"*

![Local Development Environment](assets/sprint1-local-tools.png)
***Bild:** Sprint 1 - Vollständig eingerichtete lokale Entwicklungsumgebung mit allen erforderlichen Tools*

![VPC Architecture](assets/sprint1-vpc-network.png)
***Bild:** Sprint 1 - Provisionierte VPC-Netzwerkarchitektur mit NAT Gateway pro Availability Zone*

![Terraform State Backend](assets/sprint1-remote-backend.png)
***Bild:** Sprint 1 - Konfiguriertes S3 Remote Backend mit DynamoDB State Locking*

### 2.3.3.5 Impediments & Lösungen

> **Hauptimpediment:** AWS Free Tier Limits und Kostenoptimierung  
> **Auswirkung:** Architekturentscheidungen mussten kostenbewusst getroffen werden  
> **Ergebnis:** NAT Gateway pro AZ als Kompromiss zwischen HA und Kosten

**Lösungsschritte**

- 💰 AWS Budget mit Alerts eingerichtet
- 🏷️ Globale Tagging-Strategie für Kostentransparenz
- ⚖️ NAT Gateway pro AZ statt single NAT für bessere Verfügbarkeit

### 2.3.3.6 Sprint Review

**Demo-Highlights:** Vollständige AWS-Infrastruktur via Terraform Code demonstriert - von Account-Setup bis
VPC-Provisionierung  
**Stakeholder-Feedback:** Solide technische Basis geschaffen, NAT-Gateway-pro-AZ-Strategie als gute Designentscheidung
bewertet  
**Sprint-Ziel Status:** ✅ Vollständig erreicht (5/5 User Stories abgeschlossen)  
**Nächste Schritte:** Sprint 2 kann mit EKS Cluster Aufbau starten

### 2.3.3.7 Sprint Retrospektive

| 😊 Was lief gut                            | 😕 Was lief schlecht                        | 💡 Lessons Learned                            | ⚡ Action Items                                   |
|--------------------------------------------|---------------------------------------------|-----------------------------------------------|--------------------------------------------------|
| Klare Zielsetzung half bei Fokussierung    | Aufwandsschätzung VPC zu optimistisch       | Remote Backend früh etablieren zahlt sich aus | Detailliertere Recherche bei komplexen Tasks     |
| Best Practices von Anfang an implementiert | AdministratorAccess nicht Least Privilege   | AWS Free Tier Limits beeinflussen Architektur | IAM Policies für Sprint 2 spezifischer gestalten |
| Strukturierte User Story Aufteilung        | Kleine Impediments nicht immer dokumentiert | Parallele Dokumentation bewährt sich          | Konsequentere Impediment-Erfassung               |
| NAT Gateway pro AZ für echte HA            | Tool-Kompatibilitäten unterschätzt          | Kostenmanagement ist kritischer Erfolgsfaktor | Terraform Provider Versionen genauer prüfen      |
***Tabelle:** Sprint 1 - Retro*

---

### 2.3.4 Sprint 2: Terraform für EKS Cluster & ECR

**Dauer:** 25. Mai - 01. Juni 2025 (Erledigt 01. Juni 2025)
**Zugehöriges Epic:** `EPIC-TF-K8S`  
**Sprint Planning:** 24.05.2025 (simuliert)

Aufbauend auf der soliden VPC-Infrastruktur aus Sprint 1 zielte dieser Sprint darauf ab, das Herzstück der
Container-Plattform zu schaffen: einen vollwertigen Kubernetes-Cluster mit persistenter Speicherunterstützung und
sicherer Container-Registry-Integration.

### 2.3.4.1 Sprint-Ziel

"Ein funktionsfähiger AWS EKS Kubernetes-Cluster mit konfigurierten Node Groups und einem IAM OIDC Provider ist mittels
Terraform automatisiert provisioniert. Zusätzlich ist ein AWS ECR Repository für Docker-Images via Terraform erstellt
und der AWS EBS CSI Driver im EKS Cluster für persistente Volumes installiert und konfiguriert."

### 2.3.4.2 Sprint Backlog

| User Story     | Was wurde umgesetzt                                                                                 | Interessante Erkenntnisse/Herausforderungen                                                                    | Abgeschlossen |
|----------------|-----------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------|---------------|
| `Nextcloud#8`  | EKS Control Plane K8s v1.29, Managed Node Group t3.medium (2 Nodes), IAM Rollen für Cluster & Nodes | `assume_role_policy` Syntax anfangs problematisch - Worker Nodes erfolgreich in private Subnetze platziert     | 01.06.2025    |
| `Nextcloud#10` | IAM OIDC Provider mit dynamischem Root-CA-Thumbprint, IRSA-Rolle für EBS CSI Driver                 | IRSA Trust Policy Komplexität unterschätzt - `Condition`-Klausel für Service Account Binding war der Schlüssel | 01.06.2025    |
| `Nextcloud#9`  | Privates ECR Repository mit Image Scanning, Lifecycle Policy für ungetaggte Images (30 Tage)        | JSON-Syntax für ECR Lifecycle Policy erforderte AWS-Dokumentation-Recherche                                    | 01.06.2025    |
| `Nextcloud#11` | AWS EBS CSI Driver als EKS Add-on via IRSA, Test PVC erfolgreich an dynamisches EBS Volume gebunden | EKS Add-on Ansatz stabiler als Helm - Live-Test mit PVC/PV-Binding bestätigte Funktionalität                   | 01.06.2025    |
***Tabelle:** Sprint 2 - User Stories*

### 2.3.4.3 Erreichtes Inkrement

| Komponente              | Deliverable                            | Wichtigste Features                                                             | Nachweis                                   |
|-------------------------|----------------------------------------|---------------------------------------------------------------------------------|--------------------------------------------|
| **EKS Cluster**         | Produktionsreifer Kubernetes Cluster   | K8s v1.29, HA mit 2 Worker Nodes in privaten Subnetzen, Auto-Scaling bereit     | `kubectl get nodes -o wide`, EKS Console   |
| **IAM OIDC Provider**   | Sichere Pod-zu-AWS-Service Integration | IRSA aktiviert, dynamischer Thumbprint, Service Account basierte Rollen         | AWS IAM Console, Trust Policy Verification |
| **ECR Repository**      | Private Container Registry             | Image Scanning aktiviert, Lifecycle Policy, Repository URL als Terraform Output | AWS ECR Console, `terraform output`        |
| **EBS CSI Driver**      | Persistente Speicherlösung             | EKS-verwaltetes Add-on, IRSA-konfiguriert, dynamische Volume-Provisionierung    | `kubectl get pvc`, AWS EC2 Volumes         |
| **Terraform Config**    | Modulare IaC-Struktur                  | Getrennte Dateien (eks.tf, ecr.tf, iam_oidc.tf), saubere Resource-Organisation  | `src/terraform/` Verzeichnisstruktur       |
| **kubectl Integration** | Lokaler Cluster-Zugriff                | kubeconfig automatisch konfiguriert, Ready-Status aller Nodes verifiziert       | `aws eks update-kubeconfig` Erfolg         |
***Tabelle:** Sprint 2 - Inkremente*

### 2.3.4.4 Screenshots

![EKS Cluster Overview](assets/sprint2-eks-cluster.png)
***Bild:** Sprint 2 - Vollständig provisionierter EKS Cluster mit 2 Worker Nodes im Ready-Status*

![ECR Repository](assets/sprint2-ecr-registry.png)
***Bild:** Sprint 2 - Privates ECR Repository mit aktiviertem Image Scanning und Lifecycle Policy*

![IRSA Configuration](assets/sprint2-irsa-setup.png)
***Bild:** Sprint 2 - IAM OIDC Provider und IRSA-Rolle für sicheren Pod-zu-AWS-Service Zugriff*

![EBS CSI Driver Test](assets/sprint2-persistent-volume.png)
***Bild:** Sprint 2 - Erfolgreicher PVC-Test mit dynamisch provisioniertem EBS Volume*

### 2.3.4.5 Impediments & Lösungen

> **Hauptimpediment:** IRSA (IAM Roles for Service Accounts) Komplexität  
> **Auswirkung:** Trust Policy Syntax und Condition-Klauseln zeitaufwändiger als erwartet  
> **Ergebnis:** Sichere, anmeldeinformationsfreie AWS-API-Integration erreicht

**Lösungsschritte**

- 📚 Intensive AWS IRSA Dokumentation studiert
- 🔍 Trust Policy Condition-Syntax für Service Account Binding verstanden
- ✅ Live-Test mit PVC-Binding bestätigte erfolgreiche Implementierung

### 2.3.4.6 Sprint Review

**Demo-Highlights:** Live-Demonstration der kompletten Container-Plattform - von `terraform apply` über
`kubectl get nodes` bis hin zum dynamischen PVC-Binding  
**Stakeholder-Feedback:** Robuste und sichere Basis für Anwendungs-Deployments geschaffen, EKS Add-on Ansatz als stabile
Entscheidung gewürdigt  
**Sprint-Ziel Status:** ✅ Vollständig erreicht (4/4 User Stories abgeschlossen)  
**Nächste Schritte:** Sprint 3 kann mit RDS-Datenbank-Setup beginnen

### 2.3.4.7 Sprint Retrospektive

| 😊 Was lief gut                             | 😕 Was lief schlecht               | 💡 Lessons Learned                         | ⚡ Action Items                                       |
|---------------------------------------------|------------------------------------|--------------------------------------------|------------------------------------------------------|
| Logische Story-Aufteilung sehr effektiv     | IRSA Komplexität unterschätzt      | EKS Add-on stabiler als Helm-Installation  | Spike-Tickets für unbekannte AWS Services            |
| Proaktive kubeconfig Problemlösung          | Terraform plan/apply dauert länger | VPC aus Sprint 1 war perfekte Basis        | Modulare Terraform-Struktur beibehalten              |
| Dokumentation von Architekturentscheidungen | ECR Lifecycle Policy JSON-Syntax   | Isolierte Verifikation jeder Komponente    | Komplexitätsbewertung vor Implementierung            |
| Stabile Integration aller Komponenten       | Trust Policy Syntax Learning Curve | Live-Tests bestätigen echte Funktionalität | Terraform-Performance in Zeitplanung berücksichtigen |
***Tabelle:** Sprint 2 - Retro*

---

### 2.3.5 Sprint 3: Terraform für RDS/IAM & Manuelles Nextcloud Deployment

**Dauer:** 03. Juni - 14. Juni 2025 (Erledigt 11. Juni 2025)
**Zugehöriges Epic:** `EPIC-TF-DB-IAM`, `EPIC-NC-DEPLOY`  
**Sprint Planning:** 02.06.2025 (simuliert)

Dieser entscheidende Sprint sollte die letzte grosse Infrastruktur-Abhängigkeit schaffen und die Funktionsfähigkeit der
Gesamtplattform validieren. Das Ziel: absolute Sicherheit durch ein manuelles Proof-of-Concept-Deployment, bevor die
Automatisierung beginnt.

### 2.3.5.1 Sprint-Ziel

"Eine ausfallsichere AWS RDS PostgreSQL-Instanz ist via Terraform provisioniert und sicher konfiguriert, sodass nur der
EKS-Cluster darauf zugreifen kann. Die erfolgreiche Integration der gesamten Infrastruktur wird durch ein manuelles
Deployment einer funktionalen, datenbank-angebundenen und persistenten Nextcloud-Instanz nachgewiesen."

### 2.3.5.2 Sprint Backlog

| User Story     | Was wurde umgesetzt                                                                              | Interessante Erkenntnisse/Herausforderungen                                             | Abgeschlossen |
|----------------|--------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|---------------|
| `Nextcloud#12` | RDS PostgreSQL 16.2 (db.t3.micro) in privaten Subnetzen, Master-Passwort via AWS Secrets Manager | Sichere Credential-Verwaltung ohne Hardcoding im Terraform-Code implementiert           | 11.06.2025    |
| `Nextcloud#13` | Dedizierte RDS Security Group, Zugriff nur von EKS-Cluster auf Port 5432                         | Netzwerk-Segmentierung zwischen EKS und RDS erfolgreich isoliert                        | 11.06.2025    |
| `Nextcloud#39` | Kubernetes Secret mit base64-codierten DB-Credentials manuell erstellt                           | Bridge zwischen AWS Secrets Manager und K8s Secrets - manuelle Synchronisation nötig    | 11.06.2025    |
| **Ungeplant**  | EKS Worker Node Launch Template mit IMDS Hop Limit 2, gehärtete IRSA Trust Policy                | 🔥 PVC Pending-Status führte zu tiefgreifender Infrastruktur-Debugging-Session          | 11.06.2025    |
| `Nextcloud#14` | Funktionale Nextcloud via manuelle YAML-Manifeste, AWS Load Balancer Integration                 | Pod-Neustart-Test bestätigte Datenpersistenz und DB-Anbindung - kritischer Meilenstein! | 11.06.2025    |
| `Nextcloud#15` | Vollständige Spezifikation des manuellen Deployments in README dokumentiert                      | Detaillierte Blaupause für Sprint 4 Helm-Automatisierung geschaffen                     | 11.06.2025    |
***Tabelle:** Sprint 3 - User Stories*

### 2.3.5.3 Erreichtes Inkrement

| Komponente            | Deliverable                         | Wichtigste Features                                                      | Nachweis                                         |
|-----------------------|-------------------------------------|--------------------------------------------------------------------------|--------------------------------------------------|
| **RDS Database**      | Produktionsreife PostgreSQL-Instanz | v16.2, private Subnetze, Secrets Manager Integration, Backup-Retention   | AWS RDS Console, Terraform State                 |
| **Database Security** | Isolierte Netzwerk-Architektur      | Dedizierte Security Group, nur EKS-Zugriff, Port 5432 exklusiv           | VPC Security Groups, Connection Test             |
| **K8s Credentials**   | Sichere Secret-Verwaltung           | base64-codierte DB-Credentials in Kubernetes Secret                      | `kubectl get secret nextcloud-db-secret -o yaml` |
| **EKS Hardening**     | Robuste Worker Node Config          | Launch Template mit IMDS Hop Limit 2, gehärtete IRSA Trust Policy        | Erfolgreiche PVC-Provisionierung                 |
| **Nextcloud PoC**     | Funktionale Anwendung               | Manuelle YAML-Manifeste, Load Balancer, persistente Datenbankanbindung   | Live-Demo mit Pod-Neustart-Test                  |
| **Deployment Spec**   | Automatisierungs-Blaupause          | Vollständige Dokumentation aller Schritte, Konfigurationen und Manifeste | README Kapitel 4.1.8                             |
***Tabelle:** Sprint 3 - Inkremente*

### 2.3.5.4 Screenshots

![RDS PostgreSQL Setup](assets/sprint3-rds-database.png)
***Bild:** Sprint 3 - Provisionierte RDS PostgreSQL-Instanz in privaten Subnetzen mit Secrets Manager Integration*

![Manual Nextcloud Deployment](assets/sprint3-nextcloud-manual.png)
***Bild:** Sprint 3 - Funktionale Nextcloud-Instanz über AWS Load Balancer mit persistenter Datenbankanbindung*

![PVC Debugging Session](assets/sprint3-troubleshooting.png)
***Bild:** Sprint 3 - Systematische Fehleranalyse: Von Pending PVC über CSI-Logs bis IMDS-Konfiguration*

![Pod Restart Persistence Test](assets/sprint3-persistence-test.png)
***Bild:** Sprint 3 - Live-Demo: Pod-Neustart mit bestätigter Datenpersistenz und Datenbankintegrität*

### 2.3.5.5 Impediments & Lösungen

> **Hauptimpediment:** PVC bleibt im Pending-Status - komplexe Fehlersuche erforderlich  
> **Auswirkung:** Zweitägiger Debugging-Marathon durch alle Infrastruktur-Ebenen  
> **Ergebnis:** Robuste EKS-Konfiguration und systematische Problemlösungskompetenz

**Lösungsschritte**

- 🔍 **Problem 1:** IMDS Hop Limit zu niedrig für Container → Launch Template mit Hop Limit 2
- 🛡️ **Problem 2:** IRSA Trust Policy zu schwach → Gehärtete Policy mit `aud` und `sub` Validierung
- 📋 **Methodik:** Schichtweise Analyse (Pod → PVC → CSI → IAM → EC2) als Best Practice etabliert

### 2.3.5.6 Sprint Review

**Demo-Highlights:** Spektakuläre Live-Demo der kompletten End-to-End-Funktionalität - vom Terraform Apply über
Nextcloud-Login bis zum Pod-Neustart-Persistenz-Test  
**Stakeholder-Feedback:** Beeindruckt von Stabilität und Resilienz, gesamte Infrastruktur als validiert betrachtet,
technische Tiefe gewürdigt  
**Sprint-Ziel Status:** ✅ Vollständig erreicht (5/5 geplante + 1 ungeplante User Story abgeschlossen)  
**Nächste Schritte:** Sprint 4 Helm-Automatisierung kann auf validierter Spezifikation aufbauen

### 2.3.5.7 Sprint Retrospektive

| 😊 Was lief gut                                   | 😕 Was lief schlecht                             | 💡 Lessons Learned                                  | ⚡ Action Items                                    |
|---------------------------------------------------|--------------------------------------------------|-----------------------------------------------------|---------------------------------------------------|
| Systematische Fehlersuche methodisch durchgeführt | Komplexität von Cloud-Integrationen unterschätzt | IMDS Hop Limits sind kritisch für Container         | Validierte Spezifikation als Helm-Basis nutzen    |
| Resilienz bei komplexen Problemen bewiesen        | Subtile Abhängigkeiten nicht in Standard-Docs    | Proof-of-Concept deckt Infrastruktur-Fehler auf     | Best-Practice-Guides vor Implementation studieren |
| Inkrementeller Wert durch PoC-Ansatz              | Dokumentation der Impediments verzögert          | Schichtweise Debugging ist der Schlüssel            | GitHub Issues für bekannte Probleme recherchieren |
| Sprint-Ziel trotz Herausforderungen erreicht      | IRSA Trust Policy Komplexität übersehen          | Manuelle Validierung vor Automatisierung essentiell | Impediments sofort nach Lösung dokumentieren      |
***Tabelle:** Sprint 3 - Retro*

---

### 2.3.6 Sprint 4: Nextcloud Helm Chart Entwicklung

**Dauer:** 15. Juni - 20. Juni 2025 (Erledigt 22. Juni 2025)
**Zugehöriges Epic:** `EPIC-HELM`  
**Sprint Planning:** 14.06.2025 (simuliert)

Nach der erfolgreichen Validierung der Infrastruktur in Sprint 3 war es Zeit, den manuellen, fehleranfälligen
Deployment-Prozess zu industrialisieren. Dieser Sprint transformierte die validierten YAML-Manifeste in ein
standardisiertes, wiederverwendbares Helm Chart - den ersten Schritt zur vollständigen Automatisierung.

### 2.3.6.1 Sprint-Ziel

"Ein eigenständiges und funktionales Helm Chart für Nextcloud ist entwickelt, das die manuelle Bereitstellung
vollständig ersetzt. Das Chart ist über eine `values.yaml`-Datei konfigurierbar, löst das `localhost`-Redirect-Problem
durch eine dedizierte ConfigMap und enthält einen einfachen Helm-Test zur Überprüfung der Erreichbarkeit des
Deployments. Die Benutzerfreundlichkeit wird durch eine informative `NOTES.txt`-Datei nach der Installation
sichergestellt."

### 2.3.6.2 Sprint Backlog

| User Story     | Was wurde umgesetzt                                                                    | Interessante Erkenntnisse/Herausforderungen                                                               | Abgeschlossen |
|----------------|----------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|---------------|
| `Nextcloud#16` | Helm Chart Grundgerüst mit `helm create`, Chart.yaml Metadaten, saubere Template-Basis | Redundante Ressourcennamen (`nextcloud-nextcloud-chart`) durch suboptimale _helpers.tpl - schnell behoben | 22.06.2025    |
| `Nextcloud#40` | Validierte Manifeste aus Sprint 3 in parametrisierte Helm-Templates überführt          | Implizit durch #16 erledigt - Ticket-Überlappung im Sprint Planning übersehen                             | 22.06.2025    |
| `Nextcloud#17` | Secret & ConfigMap Templates, dynamische trusted_domains für localhost-Fix             | ConfigMap mit autoconfig.php löst kritisches Redirect-Problem elegant                                     | 22.06.2025    |
| `Nextcloud#19` | Helm-Test mit wget-basierter /status.php Connectivity-Prüfung                          | Test-Pod mit `helm.sh/hook: test` Annotation erfolgreich implementiert                                    | 22.06.2025    |
| `Nextcloud#18` | Dynamische NOTES.txt mit service-type-spezifischen Anweisungen                         | UX-Fokus: Benutzer bekommen sofort nächste Schritte nach Installation                                     | 22.06.2025    |
***Tabelle:** Sprint 4 - User Stories*

### 2.3.6.3 Erreichtes Inkrement

| Komponente                   | Deliverable                   | Wichtigste Features                                               | Nachweis                                       |
|------------------------------|-------------------------------|-------------------------------------------------------------------|------------------------------------------------|
| **Helm Chart Struktur**      | Vollständiges Chart-Package   | charts/nextcloud-chart/, Chart.yaml, values.yaml, _helpers.tpl    | `helm lint` & `helm template` erfolgreich      |
| **Template System**          | Parametrisierte K8s-Manifeste | Deployment, Service, PVC als konfigurierbare Templates            | `helm template . --set image.tag=28`           |
| **Configuration Management** | Secret & ConfigMap Automation | Optional Secret generation, autoconfig.php für trusted_domains    | LoadBalancer hostname dynamisch konfigurierbar |
| **User Experience**          | Post-Installation Guidance    | Service-type-spezifische NOTES.txt, Admin-Credential Anweisungen  | `helm install --dry-run` Demo                  |
| **Quality Assurance**        | Automatisierte Tests          | Helm-Test für /status.php Connectivity-Check                      | `helm test nextcloud` → `Succeeded`            |
| **Documentation**            | Chart-Dokumentation           | README Kapitel 4.2.x, values.yaml Kommentare, Sicherheitshinweise | Vollständige Nutzungsanleitung                 |
***Tabelle:** Sprint 4 - Inkremente*

### 2.3.6.4 Screenshots

![Helm Chart Structure](assets/sprint4-helm-structure.png)
***Bild:** Sprint 4 - Vollständige Helm Chart Verzeichnisstruktur mit Templates, Tests und Konfiguration*

![Helm Template Rendering](assets/sprint4-template-demo.png)
***Bild:** Sprint 4 - Live-Demo der parametrisierten Manifest-Generierung mit verschiedenen values.yaml Konfigurationen*

![NOTES.txt User Experience](assets/sprint4-notes-output.png)
***Bild:** Sprint 4 - Benutzerfreundliche Post-Installation Anweisungen je nach Service-Type Konfiguration*

![Helm Test Execution](assets/sprint4-test-success.png)
***Bild:** Sprint 4 - Erfolgreicher Helm-Test mit /status.php Connectivity-Prüfung im EKS-Cluster*

### 2.3.6.5 Impediments & Lösungen

> **Hauptimpediment:** Chicken-and-Egg-Problem mit LoadBalancer Hostname  
> **Auswirkung:** Chart muss installiert werden um Hostname zu erhalten, dann Upgrade für Konfiguration  
> **Ergebnis:** Zweistufiger Prozess als Standard etabliert, Automation für Sprint 5 geplant

**Lösungsschritte**

- 🔧 **Naming-Fix:** _helpers.tpl Template durch Standard-Helm-Logik ersetzt
- 📋 **Validationskreislauf:** `helm lint` → `helm template` → Fix als Best Practice etabliert
- 🎯 **UX-Optimierung:** NOTES.txt mit klaren upgrade-Anweisungen für Benutzer

### 2.3.6.6 Sprint Review

**Demo-Highlights:** Kompletter Helm Chart Lebenszyklus live demonstriert - von `helm install --dry-run` über
ConfigMap-Rendering bis hin zum erfolgreichen Test-Execution  
**Stakeholder-Feedback:** Massive Verbesserung gegenüber manuellen Manifesten, proaktive localhost-Lösung und
Test-Implementation als Qualitätszeichen gelobt  
**Sprint-Ziel Status:** ✅ Vollständig erreicht (5/5 User Stories abgeschlossen)  
**Nächste Schritte:** CI/CD-Pipeline in Sprint 5 kann auf robustes Chart aufbauen

### 2.3.6.7 Sprint Retrospektive

| 😊 Was lief gut                                  | 😕 Was lief schlecht                      | 💡 Lessons Learned                       | ⚡ Action Items                                 |
|--------------------------------------------------|-------------------------------------------|------------------------------------------|------------------------------------------------|
| Validationskreislauf extrem effizient            | Chicken-and-Egg LoadBalancer Problem      | Sprint 3 Blaupause zahlt sich aus        | Automatisierung des Upgrade-Schritts für CI/CD |
| UX-Fokus mit NOTES.txt und Kommentaren           | Ticket-Überlappung im Sprint Planning     | helm lint/template als Standard-Workflow | Wiederverwendung der Parameterlogik            |
| Blaupause aus Sprint 3 beschleunigte Entwicklung | Implizite Abhängigkeiten zwischen Tickets | User Experience ist kein Nice-to-Have    | Bessere Ticket-Granularität in Zukunft         |
| Sofortige Fehlererkennung verhinderte Tech Debt  | Zweistufiger Install-Prozess unvermeidbar | Helm Charts sind der Industriestandard   | CI/CD Pipeline für automatisches Upgrade       |
***Tabelle:** Sprint 4 - Retro*

---

### 2.3.7 Sprint 5: CI/CD Pipeline (GitHub Actions) & Tests

**Dauer:** 21. Juni - 03. Juli 2025 (Erledigt 02. Juli 2025)
**Zugehöriges Epic:** `EPIC-CICD`, `EPIC-ABSCHLUSS` (Testing)  
**Sprint Planning:** 20.06.2025 (simuliert)

Der Höhepunkt des Projekts: Nach vier Sprints der Infrastruktur- und Anwendungsentwicklung war es Zeit für die
ultimative Automatisierung. Dieser Sprint transformierte den manuellen Deployment-Prozess in eine vollautomatisierte,
sichere CI/CD-Pipeline - das letzte Puzzlestück für echte End-to-End-Automatisierung.

### 2.3.7.1 Sprint-Ziel

"Eine sichere und voll-automatisierte CI/CD-Pipeline ist etabliert. Sie wird bei einem Push auf den `main`-Branch
getriggert, authentifiziert sich sicher via OIDC bei AWS, installiert oder aktualisiert das Nextcloud Helm Chart im
EKS-Cluster, löst das 'Load Balancer Hostname'-Problem automatisiert und verifiziert das erfolgreiche Deployment durch
die Ausführung der Helm-Tests."

### 2.3.7.2 Sprint Backlog

| User Story     | Was wurde umgesetzt                                                                       | Interessante Erkenntnisse/Herausforderungen                                        | Abgeschlossen |
|----------------|-------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------|---------------|
| `Nextcloud#20` | IAM OIDC Provider & dedizierte Rolle für GitHub Actions, granulare Least-Privilege Policy | Dynamischer Cluster-Name führte zu robusterer Lösung via Terraform Remote State    | 02.07.2025    |
| `Nextcloud#21` | Vollständiger GitHub Actions Workflow, automatisches LoadBalancer-Hostname-Handling       | Chicken-and-Egg Problem elegant mit Warteschleife und automatischem Upgrade gelöst | 02.07.2025    |
| `Nextcloud#23` | Pipeline Status Badge im README mit Live-Status Anzeige                                   | Einfache aber effektive Transparenz-Verbesserung für Stakeholder                   | 02.07.2025    |
| **De-Scoped**  | Terraform Plan/Apply in CI/CD bewusst ausgeschlossen                                      | Fokus auf Application Deployment - Infrastruktur-Automation bleibt im Backlog      | -             |
***Tabelle:** Sprint 5 - User Stories*

### 2.3.7.3 Erreichtes Inkrement

| Komponente                  | Deliverable                            | Wichtigste Features                                                                    | Nachweis                       |
|-----------------------------|----------------------------------------|----------------------------------------------------------------------------------------|--------------------------------|
| **OIDC Authentication**     | Sichere GitHub-zu-AWS Integration      | IAM OIDC Provider, Repository-spezifische Trust Policy, Least-Privilege Berechtigungen | Test-Workflow erfolgreich      |
| **CI/CD Pipeline**          | Vollautomatisierte Deployment-Pipeline | Push-triggered, `helm upgrade --install`, automatische Tests, LoadBalancer-Handling    | `.github/workflows/deploy.yml` |
| **LoadBalancer Automation** | Dynamische Hostname-Konfiguration      | Warteschleife + automatisches `helm upgrade` mit korrektem `nextcloud.host`            | Workflow-Logs                  |
| **Quality Gates**           | Integrierte Test-Automation            | `helm lint` + `helm test` als Pipeline-Schritte, Failure-on-Error                      | Pipeline-Status                |
| **Transparency**            | Live Pipeline Status                   | GitHub Actions Badge mit "passing" Status im README                                    | Repository Hauptseite          |
| **Security**                | Passwortlose AWS-Integration           | OIDC statt langlebige Keys, GitHub Secrets für sensitive Daten                         | IAM Role Trust Policy          |
***Tabelle:** Sprint 5 - Inkremente*

### 2.3.7.4 Screenshots

![OIDC Configuration](assets/sprint5-oidc-setup.png)
***Bild:** Sprint 5 - IAM OIDC Provider und GitHub Actions Rolle mit granularen Berechtigungen*

![CI/CD Pipeline Execution](assets/sprint5-pipeline-running.png)
***Bild:** Sprint 5 - Live GitHub Actions Workflow mit automatischem Deployment und Test-Ausführung*

![LoadBalancer Automation](assets/sprint5-hostname-handling.png)
***Bild:** Sprint 5 - Automatische LoadBalancer-Hostname-Abfrage und dynamisches Helm-Upgrade*

![Pipeline Status Badge](assets/sprint5-status-badge.png)
***Bild:** Sprint 5 - Grünes "passing" Status-Badge auf der Repository-Hauptseite*

### 2.3.7.5 Impediments & Lösungen

> **Hauptimpediment:** Dynamischer vs. statischer Cluster-Name für CI/CD  
> **Auswirkung:** Pipeline muss flexibel auf verschiedene Cluster-Namen reagieren können  
> **Ergebnis:** Robustere Lösung durch Terraform Remote State Abfrage implementiert

**Lösungsschritte**

- 🔍 **Annahme hinterfragt:** Statischer Cluster-Name als Betriebseinschränkung erkannt
- 📋 **Robuste Lösung:** Remote State Parsing für dynamische Cluster-Namen
- 🎯 **Iterative Verbesserung:** Plan angepasst ohne Ziel aus Augen zu verlieren

### 2.3.7.6 Sprint Review

**Demo-Highlights:** 🎯 **PROJEKT-HÖHEPUNKT:** Vollständige End-to-End-Automation live demonstriert - Code-Push →
automatisches Deployment → erfolgreiches Testing → grünes Status-Badge  
**Stakeholder-Feedback:** Beeindruckt von nahtloser Automatisierung, elegante LoadBalancer-Lösung als besonders
professionell hervorgehoben  
**Sprint-Ziel Status:** ✅ Vollständig erreicht (3/3 User Stories abgeschlossen)  
**Nächste Schritte:** Sprint 6 fokussiert auf Dokumentations-Finalisierung

### 2.3.7.7 Sprint Retrospektive

| 😊 Was lief gut                                  | 😕 Was lief schlecht                         | 💡 Lessons Learned                                | ⚡ Action Items                         |
|--------------------------------------------------|----------------------------------------------|---------------------------------------------------|----------------------------------------|
| Iterative Problemlösung bei dynamischen Clustern | Annahmen zu spät hinterfragen                | Solide Basis aus Sprints 1-4 war entscheidend     | Fokus auf saubere Dokumentation        |
| OIDC-First Sicherheitsansatz ausgezahlt          | Workflow-Komplexität durch Shell-Skripte     | Adaptivität wichtiger als starrer Plan            | Installations-Anleitung für Experten   |
| Auf vorheriger Arbeit erfolgreich aufgebaut      | Betriebskosten-Anforderungen zu spät bedacht | End-to-End Tests sind unverzichtbar               | README finale Überprüfung              |
| Komplettes Projektziel erreicht                  | LoadBalancer-Skript relativ komplex          | Non-funktionale Requirements früh berücksichtigen | GitHub-Secrets Konfigurationsanleitung |
***Tabelle:** Sprint 5 - Retro*

---

### 2.3.8 Sprint 6: Finalisierung & Vollständiges Lifecycle-Management

**Dauer:** 04. Juli - 09. Juli 2025 (Erledigt 02. Juli 2025)
**Zugehöriges Epic:** `EPIC-ABSCHLUSS`, `EPIC-CICD`  
**Sprint Planning:** 03.07.2025 (simuliert)

Der ambitionierteste Sprint des Projekts: Über die reine CI/CD-Pipeline hinaus sollte der komplette
Infrastruktur-Lebenszyklus automatisiert werden. Das Ziel war ein "One-Click"-Ansatz für die gesamte Umgebung - von der
Erstellung bis zur sicheren Zerstörung aller AWS-Ressourcen.

### 2.3.8.1 Sprint-Ziel

"Das Projekt wird mit der Implementierung von zwei neuen, manuell triggerbaren GitHub Actions Workflows abgeschlossen:
Ein 'Full Setup'-Workflow, der die gesamte AWS-Infrastruktur mit Terraform provisioniert und anschliessend die
Nextcloud-Anwendung deployt, sowie ein 'Full Teardown'-Workflow, der die Anwendung sauber deinstalliert und danach die
gesamte Infrastruktur wieder zerstört. Die finale Projektdokumentation, inklusive der neuen Workflows, der
Systemarchitektur und einer umfassenden Reflexion, wird fertiggestellt."

### 2.3.8.2 Sprint Backlog

| User Story     | Was wurde umgesetzt                                                                        | Interessante Erkenntnisse/Herausforderungen                                           | Abgeschlossen |
|----------------|--------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|---------------|
| `Nextcloud#41` | **NEU:** Full Setup Workflow mit terraform apply + deploy, wiederverwendbarer App-Workflow | IAM-Policy für terraform destroy-Berechtigungen musste erweitert werden               | 02.07.2025    |
| `Nextcloud#42` | **NEU:** Full Teardown Workflow mit helm uninstall + terraform destroy                     | Fehlertoleranzen für bereits entfernte Releases, sleep für saubere AWS-Abhängigkeiten | 02.07.2025    |
| `Nextcloud#28` | Umfassende Installations-Anleitung mit Fokus auf neuen Lifecycle-Workflows                 | One-Click Setup als benutzerfreundlichster Ansatz dokumentiert                        | 02.07.2025    |
| `Nextcloud#26` | Mermaid-basierte Architekturdiagramme direkt in README eingebettet                         | End-to-End und AWS-Netzwerk-Diagramme für vollständige Transparenz                    | 02.07.2025    |
| `Nextcloud#31` | Terraform fmt, umfassende Code-Kommentierung, Workflow-Dokumentation                       | Obsoletes /kubernetes-manifests Verzeichnis entfernt - technische Schulden abgebaut   | 02.07.2025    |
| `Nextcloud#32` | Vollständiges Reflexionskapitel mit Theorie-Praxis-Abgleich                                | Kritische Bewertung der Lösung und konkrete Weiterentwicklungsempfehlungen            | 02.07.2025    |
***Tabelle:** Sprint 6 - User Stories*

### 2.3.8.3 Erreichtes Inkrement

| Komponente                     | Deliverable                            | Wichtigste Features                                                  | Nachweis                          |
|--------------------------------|----------------------------------------|----------------------------------------------------------------------|-----------------------------------|
| **Lifecycle Automation**       | One-Click Setup/Teardown               | Manual trigger via GitHub UI, terraform + helm Orchestrierung        | `.github/workflows/lifecycle.yml` |
| **Workflow Architecture**      | Wiederverwendbare Pipeline-Komponenten | Refactored deploy workflow, keine Code-Duplizierung                  | `reusable-deploy-app.yml`         |
| **Infrastructure Management**  | Vollständige AWS-Kontrolle             | Auto-approve terraform apply/destroy, dynamische Ressourcen-Übergabe | IAM Policy erweitert              |
| **Documentation Suite**        | Produktionsreife Anleitung             | Schritt-für-Schritt Setup, GitHub Secrets Konfiguration              | README Kapitel 4.4                |
| **Architecture Visualization** | Eingebettete Diagramme                 | Mermaid End-to-End + AWS Network Diagramme                           | README Kapitel 3.3.x              |
| **Project Reflection**         | Comprehensive Analysis                 | Theorie-Praxis-Abgleich, Stärken/Schwächen, Weiterentwicklung        | README Kapitel 7                  |
***Tabelle:** Sprint 6 - Inkremente*

### 2.3.8.4 Screenshots

![Lifecycle Workflow UI](assets/sprint6-lifecycle-trigger.png)
***Bild:** Sprint 6 - GitHub Actions Manual Trigger mit Setup/Destroy Choice-Parameter*

![Full Setup Execution](assets/sprint6-setup-workflow.png)
***Bild:** Sprint 6 - Komplette Umgebungs-Provisionierung: Terraform Apply → App Deployment*

![Full Teardown Process](assets/sprint6-teardown-workflow.png)
***Bild:** Sprint 6 - Saubere Umgebungs-Zerstörung: Helm Uninstall → Terraform Destroy*

![Architecture Diagrams](assets/sprint6-mermaid-diagrams.png)
***Bild:** Sprint 6 - Eingebettete Mermaid-Diagramme für End-to-End und AWS-Netzwerk-Architektur*

### 2.3.8.5 Impediments & Lösungen

> **Hauptimpediment:** IAM-Policy zu restriktiv für terraform destroy  
> **Auswirkung:** Terraform konnte erstellte Ressourcen nicht wieder löschen  
> **Ergebnis:** Erweiterte aber projektspezifische Berechtigungen für vollständigen Lifecycle

**Lösungsschritte**

- 🔐 **Policy erweitert:** `ec2:*`, `rds:*`, etc. für terraform destroy-Operationen
- 🧹 **Clean Teardown:** Sleep-Befehle für saubere AWS-Abhängigkeitsauflösung
- 🛡️ **Fehlertoleranz:** Workflow schlägt nicht bei bereits entfernten Releases fehl

### 2.3.8.6 Sprint Review

**Demo-Highlights:** 🚀 **TECHNISCHER ABSCHLUSS:** One-Click Setup/Teardown live demonstriert - komplette AWS-Umgebung
auf Knopfdruck erstellt und wieder entfernt  
**Stakeholder-Feedback:** Alle technischen Anforderungen erfüllt, aber grosse Architektur-Änderungen erfordern finale
Validierung vor Abgabe  
**Sprint-Ziel Status:** ✅ Vollständig erreicht (6/6 User Stories abgeschlossen)  
**Nächste Schritte:** 📋 **ENTSCHEIDUNG:** Zusätzlicher Hardening-Sprint für umfassende End-to-End-Tests

### 2.3.8.7 Sprint Retrospektive

| 😊 Was lief gut                         | 😕 Was lief schlecht                            | 💡 Lessons Learned                               | ⚡ Action Items                                    |
|-----------------------------------------|-------------------------------------------------|--------------------------------------------------|---------------------------------------------------|
| One-Click Vision vollständig umgesetzt  | Grosse Architektur-Änderungen in letztem Sprint | Lifecycle-Management ist der ultimative IaC-Test | Vollständiger Regressionstest erforderlich        |
| Wiederverwendbare Workflow-Architektur  | Push-to-Main Tests reichen nicht mehr aus       | Refactoring verhindert Code-Duplizierung         | Finale Präsentationsunterlagen erstellen          |
| Umfassende Dokumentation fertiggestellt | IAM-Berechtigungen unterschätzt                 | Technische Schulden konsequent abgebaut          | Feature-complete Produkt stabilisieren            |
| Reflexion mit Theorie-Praxis-Abgleich   | Validierungsaufwand nach grossen Änderungen     | Documentation-First zahlt sich aus               | End-to-End Vertrauen durch Tests wiederherstellen |
***Tabelle:** Sprint 6 - Retro*

---

### 2.4 Risikomanagement

Zur systematischen Bewertung und Priorisierung der Projektrisiken wird eine visuelle Risikomatrix verwendet. Sie ordnet die Risiken nach ihrer Eintrittswahrscheinlichkeit und ihrer potenziellen Auswirkung ein.

|                    |                                | **Auswirkung (A)**                                           |                                      |
| ------------------ | ------------------------------ | ------------------------------------------------------------ | ------------------------------------ |
|                    |                                | **1** (Gering)                                               | **2** (Moderat)                      | **3** (Schwerwiegend)                |
| **Wahrscheinlichkeit (W)** | **3** (Hoch)                   |                                                              | <center>R4</center>                  | <center>R1, R2</center>              |
|                    | **2** (Mittel)                 |                                                              | <center>R3</center>                  | <center>R5</center>                  |
|                    | **1** (Niedrig)                |                                                              | <center>R6</center>                  |                                      |
***Tabelle:** Risikomatrix*

Das nachfolgende Risikoregister dokumentiert die Details zu jedem identifizierten Risiko:

| ID     | Risiko                                       | W (1-3) | A (1-3) | RW  | Risiko-Level | Gegenmassnahmen                                                     | Status        |
| :----- | :------------------------------------------- | :------ | :------ | :-- | :----------- | :------------------------------------------------------------------ |:--------------|
| **R1** | Technische Komplexität der Integration       | 3       | 3       | 9   | **Hoch**     | Iteratives Vorgehen, Fokus auf Kernfunktionalität, Managed Services | Offen         |
| **R2** | Zeitlicher Aufwand für 50h sehr ambitioniert | 3       | 3       | 9   | **Hoch**     | Striktes Scope-Management, realistische Aufwandsschätzung           | Offen         |
| **R4** | Debugging-Aufwand (Terraform, Helm, CI/CD)   | 3       | 2       | 6   | **Hoch**     | Inkrementelles Testen, systematisches Logging                       | Offen          |
| **R5** | Komplexität des Secrets Managements          | 2       | 3       | 6   | **Hoch**     | GitHub Actions OIDC, Kubernetes Secrets, Least Privilege            | Offen         |
| **R3** | Cloud-Kosten (AWS Managed Services)          | 2       | 2       | 4   | **Mittel**   | **AWS Budget mit $10 Limit + E-Mail-Alerts**, kleinste Instanzen    | **Mitigiert** |
| **R6** | Tool-Versionskonflikte                       | 1       | 2       | 2   | **Niedrig**  | Dokumentierte Versionsanforderungen, Version Manager                | Mitigiert     |
***Tabelle:** Risikoregister*

*Risiken werden kontinuierlich überwacht und bei Bedarf aktualisiert.*

## 2.5 Stakeholder & Kommunikation

### Projekt-Team

| Rolle                         | Person               | Verantwortlichkeiten                                  |
|-------------------------------|----------------------|-------------------------------------------------------|
| **Projektdurchführung**       | Nenad Stevic         | Technische Umsetzung, Dokumentation, Termineinhaltung |
| **Experte Projektmanagement** | Corrado Parisi (TBZ) | Methodische Begleitung, Projektstruktur-Feedback      |
| **Experte Fachbereich (IaC)** | Armin Dörzbach (TBZ) | Technische Beratung, Code-Review, fachliche Bewertung |
***Tabelle:** Projekt-Team*

### Kommunikationsplan

**Primärer Kanal:** MS Teams (dedizierter Projekt-Channel)

**Regelmässige Termine:**

- Einzelbesprechungen gemäss TBZ-Ablaufplan für formelles Feedback
- Proaktive Kontaktaufnahme bei technischen Hindernissen oder Scope-Änderungen

**Transparenz:** Aktueller Projektstand jederzeit über GitHub Repository einsehbar

Wichtige Entscheidungen oder Scope-Änderungen werden mit beiden Experten abgestimmt und dokumentiert.

### 2.6 SWOT-Analyse

Bevor die erste Zeile Code geschrieben wird, lohnt sich ein strategischer Blick nach vorn. Diese SWOT-Analyse dient als Landkarte für das, was ich erwarte: Wo liegen die Stärken meines Plans, wo die absehbaren Hürden und welche Chancen und Risiken bringt das Umfeld mit sich?

|                          | **Mein grösster Vorteil**                                                                                                                                                            | **Der erwartete Knackpunkt**                                                                                                                                                               |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Was ich kontrolliere** | **Stärke: Einsatz von modernen Industriestandards** <br> Mein Plan, auf top-aktuelle Tools wie Terraform, Kubernetes (EKS) und Helm zu setzen, ist die grösste Stärke. Das sichert nicht nur ein robustes Ergebnis, sondern auch maximale Relevanz. | **Schwäche: Technische Komplexität als Einzelkämpfer** <br> Die grösste Herausforderung wird die Komplexität sein. All diese mächtigen Tools fehlerfrei zu integrieren, ist als Einzelperson ohne direktes Team-Feedback eine enorme Aufgabe. |
| **Was von aussen kommt** | **Chance: Hohe Relevanz für die Praxis** <br> Der Hauptgrund für dieses Projekt ist die hohe Nachfrage nach DevOps- und Cloud-Fähigkeiten. Ein erfolgreicher Abschluss ist nicht nur ein Schulprojekt, sondern ein wertvoller, praktischer Fähigkeitsnachweis. | **Gefahr: Unkontrollierbare Cloud-Kosten** <br> Das grösste externe Risiko sind definitiv die potenziellen AWS-Kosten. Ein Konfigurationsfehler oder ein unerwarteter Ressourcenverbrauch könnte teuer werden. Daher plane ich von Anfang an, Budget-Alerts einzurichten. |
***Tabelle:** SWOT-Analyse*

Diese Analyse zeigt, dass das Projekt auf einem starken technologischen Fundament steht, die grössten Herausforderungen
aber in der Komplexitätsbeherrschung und der Prozessdisziplin eines Einzelprojekts liegen.


---

## 3. Evaluation

*In diesem Kapitel begründe ich meine Technologie-Wahl und erkläre die theoretischen Konzepte dahinter.*

## 3.1 Evaluation von Lösungen

Die Technologie-Auswahl erfolgte systematisch basierend auf Projektanforderungen und Industriestandards. Ziel war eine
moderne, wartbare Cloud-native Lösung.

> **[DIAGRAM PLACEHOLDER: Projekt-Architektur Overview]**  
> *Zeigt: AWS Cloud → EKS Cluster → Nextcloud Application mit CI/CD Pipeline*

### 3.1.1 Cloud Provider Evaluation

| Kriterium                     | AWS                    | Azure              | Entscheidung | Begründung                                                                                                     |
|-------------------------------|------------------------|--------------------|--------------|----------------------------------------------------------------------------------------------------------------|
| **Managed K8s Service**       | EKS (sehr ausgereift)  | AKS (vergleichbar) | ✅ **AWS**    | EKS bietet tiefere AWS-Integration (IAM, VPC, ALB). Aus privaten Projekten bereits bewährte Stabilität bekannt |
| **Managed Database**          | RDS (umfangreich)      | Azure Database     | ✅ **AWS**    | RDS PostgreSQL mit automatischen Backups, Read Replicas und Performance Insights. Nahtlose EKS-Integration     |
| **Vorhandene Kenntnisse**     | Ja                     | Begrenzt           | ✅ **AWS**    | Mehrjährige Erfahrung aus privaten Projekten mit EC2, S3, RDS. Reduziert Lernkurve erheblich                   |
| **DSGVO-Compliance**          | eu-central-1 verfügbar | Ja                 | ✅ **Beide**  | Frankfurt-Region erfüllt Schweizer Datenschutz-Anforderungen, AWS bietet transparente Compliance-Dokumentation |
| **Community & Dokumentation** | Sehr umfangreich       | Gut                | ✅ **AWS**    | Grösste DevOps-Community, umfangreiche Terraform-Provider-Dokumentation, bewährte Best Practices verfügbar     |

***Tabelle:** Cloud-Provider Vergleich*

**Gewählte Region:** `eu-central-1` (Frankfurt) - geringe Latenz zur Schweiz, DSGVO-konform

> **[SCREENSHOT PLACEHOLDER: AWS Console - EKS Cluster Overview]**

### 3.1.2 Container Orchestrierung

**Warum Kubernetes + EKS?**

**Vorteile von Managed EKS vs. Self-hosted:**

- **Reduzierter Management-Overhead:** AWS übernimmt Control Plane (API-Server, etcd)
- **Nahtlose AWS-Integration:** IAM, VPC, Load Balancer, CloudWatch
- **Fokus auf Anwendung:** Mehr Zeit für Pipeline-Entwicklung statt Cluster-Administration

**CKA-Kenntnisse nutzen:** Bestehende Kubernetes-Zertifizierung optimal einsetzen

> **[DIAGRAM PLACEHOLDER: EKS Architecture]**  
> *Zeigt: AWS Control Plane + Worker Nodes + VPC Integration*

**Alternative betrachtet:** Manuelles Setup (kubeadm)

- ❌ Zeitaufwand für HA, Backup, Upgrades zu hoch für 50h-Projekt

### 3.1.3 Infrastructure as Code

Manuelle Infrastruktur-Provisionierung über die AWS Console ist fehleranfällig, nicht reproduzierbar und schlecht
dokumentierbar. Für ein professionelles DevOps-Projekt war ein Infrastructure-as-Code-Ansatz unerlässlich.

| Tool               | Lesbarkeit              | Cloud-Support | Lernaufwand | Entscheidung  |
|--------------------|-------------------------|---------------|-------------|---------------|
| **Terraform**      | HCL-Syntax (sehr gut)   | Multi-Cloud   | Moderat     | ✅ **Gewählt** |
| **CloudFormation** | JSON/YAML (umständlich) | AWS-only      | Niedrig     | ❌             |
***Tabelle:** IAC-Tool Vergleich*

**Warum Terraform überzeugte:** Die HashiCorp Configuration Language (HCL) ist deutlich lesbarer als CloudFormation's
JSON-Syntax. Während `"${aws_vpc.main.id}"` in CloudFormation zu `{"Ref": "MainVPC"}` wird, bleibt Terraform-Code
intuitiv verständlich.

**Das Killer-Feature: State Management.** Terraform verwaltet den aktuellen Zustand der Infrastruktur in einer
State-Datei, die für dieses Projekt in einem S3-Bucket mit DynamoDB-Locking ausgelagert wurde. Dies ermöglicht Drift
Detection - Terraform erkennt manuelle Änderungen an der Infrastruktur und kann diese reparieren oder dokumentieren.
CloudFormation bietet zwar ähnliche Funktionen, aber Terraform's State-Konzept ist ausgereifter und transparenter.

**Zusätzlicher Vorteil:** Die erlernten Terraform-Konzepte sind direkt auf andere Cloud-Provider übertragbar, was den
Kompetenzerwerb nachhaltiger macht als AWS-spezifisches CloudFormation-Wissen.

> **[SCREENSHOT PLACEHOLDER: Terraform Plan Output]**  
> *Zeigt: `terraform plan` mit geplanten Ressourcen-Änderungen*

### 3.1.4 Application Configuration Management

Kubernetes-YAML-Dateien sind statisch und schwer wiederverwendbar. Nextcloud benötigt verschiedene Konfigurationen für
Development und Production, unterschiedliche Hostnamen und Image-Versionen. Copy-Paste von YAML-Dateien führt schnell zu
Inkonsistenzen und Wartungsproblemen.

Darum: Helm behandelt Kubernetes-Manifeste als Templates und ermöglicht die Parametrisierung über eine zentrale
`values.yaml`. Dadurch wird `{{ .Values.image.tag }}` zur Laufzeit durch die gewünschte Version ersetzt, und
`{{ .Values.nextcloud.host }}` bestimmt den Hostnamen dynamisch.

| Merkmal                  | Helm                     | Kustomize     | Begründung                                   |
|--------------------------|--------------------------|---------------|----------------------------------------------|
| **Templating**           | Go-Templates (flexibel)  | Patch-basiert | Helm ermöglicht komplexe Logik und Schleifen |
| **Lifecycle**            | Install/Upgrade/Rollback | Nur Apply     | Helm verwaltet Release-Historie komplett     |
| **Wiederverwendbarkeit** | Charts + Values          | Overlays      | Charts sind echte Pakete, nicht nur Patches  |
***Tabelle:** Cluster-Config-Tool Vergleich*

**Bewusst eigenes Chart entwickelt:** Anstatt ein vorgefertigtes Nextcloud-Chart zu verwenden, wurde ein
projektspezifisches Chart erstellt. Dies ermöglichte massgeschneiderte Lösungen wie die `trusted_domains` ConfigMap, die
das bekannte Nextcloud-Problem mit dynamischen Hostnamen elegant löst. Zudem lerne ich was :)

> **[CODE SNIPPET PLACEHOLDER: values.yaml Struktur]**  
> *Zeigt: Konfigurable Parameter für Nextcloud Deployment*

### 3.1.5 CI/CD Pipeline

Das Auswahlkriterium war klar: Maximale Integration bei minimalem Wartungsaufwand. Da der Code bereits auf GitHub liegt,
war die Pipeline-Wahl hauptsächlich eine Frage der Effizienz.

| Kriterium             | GitHub Actions  | Jenkins       | GitLab CI      | Gewichtung      |
|-----------------------|-----------------|---------------|----------------|-----------------|
| **Setup-Aufwand**     | Keine (in Repo) | Hoch (Server) | Mittel         | 🔴 Kritisch     |
| **Authentifizierung** | OIDC native     | Manual        | OIDC verfügbar | 🔴 Kritisch     |
| **Wartung**           | Serverless      | Hoch          | Mittel         | 🟡 Wichtig      |
| **Flexibilität**      | Gut             | Sehr hoch     | Hoch           | 🟢 Nice-to-have |
***Tabelle:** CI/CD Tool Vergleich*

**Der Game-Changer: OIDC-Authentifizierung.** GitHub Actions bietet native OpenID Connect-Integration mit AWS. Das
bedeutet: keine langlebigen Access Keys, keine Secrets in der Pipeline, sondern temporäre Token, die nur für die Dauer
des Deployments gültig sind. Das ist nicht nur sicherer, sondern auch wartungsfreier.

**Wiederverwendbare Workflows** eliminierten Code-Duplizierung. Der `reusable-deploy-app.yml` Workflow wird sowohl vom
automatischen `main-push` als auch vom manuellen `lifecycle` Workflow aufgerufen - einmal schreiben, mehrfach nutzen.

> **[DIAGRAM PLACEHOLDER: CI/CD Pipeline Flow]**  
> *Zeigt: Git Push → GitHub Actions → AWS EKS Deployment*

### 3.1.6 Tool-Versioning & Reproduzierbarkeit

Ein Kubernetes-Projekt, das heute funktioniert, kann morgen fehlschlagen - z.B. wegen inkompatiblen Versionen der Tools.
Die `kubectl`-Version muss zur EKS-API-Version passen, Terraform-Provider entwickeln sich schnell weiter, und
Helm-Charts haben eigene Kompatibilitätsmatrix.

**Die Lösung: Explizite Versionsfixierung auf allen Ebenen.**

| Tool        | Fixierte Version | Kritischer Punkt                |
|-------------|------------------|---------------------------------|
| `kubectl`   | `v1.28.x`        | API-Kompatibilität mit EKS 1.28 |
| `terraform` | `~> 1.5.0`       | AWS Provider Breaking Changes   |
| `helm`      | `v3.12.x`        | Chart API Stabilität            |
***Tabelle:** Versionen*

**Implementierung erfolgte zweistufig:** In `terraform/versions.tf` werden die Terraform- und AWS-Provider-Versionen
definiert, während die Client-Tools in der Projekt-Dokumentation spezifiziert sind. Das AWS-Provider-Constraint `~> 5.0`
erlaubt Patch-Updates (5.0.1, 5.0.2), verhindert aber Major-Updates (6.0), die Breaking Changes einführen könnten.

> **[SCREENSHOT PLACEHOLDER: versions.tf File]**  
> *Zeigt: Terraform Provider Version Constraints*

## 3.2 Theoretische Grundlagen

Die implementierte Lösung basiert auf bewährten Konzepten der modernen Cloud-Entwicklung.

### 3.2.1 Infrastructure as Code - Der Paradigmenwechsel

Infrastructure as Code revolutioniert die Art, wie wir über Infrastruktur denken. Früher wurden Server "gepflegt" und "
repariert" - heute werden sie "kompiliert" und "deployed". Der entscheidende Unterschied liegt im deklarativen Ansatz:
Anstatt Terraform zu sagen "erstelle eine VPC, dann ein Subnetz, dann ein Gateway", beschreiben wir den gewünschten
Endzustand.

Terraform wird zum Übersetzer zwischen unserem Wunsch und der Realität. Das Herzstück ist die `.tfstate`-Datei -
Terraforms Gedächtnis, das kontinuierlich "Was haben wir?" mit "Was wollen wir?" vergleicht und präzise Ausführungspläne
für die Differenz erstellt.

Versionierung verwandelt Infrastruktur in Software. Plötzlich werden Feature-Branches, Pull-Requests und Code-Reviews
nicht nur für Anwendungscode, sondern auch für Netzwerke und Datenbanken möglich.

> **[DIAGRAM PLACEHOLDER: IaC Workflow - Declare → Plan → Apply → State Cycle]**

### 3.2.2 CI/CD Pipeline - Code trifft Automation

**Der Automatisierungsflow:**

```yaml
# GitHub Actions: main-push-deploy.yml
name: Deploy to EKS
on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Lint Helm Chart
        run: helm lint charts/nextcloud-chart/

      - name: Deploy to EKS
        run: helm upgrade --install nextcloud ./charts/nextcloud-chart

      - name: Test Deployment
        run: helm test nextcloud
```
***Code:** GH Actions Workflow - Deploy*

**Environment-as-a-Service in Aktion:**

```yaml
# lifecycle.yml - Komplette Umgebung on-demand
- name: Terraform Apply
  run: terraform apply -auto-approve

- name: Deploy Application
  run: helm install nextcloud ./charts/nextcloud-chart

- name: Destroy Everything
  if: github.event.inputs.action == 'destroy'
  run: |
    helm uninstall nextcloud
    terraform destroy -auto-approve
```
***Code:** GH Actions Workflow - Provision Infrastructure*


Jeder `git push` auf `main` löst eine Kaskade aus: Validierung → Deployment → Testing → Live System. Kein manueller
Eingriff nötig.

> **[SCREENSHOT PLACEHOLDER: GitHub Actions Workflow Run]**

### 3.2.3 Kubernetes - Das Nextcloud Ökosystem

Kubernetes ist komplex, aber für Nextcloud benötigen wir nur einige Schlüsselkomponenten:

| Komponente     | Problem gelöst           | Nextcloud-spezifisch                      |
|----------------|--------------------------|-------------------------------------------|
| **Deployment** | Pod-Verfügbarkeit        | Startet Nextcloud-Container neu bei Crash |
| **Service**    | Stabile Netzwerk-Adresse | LoadBalancer für Internet-Zugang          |
| **PVC**        | Persistente Daten        | User-Uploads überleben Pod-Restarts       |
| **ConfigMap**  | Dynamische Konfiguration | `trusted_domains` für Load Balancer URLs  |
| **Secret**     | Sichere Credentials      | Datenbank-Passwörter base64-kodiert       |
***Tabelle:** Kubernetes Komponente für Nextcloud*

**Das trusted_domains Problem:**

Nextcloud verweigert standardmässig Zugriffe über unbekannte Hostnamen. In Kubernetes ändert sich aber der Hostname je
nach Service-Konfiguration.

**Lösung:** ConfigMap injiziert die korrekten Domains zur Laufzeit.

### 3.2.4 Helm - Templates werden zu Realität

**Ein Chart, viele Möglichkeiten:**

```yaml
# templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
spec:
  replicas: { { .Values.replicaCount } }
  template:
    spec:
      containers:
        - name: nextcloud
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          env:
            - name: POSTGRES_HOST
              value: { { .Values.database.host } }
```
***Code:** Helm Chart - Deployment*

**Development vs Production:**

```yaml
# values-dev.yaml
replicaCount: 1
image:
  tag: "27-apache"
database:
  host: "localhost"

# values-prod.yaml  
replicaCount: 3
image:
  tag: "27-apache"
database:
  host: "nextcloud-db.xyz.eu-central-1.rds.amazonaws.com"
```
***Code:** Helm Chart - Deployment*

**Deployment-Kommandos:**

```bash
# Development Environment
helm install nextcloud-dev ./charts/nextcloud-chart -f values-dev.yaml

# Production Environment
helm install nextcloud-prod ./charts/nextcloud-chart -f values-prod.yaml

# Update mit neuen Werten
helm upgrade nextcloud-prod ./charts/nextcloud-chart --set image.tag=28-apache
```
***Code:** Command Line - Configure Kubernetes*

**Release-Management:**

```bash
$ helm list
NAME             NAMESPACE  REVISION  STATUS    CHART               
nextcloud-dev    default    1         deployed  nextcloud-chart-0.1.0
nextcloud-prod   default    3         deployed  nextcloud-chart-0.1.0

$ helm rollback nextcloud-prod 2  # Zurück zur vorherigen Version
```

### 3.2.5 Stateful Architecture - Persistenz in der Container-Welt

**Die zentrale Herausforderung:** Kubernetes ist für stateless Apps optimiert, Nextcloud ist stateful.

Nextcloud benötigt drei Arten von persistentem Zustand, die jeweils unterschiedlich gelöst werden:

**Dateisystem-Persistierung:** User-Uploads müssen Pod-Neustarts überleben. Ohne PersistentVolumeClaim würden alle
Benutzerdateien beim nächsten Deployment verschwinden. Das AWS EBS Volume wird ausserhalb des Containers gemounted und
übersteht alle Pod-Lebenszyklen.

**Datenbank-Persistierung:** Metadaten wie Benutzer, Freigaben und Dateiversionen sind weniger sichtbar, aber genauso
kritisch. Die Entscheidung für AWS RDS anstatt einer In-Cluster-Datenbank trennt die Lebenszyklen von Anwendung und
Daten - AWS übernimmt Backup, Patching und Failover.

**Konfigurations-Persistierung:** Die `trusted_domains` ConfigMap löst ein subtiles Problem. Nextcloud verweigert
standardmässig Zugriffe über unbekannte Hostnamen, aber in Kubernetes ändert sich der Hostname je nach
Service-Konfiguration.

| Zustand            | Storage-Lösung | Lifecycle          | Backup-Strategie      |
|--------------------|----------------|--------------------|-----------------------|
| **User-Dateien**   | AWS EBS (PVC)  | Cluster-unabhängig | EBS Snapshots         |
| **App-Metadaten**  | AWS RDS        | Cluster-unabhängig | RDS Automated Backups |
| **Runtime-Config** | ConfigMap      | Cluster-abhängig   | Git-Repository        |

> **[DIAGRAM PLACEHOLDER: Stateful Architecture - Pod + EBS + RDS Separation]**

Diese Architektur folgt dem Prinzip der Separation of Concerns: Jede Komponente hat eine klare Verantwortlichkeit, und
die persistenten Elemente sind vom Kubernetes-Cluster-Lebenszyklus entkoppelt. Das Ergebnis ist eine robuste Anwendung,
die sowohl die Flexibilität von Kubernetes als auch die Zuverlässigkeit von Managed Services nutzt.

## 3.3 System-Design / Architektur

Eine robuste Architektur ist das Fundament für eine erfolgreiche technische Lösung. Dieses Kapitel beschreibt das
Gesamtsystem und seine Komponenten auf konzeptioneller Ebene.

### 3.3.1 Logische Gesamtarchitektur

Der End-to-End-Prozess von der Code-Änderung bis zum Endbenutzer-Zugriff folgt einem klaren, automatisierten Workflow:

> **[DIAGRAM PLACEHOLDER: Logische Gesamtarchitektur]**  
> *Zeigt: Developer → Git → GitHub Actions → AWS → EKS → User*

**Der Deployment-Flow in 7 Schritten:**

| Schritt | Akteur         | Aktion                                       | Trigger              |
|---------|----------------|----------------------------------------------|----------------------|
| **1**   | Developer      | Code-Änderungen committen & pushen           | Manuell              |
| **2**   | GitHub Actions | Pipeline automatisch auslösen                | Git Push             |
| **3**   | CI/CD Pipeline | OIDC-Authentifizierung bei AWS IAM           | Workflow Start       |
| **4**   | Terraform      | Infrastruktur provisionieren (VPC, EKS, RDS) | `lifecycle` Workflow |
| **5**   | Helm           | Nextcloud-Anwendung deployen                 | Jeder Push           |
| **6**   | EKS Cluster    | Nextcloud Image von Docker Hub pullen        | Pod-Start            |
| **7**   | Load Balancer  | Externen Zugriff für Browser ermöglichen     | Service-Erstellung   |

**Kritische Datenflüsse:**

- **Nextcloud ↔ RDS:** Metadaten über privates VPC-Netzwerk
- **Nextcloud ↔ EBS:** Benutzerdateien via PersistentVolumeClaims
- **User ↔ Load Balancer:** HTTPS-Traffic über öffentliches Internet

Der OIDC-Mechanismus eliminiert langlebige AWS-Credentials und sorgt für temporäre, sichere Authentifizierung während
der Pipeline-Ausführung.

### 3.3.2 AWS Netzwerkarchitektur

**Netzwerk-Spezifikationen:**

| Komponente               | Konfiguration                    | Zweck                              |
|--------------------------|----------------------------------|------------------------------------|
| **VPC CIDR**             | `10.0.0.0/16`                    | Logisch isolierter Netzwerkbereich |
| **Availability Zones**   | `eu-central-1a`, `eu-central-1b` | Hochverfügbarkeit                  |
| **Öffentliche Subnetze** | `/24` pro AZ                     | Load Balancer, NAT Gateways        |
| **Private Subnetze**     | `/24` pro AZ                     | EKS Worker Nodes, RDS              |
| **NAT Gateways**         | 1 pro AZ                         | Ausgehende Internet-Verbindung     |

Die Netzwerkarchitektur folgt dem Defense-in-Depth-Prinzip. Sicherheitskritische Ressourcen wie EKS Worker Nodes und die
RDS-Datenbankinstanz operieren ausschliesslich in privaten Subnetzen ohne direkte Internet-Erreichbarkeit. Der Zugriff
erfolgt ausschliesslich über den kontrollierten Load Balancer-Endpunkt.

> **[DIAGRAM PLACEHOLDER: AWS Netzwerkarchitektur - VPC mit Subnetz-Details]**

**Design-Entscheidung: Zwei NAT Gateways**

Die Bereitstellung eines NAT Gateways pro Availability Zone ist eine bewusste Redundanz-Entscheidung. Ein einzelnes NAT
Gateway wäre kostengünstiger, würde aber einen Single Point of Failure darstellen. Bei einem AZ-Ausfall könnten Worker
Nodes in der anderen AZ keine ausgehenden Internet-Verbindungen mehr herstellen, was Updates und Image-Pulls unmöglich
machen würde.

**Routing-Strategie:**

- Öffentliche Subnetze routen direkt über das Internet Gateway (IGW)
- Private Subnetze routen über das NAT Gateway ihrer jeweiligen AZ
- Cross-AZ-Traffic bleibt vollständig im AWS-Backbone

### 3.3.3 Komponenten-Matrix

**System-Verantwortlichkeiten nach Ebenen:**

| Ebene             | Komponente       | Verantwortlichkeit                  | Datenfluss                     |
|-------------------|------------------|-------------------------------------|--------------------------------|
| **Steuerung**     | GitHub + Actions | Source of Truth, Orchestrierung     | Git-Commits → Pipeline-Trigger |
|                   | Terraform        | AWS-Ressourcen (VPC, EKS, RDS, IAM) | CLI ↔ AWS APIs                 |
|                   | Helm             | Kubernetes-Ressourcen für Nextcloud | Client ↔ K8s API               |
| **Infrastruktur** | VPC              | Sicheres Netzwerk-Fundament         | HTTP/S Load Balancer → EKS     |
|                   | EKS              | Kubernetes-Plattform                | Docker Pull + App-Traffic      |
|                   | RDS + EBS        | Daten-Persistierung                 | Nextcloud Read/Write           |

**Schnittstellen-Design:**

```yaml
# Terraform → AWS
  provider "aws" {
    region = "eu-central-1"
}

  # Helm → Kubernetes  
    provider "helm" {
    kubernetes {
    host = module.eks.cluster_endpoint
    }
}

  # Nextcloud → RDS
  env:
    - name: POSTGRES_HOST
      value: "{{ .Values.database.host }}"
```

Die Komponenten sind lose gekoppelt - jede Ebene kann unabhängig aktualisiert werden, ohne die anderen zu
beeinträchtigen.

### 3.3.4 EKS Deep-Dive - Security by Design

**Das Problem:** Standard-EKS-Konfigurationen führen zu subtilen Kompatibilitätsproblemen.

EKS Worker Nodes in privaten Subnetzen können standardmässig nicht auf den EC2 Instance Metadata Service (IMDS)
zugreifen. Das ist problematisch, weil Systemkomponenten wie der EBS CSI Driver ihre eigene Availability Zone über IMDS
ermitteln müssen, um EBS-Volumes korrekt zu mounten.

**Die Lösung: Custom Launch Template**

```hcl
# terraform/launch_template.tf
resource "aws_launch_template" "eks_nodes" {
  name_prefix   = "eks-node-group-"
  image_id      = data.aws_ami.eks_worker.id
  instance_type = "t3.medium"

  metadata_options {
    http_endpoint          = "enabled"
    http_tokens            = "required"
    http_put_response_hop_limit = 2  # Kritisch für EKS!
    instance_metadata_tags = "disabled"
  }

  vpc_security_group_ids = [aws_security_group.eks_nodes.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "eks-worker-node"
    }
  }
}
```

**Warum `hop_limit = 2`?**

Container in Kubernetes laufen in einer zusätzlichen Netzwerk-Schicht. Der Standard-Hop-Limit von 1 verhindert, dass
Pods IMDS erreichen können. Mit Limit 2 können sowohl der Node als auch die darauf laufenden Pods auf Metadata
zugreifen.

**IAM Roles for Service Accounts (IRSA):**

```yaml
# EBS CSI Driver bekommt eigene AWS-Berechtigungen
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ebs-csi-controller-sa
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::ACCOUNT:role/AmazonEKS_EBS_CSI_DriverRole
```

**Sicherheits-Architektur:**

- **Control Plane:** Von AWS verwaltet, hochverfügbar
- **Worker Nodes:** Ausschliesslich in privaten Subnetzen
- **Pod-to-AWS Communication:** Via IRSA ohne Credentials auf Nodes
- **External Access:** Nur über kontrollierten Load Balancer

> **[DIAGRAM PLACEHOLDER: EKS Security Architecture - Control Plane + Worker Nodes + IRSA]**

Diese Konfiguration löst nicht nur technische Probleme, sondern implementiert auch AWS Security Best Practices: Minimale
Berechtigungen, keine langlebigen Credentials, und Defense in Depth durch Netzwerk-Segmentierung.

---

## 4. Implementierung und Technische Umsetzung

Die Umsetzung erfolgte in vier strategischen Phasen: Infrastruktur-Provisionierung, Anwendungs-Paketierung,
Automatisierung und Konfigurationsoptimierung. Jede Phase löste spezifische technische Herausforderungen und baute auf
den Erkenntnissen der vorherigen auf.

## 4.1 Infrastruktur-Provisionierung mit Terraform

**Die Herausforderung:** Eine produktionsreife Kubernetes-Umgebung benötigt mehr als nur einen Cluster.
Netzwerk-Segmentierung, Datenbank-Integration, Speicher-Management und Sicherheits-Konfigurationen müssen orchestriert
werden.

**Der Ansatz:** Terraform ermöglicht deklarative Infrastruktur-Definition mit automatisiertem State-Management. Die
Komponenten wurden in logischer Abhängigkeitsreihenfolge entwickelt: Netzwerk → Cluster → Speicher → Datenbank →
Sicherheit.

### 4.1.1 Terraform State Backend - Foundation für Kollaboration

**Das Problem:** Lokaler Terraform State verhindert Zusammenarbeit und Automatisierung.

| Ansatz                | Lokaler State | Remote S3 Backend   | Entscheidung |
|-----------------------|---------------|---------------------|--------------|
| **Kollaboration**     | Unmöglich     | Multiple Entwickler | ✅ S3 Backend |
| **CI/CD Integration** | Nicht möglich | Nahtlos             | ✅ S3 Backend |
| **State Corruption**  | Risiko hoch   | DynamoDB Locking    | ✅ S3 Backend |
| **Versionierung**     | Keine         | S3 Versioning       | ✅ S3 Backend |

**Implementierung:**

```terraform
# backend/main.tf - Einmalige Backend-Infrastruktur
resource "aws_s3_bucket" "terraform_state" {
  bucket = "nenad-stevic-nextcloud-tfstate"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "nenad-stevic-nextcloud-tfstate-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
```

**Backend-Konfiguration in der Hauptanwendung:**

```terraform
# terraform/backend.tf
terraform {
  backend "s3" {
    bucket         = "nenad-stevic-nextcloud-tfstate"
    key            = "nextcloud-app/main.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "nenad-stevic-nextcloud-tfstate-lock"
    encrypt        = true
  }
}
```

**Tagging-Strategie für Kostenmanagement:**

```terraform
# terraform/locals.tf
locals {
  common_tags = {
    Projekt   = "Nextcloud"
    Student   = "NenadStevic"
    ManagedBy = "Terraform"
  }
}

# terraform/provider.tf
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}
```

Diese zentrale Tagging-Strategie ermöglicht präzise Kostenverfolgung im AWS Billing Dashboard.

### 4.1.2 Netzwerk-Architektur - Defense in Depth

**Design-Entscheidung: Hochverfügbares Multi-AZ Setup**

| Komponente          | Konfiguration     | Sicherheits-Impact                  |
|---------------------|-------------------|-------------------------------------|
| **VPC CIDR**        | `10.0.0.0/16`     | Logische Isolation                  |
| **Public Subnets**  | 2 AZs, `/24` each | Load Balancer, NAT Gateways         |
| **Private Subnets** | 2 AZs, `/24` each | EKS Nodes, RDS (Internet-geschützt) |
| **NAT Gateways**    | 1 pro AZ          | Redundante Outbound-Konnektivität   |

**Kritische Routing-Entscheidung:**

```terraform
# terraform/network.tf - NAT Gateway pro AZ für Ausfallsicherheit
resource "aws_nat_gateway" "nat_gw_per_az" {
  count = length(var.availability_zones)
  allocation_id = aws_eip.nat_eip_per_az[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  depends_on = [aws_internet_gateway.main_igw]
}

# Separate Route Table pro AZ
resource "aws_route_table" "private_rt_per_az" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_per_az[count.index].id
  }
}
```

**Warum zwei NAT Gateways?** Ein einzelnes Gateway wäre kostengünstiger, würde aber einen Single Point of Failure
schaffen. Bei AZ-Ausfall könnten Pods keine Container-Images mehr pullen.

> **[DIAGRAM PLACEHOLDER: VPC Multi-AZ Architecture]**  
> *Zeigt: Public/Private Subnets pro AZ, NAT Gateway Redundanz*

### 4.1.3 EKS Cluster - Managed Kubernetes mit Custom Tuning

**IAM-Rollen-Matrix:**

| Rolle              | Service             | Attached Policies                                                                             | Zweck                    |
|--------------------|---------------------|-----------------------------------------------------------------------------------------------|--------------------------|
| `eks-cluster-role` | `eks.amazonaws.com` | `AmazonEKSClusterPolicy`                                                                      | Control Plane Management |
| `eks-node-role`    | `ec2.amazonaws.com` | `AmazonEKSWorkerNodePolicy`<br>`AmazonEC2ContainerRegistryReadOnly`<br>`AmazonEKS_CNI_Policy` | Worker Node Operations   |

**Das IMDS Problem und die Lösung:**

Standard-EKS-Konfigurationen führen zu einem subtilen Problem: Pods können den EC2 Instance Metadata Service nicht
erreichen, was den EBS CSI Driver funktionsunfähig macht.

```terraform
# terraform/launch_template.tf - Lösung für IMDS-Zugriff
resource "aws_launch_template" "eks_nodes" {
  name_prefix = "${lower(var.project_name)}-lt-"

  metadata_options {
    http_tokens = "required"  # IMDSv2 enforcement
    http_put_response_hop_limit = 2           # Pods können IMDS erreichen
  }

  lifecycle {
    create_before_destroy = true
  }
}

# EKS Node Group mit Custom Launch Template
resource "aws_eks_node_group" "main_nodes" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-main-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.private[*].id  # Sicherheit: Private Subnetze

  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = aws_launch_template.eks_nodes.latest_version
  }

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }
}
```

**Cluster-Zugriff konfigurieren:**

```bash
aws eks update-kubeconfig --region eu-central-1 --name nextcloud-eks-cluster
kubectl get nodes  # Validierung
```

### 4.1.4 IAM Roles for Service Accounts (IRSA) - Sichere Pod-Authentifizierung

**Das Authentifizierungs-Problem:** Pods benötigen AWS-Berechtigungen ohne Access Keys im Cluster zu speichern.

**OIDC-Integration:**

```terraform
# terraform/iam_irsa.tf
data "tls_certificate" "eks_oidc_thumbprint" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_oidc_thumbprint.certificates[0].sha1_fingerprint]
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}
```

**EBS CSI Driver IAM-Rolle:**

```terraform
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
            "${replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:aud" = "sts.amazonaws.com",
            "${replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      }
    ]
  })
}
```

**Trust Policy Debugging:** Die ursprüngliche Implementation scheiterte mit `AccessDenied`. Die Lösung war eine
präzisere Condition-Syntax mit beiden `aud` und `sub` Validierung.

### 4.1.5 Persistenter Speicher - EBS CSI Driver

**Entscheidung: EKS Add-on vs Helm Chart**

| Kriterium                 | EKS Add-on    | Helm Chart       | Gewählt      |
|---------------------------|---------------|------------------|--------------|
| **AWS Integration**       | Nativ         | Community        | ✅ EKS Add-on |
| **Version Compatibility** | Garantiert    | Manuell          | ✅ EKS Add-on |
| **Lifecycle Management**  | AWS verwaltet | Selbst verwaltet | ✅ EKS Add-on |

```terraform
# terraform/eks_addons.tf
resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "aws-ebs-csi-driver"
  service_account_role_arn    = aws_iam_role.ebs_csi_driver_role.arn
  resolve_conflicts_on_create = "OVERWRITE"
}
```

Der EBS CSI Driver ist fundamentale Cluster-Infrastruktur, keine Anwendung. Die EKS Add-on-Methode folgt der
Architektur-Trennung: Terraform für Infrastruktur, Helm für Anwendungen.

### 4.1.6 RDS Datenbank - Managed PostgreSQL

**Sicherheits-Konfiguration:**

```terraform
# terraform/rds.tf
resource "aws_db_instance" "nextcloud" {
  identifier     = "${var.project_name}-db-instance"
  engine         = "postgres"
  engine_version = "15.4"
  instance_class = "db.t3.micro"

  allocated_storage = 20
  max_allocated_storage = 100  # Auto-scaling
  storage_encrypted = true

  db_name  = "nextclouddb"
  username = "nextcloudadmin"
  password = data.aws_secretsmanager_secret_version.rds_master_password.secret_string

  # Sicherheit: Nur private Subnetze
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  # Backup und Wartung
  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:04:00-sun:05:00"

  multi_az = false  # Kostenoptimierung für Demo
  publicly_accessible = false # Kritisch: Keine Internet-Exposition

  skip_final_snapshot = true  # Nur für Demo-Umgebung
}
```

**Netzwerk-Isolation:**

```terraform
# terraform/security_groups.tf
resource "aws_security_group_rule" "eks_to_rds" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds.id
  source_security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}
```

Diese Regel erlaubt PostgreSQL-Zugriff ausschliesslich von EKS-Pods - Least Privilege Prinzip umgesetzt.

## 4.2 Nextcloud Helm Chart - Anwendungs-Paketierung

**Das Problem:** Kubernetes YAML-Dateien sind statisch und umständlich zu verwalten. Unterschiedliche Umgebungen (
Dev/Prod) benötigen verschiedene Konfigurationen.

**Die Lösung:** Ein eigenes Helm Chart bietet vollständige Kontrolle über die Deployment-Logik und ermöglicht
Parametrisierung.

### 4.2.1 Chart-Architektur

```
charts/nextcloud-chart/
├── Chart.yaml           # Metadaten
├── values.yaml          # Standardkonfiguration
└── templates/
    ├── _helpers.tpl     # Template-Funktionen
    ├── configmap.yaml   # Nextcloud-Konfiguration
    ├── deployment.yaml  # Hauptanwendung
    ├── pvc.yaml         # Persistenter Speicher
    ├── secret.yaml      # Credentials
    └── service.yaml     # Netzwerk-Exposition
```

### 4.2.2 Kritische Template-Komponenten

**Deployment mit Umgebungsvariablen:**

```yaml
# templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
spec:
  replicas: { { .Values.replicaCount } }
  template:
    spec:
      containers:
        - name: nextcloud
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          env:
            - name: POSTGRES_HOST
              valueFrom:
                secretKeyRef:
                  name: { { include "nextcloud-chart.secretName" . } }
                  key: POSTGRES_HOST
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: { { include "nextcloud-chart.secretName" . } }
                  key: POSTGRES_PASSWORD
          volumeMounts:
            - name: nextcloud-data
              mountPath: /var/www/html
            - name: config-volume
              mountPath: /var/www/html/config/nextcloud-config.php
              subPath: nextcloud-config.php
      volumes:
        - name: nextcloud-data
          persistentVolumeClaim:
            claimName: { { include "nextcloud-chart.fullname" . } }-data
      - name: config-volume
      configMap:
        name: { { include "nextcloud-chart.fullname" . } }-config
```

**Das trusted_domains Problem:**

Nextcloud verweigert standardmässig Zugriffe über unbekannte Hostnamen. In Kubernetes ist der Hostname aber dynamisch (
Load Balancer).

```yaml
# templates/configmap.yaml - Lösung
apiVersion: v1
kind: ConfigMap
metadata:
  name: { { include "nextcloud-chart.fullname" . } }-config
data:
  nextcloud-config.php: |
    <?php
    $CONFIG = array (
      'overwrite.cli.url' => 'http://{{ .Values.nextcloud.host }}',
      'overwritehost' => '{{ .Values.nextcloud.host }}',
      'trusted_domains' => array (
        0 => 'localhost',
        1 => '{{ .Values.nextcloud.host }}',
      ),
    );
```

**Load Balancer Service:**

```yaml
# templates/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: { { include "nextcloud-chart.fullname" . } }
spec:
  type: { { .Values.service.type } }
  ports:
    - port: { { .Values.service.port } }
      targetPort: 80
      protocol: TCP
  selector:
    { { - include "nextcloud-chart.selectorLabels" . | nindent 4 } }
```

### 4.2.3 Flexible Konfiguration

**values.yaml Struktur:**

```yaml
# Anwendungs-Konfiguration
replicaCount: 1
image:
  repository: nextcloud
  tag: "27-apache"

# Nextcloud-spezifische Einstellungen
nextcloud:
  host: ""  # Wird zur Laufzeit gesetzt
  admin:
    user: "admin"
    password: ""  # Via --set übergeben

# Datenbank-Konfiguration
database:
  enabled: true
  host: ""  # RDS Endpoint
  user: "nextcloudadmin"
  password: ""  # Via --set übergeben
  database: "nextclouddb"

# Speicher-Konfiguration
persistence:
  enabled: true
  storageClass: "gp2"
  size: 10Gi

# Service-Konfiguration
service:
  type: LoadBalancer
  port: 80
```

**Deployment-Kommandos:**

```bash
# Installation
helm install nextcloud ./charts/nextcloud-chart \
  --set database.host="nextcloud-db.region.rds.amazonaws.com" \
  --set database.password="$RDS_PASSWORD" \
  --set nextcloud.admin.password="$ADMIN_PASSWORD"

# Hostname-Update nach Load Balancer-Erstellung
helm upgrade nextcloud ./charts/nextcloud-chart \
  --set nextcloud.host="a1b2c3d4.eu-central-1.elb.amazonaws.com"
```

## 4.3 CI/CD Pipeline - Automatisierte Deployments

**Die Vision:** Code-Änderungen sollen automatisch validiert, deployed und getestet werden. Keine manuellen Schritte,
keine langlebigen Credentials.

### 4.3.1 GitHub Actions Architektur

**Workflow-Trigger und Jobs:**

```yaml
# .github/workflows/main-push-deploy.yml
name: Deploy Nextcloud Application
on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      id-token: write    # OIDC-Token anfordern
      contents: read     # Repository lesen

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::${{ secrets.AWS_ACCOUNT_ID }}:role/${{ secrets.CICD_ROLE_NAME }}
          aws-region: ${{ secrets.AWS_REGION }}

      - name: Configure kubectl
        run: |
          aws eks update-kubeconfig --region ${{ secrets.AWS_REGION }} --name nextcloud-eks-cluster

      - name: Lint Helm Chart
        run: |
          helm lint charts/nextcloud-chart/

      - name: Deploy Application
        run: |
          helm upgrade --install nextcloud ./charts/nextcloud-chart \
            --create-namespace \
            --namespace nextcloud \
            --set database.host="${{ secrets.RDS_ENDPOINT }}" \
            --set database.password="${{ secrets.RDS_DB_PASSWORD }}" \
            --set nextcloud.admin.password="${{ secrets.NEXTCLOUD_ADMIN_PASSWORD }}" \
            --wait

      - name: Get Load Balancer Hostname
        run: |
          echo "Waiting for Load Balancer..."
          kubectl wait --for=condition=available --timeout=300s deployment/nextcloud -n nextcloud

          LB_HOSTNAME=$(kubectl get svc nextcloud -n nextcloud -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
          echo "Load Balancer: $LB_HOSTNAME"

          helm upgrade nextcloud ./charts/nextcloud-chart \
            --namespace nextcloud \
            --set nextcloud.host="$LB_HOSTNAME"

      - name: Test Deployment
        run: |
          helm test nextcloud --namespace nextcloud
```

### 4.3.2 OIDC-Authentifizierung - Keine Passwörter

**Das Sicherheitsproblem:** Traditionelle CI/CD pipelines speichern AWS Access Keys als Secrets - ein Sicherheitsrisiko.

**OIDC-Lösung:**

```terraform
# terraform/iam_cicd.tf
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"  # GitHub OIDC
  ]
}

resource "aws_iam_role" "cicd_role" {
  name = "Nextcloud-cicd-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRoleWithWebIdentity",
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        },
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:Stevic-Nenad/Nextcloud:ref:refs/heads/main"
          }
        }
      }
    ]
  })
}
```

**Sicherheits-Vorteile:**

- Keine langlebigen Credentials in GitHub Secrets
- Temporäre Token nur für spezifische Repository/Branch
- Automatische Token-Rotation durch AWS

### 4.3.3 Lifecycle-Management

**Full Environment Management:**

```yaml
# .github/workflows/lifecycle.yml
name: Full Environment Lifecycle
on:
  workflow_dispatch:
    inputs:
      action:
        description: 'Action to perform'
        required: true
        default: 'setup'
        type: choice
        options:
          - setup
          - destroy

jobs:
  terraform:
    if: github.event.inputs.action == 'setup'
    runs-on: ubuntu-latest
    steps:
      - name: Terraform Apply
        run: |
          cd terraform
          terraform init
          terraform apply -auto-approve

  deploy:
    if: github.event.inputs.action == 'setup'
    needs: terraform
    uses: ./.github/workflows/reusable-deploy-app.yml

  destroy:
    if: github.event.inputs.action == 'destroy'
    runs-on: ubuntu-latest
    steps:
      - name: Destroy Application
        run: |
          helm uninstall nextcloud --namespace nextcloud

      - name: Destroy Infrastructure
        run: |
          cd terraform
          terraform destroy -auto-approve
```

Dieser Workflow ermöglicht komplette Umgebungen "on-demand" zu erstellen oder zu zerstören - Environment-as-a-Service.

## 4.4 Kritische Konfigurationsanpassungen

Neben der Standard-Ressourcen-Provisionierung waren spezifische Anpassungen notwendig, um Kompatibilität und Sicherheit
zu gewährleisten.

### 4.4.1 EKS Node IMDS-Konfiguration

**Das Problem:** EBS CSI Driver kann Availability Zone nicht ermitteln.

**Root Cause:** Standard EKS-Nodes haben IMDS Hop Limit = 1, aber Container benötigen Hop Limit = 2.

**Fehlersymptom:**

```
Events:
  Warning  ProvisioningFailed  persistentvolumeclaim/nextcloud-data
  failed to provision volume with StorageClass "gp2": rpc error: code = Internal 
  desc = Could not create volume: UnauthorizedOperation: You are not authorized to perform this operation
```

**Lösung - Custom Launch Template:**

```terraform
resource "aws_launch_template" "eks_nodes" {
  metadata_options {
    http_tokens = "required"  # IMDSv2 erzwingen
    http_put_response_hop_limit = 2           # Container können IMDS erreichen
  }
}
```

### 4.4.2 Nextcloud Load Balancer Integration

**Das Problem:** Nextcloud zeigt interne IPs in generierten URLs.

**Symptom:** Redirects führen zu internen Kubernetes Service-IPs statt externen Load Balancer-URLs.

**Lösung - Dynamische Konfiguration:**

```php
# Via ConfigMap injiziert
<?php
$CONFIG = array (
  'overwrite.cli.url' => 'http://a1b2c3d4.eu-central-1.elb.amazonaws.com',
  'overwritehost' => 'a1b2c3d4.eu-central-1.elb.amazonaws.com',
  'trusted_domains' => array (
    0 => 'localhost',
    1 => 'a1b2c3d4.eu-central-1.elb.amazonaws.com',
  ),
);
```

### 4.4.3 RDS Security Group Isolation

**Das Problem:** Datenbank sollte nur von Nextcloud-Pods erreichbar sein.

**Lösung - Präzise Security Group Rules:**

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

**Sicherheits-Impact:** Selbst mit VPC-Zugriff kann nur der EKS-Cluster die Datenbank erreichen. Alle anderen Services (
EC2, Lambda, etc.) werden blockiert.

## 4.5 Deployment und Validierung

**Vollständiger Deployment-Prozess:**

```bash
# 1. Infrastruktur erstellen
cd terraform
terraform init
terraform apply

# 2. Kubectl konfigurieren
aws eks update-kubeconfig --region eu-central-1 --name nextcloud-eks-cluster

# 3. Anwendung deployen
helm install nextcloud ./charts/nextcloud-chart \
  --set database.host="$(terraform output -raw rds_endpoint)" \
  --set database.password="$RDS_PASSWORD" \
  --set nextcloud.admin.password="$ADMIN_PASSWORD"

# 4. Load Balancer URL ermitteln
kubectl get svc nextcloud -w

# 5. Hostname konfigurieren
helm upgrade nextcloud ./charts/nextcloud-chart \
  --set nextcloud.host="$(kubectl get svc nextcloud -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')"

# 6. Funktionalität testen
helm test nextcloud
```

**Validierung der Persistenz:**

```bash
# Pod löschen zum Test der Datenpersistenz
kubectl delete pod -l app.kubernetes.io/name=nextcloud-chart

# Neuer Pod sollte automatisch starten und Daten behalten
kubectl get pods -w
```

**Environment Cleanup:**

```bash
# Anwendung entfernen
helm uninstall nextcloud

# Infrastruktur zerstören
terraform destroy -auto-approve
```

---

## 5. Testing und Qualitätssicherung

**Die Herausforderung:** Eine fehlerhaft deployete Nextcloud-Instanz in der Cloud kostet Zeit und Geld. Jeder Fehler,
der erst in der AWS-Umgebung entdeckt wird, verursacht einen teuren Debug-Zyklus.

**Die Strategie:** "Shift-Left" - Fehler so früh wie möglich fangen, bevor sie teuer werden.

## 5.1 Mehrstufige Qualitätssicherung

**Pipeline-integrierte Validierung:**

| Stage                      | Tool                 | Was wird geprüft                     | Abbruch bei Fehler |
|----------------------------|----------------------|--------------------------------------|--------------------|
| **Code-Qualität**          | `helm lint`          | Chart-Syntax, Best Practices         | ✅ Sofort           |
| **Infrastruktur**          | `terraform validate` | HCL-Syntax, Provider-Kompatibilität  | ✅ Sofort           |
| **Template-Generierung**   | `helm template`      | Kubernetes-Manifest-Ausgabe          | ✅ Sofort           |
| **Deployment-Validierung** | `kubectl wait`       | Pod-Readiness, Service-Verfügbarkeit | ✅ Nach Timeout     |
| **Funktionalität**         | `helm test`          | HTTP-Endpunkt-Erreichbarkeit         | ✅ Bei Fehlschlag   |

## 5.2 Automatisierte Tests

### Helm Test Implementation

**Das Problem:** Wie beweist man, dass Nextcloud wirklich läuft und nicht nur deployed ist?

**Die Lösung:** Ein eigener Test-Pod, der die Anwendung aus Cluster-Sicht validiert.

```yaml
# templates/tests/test-connection.yaml
apiVersion: v1
kind: Pod
metadata:
  name: "{{ include "nextcloud-chart.fullname" . }}-test"
  annotations:
    "helm.sh/hook": test
    "helm.sh/hook-weight": "1"
    "helm.sh/hook-delete-policy": hook-succeeded
spec:
  restartPolicy: Never
  containers:
    - name: wget
      image: busybox
      command: [ 'wget' ]
      args: [ '--spider', '--timeout=10', 'http://{{ include "nextcloud-chart.fullname" . }}/status.php' ]
```

**Test-Ausführung:**

```bash
# Deployment testen
helm test nextcloud

# Output:
NAME: nextcloud
LAST DEPLOYED: 2024-01-15T10:30:45Z
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE:     nextcloud-test
Last Started:   2024-01-15T10:31:00Z
Last Completed: 2024-01-15T10:31:05Z
Phase:          Succeeded
```

### CI/CD Integration

**Validierungsschritt in GitHub Actions:**

```yaml
# .github/workflows/main-push-deploy.yml
- name: Validate Infrastructure
  run: |
    cd terraform
    terraform validate
    terraform plan -detailed-exitcode

- name: Lint Helm Chart
  run: |
    helm lint charts/nextcloud-chart/

- name: Template Validation
  run: |
    helm template nextcloud charts/nextcloud-chart/ > /tmp/manifests.yaml
    kubectl apply --dry-run=client -f /tmp/manifests.yaml

- name: Deploy and Test
  run: |
    helm upgrade --install nextcloud charts/nextcloud-chart/ --wait
    helm test nextcloud --timeout 300s
```

**Fehler-Eskalation:** Jeder fehlgeschlagene Test bricht die Pipeline ab und verhindert fehlerhafte Deployments.

## 5.3 Manuelle Validierung

**Kritische Funktionen, die automatisierte Tests nicht abdecken:**

### Persistenz-Test

```bash
# 1. Testdatei hochladen
echo "Test-Content-$(date)" > testfile.txt
# Via Nextcloud UI hochladen

# 2. Pod-Neustart simulieren  
kubectl delete pod -l app.kubernetes.io/name=nextcloud-chart

# 3. Neuer Pod sollte starten
kubectl get pods -w

# 4. Testdatei sollte noch existieren
# Via Nextcloud UI überprüfen
```

**Warum manuell?** Datei-Upload-Tests benötigen Browser-Interaktion oder komplexe API-Aufrufe. Der Aufwand übersteigt
den Nutzen für ein Proof-of-Concept.

### Load Balancer Konnektivität

**Browser-Test:**

1. Load Balancer URL ermitteln: `kubectl get svc nextcloud`
2. URL im Browser öffnen
3. Login mit Admin-Credentials
4. File-Upload/Download testen

**Warum kritisch?** Der Helm Test prüft nur cluster-interne Konnektivität. Externe Erreichbarkeit über den Load Balancer
ist separater Failure-Mode.

## 5.4 End-to-End Pipeline Tests

**Lifecycle-Workflow Validierung:**

| Test-Szenario         | Ziel                                    | Dauer   | Häufigkeit            |
|-----------------------|-----------------------------------------|---------|-----------------------|
| **Cold Setup**        | Komplette Umgebung aus nichts erstellen | ~20 Min | Nach Major-Änderungen |
| **Hot Deployment**    | Anwendungs-Update auf bestehender Infra | ~5 Min  | Bei jedem Push        |
| **Complete Teardown** | Alle Ressourcen sauber entfernen        | ~10 Min | Nach Tests            |

**Cold Setup Validierung:**

```bash
# Workflow manuell triggern
gh workflow run lifecycle.yml -f action=setup

# Erfolgskriterien:
# ✅ Terraform Apply erfolgreich
# ✅ EKS Cluster erreichbar  
# ✅ Nextcloud-Deployment läuft
# ✅ Load Balancer funktional
# ✅ Helm Test bestanden
```

**Teardown Validierung:**

```bash
# Cleanup triggern
gh workflow run lifecycle.yml -f action=destroy

# Validierung:
aws ec2 describe-instances --filters "Name=tag:Projekt,Values=Nextcloud" # Keine Instanzen
aws rds describe-db-instances --filters "Name=tag:Projekt,Values=Nextcloud" # Keine DBs  
aws elb describe-load-balancers # Keine Nextcloud Load Balancer
```

**Kostenschutz:** Complete Teardown verhindert vergessene, kostenfressende Ressourcen.

## 5.5 Qualitätssicherungs-Erkenntnisse

**Gefundene kritische Issues:**

| Problem               | Entdeckt durch         | Impact                         | Lösung                         |
|-----------------------|------------------------|--------------------------------|--------------------------------|
| **IMDS Hop Limit**    | Manueller PVC-Test     | EBS Volumes funktionslos       | Custom Launch Template         |
| **Trusted Domains**   | Browser-Test           | Nextcloud-Redirects fehlerhaft | ConfigMap mit dynamischem Host |
| **IRSA Trust Policy** | `helm test` Fehlschlag | EBS CSI Driver Access Denied   | Präzisere Condition-Syntax     |

**Lessons Learned:**

- **Automatisierte Tests** fangen Konfigurationsfehler früh
- **Manuelle Tests** decken UX-Probleme auf, die Scripts übersehen
- **End-to-End Tests** validieren die gesamte Wertschöpfungskette

**Test-ROI:** Jeder gefundene Fehler in der lokalen Umgebung spart 10-15 Minuten AWS-Deployment-Zeit und verhindert
frustrierende Debug-Sessions in der Cloud.

## 5.6 Testprotokolle

---

### Testfall T5.6.1 – Kosten-Tags auf AWS-Ressourcen

| Kriterium                  | Beschreibung                                                                                                                                                 |
|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#7, Nextcloud#5                                                                                                                                     |
| **Status**                 | ✅ Abgeschlossen                                                                                                                                              |
| **Zielsetzung**            | Verifizieren, dass die globalen Standard-Tags (`Projekt`, `Student`, `ManagedBy`) auf allen via Terraform erstellten Ressourcen angezeigt werden.            |
| **Testschritte**           | <ol><li>`terraform apply` für Netzwerk-Stack ausführen.</li><li>In der AWS Konsole VPC → Tags prüfen.</li><li>Ein Subnetz auswählen → Tags prüfen.</li></ol> |
| **Erwartetes Ergebnis**    | Alle in `local.common_tags` definierten Tags sind mit korrekten Werten vorhanden.                                                                            |
| **Tatsächliches Ergebnis** | ✅ Tags auf VPC, Subnetzen, IGW, NAT Gateways und Routen erfolgreich verifiziert.                                                                             |
| **Nachweis**               | Screenshot `vpc_tags_verification.png` (Abschnitt 5.6.1)                                                                                                     |

---

### Testfall T5.6.2 – VPC-Grundfunktionalität & HA der NAT Gateways

| Kriterium                  | Beschreibung                                                                                                                                                                                                               |
|----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#5                                                                                                                                                                                                                |
| **Status**                 | ✅ Abgeschlossen                                                                                                                                                                                                            |
| **Zielsetzung**            | Sicherstellen, dass VPC, Subnetze, IGW und je AZ genau ein NAT Gateway korrekt erstellt sind.                                                                                                                              |
| **Testschritte**           | <ol><li>Stichproben-Check VPC/Subnetze/IGW/NAT GW in Konsole.</li><li>Routing-Tabellen prüfen:<br> • 0.0.0.0/0 → IGW (öffentlich)<br> • 0.0.0.0/0 → AZ-NAT GW (privat)</li><li>`terraform output` kontrollieren.</li></ol> |
| **Erwartetes Ergebnis**    | Komponenten und Routing wie definiert; AZ-NAT-GW-Architektur intakt.                                                                                                                                                       |
| **Tatsächliches Ergebnis** | ✅ Alles wie erwartet, AZ-spezifische NAT-Gateways korrekt.                                                                                                                                                                 |
| **Nachweis**               | Screenshot `vpc_functionality_verification.png` (Abschnitt 5.6.1)                                                                                                                                                          |

---

### Testfall T5.6.3 – Terraform Remote Backend (S3)

| Kriterium                  | Beschreibung                                                                                                                                                                            |
|----------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#6                                                                                                                                                                             |
| **Status**                 | ✅ Abgeschlossen <br>*(oder anpassen, falls teilweise)*                                                                                                                                  |
| **Zielsetzung**            | Verifizieren, dass der Terraform-State im S3-Bucket gespeichert und via DynamoDB gelockt wird.                                                                                          |
| **Testschritte**           | <ol><li>`terraform init` in `src/terraform/`.</li><li>`terraform apply` → S3 Bucket prüfen: `nextcloud-app/main.tfstate`.</li><li>`terraform plan/apply` → keine Lock-Fehler.</li></ol> |
| **Erwartetes Ergebnis**    | S3-Backend initialisiert; State wird zentral verwaltet.                                                                                                                                 |
| **Tatsächliches Ergebnis** | ✅ Initialisierung & State-Speicherung funktionierten.                                                                                                                                   |
| **Nachweis**               | Screenshot `terraform_remote_backend.png` (Abschnitt 5.6.1)                                                                                                                             |

---

### Testfall T5.6.4 – Provisionierung EKS Cluster & Node Groups

| Kriterium                  | Beschreibung                                                                                                                                                      |
|----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#8                                                                                                                                                       |
| **Status**                 | ✅ Abgeschlossen                                                                                                                                                   |
| **Zielsetzung**            | Sicherstellen, dass EKS Cluster + Managed Node Group bereitgestellt und via `kubectl` erreichbar sind.                                                            |
| **Testschritte**           | <ol><li>`terraform apply`.</li><li>`aws eks update-kubeconfig …`.</li><li>`kubectl get nodes -o wide`.</li><li>EC2-Instanzen → private Subnetze prüfen.</li></ol> |
| **Erwartetes Ergebnis**    | Nodes im Status *Ready*, private IP-Adressen.                                                                                                                     |
| **Tatsächliches Ergebnis** | ✅ 2 Worker Nodes *Ready*, private IPs, IAM-Rollen korrigiert.                                                                                                     |
| **Nachweis**               | Screenshot `eks_nodes_ready.png` (Abschnitt 5.6.1)                                                                                                                |

---

### Testfall T5.6.5 – ECR Repository Provisionierung

| Kriterium                  | Beschreibung                                                                                                                                                                                                               |
|----------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#9                                                                                                                                                                                                                |
| **Status**                 | ✅ Abgeschlossen                                                                                                                                                                                                            |
| **Zielsetzung**            | Verifizieren, dass das ECR Repository mit Scan-on-Push, Lifecycle-Policy & Tags erstellt ist.                                                                                                                              |
| **Testschritte**           | <ol><li>`terraform output` prüfen (URL, Name, ARN).</li><li>ECR Konsole → Repository-Details kontrollieren (Scan, Policy, Mutability, Tags).</li><li>Optional: `aws ecr get-login-password` → Docker Login-Test.</li></ol> |
| **Erwartetes Ergebnis**    | Repository-Konfiguration entspricht Terraform.                                                                                                                                                                             |
| **Tatsächliches Ergebnis** | ✅ Alle Einstellungen in AWS Konsole bestätigt.                                                                                                                                                                             |
| **Nachweis**               | Screenshot `ecr_repository_verification.png` (Abschnitt 5.6.1)                                                                                                                                                             |

---

### Testfall T5.6.6 – IAM OIDC Provider & IRSA-Rolle

| Kriterium                  | Beschreibung                                                                                                                                          |
|----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#10                                                                                                                                          |
| **Status**                 | ✅ Abgeschlossen                                                                                                                                       |
| **Zielsetzung**            | OIDC-Provider & EBS-CSI-IAM-Rolle besitzen korrekte Trust Policy.                                                                                     |
| **Testschritte**           | <ol><li>IAM → Identity providers: OIDC-URL prüfen.</li><li>IAM → Role `${var.project_name}-ebs-csi-driver-role` → Trust Policy vergleichen.</li></ol> |
| **Erwartetes Ergebnis**    | Trust Policy entspricht exakt der Terraform-Definition.                                                                                               |
| **Tatsächliches Ergebnis** | ✅ Provider & Rolle identisch mit Definition.                                                                                                          |
| **Nachweis**               | Screenshot `irsa_trust_policy_verification.png` (Abschnitt 5.6.1)                                                                                     |

---

### Testfall T5.6.7 – EBS CSI Driver (Dynamische Provisionierung)

| Kriterium                  | Beschreibung                                                                                                                                                                                                |
|----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#11                                                                                                                                                                                                |
| **Status**                 | ✅ Abgeschlossen                                                                                                                                                                                             |
| **Zielsetzung**            | Sicherstellen, dass PVC → dynamisch EBS Volume erstellt & gebunden wird.                                                                                                                                    |
| **Testschritte**           | <ol><li>`kubectl apply` Test-StorageClass & PVC.</li><li>`kubectl get pvc/pv` bis Status *Bound*.</li><li>AWS Konsole → EBS Volume *in-use* prüfen.</li><li>PVC/PV löschen → Volume verschwindet.</li></ol> |
| **Erwartetes Ergebnis**    | PVC & PV *Bound*; Volume wird erstellt & gelöscht.                                                                                                                                                          |
| **Tatsächliches Ergebnis** | ✅ PVC binnen Sekunden *Bound*; Volume korrekt gehandhabt.                                                                                                                                                   |
| **Nachweis**               | Screenshot `ebs_pvc_bound_verification.png` (Abschnitt 5.6.1)                                                                                                                                               |

---

### Testfall T5.6.8 – RDS-Instanz Provisionierung & Netzwerkkonnektivität

| Kriterium                  | Beschreibung                                                                                                                                                                                                                  |
|----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#12, #13                                                                                                                                                                                                             |
| **Status**                 | *(nach Apply ausfüllen)*                                                                                                                                                                                                      |
| **Zielsetzung**            | Verifizieren, dass RDS instanz privat platziert & nur vom EKS-Cluster erreichbar ist.                                                                                                                                         |
| **Testschritte**           | <ol><li>RDS Konsole → Instanz Status *Available*.</li><li>Connectivity & Security prüfen (Public = No; private Subnets).</li><li>RDS-SG → Inbound 5432 von EKS-SG.</li><li>`terraform output` Endpoint/Port prüfen.</li></ol> |
| **Erwartetes Ergebnis**    | DB privat, Zugriff nur via EKS-SG.                                                                                                                                                                                            |
| **Tatsächliches Ergebnis** | *(nach Apply eintragen)*                                                                                                                                                                                                      |
| **Nachweis**               | Screenshot `rds_sg_inbound_rules.png` (Abschnitt 5.6.1)                                                                                                                                                                       |

---

### Testfall T5.6.9 – EKS-Node-Konfiguration (IMDS & Topologie)

| Kriterium                  | Beschreibung                                                                                                                                                                                                                  |
|----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Sprint-Fehleranalyse (indirekt #11, #14)                                                                                                                                                                                      |
| **Status**                 | ✅ Abgeschlossen                                                                                                                                                                                                               |
| **Zielsetzung**            | Sicherstellen, dass IMDS-Hop-Limit korrekt und Topologie-Labels gesetzt sind.                                                                                                                                                 |
| **Testschritte**           | <ol><li>`aws ec2 describe-instances … MetadataOptions` → Hop-Limit = 2.</li><li>`kubectl describe node …` → `topology.ebs.csi.aws.com/zone` vorhanden.</li><li>`kubectl logs ebs-csi-node …` → keine IMDS-Timeouts.</li></ol> |
| **Erwartetes Ergebnis**    | IMDS-Konnektivität & Topologie-Labels ok.                                                                                                                                                                                     |
| **Tatsächliches Ergebnis** | ✅ Nach Launch-Template-Fix alles grün; PVC-Probleme gelöst.                                                                                                                                                                   |
| **Nachweis**               | Screenshot `eks_node_imds_topology.png` (Abschnitt 5.6.1)                                                                                                                                                                     |

---

### Testfall T5.6.10 – OIDC-Authentifizierung GitHub Actions → AWS

| Kriterium                  | Beschreibung                                                                                                                                                                                     |
|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#20                                                                                                                                                                                     |
| **Status**                 | ✅ Abgeschlossen                                                                                                                                                                                  |
| **Zielsetzung**            | GitHub Actions kann per OIDC die IAM-Rolle `Nextcloud-cicd-role` übernehmen.                                                                                                                     |
| **Testschritte**           | <ol><li>Terraform → OIDC-Provider & Role erstellen.</li><li>IAM Konsole → Trust Policy prüfen (Repo-Condition).</li><li>Test-Workflow `test-auth.yml` → `aws sts get-caller-identity`.</li></ol> |
| **Erwartetes Ergebnis**    | Workflow läuft durch; ARN zeigt `assumed-role/Nextcloud-cicd-role`.                                                                                                                              |
| **Tatsächliches Ergebnis** | ✅ Workflow erfolgreich; Rolle übernommen.                                                                                                                                                        |
| **Nachweis**               | Screenshot `github_actions_oidc_workflow.png` (Abschnitt 5.6.1)                                                                                                                                  |

---

### Testfall T5.6.11 – End-to-End CI/CD-Pipeline

| Kriterium                  | Beschreibung                                                                                                                                          |
|----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#21                                                                                                                                          |
| **Status**                 | ✅ Abgeschlossen                                                                                                                                       |
| **Zielsetzung**            | Sicherstellen, dass Push → Workflow → Helm-Deploy → Helm-Tests erfolgreich ist.                                                                       |
| **Testschritte**           | <ol><li>Push auf `main`.</li><li>Job `get-infra-data` liest Remote State.</li><li>Job `deploy-application` führt Helm-Deploy & Tests durch.</li></ol> |
| **Erwartetes Ergebnis**    | Workflow mit grünem Haken, Logs zeigen dynamische Datenübergabe.                                                                                      |
| **Tatsächliches Ergebnis** | ✅ Workflow lief fehlerfrei; Helm-Tests bestanden.                                                                                                     |
| **Nachweis**               | Screenshot `ci_cd_pipeline_summary.png` (Abschnitt 5.6.1)                                                                                             |

---

### Testfall T5.6.12 – Pipeline-Status-Badge

| Kriterium                  | Beschreibung                                                                                                                                  |
|----------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#23                                                                                                                                  |
| **Status**                 | ✅ Abgeschlossen                                                                                                                               |
| **Zielsetzung**            | Badge zeigt Live-Status & verlinkt zur Workflow-Seite.                                                                                        |
| **Testschritte**           | <ol><li>Badge-Markdown in `README.md` einfügen.</li><li>Push → Workflow abwarten.</li><li>Repo-Startseite neu laden → Badge prüfen.</li></ol> |
| **Erwartetes Ergebnis**    | Badge sichtbar, Status korrekt, Link funktioniert.                                                                                            |
| **Tatsächliches Ergebnis** | ✅ Anzeige & Verlinkung wie erwartet.                                                                                                          |
| **Nachweis**               | Screenshot `readme_pipeline_badge.png` (Abschnitt 5.6.1)                                                                                      |

---

### Testfall T5.6.13 – “Full Setup” Lifecycle-Workflow

| Kriterium                  | Beschreibung                                                                                                                                                                                         |
|----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#41                                                                                                                                                                                         |
| **Status**                 | ✅ Abgeschlossen                                                                                                                                                                                      |
| **Zielsetzung**            | Manueller `setup`-Workflow provisioniert komplette Infrastruktur + App.                                                                                                                              |
| **Testschritte**           | <ol><li>Keine Ressourcen vorhanden → Workflow `setup` starten.</li><li>Jobs `terraform-apply`, `deploy-application` beobachten.</li><li>AWS-Konsole → Ressourcen erstellt, App erreichbar.</li></ol> |
| **Erwartetes Ergebnis**    | Beide Jobs grün; Nextcloud online.                                                                                                                                                                   |
| **Tatsächliches Ergebnis** | ✅ Workflow setzte Umgebung fehlerfrei auf.                                                                                                                                                           |
| **Nachweis**               | Screenshot `lifecycle_setup_workflow.png` (Abschnitt 5.6.1)                                                                                                                                          |

---

### Testfall T5.6.14 – “Full Teardown” Lifecycle-Workflow

| Kriterium                  | Beschreibung                                                                                                                                                                             |
|----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#42                                                                                                                                                                             |
| **Status**                 | ✅ Abgeschlossen                                                                                                                                                                          |
| **Zielsetzung**            | Manueller `destroy`-Workflow entfernt App & Infrastruktur vollständig und idempotent.                                                                                                    |
| **Testschritte**           | <ol><li>Bestehende Umgebung → Workflow `destroy` starten.</li><li>Jobs `helm-uninstall`, `terraform-destroy` beobachten.</li><li>AWS-Konsole danach leer (Projekt-Ressourcen).</li></ol> |
| **Erwartetes Ergebnis**    | Ressourcen vollständig entfernt; zweiter Lauf überspringt Steps.                                                                                                                         |
| **Tatsächliches Ergebnis** | ✅ Workflow entfernte alles; zweiter Lauf ohne Fehler.                                                                                                                                    |
| **Nachweis**               | Screenshot `lifecycle_destroy_workflow.png` (Abschnitt 5.6.1)                                                                                                                            |

---

### Testfall T5.6.15 – Installations- & Inbetriebnahme-Anleitung

| Kriterium                  | Beschreibung                                                                                                                           |
|----------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#28                                                                                                                           |
| **Status**                 | ✅ Abgeschlossen                                                                                                                        |
| **Zielsetzung**            | Anleitung (Kap. 4.4) ermöglicht neuen Nutzern vollständiges Aufsetzen + Teardown.                                                      |
| **Testschritte**           | <ol><li>Schritt-für-Schritt-Durchgang (mentale Probe).</li><li>Secrets, Setup-, Zugriffs- & Destroy-Schritte nachvollziehen.</li></ol> |
| **Erwartetes Ergebnis**    | Kapitel logisch, lückenlos, verständlich.                                                                                              |
| **Tatsächliches Ergebnis** | ✅ Anleitung führt sicher durch *Happy Path*.                                                                                           |
| **Nachweis**               | Verweis auf endgültiges Kapitel 4.4 (`installation_guide_verification.png`)                                                            |

---

### Testfall T5.6.16 – Architektur-Diagramme

| Kriterium                  | Beschreibung                                                                                                                          |
|----------------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#26                                                                                                                          |
| **Status**                 | ✅ Abgeschlossen                                                                                                                       |
| **Zielsetzung**            | Diagramme repräsentieren finale Architektur (gesamt & AWS-Netzwerk) korrekt.                                                          |
| **Testschritte**           | <ol><li>Diagramm 3.3.1 → Komponenten & Flows vergleichen.</li><li>Diagramm 3.3.2 → VPC/Subnetze/NAT → Terraform abgleichen.</li></ol> |
| **Erwartetes Ergebnis**    | Diagramme spiegeln Realität exakt wider.                                                                                              |
| **Tatsächliches Ergebnis** | ✅ Diagramme aktuell & vollständig.                                                                                                    |
| **Nachweis**               | Zusammengestelltes Bild `architecture_diagrams.png` (Abschnitt 5.6.1)                                                                 |

---

### Testfall T5.6.17 – Reflexionskapitel

| Kriterium                  | Beschreibung                                                                                                                           |
|----------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#32                                                                                                                           |
| **Status**                 | ✅ Abgeschlossen                                                                                                                        |
| **Zielsetzung**            | Kapitel 7 bietet ehrliche, fundierte Reflexion inkl. Verbesserungspotenziale.                                                          |
| **Testschritte**           | <ol><li>Lesen 7.1 – 7.4.</li><li>Abgleich mit tatsächlichen Sprint-Ereignissen.</li><li>Bewertung der Handlungsempfehlungen.</li></ol> |
| **Erwartetes Ergebnis**    | Kohärente, kritische Auseinandersetzung.                                                                                               |
| **Tatsächliches Ergebnis** | ✅ Kapitel erfüllt Anforderungen.                                                                                                       |
| **Nachweis**               | Screenshot `reflections_chapter.png` (Abschnitt 5.6.1)                                                                                 |

---

### Testfall T5.6.18 – Codebase-Qualität & Verständlichkeit

| Kriterium                  | Beschreibung                                                                                                                                                                |
|----------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **User Story**             | Nextcloud#31                                                                                                                                                                |
| **Status**                 | ✅ Abgeschlossen                                                                                                                                                             |
| **Zielsetzung**            | Code ist formatiert, dokumentiert, frei von Artefakten.                                                                                                                     |
| **Testschritte**           | <ol><li>`terraform fmt --check -recursive`.</li><li>Manual Review: Kommentare & Dead Code.</li><li>Verzeichnisstruktur prüfen (`/kubernetes-manifests` entfernt).</li></ol> |
| **Erwartetes Ergebnis**    | Format sauber, Kommentare erklären *Warum*, Repo frei von Altlasten.                                                                                                        |
| **Tatsächliches Ergebnis** | ✅ Alle Checks bestanden; Repo sauber.                                                                                                                                       |
| **Nachweis**               | Screenshot `codebase_quality_checks.png` (Abschnitt 5.6.1)                                                                                                                  |

---

### 5.6.1 Nachweise der Testergebnisse (Screenshots / GIFs)

| Testfall | Datei                                 | Kurzbeschreibung                |
|----------|---------------------------------------|---------------------------------|
| T5.6.1   | `vpc_tags_verification.png`           | Tags auf VPC & NAT GW           |
| T5.6.2   | `vpc_functionality_verification.png`  | VPC-/Routing-Stichprobe         |
| T5.6.3   | `terraform_remote_backend.png`        | S3 State + `terraform init`     |
| T5.6.4   | `eks_nodes_ready.png`                 | `kubectl get nodes` Ready       |
| T5.6.5   | `ecr_repository_verification.png`     | ECR Details & Lifecycle         |
| T5.6.6   | `irsa_trust_policy_verification.png`  | IAM Trust Policy                |
| T5.6.7   | `ebs_pvc_bound_verification.png`      | PVC/PV Bound + EBS Volume       |
| T5.6.8   | `rds_sg_inbound_rules.png`            | RDS-SG Inbound 5432             |
| T5.6.9   | `eks_node_imds_topology.png`          | IMDS Hop-Limit & Topology-Label |
| T5.6.10  | `github_actions_oidc_workflow.png`    | GitHub Actions OIDC-Run         |
| T5.6.11  | `ci_cd_pipeline_summary.png`          | Workflow-Übersicht grün         |
| T5.6.12  | `readme_pipeline_badge.png`           | README Badge “passing”          |
| T5.6.13  | `lifecycle_setup_workflow.png`        | `setup`-Workflow grün           |
| T5.6.14  | `lifecycle_destroy_workflow.png`      | `destroy`-Workflow grün         |
| T5.6.15  | `installation_guide_verification.png` | Kapitel 4.4 (Ausschnitt)        |
| T5.6.16  | `architecture_diagrams.png`           | Gesamt- & Netzwerk-Diagramm     |
| T5.6.17  | `reflections_chapter.png`             | Auszug Kapitel 7                |
| T5.6.18  | `codebase_quality_checks.png`         | `terraform fmt` Output          |

---

## **6. Projektdokumentation (Zusammenfassung)**

Diese `README.md`-Datei dient als zentrale und umfassende Projektdokumentation. Alle relevanten Informationen, von der
initialen Evaluation über die Architekturentscheidungen und die technische Implementierung bis hin zur Reflexion, sind
hier festgehalten oder direkt verlinkt.

## **6.1 Verzeichnisse und Zusammenfassungen**

Das Inhaltsverzeichnis am Anfang dieser Datei bietet eine schnelle Navigation zu allen relevanten Abschnitten. Jedes
Hauptkapitel beginnt mit einer kurzen Einleitung, die den Zweck des Kapitels erläutert. Die agilen
Sprint-Zusammenfassungen in Kapitel 2.3 dokumentieren den Projektfortschritt inkrementell und nachvollziehbar.

## **6.2 Quellenangaben und verwendete Werkzeuge**

Für die Umsetzung dieses Projekts wurden ausschliesslich offizielle Dokumentationen der Hersteller und etablierte
Community-Ressourcen herangezogen.

**Primäre Werkzeuge:**

* **Cloud Provider:** Amazon Web Services (AWS)
* **Infrastructure as Code (Infra):** Terraform v1.9.x
* **Infrastructure as Code (App Config):** Helm v3.15.x
* **Container Orchestration:** Kubernetes v1.29 (via AWS EKS)
* **CI/CD:** GitHub Actions
* **Containerisierung:** Docker (für das Nextcloud-Image)
* **Anwendung:** Nextcloud (offizielles Image von Docker Hub)
* **Datenbank:** AWS RDS for PostgreSQL v16.2
* **Versionskontrolle:** Git (gehostet auf GitHub)

**Wichtige Referenzdokumentationen:**

* [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
* [Helm Documentation](https://helm.sh/docs/)
* [AWS EKS Best Practices Guides](https://aws.github.io/aws-eks-best-practices/)
* [GitHub Actions Documentation](https://docs.github.com/en/actions)
* [Kubernetes Documentation](https://kubernetes.io/docs/)

**Unterstützung durch KI-Systeme:**

Zur Effizienzsteigerung und Unterstützung in verschiedenen Phasen dieses Projekts wurden KI-gestützte Sprachmodelle
eingesetzt. Die finale Verantwortung für den Code, die Architektur und die Dokumentation lag jedoch jederzeit beim
Autor. Die KI-Systeme dienten als Werkzeug und nicht als primärer Ersteller.

* **Verwendete Modelle:** ChatGPT (OpenAI), Gemini (Google), Claude (Anthropic)
* **Anwendungsbereiche:**
    * **Brainstorming und Ideenfindung:** Entwicklung von Lösungsansätzen für komplexe Probleme (z.B.
      LoadBalancer-Hostname-Automatisierung).
    * **Konzepterklärungen:** Vereinfachte Erläuterungen zu AWS-Services, Kubernetes-Konzepten (z.B. IRSA, IMDS) und
      Terraform-Syntax.
    * **Code-Generierung und Refactoring:** Erstellung von Boilerplate-Code (z.B. GitHub-Action-Grundgerüste) und
      Vorschläge zur Code-Verbesserung.
    * **Fehlersuche (Debugging):** Analyse von Fehlermeldungen und Vorschläge für mögliche Ursachen und Lösungen.
    * **Grammatik und Formulierung:** Korrektur und stilistische Verbesserung der Dokumentation in dieser `README.md`
      -Datei.

## 6.3 Lizenz

Der **gesamte Quellcode** dieses Projekts (Terraform, Helm-Charts, GitHub-Actions-Workflows usw.) steht unter
der [MIT-Lizenz](LICENSE).  
Die **Dokumentation** dieses Repositories ist, sofern nicht anders gekennzeichnet, ebenfalls unter MIT veröffentlicht.  
Das verwendete Nextcloud-Docker-Image unterliegt der AGPL-3.0 (→
siehe [Nextcloud-Projekt](https://github.com/nextcloud/docker)).

---

## 7. Reflexion und Erkenntnisse

*Die ehrliche Geschichte eines Projekts zwischen Faszination und Überforderung - und warum das völlig in Ordnung ist.*

## 7.1 Scrum für eine Person - schwieriger als gedacht

**Seien wir ehrlich: Die Scrum-Zeremonien konsequent durchzuziehen war... kompliziert.**

Sprint Planning funktionierte noch ganz gut - da hatte ich konkrete Tasks und User Stories zum Planen. Aber die
Retrospektiven? Das fühlte sich extrem seltsam an. Mit sich selbst über "was lief gut, was lief schlecht" zu diskutieren
ist surreal. Meistens verschmolzen Review und Retrospektive zu einem grossen "Was habe ich geschafft und wo bin ich
hängengeblieben?"-Moment.

Das tägliche Daily Scrum? Vergiss es. Manchmal erinnerte ich mich daran, meist nicht. Ich arbeitete lieber mit meinem
lokalen Kanban-Board und vergass dann wochenlang, das offizielle GitHub-Board zu aktualisieren. Erst wenn ich für die
Sprint-Dokumentation alles nachträglich eintragen musste, wurde mir bewusst, wie inkonsistent ich war.

**Und dann kam das grosse Chaos.** Irgendwann gegen Ende verlor ich mehrere Wochen Fortschritt, weil sich persönliche
Sachen, Arbeit und Studium zu einem perfekten Sturm entwickelten. Dinge kamen dazwischen, die Prioritäten verschoben
sich, und plötzlich hatte ich wochenlang nicht mehr am Projekt gearbeitet. Das war frustrierend und stressig - besonders
weil die Deadline näher rückte.

## 7.2 Die Faszination für Komplexität

**Aber hier ist das Verrückte: Trotz allem war es unglaublich faszinierend.**

Wenn alles funktionierte, wenn ich einen `gh workflow run lifecycle.yml -f action=setup` ausführte und 20 Minuten später
eine komplette Nextcloud-Instanz in der Cloud lief - das war pure Magie. So viele bewegliche Teile: Terraform erstellt
die Infrastruktur, EKS startet die Cluster, GitHub Actions orchestriert alles, Helm deployed die Anwendung, Load
Balancer leiten Traffic weiter. Und irgendwie funktioniert es zusammen.

**Die Komplexität war überwältigend.** Ich habe ehrlich gesagt viele Konfigurationen implementiert, ohne das grosse Bild
zu verstehen. IRSA Trust Policies? Keine Ahnung, warum diese spezielle JSON-Syntax funktioniert, aber sie tut es. EKS
Launch Templates mit IMDS Hop Limits? Ich habe die Lösung gefunden und implementiert, aber die zugrunde liegenden
EC2-Netzwerk-Mechanismen sind mir immer noch ein Rätsel.

Das ist vermutlich der ernüchterndste Lerneffekt: Ich bräuchte wahrscheinlich ein intensives DevOps-Bootcamp über
mehrere Monate, um wirklich zu verstehen, was ich da gebaut habe. Momentan fühlt es sich an, als hätte ich ein komplexes
Uhrwerk zusammengebaut, das funktioniert - aber ich könnte dir nicht erklären, warum jedes Zahnrad genau dort sein muss.

## 7.3 Tool-Chaos und Realitäts-Check

**Die Tools waren auch nicht immer meine Freunde.**

Terraform? Grossartig, wenn es funktioniert. Frustrierend, wenn kryptische Fehlermeldungen kommen und man nicht weiss,
ob es ein Syntax-Problem, ein AWS-Problem oder ein State-Problem ist. GitHub Actions? Mächtig, aber das Debugging ist
schmerzhaft - man kann nicht einfach einen Breakpoint setzen.

Helm war anfangs verwirrend mit all den Templates und Values, wurde aber zum Ende hin zu meinem Lieblings-Tool.
Kubernetes selbst? Immer noch ein Mysterium in vielen Bereichen. Ich kann ein Deployment erstellen und einen Service
exponieren, aber wenn etwas schief geht, fühle ich mich oft hilflos.

**Das GitHub Board-Management war katastrophal.** Ich arbeitete hauptsächlich mit meinem lokalen Setup - Post-its,
Notizen, mentale TODOs. Das offizielle Board aktualisierte ich nur sporadisch, meist erst wenn ich für die
Sprint-Reviews alles nachträglich dokumentieren musste. Das ist ehrlich gesagt ein typisches Problem: Die Tools, die für
die Dokumentation gut sind, sind nicht unbedingt die Tools, mit denen ich gerne arbeite.

## 7.4 Was bleibt - trotz allem

**Das Projekt war ein Erfolg, auch wenn der Weg chaotisch war.**

Am Ende funktioniert alles. Ein Button erstellt eine komplette Cloud-Infrastruktur, ein anderer löscht sie wieder. Das
ist beeindruckend, auch wenn ich nicht jeden Aspekt davon vollständig durchdringe.

**Die grössten Erkenntnisse waren nicht technisch, sondern meta:**

- Komplexe Systeme funktionieren oft, auch wenn man nicht alles versteht - und das ist okay
- Documentation-as-Code ist grossartig, aber nur wenn man es auch tut (anstatt es aufzuschieben)
- Work-Life-Balance ist nicht nur ein Buzzword - wenn sie kippt, leiden alle Projekte
- Manchmal ist "es funktioniert" wichtiger als "ich verstehe warum es funktioniert"

**Wenn ich das Projekt nochmal machen würde?** Ich würde versuchen, konsequenter mit dem Prozess zu sein, aber ehrlich
gesagt würde wahrscheinlich ähnliches Chaos entstehen. Das ist menschlich. Das Wichtige ist, dass ich trotz aller Umwege
und Stolpersteine etwas Funktionierendes und Nützliches geschaffen habe.

**Und das Gefühl, wenn der ganze Stack zum ersten Mal funktioniert hat?** Unbezahlbar. Dafür hat sich jede frustrierende
Debug-Session gelohnt.

---

## 8. Anhänge

*Zusätzliche Materialien, die das Verständnis unterstützen oder für die Nachvollziehbarkeit relevant sind.*

## 8.1 Verwendete Scrum-Vorlagen (Templates)

*Die hier aufgeführten Markdown-Vorlagen dienten als Grundlage und Inspiration für die Dokumentation der
Scrum-Zeremonien und Artefakte.*

* [Sprint Planning Vorlage](docs/templates/sprint_planning.md)
* [Daily Scrum Log Vorlage](docs/templates/daily_scrum.md)
* [Sprint Review Vorlage](docs/templates/sprint_review.md)
* [Sprint Retrospektive Vorlage](docs/templates/sprint_retro.md)
* [User Story Vorlage](docs/templates/user_story.md)

## 8.2 Weitere Referenzen (Optional)

*Platz für zusätzliche Links, interessante Artikel oder Dokumente, die im Projektkontext relevant waren.*

## 8.3 Link zum GitHub Repository

*Der vollständige Quellcode und diese Dokumentation sind öffentlich zugänglich
unter: https://github.com/Stevic-Nenad/Nextcloud*

## 8.4 Link zum GitHub Project Board (Kanban/Scrum Board)

*Der aktuelle Stand der Aufgaben und das Product/Sprint Backlog sind einsehbar
unter: https://github.com/users/Stevic-Nenad/projects/1/views/1*

---

**Selbstständigkeitserklärung**

Ich erkläre hiermit, dass ich die vorliegende Semesterarbeit selbstständig und ohne fremde Hilfe verfasst und keine
anderen als die angegebenen Quellen und Hilfsmittel benutzt habe. Alle Stellen, die dem Wortlaut oder dem Sinn nach
anderen Werken entnommen sind, wurden unter Angabe der Quelle kenntlich gemacht.

Ort, Datum Nenad Stevic

---