$content = Get-Content "Request.json" -Raw

Try {	
	$headers = @{
		Accept="application/json"
		"Content-Type"="application/json"
	}

	$content = Get-Content "Request.json" -Raw

	#FIX:
    #$data= [System.Text.Encoding]::UTF8.GetBytes($content)
    $data = $content

	$url = "http://localhost:5000/api/values"
	
	$result = Invoke-WebRequest -Uri $url -Method POST -Headers $headers -Body $data -UseBasicParsing 
	$responsecode= $result | select StatusCode

	write-host "Response code: " + $responsecode.StatusCode
    Write-Host "Response:"
    Write-Host $result.Content
}
catch
{
    $responsecode= $_.Exception.Response | select StatusCode
    $reader = New-Object -TypeName System.IO.StreamReader -ArgumentList $_.Exception.Response.GetResponseStream()
    Write-Host "Error response:"
    Write-Host $reader.ReadToEnd().Substring(200)
    Write-Host "Error response status code: $responsecode"
}
