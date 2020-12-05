function discord_webhook ($content) {
    Invoke-RestMethod -Uri $discord_webhook -Method POST -Headers @{ "Content-Type" = "application/json" } -Body "{`"content`":`"**[$SSM_Profile]** $content`"}"
}
