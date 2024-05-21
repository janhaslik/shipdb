## Business Logik und UseCases

### Funktionen
- **Add_Owner**
  - Fügt einen Besitzer (Owner) hinzu mit entsprechenden Überprüfungen mit Exceptions (z.B. auf Einzigartigkeit).
- **Add_User**
  - Fügt einen Benutzer (User) hinzu mit entsprechenden Überprüfungen mit Exceptions.
- **Add_Ship**
  - Fügt ein Schiff hinzu mit entsprechenden Überprüfungen mit Exceptions.
- **Add_Plane**
  - Fügt ein Flugzeug hinzu mit entsprechenden Überprüfungen mit Exceptions.
- **Add_Crewmember**
  - Fügt ein Besatzungsmitglied (Crewmember) hinzu mit entsprechenden Überprüfungen mit Exceptions.
- **Add_Ships_Crewmember**
  - Fügt eine Verbindung zwischen Schiff und Besatzungsmitglied hinzu mit entsprechenden Überprüfungen mit Exceptions.
- **Add_Shipment**
  - Fügt eine Lieferung (Shipment) hinzu mit entsprechenden Überprüfungen mit Exceptions.
- **Add_Plane_Shipment**
  - Fügt eine Verbindung zwischen Lieferung und Flugzeug hinzu mit entsprechenden Überprüfungen mit Exceptions.
- **Add_Ship_Shipment**
  - Fügt eine Verbindung zwischen Lieferung und Schiff hinzu mit entsprechenden Überprüfungen mit Exceptions.
- **Add_Maintenance**
  - Fügt eine Wartung (Maintenance) hinzu mit entsprechenden Überprüfungen mit Exceptions.
- **Add_Ship_Maintenance**
  - Fügt eine Verbindung zwischen Wartung und Schiff hinzu mit entsprechenden Überprüfungen mit Exceptions.
- **Add_Plane_Maintenance**
  - Fügt eine Verbindung zwischen Wartung und Flugzeug hinzu mit entsprechenden Überprüfungen mit Exceptions.

### Berichte und Analysen
- **Generate_Owner_Ship_Fleet_Report**
  - Generiert einen Bericht über die Schiffsflotte basierend auf dem Besitzer.
- **Generate_Owner_Plane_Fleet_Report**
  - Generiert einen Bericht über die Flugzeugflotte basierend auf dem Besitzer.
- **Generate_Utilization_Report**
  - Generiert einen Nutzungsbericht (Utilization Report).
- **Identify_Unassigned_Crew_Members**
  - Listet alle nicht zugeordneten Besatzungsmitglieder auf.
- **Generate_Fleet_Value_Plane_Report**
  - Generiert einen Bericht über den Wert der Flugzeugflotte basierend auf dem Besitzer.
- **Generate_Fleet_Value_Ship_Report**
  - Generiert einen Bericht über den Wert der Schiffsflotte basierend auf dem Besitzer.

## Log Nachrichten (log_msg)
- Speichert logs in die Log-Tabelle, message + date

## Trigger
- Für Insert, Update, Delete wird für jede Tabelle ein Trigger erstellt, um einen Log zu schreiben.
- Zwischen 23:00 - 5:00 darf kein Shipment und Maintenance erstellt oder aktualisiert werden.
