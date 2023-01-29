param($TOKEN)
#TOKEN = Read-Host "Gitlab Token" -AsSecureString | ConvertFrom-SecureString -AsPlainText

$header = @{
    "PRIVATE-TOKEN"=$TOKEN
}
$GitlabAPI = "https://gitlab.com/api/v4"

if(!(test-path ~/.ssh/id_rsa)){
    ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N '""'
}

$publickey = Get-Content ~/.ssh/id_rsa.pub

$body = @{
    title = "Automated Script WSL"
    key = "$publickey"
    expires_at ="$((get-date).AddYears(1).ToUniversalTime().ToString("o"))"
} | ConvertTo-Json

Try{
    Invoke-RestMethod -Headers $header -Uri $GitlabAPI/user/keys -Body $body -Method Post -ContentType application/json -ErrorVariable gitlabkey | Out-Null
}Catch{
    if($gitlabkey -notlike "*has already been taken*"){
        Write-Error "Failed to upload key"
        exit -1
    }
}


