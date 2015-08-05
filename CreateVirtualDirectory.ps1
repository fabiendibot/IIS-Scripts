[cmdletbinding()]
param (
    ## Declare few variables
    [String]$siteName = 'Default Web Site',
    [String]$virtualDirectoryName = 'Repository',
    [String]$physicalPath = 'C:\Repository'
)

Write-Verbose "Info: Virtual directoy script started"
Write-Verbose "Test: Test if $physicalPath exists"
if (Test-Path $physicalPath) {
    
    Write-Verbose "Success: $physicalPath exists!"
    ## Create Virtual Directory 
    Try {
        Write-Verbose "Info: Start the creation of the virtualdirectoy: $virtualDirectoryName in $siteName"
        New-WebVirtualDirectory -Site $SiteName -Name $virtualDirectoryName -PhysicalPath $physicalPath -ErrorAction SilentlyContinue | Out-Null
        Write-Verbose "Success: creation of the virtualdirectoy: $virtualDirectoryName in $siteName done!"
    }
    Catch {
        Throw "Error: $($_.Exception.Message)"
    }

    Try {
        ## Change permissions
        ## Get the VirtualDirectoryObjet
        Write-Verbose "Info: Start loading the $virtualDirectoryName objet in memory"
        $Folder = new-object System.DirectoryServices.DirectoryEntry("IIS://localhost/W3SVC/1/Root/Repository")
        Write-Verbose "Success: $virtualDirectoryName loaded!"

        # Enable directory browsing
        Write-Verbose "Info: Start enabling browsing the $virtualDirectoryName directory."
        $Folder.Put("EnableDirBrowsing",$true)
        Write-Verbose "Success: Browsing the $virtualDirectoryName directory activated."

        # Apply changes
        Write-Verbose "Info: Start the commit to apply changements"
        $Folder.psbase.commitchanges()
        Write-Verbose "Success: Changements committed!"
    }
    Catch {
        Throw "Error: $($_.Exception.Message)"
    }
}
else {
    Write-Error "$physicalPath isn't available"
}