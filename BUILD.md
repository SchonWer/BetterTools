# Build Notes

## Fantasy Grounds .ext packaging

Fantasy Grounds extensions are ZIP archives with the `.ext` file extension. Archive entries must use forward slashes, for example:

```text
campaign/record_char_tools.xml
campaign/scripts/kraeuterkundeausruestung/manager_bettertools_herbalism.lua
```

Do not package entries with Windows backslashes such as:

```text
campaign\record_char_tools.xml
```

Fantasy Grounds may load the unpacked extension folder successfully while the `.ext` file fails with errors like:

```text
Unable to locate extension file. [BetterTools] [campaign/record_char_tools.xml]
```

## Build command

Run this from `extensions/BetterTools`:

```powershell
Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.IO.Compression

$src = (Resolve-Path '.').Path
$zipPath = Join-Path (Split-Path $src -Parent) 'BetterTools.zip'
$extPath = Join-Path (Split-Path $src -Parent) 'BetterTools.ext'

if (Test-Path $zipPath) { Remove-Item -LiteralPath $zipPath -Force }
if (Test-Path $extPath) { Remove-Item -LiteralPath $extPath -Force }

$zip = [System.IO.Compression.ZipFile]::Open($zipPath, [System.IO.Compression.ZipArchiveMode]::Create)
try {
	[System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
		$zip,
		(Join-Path $src 'extension.xml'),
		'extension.xml',
		[System.IO.Compression.CompressionLevel]::Optimal
	) | Out-Null

	Get-ChildItem -Path (Join-Path $src 'campaign') -Recurse -File |
		Sort-Object FullName |
		ForEach-Object {
			$rel = $_.FullName.Substring($src.Length + 1).Replace('\', '/')
			[System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
				$zip,
				$_.FullName,
				$rel,
				[System.IO.Compression.CompressionLevel]::Optimal
			) | Out-Null
		}
}
finally {
	$zip.Dispose()
}

Rename-Item -LiteralPath $zipPath -NewName 'BetterTools.ext'
Get-Item $extPath
```

## Verify

After building, verify the archive paths:

```powershell
tar -tf ..\BetterTools.ext
```

The output should contain paths with `/`, not `\`.
