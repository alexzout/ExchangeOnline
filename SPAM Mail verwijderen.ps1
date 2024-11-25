# Maak verbinding met Exchange Online en de Security & Compliance Center
Connect-ExchangeOnline
Connect-IPPSSession

# Vul hier het onderwerp in van het SPAM bericht
$subject = "Bijkletsen met jouw lievelings"

# Genereer een unieke naam voor de zoekopdracht met de huidige datum en tijd
$naam = "Verwijder Spam Mail"
$currentDateTime = Get-Date -Format "yyyy-MM-dd_HH-mm-ss" # Gebruik een formaat zonder spaties of dubbele punten
$regel = "$naam $currentDateTime"

# Voer de compliance zoekopdracht uit
$Search = New-ComplianceSearch -Name $regel -ExchangeLocation All -ContentMatchQuery "subject:`"$subject`""
Start-ComplianceSearch -Identity $Search.Identity

# Wacht tot de zoekopdracht is voltooid (dit kan tot 15 minuten duren)
Start-Sleep -Seconds 900 # Optioneel, om te wachten voordat u verder gaat

# Controleer de resultaten van de zoekopdracht
Get-ComplianceSearch $regel | Select Name, ContentMatchQuery, Items, SuccessResults

# Voer de verwijderactie uit op de gevonden items
New-ComplianceSearchAction -SearchName $regel -Purge -PurgeType SoftDelete

# Verbreek de verbinding met Exchange Online
Disconnect-ExchangeOnline
