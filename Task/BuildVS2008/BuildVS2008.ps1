Param (
		 [Parameter(mandatory=$true)]
         [string] $TargetFile,
         [Parameter(mandatory=$true)]
         [string] $Config,
	     [string] $DevEnvPath
)

if (!$DevEnvPath)
{
	if ($env:VS90COMNTOOLS)
	{
		$DevEnvPath = $env:VS90COMNTOOLS+"..\IDE\devenv.exe"
	}
	else
	{
		throw ("Invalid Microsoft Visual Studio 2008 DevEnv.exe path! Please inform a valid path or configure a ""VS90COMNTOOLS"" system enviroment variable with the path on the agent machine.")
	}
}

Function CreateLogFile($logPath) 
{
     if (Test-Path $logPath)
     {
         Remove-Item $logPath
     }
     $path = [IO.Path]::GetFullPath($logPath)
     New-Item -ItemType file  $path
}

Function Build([string] $targetPath)
{
	Write-Host ">>>>>>>>> Begin build >>>>>>>>>>"
	Write-Host "Building $targetPath..."
	
	$parentFolderPath = Split-Path $targetPath -Parent   
	$buildItem = Split-Path $targetPath -Leaf
    $log = "$parentFolderPath\build_"+$buildItem.Replace('.','_')+".log"
    CreateLogFile $log 
	
	& $DevEnvPath $targetPath /rebuild $Config /out ""$log"" | Out-Null
    Type $log 
	
	Write-Host "<<<<<<<<< End build <<<<<<<<<<"
}

Write-Host "Searching for target files..."
$files = Get-ChildItem "$TargetFile" -Recurse
    
if ($files.Length -eq 0)
{
	throw ("The specified Target(s) File(s) was not found!")
}

if ($files.GetType().FullName -eq "System.Object[]")
{
	Write-Host ("{0} build target files found!" -f $files.Length)
}

$position = "."
foreach($file in $files)
{
	Write-Host "$position"
    Build $file.FullName
	$position += "."
}


