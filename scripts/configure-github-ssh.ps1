param($TOKEN)
#TOKEN = Read-Host "Gitlab Token" -AsSecureString | ConvertFrom-SecureString -AsPlainText

$header = @{
    "Authorization"= "Bearer $TOKEN"
    "Accept" = "application/vnd.github+json"
    "X-GitHub-Api-Version" = "2022-11-28"
}
$GithubAPI = " https://api.github.com"

if(!(test-path ~/.ssh/id_rsa)){
    ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N '""'
}

$publickey = Get-Content ~/.ssh/id_rsa.pub

$body = @{
    title = "Automated Script WSL"
    key = "$publickey"
} | ConvertTo-Json

Try{
    Invoke-RestMethod -Headers $header -Uri $GithubAPI/user/keys -Body $body -Method Post -ContentType application/json -ErrorVariable github | Out-Null
}Catch{
    if($github -notlike "*has already been taken*"){
        Write-Error "Failed to upload key"
        exit -1
    }
}
