Function Invoke-StatusCheck
{
    [CmdletBinding()]
    Param
    (
        [Switch] $Recursive
    )

    Begin
    {
        $root = Get-ChildItem | ?{$_.PSIsContainer}
    }

    Process
    {
        if ($Recursive)
        {
            ForEach($folder in $root)
            {
                Set-Location $folder

                if(Test-Path ".git")
                {
                    Write-Host "$folder is a repo, checking status..."
                    git status
                }
                else
                {
                    Write-Host "$folder is not a repo, skipping..."
                }

                Set-Location ".."
            }
        }
        else
        {
            git status
        }
    }
}