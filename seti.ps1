function check-git {
    if (-Not (Get-Command git -ErrorAction SilentlyContinue))
    {
            write-host "install git dummy"
    }
}

function create-branch
{
        [CmdletBinding()]
        param(
            [string]$branch_name,
            [string]$repo_name = 'SETI'
        )
        cd ~/code/$repo_name
        git checkout -b $branch_name
        git push -u origin $branch_name
}

function create-codedirectory
{
        New-Item ~/code -ItemType Directory -Force
}

function check-path
{
        [CmdletBinding()]
        param(
            [string]$repo_name = 'SETI'
        )
        Test-Path ~/code/$repo_name
}

function check-branch
{
        [CmdletBinding()]
        param(
            [string]$branch_name,
            [string]$repo_name = 'SETI'
        )

        cd ~/code/$repo_name
        git branch -a | Select-String $branch_name -quiet
}

function generate-branchname
{
        param(
            [string]$userinput = $( Read-Host "Input Branch Name:" )
        )
        return $userinput
}
function create-clone
{
        param(
            [string]$repo_name = 'SETI'
            )
        cd ~/code
        git clone https://4j4tnlwp2wpcrwnkbuh6pbfvxhiekdi3hbgveyhdnevkmzb2rbua@dev.azure.com/DellSEBI/SETI/_git/SETI
}

function main
{
        check-git
        $branch_name = generate-branchname
        create-codedirectory
        if (-Not (check-path))
        {
            create-clone
        }
        if (-Not (check-branch -branch_name $branch_name))
        {
                create-branch -branch_name $branch_name
                write-output "we did it"
        }
}

main
