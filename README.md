# Semesterarbeit: Aufbau einer End-to-End CI/CD-Pipeline mit Terraform, Helm und GitHub Actions zur Bereitstellung von Nextcloud auf Kubernetes (AWS EKS)

![Header Bild](D:\Nextcloud\assets\header.png)

**Student:** Nenad Stevic<br>
**TBZ Lehrgang dipl. Informatiker/in HF - 3. Semester**<br>
**Abgabedatum:** 09.07.2025

[[_TOC_]]

---
## 1. Einleitung
In diesem Kapitel wird das Projekt, die Kriterien und die Vorgehensweise genauer unter die Lupe genommen. Damit wird ein Überblick über die geplante Arbeit geschaffen, was die Auswertung der Ergebnisse am Schluss vereinfachen soll.

### 1.1 Problemstellung
Das Hosten und Verwalten von Webanwendungen mit Datenbankanbindung stellt in der heutigen IT-Welt mehrere Herausforderungen dar. Mit High-Availability Infrastrukturen, welche heute in der Industrie weit verbreitet sind, muss man deutlich mehr konfigurieren und beachten, als bei "Bare Metal" Servern vor einem Jahrzehnt. Wie kann man mehrere Instanzen einer Applikation laufen lassen, und trotzdem Datenintegrität auf allen Replicas gewährleisten? Wie kann man diese verschiedenen Komponenten und Abhängigkeiten erfolgreich konfigurieren, ohne dass Fehler oder Unachtsamkeiten unterlaufen?

Diese Fragen oder Probleme sind welche, die wir auch in meinem Betrieb begegnen, besonders wenn es darum geht, Webanwendungen für unsere Kunden zu hosten. Deswegen ist dieses Thema äusserst interessant und motivierend, Lösungsansätze zu finden, und Erfahrungen zu sammeln die einen messbaren Beitrag zum Berufsleben bringen werden.

### 1.2 Projektziele
Die Ziele der Arbeit wurden nach dem SMART-Prinzip definiert:

1. **Automatisierte Infrastruktur Verwaltung via IaC (Terraform):**<br>
Deadline: Ende Sprint 1<br>
Die erforderliche Cloud-Infrastruktur auf AWS – bestehend aus einem Elastic Kubernetes Service (EKS) Cluster, einem Relational Database Service (RDS) und einer Elastic Container Registry (ECR) – wird vollständig mittels Terraform-Code automatisiert erstellt und versioniert. Das Ergebnis ist eine betriebsbereite, aber initial leere Kubernetes- und Datenbankumgebung.
2. **Entwicklung eines funktionalen Nextcloud Helm Charts:**<br>
Deadline: Ende Sprint 1<br>
Ein eigenständiges, funktionales Helm Chart für die Nextcloud-Anwendung entwickeln. Dieses Chart ermöglicht die Konfiguration von Kubernetes-Deployments, Services, Persistent Volume Claims (PVCs), Datenbankverbindungs-Secrets und weiterer Anwendungsparameter über eine `values.yaml`-Datei. Die Funktionalität wird durch `helm template` und `helm install` (lokal oder auf EKS) verifiziert.
3. **Implementierung einer CI/CD-Pipeline mit GitHub Actions:**<br>
Deadline: Ende Sprint 2<br>
Eine automatisierte Continuous Integration / Continuous Deployment (CI/CD) Pipeline unter Verwendung von GitHub Actions einrichten. Diese Pipeline wird bei Änderungen im Git-Repository (z.B. Aktualisierung des Nextcloud-Images oder der Helm-Chart-Konfiguration) den vollständigen Deployment-Prozess auslösen. Dies beinhaltet optionale Schritte wie Image Build/Push und Helm Linting/Packaging.
4. **Bereitstellung einer funktionalen Nextcloud Instanz:**<br>
Deadline: Ende Sprint 2<br>
Eine Nextcloud-Instanz mittels der CI/CD-Pipeline auf dem Kubernetes-Cluster bereitstellen. Die Instanz ist extern erreichbar, erfolgreich mit der provisionierten Datenbank verbunden und weist Persistenz für Benutzerdaten auf. Dies wird durch einen erfolgreichen Login sowie exemplarische Datei-Upload- und Download-Vorgänge demonstriert.
5. **Umfassende Dokumentation und Code-Bereitstellung:**<br>
Deadline: Ende Spring 2<br>
Bis zum Projektende sind die Systemarchitektur, die Terraform-Module, das Helm Chart, die CI/CD-Pipeline, getroffene Sicherheitsüberlegungen sowie der gesamte Setup- und Deployment-Prozess detailliert dokumentiert. Der gesamte Quellcode (Terraform, Helm, GitHub Actions Workflows) ist in einem Git-Repository versioniert und für die Experten zugänglich.

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
