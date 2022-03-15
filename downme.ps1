<# A small powershell script that downloads all the content with a secific extension from a URL.
   This small script safes alot of clicking ;)
   
   Use at your own risk!
   (C) 2022 Xatru <https://github.com/xatru/tools>
#>

$extension = '*7z*' # specify extension here
$path = 'D:\'       # specify path to download here
$url = 'https://<my URL path>' # enter the url with content 

$l = (Invoke-WebRequest –Uri $u).Links | ? href -like $extension # extracts links to files

$l | select -Unique href | % { # for all links we try once ...
    $name = $l | ? href -eq $_.href  | select -First 1 -ExpandProperty innerHtml # getting the filename 
    "Downloading $name ..." # just a message to let the user know what happends
    $down = $u + $name # putting link and url together
	$file = $path + $name # specify the download path and filename
    Invoke-WebRequest -Uri $down  -OutFile $file -Verbose # downloading and safe the file
    }
