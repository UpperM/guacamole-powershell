Function New-GuacToken()
{
    param(
        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 0,
            Mandatory = $true
        )]
        [System.String]
        $Username,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 1,
            Mandatory = $False
        )]
        [System.String]
        $Password,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 2,
            Mandatory = $False
        )]
        [System.String]
        $TOTP,

        [ValidateNotNullOrEmpty()]
        [Parameter(
            Position = 3,
            Mandatory = $true
        )]
        [System.String]
        $Server
    )

    begin
    {
        if ($Null -eq $Password -or $Password.Length -eq 0)
        {
            $SecurePassword = Read-Host "Enter password" -AsSecureString
            # If running on Windows
            if ($IsWindows)
            {
                # Decode SecureString to Plain text for Guacamole (https://www.powershelladmin.com/wiki/Powershell_prompt_for_password_convert_securestring_to_plain_text)
                # Create a "password pointer"
                $PasswordPointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
    
                # Get the plain text version of the password
                $Password = [Runtime.InteropServices.Marshal]::PtrToStringAuto($PasswordPointer)
    
                # Free the pointer
                [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($PasswordPointer)
            # If running on Linux of MacOS
            } else {
                $Password = ConvertFrom-SecureString -SecureString $SecurePassword -AsPlaintext
            }
        }

        $Body = @{
            username = $Username
            password = $Password
        }

        if($Null -ne $TOTP)
        {
            $Body.Add("guac-totp",$TOTP)
        }

        $Uri = "$Server/api/tokens"
    }
    process
    {

        try
        {
            $RestCall = Invoke-RestMethod -Method POST -Body $Body -Uri $Uri
        }
        catch
        {
            Write-Output "If TOTP is enabled, please provid -TOTP parameters with your TOTP code"
            Write-Warning $_.Exception.Message
            return $False
        }

    }
    end
    {
        $Script:Token = $RestCall.authToken
        $Script:Server = $Server
        return $RestCall
    }
}

<#
New-GuacToken -Username guacadmin -Password guacadmin -Server "http://srv-guacamole:8080/guacamole" -TOTP 803505
#>
